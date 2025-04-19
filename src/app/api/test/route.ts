import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { User, Contribution, Status } from '@prisma/client';

type FormattedUser = {
  id: number;
  name: string;
  email: string;
  is_admin: boolean;
  contributions: Array<{
    id: number;
    amount: number;
    month: string;
    year: number;
    status: Status;
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
    const formattedUsers: FormattedUser[] = users.map((user) => {
      const contributions = user.contributions.map((contribution) => ({
        id: contribution.id,
        amount: Number(contribution.amount),
        month: contribution.month,
        year: contribution.year,
        status: contribution.status,
        notes: contribution.notes,
      }));

      return {
        id: user.id,
        name: user.name,
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