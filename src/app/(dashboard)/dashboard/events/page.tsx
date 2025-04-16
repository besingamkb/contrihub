'use client'

import dynamic from 'next/dynamic'
import { useEffect, useState } from 'react'
import type { PluginDef } from '@fullcalendar/core'
import { CalendarEvent, FullCalendarEvent, CreateCalendarEventInput, CalendarEventWithAttendees } from '@/types/calendar'
import EventDetailsModal from '@/components/calendar/EventDetailsModal'
import CreateEventModal from '@/components/calendar/CreateEventModal'
import { PlusIcon } from '@heroicons/react/24/outline'
import { User } from '@prisma/client'

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
  const [selectedEvent, setSelectedEvent] = useState<FullCalendarEvent | null>(null)
  const [isDetailsModalOpen, setIsDetailsModalOpen] = useState(false)
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false)
  const [users, setUsers] = useState<User[]>([])

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
    const fetchData = async () => {
      try {
        const [eventsResponse, usersResponse] = await Promise.all([
          fetch('/api/calendar/events'),
          fetch('/api/users')
        ]);

        if (!eventsResponse.ok) {
          throw new Error('Failed to fetch events');
        }
        if (!usersResponse.ok) {
          throw new Error('Failed to fetch users');
        }

        const eventsData: CalendarEventWithAttendees[] = await eventsResponse.json();
        const usersData: User[] = await usersResponse.json();
        
        // Transform the API response to match FullCalendar's expected format
        const transformedEvents: FullCalendarEvent[] = eventsData.map((event) => ({
          id: event.id.toString(),
          title: event.title,
          description: event.description || '',
          start: event.start_time,
          end: event.end_time,
          location: event.location || '',
          backgroundColor: '#3b82f6', // Default blue color
          borderColor: '#3b82f6',
          attendees: event.attendees?.map(attendee => ({
            user: attendee.user,
            status: attendee.status
          })),
          creator: event.creator
        }));
        
        setEvents(transformedEvents);
        setUsers(usersData);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setIsLoading(false);
      }
    };

    if (mounted) {
      fetchData();
    }
  }, [mounted]);

  const handleEventClick = (info: any) => {
    const event = events.find(e => e.id === info.event.id)
    if (event) {
      setSelectedEvent(event)
      setIsDetailsModalOpen(true)
    }
  }

  const handleCreateEvent = async (eventData: CreateCalendarEventInput) => {
    try {
      const response = await fetch('/api/calendar', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(eventData),
      });

      if (!response.ok) {
        throw new Error('Failed to create event');
      }

      const newEvent: CalendarEventWithAttendees = await response.json();
      
      // Add the new event to the calendar
      setEvents(prevEvents => [
        ...prevEvents,
        {
          id: newEvent.id.toString(),
          title: newEvent.title,
          description: newEvent.description || '',
          start: newEvent.start_time,
          end: newEvent.end_time,
          location: newEvent.location || '',
          backgroundColor: '#3b82f6',
          borderColor: '#3b82f6',
          attendees: newEvent.attendees?.map(attendee => ({
            user: attendee.user,
            status: attendee.status
          })),
          creator: newEvent.creator
        }
      ]);
    } catch (err) {
      throw err;
    }
  };

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
      <div className="mb-6 flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold">Events Calendar</h1>
          <p className="text-gray-600">View your scheduled events for {new Date().toLocaleString('default', { month: 'long', year: 'numeric' })}</p>
        </div>
        <button
          onClick={() => setIsCreateModalOpen(true)}
          className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          <PlusIcon className="-ml-1 mr-2 h-5 w-5" />
          New Event
        </button>
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
          eventClick={handleEventClick}
        />
      </div>

      <EventDetailsModal
        isOpen={isDetailsModalOpen}
        onClose={() => setIsDetailsModalOpen(false)}
        event={selectedEvent}
      />

      <CreateEventModal
        isOpen={isCreateModalOpen}
        onClose={() => setIsCreateModalOpen(false)}
        onCreateEvent={handleCreateEvent}
        users={users}
      />
    </div>
  )
} 