'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useSession, signOut } from 'next-auth/react'

export default function Sidebar() {
  const pathname = usePathname()
  const { data: session } = useSession()

  const handleLogout = async () => {
    await signOut({ redirect: true, callbackUrl: '/login' })
  }

  return (
    <div className="flex flex-col h-full w-64 bg-white shadow-lg">
      <div className="flex items-center justify-center h-16 bg-indigo-600">
        <h1 className="text-white text-xl font-bold">ContriHub</h1>
      </div>
      <nav className="flex-1 px-2 py-4 space-y-1">
        {session?.user?.is_admin ? (
          // Admin Navigation
          <>
            <Link
              href="/dashboard"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Dashboard
            </Link>
            <Link
              href="/dashboard/members"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/members'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Members
            </Link>
            <Link
              href="/dashboard/contributions"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/contributions'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Contributions
            </Link>
            <Link
              href="/dashboard/inquiries"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/inquiries'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Inquiries
            </Link>
            <Link
              href="/dashboard/events"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/events'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Events
            </Link>
            <Link
              href="/dashboard/reports"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/reports'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Reports
            </Link>
          </>
        ) : (
          // Normal User Navigation
          <>
            <Link
              href="/dashboard/profile"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/profile'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Profile
            </Link>
            <Link
              href="/dashboard/events"
              className={`flex items-center px-4 py-2 text-sm font-medium rounded-md ${
                pathname === '/dashboard/events'
                  ? 'bg-indigo-100 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50'
              }`}
            >
              Events
            </Link>
          </>
        )}
      </nav>
      <div className="p-4 border-t">
        <div className="mb-4 px-4 py-2 text-sm text-gray-600">
          Signed in as: {session?.user?.name}
          <div className="mt-2">
            <span className={`px-2 py-1 text-xs font-semibold rounded-full ${
              session?.user?.is_admin 
                ? 'bg-purple-100 text-purple-800' 
                : 'bg-gray-100 text-gray-800'
            }`}>
              {session?.user?.is_admin ? 'Admin' : 'Member'}
            </span>
          </div>
        </div>
        <button
          onClick={handleLogout}
          className="w-full px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 rounded-md hover:bg-gray-200"
        >
          Logout
        </button>
      </div>
    </div>
  )
} 