'use client'

import { useEffect, useState } from 'react'
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
      accessor: 'contributions',
      render: (value: any[]) => value.length
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
    <div className="bg-white rounded-lg shadow-md p-6">
      <h1 className="text-2xl font-bold mb-4">Contributions</h1>
      <DataTable
        columns={columns}
        data={groupedContributions}
        searchableColumns={['month', 'year']}
        className="mt-4"
      />
    </div>
  )
} 