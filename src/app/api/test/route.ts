import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

type FormattedUser = {
  id: number;
  fullname: string;
  email: string;
  is_admin: boolean;
  contributions: Array<{
    id: number;
    amount: number;
    month: Date;
    status: string;
    notes: string | null;
  }>;
};

type User = {
  id: number;
  fullname: string;
  email: string;
  is_admin: boolean;
  contributions: Array<{
    id: number;
    amount: number;
    month: Date;
    status: string;
    notes: string | null;
  }>;
};

export async function GET() {
  try {
    // Get all users with their contributions
    const users = await prisma.user.findMany({
      include: {
        contributions: {
          orderBy: {
            month: 'desc',
          },
        },
      },
    });

    // Format the response
    const formattedUsers: FormattedUser[] = users.map((user: User) => {
      const contributions = user.contributions.map((contribution) => ({
        id: contribution.id,
        amount: Number(contribution.amount),
        month: contribution.month,
        status: contribution.status,
        notes: contribution.notes,
      }));

      return {
        id: user.id,
        fullname: user.fullname,
        email: user.email,
        is_admin: user.is_admin,
        contributions,
      };
    });

    return NextResponse.json({
      success: true,
      data: formattedUsers,
    });
  } catch (error) {
    console.error('Error fetching test data:', error);
    return NextResponse.json(
      {
        success: false,
        error: 'Failed to fetch test data',
      },
      { status: 500 }
    );
  }
} 