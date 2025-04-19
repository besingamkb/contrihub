import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { UpdateAttendeeStatusInput } from '@/types/calendar';

export async function PUT(
  request: Request,
  { params }: { params: Promise<{ id: string; userId: string }> }
) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { id, userId } = await params;
    const event = await prisma.calendarEvent.findUnique({
      where: {
        id: parseInt(id),
      },
      include: {
        attendees: true,
      },
    });

    if (!event) {
      return NextResponse.json({ error: 'Event not found' }, { status: 404 });
    }

    const userIdNum = parseInt(userId);
    // Check if the user is an attendee
    const attendee = event.attendees.find(
      (a) => a.user_id === userIdNum
    );

    if (!attendee) {
      return NextResponse.json(
        { error: 'User is not an attendee of this event' },
        { status: 400 }
      );
    }

    // Only allow users to update their own status
    if (userIdNum !== parseInt(session.user.id)) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
    }

    const body: UpdateAttendeeStatusInput = await request.json();
    const { status } = body;

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