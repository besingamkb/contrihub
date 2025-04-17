import { NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

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
    const body = await request.json();
    const { name, email, subject, message } = body;

    if (!name || !email || !subject || !message) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      );
    }

    const inquiry = await prisma.inquiry.create({
      data: {
        name,
        email,
        subject,
        message
      }
    });

    return NextResponse.json(inquiry, { status: 201 });
  } catch (error) {
    console.error('Error creating inquiry:', error);
    return NextResponse.json(
      { error: 'Failed to create inquiry' },
      { status: 500 }
    );
  }
} 