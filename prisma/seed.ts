import { PrismaClient, Status, AttendeeStatus, User } from '@prisma/client';
import bcrypt from 'bcrypt';
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

async function main() {
  console.log('Starting database seeding...');

  // Check if we already have users
  const existingUsers = await prisma.user.findMany();
  if (existingUsers.length > 0) {
    console.log('Database already has users. Skipping user creation...');
  } else {
    // Create admin users
    const adminUsers = await prisma.user.createMany({
      data: [
        {
          name: 'John Doe',
          email: 'john.doe@example.com',
          password: await bcrypt.hash('password123', 10),
          is_admin: true,
        },
        {
          name: 'Sarah Williams',
          email: 'sarah.williams@example.com',
          password: await bcrypt.hash('password123', 10),
          is_admin: true,
        },
        {
          name: 'Michael Chen',
          email: 'michael.chen@example.com',
          password: await bcrypt.hash('password123', 10),
          is_admin: false,
        },
      ],
    });

    // Create regular members (50 users)
    const regularMembers = Array.from({ length: 50 }, () => ({
      name: faker.person.fullName(),
      email: faker.internet.email(),
      password: 'password123', // We'll hash this later
      is_admin: false,
    }));

    // Hash passwords for regular members
    const hashedRegularMembers = await Promise.all(
      regularMembers.map(async (member) => ({
        ...member,
        password: await bcrypt.hash(member.password, 10),
      }))
    );

    // Create regular members in database
    await prisma.user.createMany({
      data: hashedRegularMembers,
    });
  }

  // Get all users (existing or newly created)
  const allUsers: User[] = await prisma.user.findMany();

  // Clear existing contributions
  await prisma.contribution.deleteMany();
  console.log('Cleared existing contributions...');

  // Create contributions for each user
  for (const user of allUsers) {
    // Generate contributions for the past 24 months
    const contributions = Array.from({ length: 24 }, (_, i) => {
      const date = new Date();
      date.setMonth(date.getMonth() - i);
      date.setDate(1); // Set to first day of the month

      // Different status probabilities based on time:
      // Current month: 60% PENDING, 40% PAID
      // Last 3 months: 70% PAID, 20% PENDING, 10% MISSED
      // Older months: 85% PAID, 5% PENDING, 10% MISSED
      let status;
      if (i === 0) {
        status = Math.random() < 0.6 ? Status.PENDING : Status.PAID;
      } else if (i <= 3) {
        const rand = Math.random();
        status = rand < 0.7 ? Status.PAID : rand < 0.9 ? Status.PENDING : Status.MISSED;
      } else {
        const rand = Math.random();
        status = rand < 0.85 ? Status.PAID : rand < 0.9 ? Status.PENDING : Status.MISSED;
      }

      // Generate more varied amounts
      const baseAmount = 1000;
      const variance = faker.number.int({ min: -200, max: 200 });
      const amount = baseAmount + variance;

      // Add notes for special cases
      let notes = null;
      if (status === Status.MISSED) {
        notes = faker.helpers.arrayElement([
          'Member requested extension',
          'Payment failed',
          'Member on leave',
          'Will pay next month',
          'Financial hardship reported'
        ]);
      } else if (Math.random() < 0.2) { // 20% chance for paid/pending to have notes
        notes = faker.helpers.arrayElement([
          'Paid via bank transfer',
          'Payment confirmed',
          'Partial payment received',
          'Payment scheduled',
          'Additional contribution included'
        ]);
      }

      return {
        user_id: user.id,
        amount,
        month: date.toLocaleString('default', { month: 'long' }),
        year: date.getFullYear(),
        status,
        notes,
      };
    });

    await prisma.contribution.createMany({
      data: contributions,
    });
  }

  console.log('Database has been seeded with enhanced test data. 🌱');
  console.log('Created:', {
    totalUsers: allUsers.length,
    contributionsPerUser: 24,
    totalContributions: allUsers.length * 24,
  });

  // Clear existing calendar events
  await prisma.calendarEventAttendee.deleteMany();
  await prisma.calendarEvent.deleteMany();
  console.log('Cleared existing calendar events...');

  // Create calendar events
  const eventTypes = [
    'Monthly Meeting',
    'Annual General Assembly',
    'Special Project Discussion',
    'Team Building',
    'Training Session',
    'Community Outreach',
    'Fundraising Event',
    'Board Meeting',
    'Workshop',
    'Social Gathering',
    'Committee Meeting',
    'Volunteer Training',
    'Member Orientation',
    'Budget Planning',
    'Strategic Planning',
    'Community Service',
    'Networking Event',
    'Award Ceremony',
    'Annual Review',
    'Project Launch'
  ] as const;

  const locations = [
    'Main Hall',
    'Conference Room A',
    'Community Center',
    'Online Meeting',
    'Outdoor Park',
    'Restaurant',
    'Hotel Conference Room',
    'Member\'s Residence',
    'Sports Complex',
    'Cultural Center',
    'Library',
    'School Auditorium',
    'Town Hall',
    'Beach Resort',
    'Garden Venue'
  ] as const;

  // Helper function to generate a random date within a specific month
  const generateRandomDate = (year: number, month: number) => {
    const startDate = new Date(year, month - 1, 1);
    const endDate = new Date(year, month, 0);
    const randomDate = new Date(startDate.getTime() + Math.random() * (endDate.getTime() - startDate.getTime()));
    randomDate.setHours(9 + Math.floor(Math.random() * 8), 0, 0, 0); // Random time between 9 AM and 5 PM
    return randomDate;
  };

  // Create events for March, April, and May 2025
  const months = [3, 4, 5]; // March, April, May
  const eventsPerMonth = 15; // 15 events per month

  for (const month of months) {
    for (let i = 0; i < eventsPerMonth; i++) {
      const startDate = generateRandomDate(2025, month);
      const endDate = new Date(startDate);
      endDate.setHours(startDate.getHours() + Math.floor(Math.random() * 3) + 1); // Duration between 1-4 hours

      const creator: User = faker.helpers.arrayElement(allUsers);
      
      // Get random users excluding the creator
      const availableUsers = allUsers.filter(user => user.id !== creator.id);
      const numAttendees = faker.number.int({ min: 5, max: Math.min(15, availableUsers.length) });
      const randomAttendees = faker.helpers.shuffle(availableUsers).slice(0, numAttendees);

      const event = await prisma.calendarEvent.create({
        data: {
          title: faker.helpers.arrayElement(eventTypes),
          description: faker.lorem.paragraph(),
          start_time: startDate,
          end_time: endDate,
          location: faker.helpers.arrayElement(locations),
          created_by: creator.id,
          attendees: {
            create: [
              // Creator is always an attendee
              {
                user_id: creator.id,
                status: AttendeeStatus.ACCEPTED
              },
              // Add random attendees
              ...randomAttendees.map(user => ({
                user_id: user.id,
                status: faker.helpers.arrayElement([
                  AttendeeStatus.PENDING,
                  AttendeeStatus.ACCEPTED,
                  AttendeeStatus.DECLINED,
                  AttendeeStatus.TENTATIVE
                ])
              }))
            ]
          }
        }
      });
    }
  }

  console.log('Created calendar events with attendees');
}

main()
  .catch((e) => {
    console.error('Seeding error:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  }); 