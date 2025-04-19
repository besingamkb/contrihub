import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { UpdateAttendeeStatusInput } from '@/types/calendar';

export async function PUT(req: NextRequest) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const { eventId, userId, status } = await req.json() as UpdateAttendeeStatusInput & { eventId: string; userId: string };

    if (userId !== session.user.id) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const event = await prisma.calendarEvent.findUnique({
      where: {
        id: parseInt(eventId),
      },
      include: {
        attendees: true,
      },
    });

    if (!event) {
      return NextResponse.json({ error: 'Event not found' }, { status: 404 });
    }

    // Check if the user is an attendee
    type CalendarEventAttendee = {
      id: number;
      user_id: number;
    };

    const attendee = event.attendees.find(
      (attendee: CalendarEventAttendee) => attendee.user_id === parseInt(userId)
    );

    if (!attendee) {
      return NextResponse.json(
        { error: 'User is not an attendee of this event' },
        { status: 400 }
      );
    }

    const updatedAttendee = await prisma.calendarEventAttendee.update({
      where: {
        id: attendee.id,
      },
      data: {
        status,
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });

    return NextResponse.json(updatedAttendee);
  } catch (error) {
    console.error('Error updating attendee status:', error);
    return NextResponse.json(
      { error: 'Failed to update attendee status' },
      { status: 500 }
    );
  }
} 