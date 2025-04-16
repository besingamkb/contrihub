'use client'

import dynamic from 'next/dynamic'
import { useEffect, useState } from 'react'
import type { PluginDef } from '@fullcalendar/core'
import { CalendarEvent, FullCalendarEvent } from '@/types/calendar'

// Dynamically import FullCalendar with no SSR
const FullCalendar = dynamic(() => import('@fullcalendar/react'), {
  ssr: false
})

export default function EventsPage() {
  const [mounted, setMounted] = useState(false)
  const [plugins, setPlugins] = useState<PluginDef[]>([])
  const [events, setEvents] = useState<FullCalendarEvent[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

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

  useEffect(() => {
    const fetchEvents = async () => {
      try {
        const response = await fetch('/api/calendar/events')
        if (!response.ok) {
          throw new Error('Failed to fetch events')
        }
        const data: CalendarEvent[] = await response.json()
        
        // Transform the API response to match FullCalendar's expected format
        const transformedEvents: FullCalendarEvent[] = data.map((event) => ({
          id: event.id.toString(),
          title: event.title,
          description: event.description || '',
          start: event.start_time,
          end: event.end_time,
          location: event.location || '',
          backgroundColor: '#3b82f6', // Default blue color
          borderColor: '#3b82f6',
          attendees: event.attendees,
          creator: event.creator
        }))
        
        setEvents(transformedEvents)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred')
      } finally {
        setIsLoading(false)
      }
    }

    if (mounted) {
      fetchEvents()
    }
  }, [mounted])

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

  if (error) {
    return (
      <div className="p-6">
        <div className="mb-6">
          <h1 className="text-2xl font-bold">Events Calendar</h1>
          <p className="text-red-600">Error: {error}</p>
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
          events={events}
          editable={false}
          dayMaxEvents={true}
          height="auto"
        />
      </div>
    </div>
  )
} 