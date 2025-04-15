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

export async function POST(request: Request) {
  try {
    const body = await request.json()
    const { user_id, amount, month, year, status, notes } = body

    // Validate required fields
    if (!user_id || !amount || !month || !year) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    // Validate amount
    if (amount <= 0) {
      return NextResponse.json(
        { error: 'Amount must be greater than 0' },
        { status: 400 }
      )
    }

    // Check if user exists
    const user = await prisma.user.findUnique({
      where: { id: user_id }
    })

    if (!user) {
      return NextResponse.json(
        { error: 'User not found' },
        { status: 404 }
      )
    }

    // Create the contribution
    const contribution = await prisma.contribution.create({
      data: {
        user_id,
        amount,
        month,
        year,
        status: status || 'PENDING',
        notes: notes || null
      },
      include: {
        user: {
          select: {
            name: true,
            email: true
          }
        }
      }
    })

    return NextResponse.json(contribution)
  } catch (error) {
    console.error('Error creating contribution:', error)
    return NextResponse.json(
      { error: 'Failed to create contribution' },
      { status: 500 }
    )
  }
} 