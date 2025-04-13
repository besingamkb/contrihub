# ContriHub

A contribution management system built with Next.js, Prisma, and PostgreSQL.

## Features

- User authentication and authorization
- Contribution tracking and management
- Monthly contribution status monitoring
- Admin dashboard for user management
- Contribution history and reporting

## Prerequisites

- Node.js 18.x or later
- PostgreSQL 14.x or later
- Bun (for faster development)

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/contrihub.git
cd contrihub
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
```
Edit `.env` and set your database connection string:
```
DATABASE_URL="postgresql://username:password@localhost:5432/contrihub"
```

4. Set up the database:
```bash
# Create the database
createdb contrihub

# Run migrations
npm run migrate:fresh

# Seed the database with test data
npm run seed:all
```

The seed data includes:
- 1 admin user (admin@example.com / admin123)
- 3 regular users (john@example.com, jane@example.com, bob@example.com)
- 6 months of contributions for each regular user
- Random contribution amounts between 500 and 1500
- 70% of contributions marked as PAID and 30% as PENDING
- 1 missed contribution for each user from 2 months ago

5. Start the development server:
```bash
npm run dev
```

## Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application
- `npm run start` - Start the production server
- `npm run lint` - Run ESLint
- `npm run migrate:fresh` - Reset and run all migrations
- `npm run prisma:generate` - Generate Prisma client
- `npm run seed` - Seed the database with test data
- `npm run seed:all` - Reset database, run migrations, and seed data

## Database Management

The application uses Prisma as the ORM with PostgreSQL. Database changes should be made through Prisma migrations:

1. Make changes to `prisma/schema.prisma`
2. Create a migration:
```bash
npx prisma migrate dev --name your_migration_name
```

## Testing

To test the application with sample data:
1. Reset the database: `npm run migrate:fresh`
2. Seed the data: `npm run seed:all`

## License

MIT

## Project Structure

- `src/` - Source code directory
  - `models/` - Database models
  - `