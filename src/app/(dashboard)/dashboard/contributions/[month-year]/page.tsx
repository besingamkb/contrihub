'use client'

import { useEffect, useState } from 'react'
import { useParams } from 'next/navigation'
import Link from 'next/link'
import { ArrowLeftIcon, TrashIcon } from '@heroicons/react/24/outline'
import ConfirmationModal from '@/components/ConfirmationModal'
import Toast from '@/components/Toast'

interface Contribution {
  id: number
  amount: number
  month: string
  year: number
  status: string
  notes: string | null
  user: {
    name: string
    email: string
  }
}

export default function ContributionDetailsPage() {
  const params = useParams()
  const [contributions, setContributions] = useState<Contribution[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [deleteModal, setDeleteModal] = useState<{
    isOpen: boolean
    contributionId: number | null
  }>({
    isOpen: false,
    contributionId: null
  })
  const [toast, setToast] = useState<{
    message: string
    type: 'success' | 'error'
  } | null>(null)

  useEffect(() => {
    const fetchContributions = async () => {
      try {
        const [month, year] = (params['month-year'] as string).split('-')
        const response = await fetch(`/api/contributions?month=${month}&year=${year}`)
        if (!response.ok) {
          throw new Error('Failed to fetch contributions')
        }
        const data = await response.json()
        setContributions(data)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred')
      } finally {
        setLoading(false)
      }
    }

    fetchContributions()
  }, [params])

  if (loading) {
    return (
      <div className="p-6">
        <p>Loading contributions...</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className="p-6">
        <p className="text-red-600">Error: {error}</p>
      </div>
    )
  }

  const [month, year] = (params['month-year'] as string).split('-')
  const totalAmount = contributions.reduce((sum, contribution) => {
    const amount = typeof contribution.amount === 'string' 
      ? parseFloat(contribution.amount) 
      : contribution.amount
    return sum + amount
  }, 0)
  const paidContributions = contributions.filter(c => c.status === 'PAID')
  const pendingContributions = contributions.filter(c => c.status === 'PENDING')

  const handleDeleteContribution = async (contributionId: number) => {
    try {
      const response = await fetch(`/api/contributions/${contributionId}`, {
        method: 'DELETE',
      })

      if (!response.ok) throw new Error('Failed to delete contribution')
      
      setContributions(contributions.filter(c => c.id !== contributionId))
      setDeleteModal({ isOpen: false, contributionId: null })
      setToast({ message: 'Contribution deleted successfully', type: 'success' })
    } catch (err) {
      console.error('Error deleting contribution:', err)
      setToast({ message: 'Failed to delete contribution', type: 'error' })
    }
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-md p-6">
        <div className="flex items-center mb-6">
          <Link
            href="/dashboard/contributions"
            className="mr-4 text-gray-600 hover:text-gray-900"
          >
            <ArrowLeftIcon className="h-5 w-5" />
          </Link>
          <h1 className="text-2xl font-bold text-gray-900">
            Contributions for {month} {year}
          </h1>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div className="bg-blue-50 p-4 rounded-lg">
            <h3 className="text-sm font-medium text-blue-800">Total Amount</h3>
            <p className="text-2xl font-bold text-blue-900">₱{totalAmount.toLocaleString()}</p>
          </div>
          <div className="bg-green-50 p-4 rounded-lg">
            <h3 className="text-sm font-medium text-green-800">Paid Members</h3>
            <p className="text-2xl font-bold text-green-900">{paidContributions.length}</p>
          </div>
          <div className="bg-yellow-50 p-4 rounded-lg">
            <h3 className="text-sm font-medium text-yellow-800">Pending Members</h3>
            <p className="text-2xl font-bold text-yellow-900">{pendingContributions.length}</p>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Member</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notes</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {contributions.map((contribution) => (
                <tr key={contribution.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm font-medium text-gray-900">{contribution.user.name}</div>
                    <div className="text-sm text-gray-500">{contribution.user.email}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    ₱{contribution.amount.toLocaleString()}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
                      contribution.status === 'PAID' ? 'bg-green-100 text-green-800' :
                      contribution.status === 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                      'bg-red-100 text-red-800'
                    }`}>
                      {contribution.status}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {contribution.notes || '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <button
                      onClick={() => setDeleteModal({ isOpen: true, contributionId: contribution.id })}
                      className="text-red-600 hover:text-red-900"
                    >
                      <TrashIcon className="h-5 w-5" />
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <ConfirmationModal
        isOpen={deleteModal.isOpen}
        onClose={() => setDeleteModal({ isOpen: false, contributionId: null })}
        onConfirm={() => {
          if (deleteModal.contributionId) {
            handleDeleteContribution(deleteModal.contributionId)
          }
        }}
        title="Delete Contribution"
        message="Are you sure you want to delete this contribution? This action cannot be undone."
      />

      {toast && (
        <Toast
          message={toast.message}
          type={toast.type}
          onClose={() => setToast(null)}
        />
      )}
    </div>
  )
} 