'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { PlusIcon, TrashIcon } from '@heroicons/react/24/outline'
import ConfirmationModal from '@/components/ConfirmationModal'
import Toast from '@/components/Toast'
import DataTable from '@/components/DataTable'

interface User {
  id: number
  name: string
  email: string
  is_admin: boolean
}

export default function MembersPage() {
  const [users, setUsers] = useState<User[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [deleteModal, setDeleteModal] = useState<{
    isOpen: boolean
    userId: number | null
  }>({
    isOpen: false,
    userId: null
  })
  const [toast, setToast] = useState<{
    message: string
    type: 'success' | 'error'
  } | null>(null)

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setLoading(true)
        const response = await fetch('/api/users')
        if (!response.ok) throw new Error('Failed to fetch users')
        const data = await response.json()
        setUsers(data)
        setError(null)
      } catch (err) {
        console.error('Error fetching users:', err)
        setError('Failed to load users. Please try again later.')
      } finally {
        setLoading(false)
      }
    }

    fetchUsers()
  }, [])

  const handleDeleteUser = async (userId: number) => {
    try {
      const response = await fetch(`/api/users/${userId}`, {
        method: 'DELETE',
      })

      if (!response.ok) throw new Error('Failed to delete user')
      
      setUsers(users.filter(user => user.id !== userId))
      setDeleteModal({ isOpen: false, userId: null })
      setToast({ message: 'User deleted successfully', type: 'success' })
    } catch (err) {
      console.error('Error deleting user:', err)
      setToast({ message: 'Failed to delete user', type: 'error' })
    }
  }

  const columns = [
    {
      header: 'Full Name',
      accessor: 'name',
      render: (value: string, row: User) => (
        <Link
          href={`/dashboard/members/${row.id}`}
          className="text-blue-600 hover:text-blue-800"
        >
          {value}
        </Link>
      )
    },
    {
      header: 'Email',
      accessor: 'email'
    },
    {
      header: 'Role',
      accessor: 'is_admin',
      render: (value: boolean) => (
        <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
          value ? 'bg-purple-100 text-purple-800' : 'bg-gray-100 text-gray-800'
        }`}>
          {value ? 'Admin' : 'Member'}
        </span>
      )
    },
    {
      header: 'Actions',
      accessor: 'id',
      render: (value: number) => (
        <button
          onClick={() => setDeleteModal({ isOpen: true, userId: value })}
          className="text-red-600 hover:text-red-900 cursor-pointer"
        >
          <TrashIcon className="h-5 w-5" />
        </button>
      )
    }
  ]

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

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-md p-6">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold text-gray-900">Members</h1>
          <Link
            href="/dashboard/members/create"
            className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Member
          </Link>
        </div>
        <DataTable
          columns={columns}
          data={users}
          itemsPerPage={10}
          searchableColumns={['name', 'email']}
        />
      </div>

      <ConfirmationModal
        isOpen={deleteModal.isOpen}
        onClose={() => setDeleteModal({ isOpen: false, userId: null })}
        onConfirm={() => {
          if (deleteModal.userId) {
            handleDeleteUser(deleteModal.userId)
          }
        }}
        title="Delete Member"
        message="Are you sure you want to delete this member? This action cannot be undone."
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