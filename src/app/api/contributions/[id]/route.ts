import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'

export async function DELETE(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const id = (await params).id;
    if (!id) {
      return NextResponse.json(
        { error: 'Contribution ID is required' },
        { status: 400 }
      )
    }

    const contributionId = parseInt(id)
    if (isNaN(contributionId)) {
      return NextResponse.json(
        { error: 'Invalid contribution ID' },
        { status: 400 }
      )
    }

    // Check if contribution exists before deleting
    const existingContribution = await prisma.contribution.findUnique({
      where: { id: contributionId }
    })

    if (!existingContribution) {
      return NextResponse.json(
        { error: 'Contribution not found' },
        { status: 404 }
      )
    }

    // Delete the contribution
    await prisma.contribution.delete({
      where: { id: contributionId }
    })

    return NextResponse.json({ message: 'Contribution deleted successfully' })
  } catch (error) {
    console.error('Error deleting contribution:', error)
    return NextResponse.json(
      { error: 'Failed to delete contribution' },
      { status: 500 }
    )
  }
} 