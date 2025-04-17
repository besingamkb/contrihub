import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';
import { z } from 'zod';

// Rate limiting configuration
const RATE_LIMIT_WINDOW = 60 * 1000; // 1 minute in milliseconds
const submissionTimes = new Map<string, number>();

const inquirySchema = z.object({
  subject: z.string().min(1, 'Subject is required'),
  message: z.string().min(1, 'Message is required'),
  senderName: z.string().min(1, 'Sender name is required'),
  senderEmail: z.string().email('Invalid email address'),
  senderPhone: z.string().optional(),
});

export async function POST(req: Request) {
  try {
    const session = await getServerSession(authOptions);
    if (!session) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Get client IP and check rate limit first
    const forwardedFor = req.headers.get('x-forwarded-for');
    const ip = forwardedFor ? forwardedFor.split(',')[0] : 'unknown';
    const now = Date.now();
    const lastSubmission = submissionTimes.get(ip);

    if (lastSubmission && now - lastSubmission < RATE_LIMIT_WINDOW) {
      const timeLeft = Math.ceil((RATE_LIMIT_WINDOW - (now - lastSubmission)) / 1000);
      return NextResponse.json(
        { error: `Please wait ${timeLeft} seconds before submitting another inquiry` },
        { status: 429 }
      );
    }

    // Update rate limit timestamp before processing
    submissionTimes.set(ip, now);

    // Clean up old entries
    for (const [storedIp, timestamp] of submissionTimes.entries()) {
      if (now - timestamp > RATE_LIMIT_WINDOW) {
        submissionTimes.delete(storedIp);
      }
    }

    const body = await req.json();
    const validatedData = inquirySchema.parse(body);

    const inquiry = await prisma.inquiry.create({
      data: {
        name: validatedData.senderName,
        email: validatedData.senderEmail,
        subject: validatedData.subject,
        message: validatedData.message,
      },
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
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
} 