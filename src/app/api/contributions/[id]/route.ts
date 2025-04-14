import { NextResponse } from 'next/server'
import prisma from '@/lib/prisma'

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const contributionId = parseInt(params.id)
    if (isNaN(contributionId)) {
      return NextResponse.json(
        { error: 'Invalid contribution ID' },
        { status: 400 }
      )
    }

    // Delete the contribution
    const contribution = await prisma.contribution.delete({
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