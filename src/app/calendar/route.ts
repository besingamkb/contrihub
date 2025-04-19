import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { CreateCalendarEventInput } from '@/types/calendar';

export async function GET(request: Request) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { searchParams } = new URL(request.url);
    const startDate = searchParams.get('startDate');
    const endDate = searchParams.get('endDate');

    const events = await prisma.calendarEvent.findMany({
      where: {
        ...(startDate && endDate
          ? {
              start_time: {
                gte: new Date(startDate),
                lte: new Date(endDate),
              },
            }
          : {}),
      },
      include: {
        attendees: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true,
              },
            },
          },
        },
        creator: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
      orderBy: {
        start_time: 'asc',
      },
    });

    return NextResponse.json(events);
  } catch (error) {
    console.error('Error fetching calendar events:', error);
    return NextResponse.json(
      { error: 'Failed to fetch calendar events' },
      { status: 500 }
    );
  }
}

export async function POST(request: Request) {
  try {
    const session = await getServerSession(authOptions);
    if (!session?.user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body: CreateCalendarEventInput = await request.json();
    const { title, description, start_time, end_time, location, attendeeIds } = body;

    const event = await prisma.calendarEvent.create({
      data: {
        title,
        description,
        start_time: new Date(start_time),
        end_time: new Date(end_time),
        location,
        created_by: session.user.id,
        attendees: {
          create: [
            // Creator is always an attendee
            {
              user_id: session.user.id,
              status: 'ACCEPTED',
            },
            // Add other attendees if provided
            ...(attendeeIds || []).map((userId) => ({
              user_id: userId,
              status: 'PENDING',
            })),
          ],
        },
      },
      include: {
        attendees: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true,
              },
            },
          },
        },
        creator: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });

    return NextResponse.json(event);
  } catch (error) {
    console.error('Error creating calendar event:', error);
    return NextResponse.json(
      { error: 'Failed to create calendar event' },
      { status: 500 }
    );
  }
} 