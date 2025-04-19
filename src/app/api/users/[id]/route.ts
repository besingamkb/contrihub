import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    // Get the session with the correct options
    const session = await getServerSession(authOptions)
    
    // Log the session for debugging
    console.log('Session:', JSON.stringify(session, null, 2))
    console.log('Params ID:', params.id)

    // Check if session exists and has user
    if (!session?.user?.id) {
      console.log('No valid session found')
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }

    // Parse the user ID from params
    const userId = parseInt(params.id)
    if (isNaN(userId)) {
      console.log('Invalid user ID format')
      return NextResponse.json(
        { error: 'Invalid user ID' },
        { status: 400 }
      )
    }

    // Parse the session user ID
    const sessionUserId = parseInt(session.user.id)
    console.log('Session user ID:', sessionUserId)
    console.log('Requested user ID:', userId)
    console.log('Is admin:', session.user.is_admin)

    // Allow access if user is admin or accessing their own data
    if (!session.user.is_admin && sessionUserId !== userId) {
      console.log('Access denied: Not admin and not own data')
      return NextResponse.json(
        { error: 'Forbidden' },
        { status: 403 }
      )
    }

    // Fetch the user data
    const user = await prisma.user.findUnique({
      where: {
        id: userId,
      },
      select: {
        id: true,
        name: true,
        email: true,
        is_admin: true,
        contributions: {
          select: {
            id: true,
            amount: true,
            month: true,
            year: true,
            status: true,
            notes: true,
          },
          orderBy: {
            month: 'desc'
          }
        }
      },
    })

    if (!user) {
      console.log('User not found in database')
      return NextResponse.json(
        { error: 'User not found' },
        { status: 404 }
      )
    }

    return NextResponse.json(user)
  } catch (error) {
    console.error('Error fetching user:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function PUT(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const userId = parseInt(params.id)
    if (isNaN(userId)) {
      return NextResponse.json(
        { error: 'Invalid user ID' },
        { status: 400 }
      )
    }

    const body = await request.json()
    const { name, email, is_admin } = body

    // Check if email already exists for another user
    const existingUser = await prisma.user.findFirst({
      where: {
        email,
        NOT: {
          id: userId
        }
      }
    })

    if (existingUser) {
      return NextResponse.json(
        { error: 'Email already exists' },
        { status: 400 }
      )
    }

    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: {
        name,
        email,
        is_admin
      },
      include: {
        contributions: {
          orderBy: {
            month: 'desc'
          }
        }
      }
    })

    return NextResponse.json(updatedUser)
  } catch (error) {
    console.error('Error updating user:', error)
    return NextResponse.json(
      { error: 'Failed to update user' },
      { status: 500 }
    )
  }
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    const userId = parseInt(params.id)
    if (isNaN(userId)) {
      return NextResponse.json(
        { error: 'Invalid user ID' },
        { status: 400 }
      )
    }

    // First, delete all contributions associated with the user
    await prisma.contribution.deleteMany({
      where: { user_id: userId }
    })

    // Then delete the user
    const user = await prisma.user.delete({
      where: { id: userId }
    })

    return NextResponse.json({ message: 'User deleted successfully' })
  } catch (error) {
    console.error('Error deleting user:', error)
    return NextResponse.json(
      { error: 'Failed to delete user' },
      { status: 500 }
    )
  }
} 