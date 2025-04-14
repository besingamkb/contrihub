import { getServerSession } from "next-auth"
import { NextResponse } from "next/server"
import { authOptions } from "../auth/[...nextauth]/route"
import prisma from "@/lib/prisma"

export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    // Get total members count
    const totalMembers = await prisma.user.count()

    // Get all contributions
    const contributions = await prisma.contribution.findMany({
      include: {
        user: {
          select: {
            name: true
          }
        }
      },
      orderBy: {
        month: 'desc'
      }
    })

    // Calculate stats
    const totalContributions = contributions.length
    const pendingContributions = contributions.filter(c => c.status === 'PENDING').length
    const totalAmount = contributions.reduce((sum, c) => sum + Number(c.amount), 0)

    // Get recent contributions
    const recentContributions = contributions.slice(0, 10).map(c => ({
      id: c.id,
      user: {
        fullname: c.user.name // Map name to fullname for frontend compatibility
      },
      amount: Number(c.amount),
      month: c.month.toISOString(),
      status: c.status
    }))

    return NextResponse.json({
      stats: {
        totalContributions,
        totalMembers,
        pendingContributions,
        totalAmount
      },
      recentContributions
    })
  } catch (error) {
    console.error('Dashboard API Error:', error)
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    )
  }
} 