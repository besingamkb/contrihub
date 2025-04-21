'use client'

import { useState } from 'react'
import Sidebar from '@/components/Sidebar'

interface DashboardLayoutProps {
  children: React.ReactNode
}

export default function DashboardLayout({ children }: DashboardLayoutProps) {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true)

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Sidebar */}
      <div className={`fixed inset-y-0 left-0 transform ${isSidebarOpen ? 'translate-x-0' : '-translate-x-full'} transition-transform duration-200 ease-in-out`}>
        <Sidebar />
      </div>

      {/* Main content */}
      <div className={`flex-1 ${isSidebarOpen ? 'ml-64' : ''}`}>
        <div className="flex items-center justify-between h-16 bg-white shadow">
          <div className="px-4">
            <button
              onClick={() => setIsSidebarOpen(!isSidebarOpen)}
              className="text-gray-500 hover:text-gray-700"
              aria-label="Toggle sidebar"
            >
              <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>
        <main className="p-6">
          {children}
        </main>
        <div className="p-6 text-center text-gray-500 text-sm">
          Made with ❤️ by <a href="https://mks4bsoftware.com/" target="_blank" rel="noopener noreferrer" className="hover:text-gray-700">@mks4bsoftware</a>
        </div>
      </div>
    </div>
  )
} 