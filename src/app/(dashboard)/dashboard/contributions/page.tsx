'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { PlusIcon, EyeIcon } from '@heroicons/react/24/outline'
import DataTable from '@/components/DataTable'

type GroupedContribution = {
  year: number
  month: string
  total: number
  totalPending: number
  contributions: any[]
}

export default function ContributionsPage() {
  const [groupedContributions, setGroupedContributions] = useState<GroupedContribution[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchGroupedContributions = async () => {
      try {
        const response = await fetch('/api/contributions/grouped')
        const data = await response.json()
        setGroupedContributions(data)
      } catch (error) {
        console.error('Error fetching grouped contributions:', error)
      } finally {
        setLoading(false)
      }
    }

    fetchGroupedContributions()
  }, [])

  const columns = [
    {
      header: 'Month',
      accessor: 'month',
      render: (value: string, row: GroupedContribution) => {
        return `${value} ${row.year}`
      }
    },
    {
      header: 'Total Amount',
      accessor: 'total',
      render: (value: number) => `₱${value.toLocaleString()}`
    },
    {
      header: 'Pending Amount',
      accessor: 'totalPending',
      render: (value: number) => `₱${value.toLocaleString()}`
    },
    {
      header: 'Paid Member',
      accessor: 'paidMembers',
      render: (value: number) => value
    },
    {
      header: 'Actions',
      accessor: 'actions',
      render: (value: any, row: GroupedContribution) => {
        const monthYear = `${row.month}-${row.year}`
        return (
          <Link 
            href={`/dashboard/contributions/${monthYear}`}
            className="text-blue-600 hover:text-blue-800"
          >
            <EyeIcon className="h-5 w-5" />
          </Link>
        )
      }
    }
  ]

  if (loading) {
    return (
      <div className="p-6">
        <h1 className="text-2xl font-bold mb-4">Contributions</h1>
        <p>Loading contributions data...</p>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-md p-6">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold text-gray-900">Contributions</h1>
          <Link
            href="/dashboard/contributions/create"
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Contribution
          </Link>
        </div>
        <DataTable
          columns={columns}
          data={groupedContributions}
          searchableColumns={['month', 'year']}
          className="mt-4"
        />
      </div>
    </div>
  )
} 