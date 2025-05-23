'use client'

import { useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import ConfirmationModal from '@/components/ConfirmationModal'
import Toast from '@/components/Toast'
import { TrashIcon } from '@heroicons/react/24/outline'

interface User {
  id: number
  name: string
  email: string
  is_admin: boolean
  contributions: Contribution[]
}

interface Contribution {
  id: number
  amount: number
  month: string
  status: string
  notes: string | null
  user_id: number
  year: string
}

interface MemberDetailsProps {
  userId: string
}

export default function MemberDetails({ userId }: MemberDetailsProps) {
  const router = useRouter()
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [isEditing, setIsEditing] = useState(false)
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    is_admin: false
  })
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
    const fetchUser = async () => {
      try {
        setLoading(true)
        const response = await fetch(`/api/users/${userId}`)
        if (!response.ok) throw new Error('Failed to fetch user')
        const userData = await response.json()
        setUser(userData)
        setFormData({
          name: userData.name,
          email: userData.email,
          is_admin: userData.is_admin
        })
        setError(null)
      } catch (err) {
        console.error('Error fetching user:', err)
        setError('Failed to load user data. Please try again later.')
      } finally {
        setLoading(false)
      }
    }

    fetchUser()
  }, [userId])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    try {
      const response = await fetch(`/api/users/${userId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      })

      if (!response.ok) throw new Error('Failed to update user')
      
      const updatedUser = await response.json()
      setUser(updatedUser)
      setIsEditing(false)
      setToast({ message: 'User updated successfully', type: 'success' })
    } catch (err) {
      console.error('Error updating user:', err)
      setToast({ message: 'Failed to update user', type: 'error' })
    }
  }

  const handleDeleteContribution = async (contributionId: number) => {
    try {
      const response = await fetch(`/api/contributions/${contributionId}`, {
        method: 'DELETE',
      })

      if (!response.ok) throw new Error('Failed to delete contribution')
      
      // Refresh user data to update contributions list
      const userResponse = await fetch(`/api/users/${userId}`)
      if (!userResponse.ok) throw new Error('Failed to fetch user')
      const userData = await userResponse.json()
      setUser(userData)
      
      setDeleteModal({ isOpen: false, contributionId: null })
      setToast({ message: 'Contribution deleted successfully', type: 'success' })
    } catch (err) {
      console.error('Error deleting contribution:', err)
      setToast({ message: 'Failed to delete contribution', type: 'error' })
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-600"></div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-red-600">{error}</div>
      </div>
    )
  }

  if (!user) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-gray-600">User not found</div>
      </div>
    )
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Member Details</h1>
        <div className="space-x-4">
          <button
            onClick={() => setIsEditing(!isEditing)}
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            {isEditing ? 'Cancel' : 'Edit'}
          </button>
          <Link
            href="/dashboard/members"
            className="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            Back to Members
          </Link>
        </div>
      </div>

      {isEditing ? (
        <form onSubmit={handleSubmit} className="bg-white shadow rounded-lg p-8 mb-8">
          <div className="space-y-6">
            <div className="space-y-2">
              <label htmlFor="name" className="block text-sm font-medium text-gray-700">
                Full Name
              </label>
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="mt-1 block w-full px-4 py-3 rounded-md border border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                required
              />
            </div>
            <div className="space-y-2">
              <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                Email
              </label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                className="mt-1 block w-full px-4 py-3 rounded-md border border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                required
              />
            </div>
            <div className="space-y-2">
              <label className="flex items-center space-x-3">
                <input
                  type="checkbox"
                  checked={formData.is_admin}
                  onChange={(e) => setFormData({ ...formData, is_admin: e.target.checked })}
                  className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                />
                <span className="text-sm font-medium text-gray-700">Admin User</span>
              </label>
            </div>
            <div className="pt-4 flex justify-end">
              <button
                type="submit"
                className="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                Save Changes
              </button>
            </div>
          </div>
        </form>
      ) : (
        <div className="bg-white shadow rounded-lg p-6 mb-8">
          <div className="space-y-4">
            <div>
              <h3 className="text-lg font-medium text-gray-900">Full Name</h3>
              <p className="mt-1 text-sm text-gray-500">{user?.name}</p>
            </div>
            <div>
              <h3 className="text-lg font-medium text-gray-900">Email</h3>
              <p className="mt-1 text-sm text-gray-500">{user?.email}</p>
            </div>
            <div>
              <h3 className="text-lg font-medium text-gray-900">Role</h3>
              <p className="mt-1 text-sm text-gray-500">
                {user?.is_admin ? 'Admin' : 'Member'}
              </p>
            </div>
          </div>
        </div>
      )}

      <div className="bg-white shadow rounded-lg p-6">
        <h2 className="text-xl font-semibold text-gray-800 mb-6">Contributions</h2>
        {user.contributions.length === 0 ? (
          <p className="text-gray-500">No contributions found</p>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Month</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notes</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {user.contributions.map((contribution) => (
                  <tr key={contribution.id}>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {`${contribution.month} ${contribution.year}`}
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
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      {contribution.notes || '-'}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                      <button
                        onClick={() => setDeleteModal({ isOpen: true, contributionId: contribution.id })}
                        className="text-red-600 hover:text-red-900 cursor-pointer"
                      >
                        <TrashIcon className="h-5 w-5" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
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