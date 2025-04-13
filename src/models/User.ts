import { PrismaClient, Prisma } from '@prisma/client';
import { hash, compare } from 'bcrypt';

const prisma = new PrismaClient();

type User = {
  id: number;
  fullname: string;
  email: string;
  password: string;
  is_admin: boolean;
  created_at: Date;
  updated_at: Date;
}

export class UserModel {
  // Static methods for querying
  static async all(): Promise<User[]> {
    return prisma.user.findMany();
  }

  static async find(id: number): Promise<User | null> {
    return prisma.user.findUnique({
      where: { id },
    });
  }

  static async findByEmail(email: string): Promise<User | null> {
    return prisma.user.findUnique({
      where: { email },
    });
  }

  static async create(data: {
    fullname: string;
    email: string;
    password: string;
    is_admin?: boolean;
  }): Promise<User> {
    const hashedPassword = await hash(data.password, 10);
    
    return prisma.user.create({
      data: {
        ...data,
        password: hashedPassword,
      },
    });
  }

  // Instance methods
  static async update(id: number, data: Partial<Omit<User, 'id' | 'created_at' | 'updated_at'>>): Promise<User> {
    if (data.password) {
      data.password = await hash(data.password, 10);
    }

    return prisma.user.update({
      where: { id },
      data,
    });
  }

  static async delete(id: number): Promise<User> {
    return prisma.user.delete({
      where: { id },
    });
  }

  // Authentication methods
  static async verifyPassword(email: string, password: string): Promise<boolean> {
    const user = await this.findByEmail(email);
    if (!user) return false;
    
    return compare(password, user.password);
  }

  // Query builder methods
  static where(field: keyof User, value: any) {
    return prisma.user.findMany({
      where: { [field]: value },
    });
  }

  static orderBy(field: keyof User, order: 'asc' | 'desc' = 'asc') {
    return prisma.user.findMany({
      orderBy: { [field]: order },
    });
  }

  static async paginate(page: number = 1, perPage: number = 10) {
    const skip = (page - 1) * perPage;
    
    const [total, items] = await Promise.all([
      prisma.user.count(),
      prisma.user.findMany({
        skip,
        take: perPage,
      }),
    ]);

    return {
      data: items,
      meta: {
        total,
        currentPage: page,
        perPage,
        lastPage: Math.ceil(total / perPage),
      },
    };
  }
} 