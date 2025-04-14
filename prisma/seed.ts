import { PrismaClient, Status } from '@prisma/client';
import bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  // Clear existing data
  await prisma.contribution.deleteMany();
  await prisma.user.deleteMany();

  // Create test users
  const users = await prisma.user.createMany({
    data: [
      // Admins
      {
        fullname: 'John Doe',
        email: 'john.doe@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: true,
      },
      {
        fullname: 'Sarah Williams',
        email: 'sarah.williams@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: true,
      },
      {
        fullname: 'Michael Chen',
        email: 'michael.chen@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: true,
      },
      // Regular members
      {
        fullname: 'Jane Smith',
        email: 'jane.smith@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Mike Johnson',
        email: 'mike.johnson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'David Brown',
        email: 'david.brown@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Emily Davis',
        email: 'emily.davis@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Robert Wilson',
        email: 'robert.wilson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Lisa Anderson',
        email: 'lisa.anderson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Michael Taylor',
        email: 'michael.taylor@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Jennifer Martinez',
        email: 'jennifer.martinez@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'James Wilson',
        email: 'james.wilson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Patricia Brown',
        email: 'patricia.brown@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Thomas Garcia',
        email: 'thomas.garcia@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Elizabeth Rodriguez',
        email: 'elizabeth.rodriguez@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Charles Martinez',
        email: 'charles.martinez@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Margaret Anderson',
        email: 'margaret.anderson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Joseph Taylor',
        email: 'joseph.taylor@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Susan Thomas',
        email: 'susan.thomas@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Daniel Hernandez',
        email: 'daniel.hernandez@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Karen Moore',
        email: 'karen.moore@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Paul Martin',
        email: 'paul.martin@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Nancy Jackson',
        email: 'nancy.jackson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Kevin Thompson',
        email: 'kevin.thompson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Betty White',
        email: 'betty.white@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Mark Lee',
        email: 'mark.lee@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Sandra Harris',
        email: 'sandra.harris@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Jason Clark',
        email: 'jason.clark@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Donna Lewis',
        email: 'donna.lewis@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
      {
        fullname: 'Jeffrey Robinson',
        email: 'jeffrey.robinson@example.com',
        password: await bcrypt.hash('password123', 10),
        is_admin: false,
      },
    ],
  });

  // Get all users
  const allUsers = await prisma.user.findMany();

  // Create contributions for each user
  for (const user of allUsers) {
    await prisma.contribution.createMany({
      data: [
        {
          user_id: user.id,
          amount: 1000.00,
          month: new Date('2024-01-01'),
          status: Status.PAID,
        },
        {
          user_id: user.id,
          amount: 1000.00,
          month: new Date('2024-02-01'),
          status: Math.random() < 0.3 ? Status.PAID : Math.random() < 0.5 ? Status.PENDING : Status.MISSED,
        },
      ],
    });
  }

  console.log('Database has been seeded. 🌱');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  }); 