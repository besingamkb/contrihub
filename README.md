# ContriHub

A Next.js application for managing contributions.

## Getting Started

First, install the dependencies:

```bash
npm install
```

Then, run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Database Setup

### Prerequisites

Make sure you have PostgreSQL installed and running on your machine.

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
DATABASE_URL="postgresql://username:password@localhost:5432/contrihub?schema=public"
```

Replace `username` and `password` with your PostgreSQL credentials.

### Database Commands

- Create a new migration:
```bash
npx prisma migrate dev --name your_migration_name
```

- Apply migrations to production:
```bash
npx prisma migrate deploy
```

- Reset database and run all migrations (fresh install):
```bash
npm run migrate:fresh
```

- View database in Prisma Studio:
```bash
npx prisma studio
```

## Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application for production
- `npm run start` - Start the production server
- `npm run lint` - Run ESLint to check for code issues
- `npm run migrate:fresh` - Reset database and run all migrations

## Project Structure

- `src/` - Source code directory
  - `models/` - Database models
  - `components/` - React components
  - `pages/` - Next.js pages
  - `styles/` - Global styles
  - `utils/` - Utility functions

## Tech Stack

- Next.js 15
- TypeScript
- Prisma (PostgreSQL)
- Tailwind CSS
- React 19

## Learn More

To learn more about the technologies used in this project:

- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [TypeScript Documentation](https://www.typescriptlang.org/docs)
