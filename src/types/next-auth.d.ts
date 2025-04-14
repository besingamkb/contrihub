import "next-auth"
import { JWT } from "next-auth/jwt"

declare module "next-auth" {
  interface User {
    id: string
    name: string
    email: string
    is_admin: boolean
  }

  interface Session {
    user: User & {
      id: string
      is_admin: boolean
    }
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    id: string
    is_admin: boolean
  }
} 