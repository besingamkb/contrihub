import { AttendeeStatus } from '@prisma/client';

export interface CalendarEvent {
  id: string;
  title: string;
  description: string;
  start_time: string;
  end_time: string;
  location: string;
  created_by: string;
  created_at: string;
  updated_at: string;
  attendees?: {
    user: {
      id: string;
      name: string;
      email: string;
    };
    status: AttendeeStatus;
  }[];
  creator?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface FullCalendarEvent {
  id: string;
  title: string;
  description: string;
  start: string;
  end: string;
  location: string;
  backgroundColor: string;
  borderColor: string;
  attendees?: {
    user: {
      id: string;
      name: string;
      email: string;
    };
    status: 'ACCEPTED' | 'DECLINED' | 'PENDING' | 'TENTATIVE';
  }[];
  creator?: {
    id: string;
    name: string;
    email: string;
  };
}

export type CalendarEventAttendee = {
  id: number;
  event_id: number;
  user_id: number;
  status: AttendeeStatus;
  created_at: Date;
  updated_at: Date;
};

export type CalendarEventWithAttendees = CalendarEvent & {
  attendees: (CalendarEventAttendee & {
    user: {
      id: number;
      name: string;
      email: string;
    };
  })[];
  creator: {
    id: number;
    name: string;
    email: string;
  };
};

export type CreateCalendarEventInput = {
  title: string;
  description?: string;
  start_time: Date;
  end_time: Date;
  location?: string;
  attendeeIds?: number[];
};

export type UpdateCalendarEventInput = Partial<CreateCalendarEventInput>;

export type UpdateAttendeeStatusInput = {
  status: AttendeeStatus;
}; 