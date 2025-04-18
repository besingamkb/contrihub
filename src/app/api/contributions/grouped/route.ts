import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { getServerSession } from 'next-auth'
import { authOptions } from '../../auth/[...nextauth]/route'

type ContributionWithUser = {
  id: number
  user_id: number
  amount: number
  month: string
  year: number
  status: 'PENDING' | 'PAID' | 'MISSED'
  notes: string | null
  created_at: Date
  updated_at: Date
  user: {
    id: number
    name: string
    email: string
  }
}

export async function GET(request: Request) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    try {
      const contributions = await prisma.contribution.findMany({
        include: {
          user: {
            select: {
              id: true,
              name: true,
              email: true
            }
          }
        }
      }) as unknown as ContributionWithUser[]

      type GroupKey = string
      type GroupedData = {
        year: number
        month: string
        total: number
        totalPending: number
        paidMembers: number
        contributions: ContributionWithUser[]
      }

      // Group contributions by month and year
      const groupedContributions = contributions.reduce<Record<GroupKey, GroupedData>>((acc, contribution) => {
        const key = `${contribution.year}-${contribution.month}`
        
        if (!acc[key]) {
          acc[key] = {
            year: contribution.year,
            month: contribution.month,
            total: 0,
            totalPending: 0,
            paidMembers: 0,
            contributions: []
          }
        }

        acc[key].total += Number(contribution.amount)
        if (contribution.status === 'PENDING') {
          acc[key].totalPending += Number(contribution.amount)
        }
        if (contribution.status === 'PAID') {
          acc[key].paidMembers += 1
        }
        acc[key].contributions.push(contribution)

        return acc
      }, {})

      // Convert to array and sort by year and month
      const result = Object.values(groupedContributions).sort((a, b) => {
        if (a.year !== b.year) {
          return b.year - a.year
        }
        return b.month.localeCompare(a.month)
      })

      return NextResponse.json(result)
    } catch (dbError) {
      console.error('Database Error:', dbError)
      return NextResponse.json(
        { error: 'Failed to fetch grouped contributions' },
        { status: 500 }
      )
    }
  } catch (error) {
    console.error('Error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
} 