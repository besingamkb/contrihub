import { withAuth } from "next-auth/middleware"
import { NextResponse } from "next/server"

export default withAuth(
  function middleware(req) {
    const token = req.nextauth.token
    const isAdmin = token?.is_admin === true
    const path = req.nextUrl.pathname
    const method = req.method

    // Protect admin routes
    if (path.startsWith('/dashboard/members') || 
        path.startsWith('/dashboard/reports') || 
        path.startsWith('/dashboard/inquiries')) {
      if (!isAdmin) {
        return NextResponse.redirect(new URL('/dashboard', req.url))
      }
    }

    // Protect API routes
    if (path.startsWith('/api')) {
      // Allow auth-related API routes
      if (path.startsWith('/api/auth')) {
        return NextResponse.next()
      }

      // Allow unauthenticated POST requests to /api/inquiries
      if (path === '/api/inquiries' && method === 'POST') {
        return NextResponse.next()
      }

      // Protect admin-only API routes
      if (path.startsWith('/api/dashboard')) {
        if (!isAdmin) {
          return NextResponse.json(
            { error: 'Unauthorized' },
            { status: 401 }
          )
        }
      }
    }

    return NextResponse.next()
  },
  {
    callbacks: {
      authorized: ({ token }) => !!token
    },
    pages: {
      signIn: '/login',
    },
  }
)

export const config = {
  matcher: [
    '/dashboard/:path*',
    '/profile/:path*',
    '/api/:path*',
  ]
} 