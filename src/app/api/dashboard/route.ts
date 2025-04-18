import { getServerSession } from "next-auth"
import { NextResponse } from "next/server"
import { authOptions } from "../auth/[...nextauth]/route"
import { prisma } from "@/lib/prisma"

export async function GET() {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    // Initialize stats with default values
    const stats = {
      totalContributions: 0,
      totalMembers: 0,
      pendingContributions: 0,
      totalAmount: 0
    }

    try {
      // Get total members count
      stats.totalMembers = await prisma.user.count()

      // Get all contributions
      const contributions = await prisma.contribution.findMany({
        include: {
          user: {
            select: {
              name: true
            }
          }
        },
        orderBy: [
          { year: 'desc' },
          { month: 'desc' }
        ]
      })

      // Calculate stats
      stats.totalContributions = contributions.length
      stats.pendingContributions = contributions.filter(c => c.status === 'PENDING').length
      stats.totalAmount = contributions.reduce((sum, c) => sum + Number(c.amount), 0)

      // Get recent contributions
      const recentContributions = contributions.slice(0, 10).map(c => ({
        id: c.id,
        user: {
          name: c.user.name
        },
        amount: Number(c.amount),
        month: c.month,
        year: c.year,
        status: c.status
      }))

      return NextResponse.json({
        stats,
        recentContributions
      })
    } catch (dbError) {
      console.error('Database Error:', dbError)
      // Return default stats if database query fails
      return NextResponse.json({
        stats,
        recentContributions: []
      })
    }
  } catch (error) {
    console.error('Dashboard API Error:', error)
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Internal server error" },
      { status: 500 }
    )
  }
} 