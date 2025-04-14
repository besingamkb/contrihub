import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('user_id')
    const month = searchParams.get('month')
    const year = searchParams.get('year')

    let whereClause = {}
    if (userId) {
      const userIdNum = parseInt(userId)
      if (isNaN(userIdNum)) {
        return NextResponse.json(
          { error: 'Invalid user ID' },
          { status: 400 }
        )
      }
      whereClause = { ...whereClause, user_id: userIdNum }
    }

    if (month && year) {
      const yearNum = parseInt(year)
      if (isNaN(yearNum)) {
        return NextResponse.json(
          { error: 'Invalid year' },
          { status: 400 }
        )
      }
      whereClause = { ...whereClause, month, year: yearNum }
    }

    const contributions = await prisma.contribution.findMany({
      where: whereClause,
      orderBy: [
        { year: 'desc' },
        { month: 'desc' }
      ],
      include: {
        user: {
          select: {
            name: true,
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