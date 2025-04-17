import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';
import { z } from 'zod';

// Rate limiting configuration
const RATE_LIMIT_WINDOW = 60 * 1000; // 1 minute in milliseconds
const MAX_REQUESTS_PER_WINDOW = 1; // Maximum 1 request per minute
const submissionTimes = new Map<string, { count: number; timestamp: number }>();

const inquirySchema = z.object({
  name: z.string().min(1, 'Name is required'),
  email: z.string().email('Invalid email address'),
  subject: z.string().min(1, 'Subject is required'),
  message: z.string().min(1, 'Message is required'),
});

export async function GET() {
  try {
    const inquiries = await prisma.inquiry.findMany({
      select: {
        id: true,
        name: true,
        email: true,
        subject: true,
        message: true,
        created_at: true,
        updated_at: true
      },
      orderBy: {
        created_at: 'desc'
      }
    });
    return NextResponse.json(inquiries);
  } catch (error) {
    console.error('Error fetching inquiries:', error);
    return NextResponse.json(
      { error: 'Failed to fetch inquiries' },
      { status: 500 }
    );
  }
}

export async function POST(request: Request) {
  try {
    // Get client IP and check rate limit
    const forwardedFor = request.headers.get('x-forwarded-for');
    const ip = forwardedFor ? forwardedFor.split(',')[0] : 'unknown';
    const now = Date.now();

    // Clean up old entries first
    for (const [storedIp, data] of submissionTimes.entries()) {
      if (now - data.timestamp > RATE_LIMIT_WINDOW) {
        submissionTimes.delete(storedIp);
      }
    }

    // Check rate limit
    const userData = submissionTimes.get(ip);
    if (userData) {
      if (now - userData.timestamp < RATE_LIMIT_WINDOW) {
        if (userData.count >= MAX_REQUESTS_PER_WINDOW) {
          const timeLeft = Math.ceil((RATE_LIMIT_WINDOW - (now - userData.timestamp)) / 1000);
          return NextResponse.json(
            { error: `Too many requests. Please wait ${timeLeft} seconds before submitting another inquiry` },
            { status: 429 }
          );
        }
        // Update count for existing user
        submissionTimes.set(ip, { count: userData.count + 1, timestamp: userData.timestamp });
      } else {
        // Reset count for new window
        submissionTimes.set(ip, { count: 1, timestamp: now });
      }
    } else {
      // First request from this IP
      submissionTimes.set(ip, { count: 1, timestamp: now });
    }

    const body = await request.json();
    const validatedData = inquirySchema.parse(body);

    const inquiry = await prisma.inquiry.create({
      data: {
        name: validatedData.name,
        email: validatedData.email,
        subject: validatedData.subject,
        message: validatedData.message
      }
    });

    return NextResponse.json(inquiry, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Validation error', details: error.errors },
        { status: 400 }
      );
    }
    console.error('Error creating inquiry:', error);
    return NextResponse.json(
      { error: 'Failed to create inquiry' },
      { status: 500 }
    );
  }
} 