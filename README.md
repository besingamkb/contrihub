# ContriHub - Community Management System

A modern web application built with Next.js 15 for managing community contributions, events, and user administration.

## Features

- **User Management**
  - Member registration and profile management
  - Admin access control
  - User role management (Admin/Member)
  - Secure authentication with NextAuth.js

- **Contribution Tracking**
  - Monthly contribution records
  - Contribution status tracking (PENDING/PAID/MISSED)
  - Contribution history view
  - Contribution management

- **Event Management**
  - Calendar integration with FullCalendar
  - Event creation and management
  - Attendee tracking
  - Event status management (PENDING/ACCEPTED/DECLINED/TENTATIVE)

- **Contact System**
  - Inquiry form handling
  - Message management
  - Admin response system

- **Modern UI/UX**
  - Responsive design with Tailwind CSS
  - Interactive forms
  - Toast notifications
  - Confirmation modals
  - Loading states
  - Beautiful calendar interface

## Tech Stack

- **Frontend**
  - Next.js 15.3.0
  - React 19
  - TypeScript
  - Tailwind CSS 4
  - Heroicons
  - FullCalendar
  - HeadlessUI

- **Backend**
  - Next.js API Routes
  - Prisma ORM
  - PostgreSQL
  - NextAuth.js
  - Bcrypt for password hashing

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/contrihub.git
   cd contrihub
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   Create a `.env` file in the root directory with the following variables:
   ```
   DATABASE_URL="your_database_url"
   NEXTAUTH_SECRET="your_nextauth_secret"
   NEXTAUTH_URL="http://localhost:3000"
   ```

4. **Run database migrations and seed data**
   ```bash
   npm run migrate:fresh
   npm run seed
   ```

5. **Start the development server**
   ```bash
   npm run dev
   ```

6. **Open your browser**
   Visit `http://localhost:3000` to see the application.

## Project Structure

```
contrihub/
├── app/
│   ├── api/
│   │   ├── auth/
│   │   │   └── [...nextauth]/
│   │   │       └── route.ts
│   │   ├── contributions/
│   │   │   └── route.ts
│   │   ├── events/
│   │   │   └── route.ts
│   │   └── inquiries/
│   │       └── route.ts
│   ├── (auth)/
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── register/
│   │       └── page.tsx
│   ├── (dashboard)/
│   │   ├── contributions/
│   │   │   └── page.tsx
│   │   ├── events/
│   │   │   └── page.tsx
│   │   └── profile/
│   │       └── page.tsx
│   └── layout.tsx
├── prisma/
│   ├── schema.prisma
│   └── seed.ts
├── public/
│   └── images/
├── src/
│   ├── components/
│   │   ├── ui/
│   │   │   ├── button.tsx
│   │   │   ├── input.tsx
│   │   │   └── modal.tsx
│   │   ├── forms/
│   │   │   ├── contribution-form.tsx
│   │   │   └── event-form.tsx
│   │   └── layout/
│   │       ├── header.tsx
│   │       └── sidebar.tsx
│   ├── lib/
│   │   ├── auth.ts
│   │   ├── db.ts
│   │   └── utils.ts
│   └── styles/
│       └── globals.css
├── .env
├── .env.local
├── .gitignore
├── next.config.js
├── next.config.ts
├── package.json
├── postcss.config.mjs
├── tsconfig.json
└── README.md
```

## Database Schema

The application uses the following main models:

- **User**: Handles user accounts and authentication
- **Contribution**: Tracks member contributions
- **CalendarEvent**: Manages community events
- **CalendarEventAttendee**: Tracks event attendance
- **Inquiry**: Handles contact form submissions

## Available Commands

### Development
- `npm run dev` - Start development server with Prisma generation
- `npm run build` - Build for production with Prisma generation
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

### Database Management
- `npm run migrate:fresh` - Reset database and run migrations
- `npm run prisma:generate` - Generate Prisma client
- `npm run seed` - Run database seeder
- `npm run seed:all` - Reset, generate, and seed database

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.