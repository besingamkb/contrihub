'use client'

import { useState, useEffect } from 'react'
import { useSession } from 'next-auth/react'
import { useRouter } from 'next/navigation'

type UserData = {
  id: number
  name: string
  email: string
  is_admin: boolean
}

export default function ProfilePage() {
  const { data: session, status } = useSession()
  const router = useRouter()
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [userData, setUserData] = useState<UserData | null>(null)

  useEffect(() => {
    if (status === 'loading') return
    if (!session) {
      router.push('/login')
      return
    }

    fetchUserData()
  }, [session, status, router])

  const fetchUserData = async () => {
    try {
      setLoading(true)
      const response = await fetch(`/api/users/${session?.user?.id}`)
      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.error || 'Failed to fetch user data')
      }
      const data = await response.json()
      setUserData(data)
      setError(null)
    } catch (error) {
      console.error('Error fetching user data:', error)
      setError(error instanceof Error ? error.message : 'Failed to fetch user data')
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-red-600">{error}</div>
      </div>
    )
  }

  if (!userData) {
    return null
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="max-w-3xl mx-auto">
        <h1 className="text-2xl font-bold text-gray-900 mb-6">Profile</h1>
        <div className="bg-white shadow rounded-lg p-6">
          <div className="space-y-4">
            <div>
              <h3 className="text-lg font-medium text-gray-900">Full Name</h3>
              <p className="mt-1 text-sm text-gray-500">{userData.name}</p>
            </div>
            <div>
              <h3 className="text-lg font-medium text-gray-900">Email</h3>
              <p className="mt-1 text-sm text-gray-500">{userData.email}</p>
            </div>
            <div>
              <h3 className="text-lg font-medium text-gray-900">Role</h3>
              <p className="mt-1 text-sm text-gray-500">
                {userData.is_admin ? 'Admin' : 'Member'}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 