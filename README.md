# ContriHub - Contribution Management System

A modern web application built with Next.js 14 for managing member contributions and user administration.

## Features

- **User Management**
  - Member registration and profile management
  - Admin access control
  - User role management (Admin/Member)

- **Contribution Tracking**
  - Monthly contribution records
  - Contribution status tracking (PAID/PENDING)
  - Contribution history view
  - Contribution deletion with confirmation

- **Dashboard**
  - Overview of all members
  - Quick access to member details
  - Contribution status at a glance

- **Modern UI/UX**
  - Responsive design
  - Interactive forms
  - Toast notifications
  - Confirmation modals
  - Loading states

## Tech Stack

- **Frontend**
  - Next.js 14
  - TypeScript
  - Tailwind CSS
  - Heroicons
  - React Hook Form

- **Backend**
  - Next.js API Routes
  - Prisma ORM
  - PostgreSQL

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
   ```

4. **Run database migrations**
   ```bash
   npx prisma migrate dev
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
├── src/
│   ├── app/
│   │   ├── (dashboard)/
│   │   │   ├── dashboard/
│   │   │   │   ├── members/
│   │   │   │   │   ├── [id]/
│   │   │   │   │   │   ├── MemberDetails.tsx
│   │   │   │   │   │   └── page.tsx
│   │   │   │   │   ├── create/
│   │   │   │   │   │   └── page.tsx
│   │   │   │   │   └── page.tsx
│   │   │   │   └── page.tsx
│   │   ├── api/
│   │   │   ├── users/
│   │   │   │   ├── [id]/
│   │   │   │   │   └── route.ts
│   │   │   │   └── route.ts
│   │   │   └── contributions/
│   │   │       ├── [id]/
│   │   │       │   └── route.ts
│   │   │       └── route.ts
│   ├── components/
│   │   ├── ConfirmationModal.tsx
│   │   └── Toast.tsx
│   └── lib/
│       └── prisma.ts
├── prisma/
│   └── schema.prisma
├── .env
├── .gitignore
├── package.json
└── README.md
```

## API Endpoints

### Users
- `GET /api/users` - Get all users
- `GET /api/users/[id]` - Get user by ID
- `PUT /api/users/[id]` - Update user
- `DELETE /api/users/[id]` - Delete user

### Contributions
- `GET /api/contributions` - Get all contributions
- `GET /api/contributions/[id]` - Get contribution by ID
- `POST /api/contributions` - Create new contribution
- `PUT /api/contributions/[id]` - Update contribution
- `DELETE /api/contributions/[id]` - Delete contribution

## Available Commands

### Development
- `npm run dev` - Start the development server with hot reloading
  ```bash
  npm run dev
  ```
  This command starts the Next.js development server on `http://localhost:3000` with hot reloading enabled.

- `npm run build` - Build the application for production
  ```bash
  npm run build
  ```
  Creates an optimized production build of your application.

- `npm run start` - Start the production server
  ```bash
  npm run start
  ```
  Runs the production build of your application.

- `npm run lint` - Run ESLint to check for code quality issues
  ```bash
  npm run lint
  ```
  Checks your code for potential problems and style issues.

### Database Management
- `npx prisma generate` - Generate Prisma Client
  ```bash
  npx prisma generate
  ```
  Generates the Prisma Client based on your schema.

- `npx prisma migrate dev` - Create and apply database migrations
  ```bash
  npx prisma migrate dev
  ```
  Creates a new migration and applies it to the database. Use this during development.

- `npx prisma migrate reset` - Reset the database
  ```bash
  npx prisma migrate reset
  ```
  Resets the database to the last successful migration.

- `npx prisma db push` - Push schema changes to the database
  ```bash
  npx prisma db push
  ```
  Pushes the schema changes to the database without creating migrations.

- `npx prisma studio` - Open Prisma Studio
  ```bash
  npx prisma studio
  ```
  Opens Prisma Studio, a visual database management tool.

### TypeScript
- `npm run type-check` - Run TypeScript type checking
  ```bash
  npm run type-check
  ```
  Checks your TypeScript code for type errors.

- `npm run type-check:watch` - Run TypeScript type checking in watch mode
  ```bash
  npm run type-check:watch
  ```
  Continuously checks for TypeScript errors as you code.

### Testing
- `npm run test` - Run tests
  ```bash
  npm run test
  ```
  Runs all tests in the project.

- `npm run test:watch` - Run tests in watch mode
  ```bash
  npm run test:watch
  ```
  Runs tests in watch mode, re-running when files change.

### Code Quality
- `npm run format` - Format code using Prettier
  ```bash
  npm run format
  ```
  Formats all code in the project according to Prettier rules.

- `npm run format:check` - Check code formatting
  ```bash
  npm run format:check
  ```
  Checks if code is properly formatted without making changes.

### Dependencies
- `npm install` - Install dependencies
  ```bash
  npm install
  ```
  Installs all project dependencies.

- `npm install <package>` - Install a new package
  ```bash
  npm install <package>
  ```
  Installs a new package and adds it to package.json.

- `npm uninstall <package>` - Remove a package
  ```bash
  npm uninstall <package>
  ```
  Removes a package and its dependencies.

### Cleanup
- `npm run clean` - Clean build artifacts
  ```bash
  npm run clean
  ```
  Removes build artifacts and cache.

- `npm cache clean` - Clean npm cache
  ```bash
  npm cache clean
  ```
  Cleans the npm cache to resolve potential installation issues.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.