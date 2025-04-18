import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'
import bcrypt from 'bcrypt'
import { getServerSession } from 'next-auth'
import { authOptions } from '../auth/[...nextauth]/route'

export async function GET(request: Request) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    try {
      const users = await prisma.user.findMany({
        select: {
          id: true,
          name: true,
          email: true,
          is_admin: true,
        },
      })
      return NextResponse.json(users)
    } catch (dbError) {
      console.error('Database Error:', dbError)
      return NextResponse.json(
        { error: 'Failed to fetch users' },
        { status: 500 }
      )
    }
  } catch (error) {
    console.error('Users API Error:', error)
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Internal server error" },
      { status: 500 }
    )
  }
}

export async function POST(request: Request) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session?.user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { name, email, password, is_admin } = body

    try {
      // Check if email already exists
      const existingUser = await prisma.user.findUnique({
        where: { email },
      })

      if (existingUser) {
        return NextResponse.json(
          { error: 'Email already exists' },
          { status: 400 }
        )
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10)

      // Create user
      const user = await prisma.user.create({
        data: {
          name,
          email,
          password: hashedPassword,
          is_admin: is_admin || false,
        },
      })

      return NextResponse.json(user, { status: 201 })
    } catch (dbError) {
      console.error('Database Error:', dbError)
      return NextResponse.json(
        { error: 'Failed to create user' },
        { status: 500 }
      )
    }
  } catch (error) {
    console.error('Users API Error:', error)
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Internal server error" },
      { status: 500 }
    )
  }
} 