import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'
import { Status, Prisma } from '@prisma/client'

type ContributionWithUser = {
  id: number
  user_id: number
  amount: Prisma.Decimal
  month: string
  year: number
  status: Status
  notes: string | null
  created_at: Date
  updated_at: Date
  user: {
    id: number
    name: string
    email: string
    [key: string]: any
  }
}

export async function GET(request: Request) {
  try {
    const contributions = await prisma.contribution.findMany({
      include: {
        user: true
      }
    }) as unknown as ContributionWithUser[]

    type GroupKey = string
    type GroupedData = {
      year: number
      month: string
      total: number
      totalPending: number
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
          contributions: []
        }
      }

      const amount = Number(contribution.amount)
      acc[key].total += amount
      if (contribution.status === Status.PENDING) {
        acc[key].totalPending += amount
      }
      acc[key].contributions.push(contribution)

      return acc
    }, {})

    // Convert the grouped object to an array and sort by year and month
    const result = Object.values(groupedContributions).sort((a, b) => {
      if (a.year !== b.year) {
        return b.year - a.year
      }
      return b.month.localeCompare(a.month)
    })

    // Format the response to ensure all amounts are numbers and calculate paid members
    const formattedResult = result.map(group => ({
      ...group,
      contributions: group.contributions.map(contribution => ({
        ...contribution,
        amount: Number(contribution.amount)
      })),
      paidMembers: group.contributions.filter(c => c.status === Status.PAID).length
    }))

    return NextResponse.json(formattedResult)
  } catch (error) {
    console.error('Error fetching grouped contributions:', error)
    return NextResponse.json(
      { error: 'Failed to fetch grouped contributions' },
      { status: 500 }
    )
  }
} 