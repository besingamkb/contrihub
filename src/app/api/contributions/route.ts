import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('user_id')

    if (userId) {
      const userIdNum = parseInt(userId)
      if (isNaN(userIdNum)) {
        return NextResponse.json(
          { error: 'Invalid user ID' },
          { status: 400 }
        )
      }

      const contributions = await prisma.contribution.findMany({
        where: {
          user_id: userIdNum
        },
        orderBy: {
          month: 'desc'
        },
        include: {
          user: {
            select: {
              fullname: true,
              email: true
            }
          }
        }
      })

      return NextResponse.json(contributions)
    }

    // If no user_id provided, return all contributions
    const contributions = await prisma.contribution.findMany({
      orderBy: {
        month: 'desc'
      },
      include: {
        user: {
          select: {
            fullname: true,
            email: true
          }
        }
      }
    })

    return NextResponse.json(contributions)
  } catch (error) {
    console.error('Error fetching contributions:', error)
    return NextResponse.json(
      { error: 'Failed to fetch contributions' },
      { status: 500 }
    )
  }
} 