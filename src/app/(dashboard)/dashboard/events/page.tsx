'use client'

import dynamic from 'next/dynamic'
import { useEffect, useState } from 'react'
import type { PluginDef } from '@fullcalendar/core'

// Dynamically import FullCalendar with no SSR
const FullCalendar = dynamic(() => import('@fullcalendar/react'), {
  ssr: false
})

// Get current date
const now = new Date()
const currentMonth = now.getMonth() + 1 // JavaScript months are 0-based
const currentYear = now.getFullYear()

// Sample events data for current month
const sampleEvents = [
  {
    title: 'Weekly Team Sync',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-01T10:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-01T11:00:00`,
    backgroundColor: '#3b82f6',
    borderColor: '#3b82f6',
  },
  {
    title: 'Project Planning',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-02T14:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-02T16:00:00`,
    backgroundColor: '#10b981',
    borderColor: '#10b981',
  },
  {
    title: 'Code Review',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-03T09:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-03T10:30:00`,
    backgroundColor: '#8b5cf6',
    borderColor: '#8b5cf6',
  },
  {
    title: 'Client Meeting',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-04T13:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-04T14:30:00`,
    backgroundColor: '#f59e0b',
    borderColor: '#f59e0b',
  },
  {
    title: 'Sprint Planning',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-08T10:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-08T12:00:00`,
    backgroundColor: '#3b82f6',
    borderColor: '#3b82f6',
  },
  {
    title: 'Team Building',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-10T15:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-10T17:00:00`,
    backgroundColor: '#ef4444',
    borderColor: '#ef4444',
  },
  {
    title: 'Product Demo',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-15T11:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-15T12:30:00`,
    backgroundColor: '#10b981',
    borderColor: '#10b981',
  },
  {
    title: 'Monthly Review',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-22T09:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-22T11:00:00`,
    backgroundColor: '#3b82f6',
    borderColor: '#3b82f6',
  },
  {
    title: 'Workshop: New Features',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-25T13:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-25T15:00:00`,
    backgroundColor: '#8b5cf6',
    borderColor: '#8b5cf6',
  },
  {
    title: 'End of Month Review',
    start: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-30T14:00:00`,
    end: `${currentYear}-${currentMonth.toString().padStart(2, '0')}-30T16:00:00`,
    backgroundColor: '#f59e0b',
    borderColor: '#f59e0b',
  }
]

export default function EventsPage() {
  const [mounted, setMounted] = useState(false)
  const [plugins, setPlugins] = useState<PluginDef[]>([])

  useEffect(() => {
    setMounted(true)
    // Load plugins after component mounts
    Promise.all([
      import('@fullcalendar/daygrid'),
      import('@fullcalendar/timegrid'),
      import('@fullcalendar/interaction')
    ]).then(([dayGrid, timeGrid, interaction]) => {
      setPlugins([dayGrid.default, timeGrid.default, interaction.default])
    })
  }, [])

  if (!mounted || plugins.length === 0) {
    return (
      <div className="p-6">
        <div className="mb-6">
          <h1 className="text-2xl font-bold">Events Calendar</h1>
          <p className="text-gray-600">Loading calendar...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="mb-6">
        <h1 className="text-2xl font-bold">Events Calendar</h1>
        <p className="text-gray-600">View your scheduled events for {new Date().toLocaleString('default', { month: 'long', year: 'numeric' })}</p>
      </div>
      
      <div className="bg-white rounded-lg shadow p-4">
        <FullCalendar
          plugins={plugins}
          initialView="dayGridMonth"
          headerToolbar={{
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          }}
          events={sampleEvents}
          editable={false}
          dayMaxEvents={true}
          height="auto"
          eventClick={(info) => {
            console.log('Event clicked:', info.event.title)
          }}
        />
      </div>
    </div>
  )
} 