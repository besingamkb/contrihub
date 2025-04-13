import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

export async function GET(request: Request) {
  try {
    // Get user from request headers
    const userHeader = request.headers.get('user')
    if (!userHeader) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    const user = JSON.parse(userHeader)

    // If user is not admin, only return their own data
    if (!user.is_admin) {
      const userContributions = await prisma.contribution.findMany({
        where: {
          userId: user.id
        },
        orderBy: {
          month: 'desc'
        },
        take: 5
      })

      const totalAmount = await prisma.contribution.aggregate({
        where: {
          userId: user.id
        },
        _sum: {
          amount: true
        }
      })

      return NextResponse.json({
        stats: {
          totalContributions: userContributions.length,
          totalMembers: 1, // Only themselves
          pendingContributions: userContributions.filter(c => c.status === 'PENDING').length,
          totalAmount: totalAmount._sum.amount || 0
        },
        recentContributions: userContributions.map(contribution => ({
          id: contribution.id,
          user: {
            fullname: user.fullname
          },
          amount: contribution.amount,
          month: contribution.month,
          status: contribution.status
        }))
      })
    }

    // Admin can see all data
    const totalContributions = await prisma.contribution.count()
    const totalMembers = await prisma.user.count()
    const pendingContributions = await prisma.contribution.count({
      where: {
        status: 'PENDING'
      }
    })
    const totalAmountResult = await prisma.contribution.aggregate({
      _sum: {
        amount: true
      }
    })
    const totalAmount = totalAmountResult._sum.amount || 0

    const recentContributions = await prisma.contribution.findMany({
      take: 5,
      orderBy: {
        month: 'desc'
      },
      include: {
        user: {
          select: {
            fullname: true
          }
        }
      }
    })

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
    console.error('Error fetching dashboard data:', error)
    return NextResponse.json(
      { error: 'Failed to fetch dashboard data' },
      { status: 500 }
    )
  }
} 