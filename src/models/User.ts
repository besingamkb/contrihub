import { BaseModel } from './BaseModel';
import { hash, compare } from 'bcrypt';
import { Prisma } from '@prisma/client';

type User = {
  id: number;
  name: string;
  email: string;
  password: string;
  is_admin: boolean;
  created_at: Date;
  updated_at: Date;
};

type UserCreateInput = {
  name: string;
  email: string;
  password: string;
  is_admin?: boolean;
};

type UserUpdateInput = Partial<Omit<User, 'id' | 'created_at' | 'updated_at'>>;

export class UserModel extends BaseModel<User, UserCreateInput, UserUpdateInput> {
  constructor() {
    super('user');
  }

  async findByEmail(email: string): Promise<User | null> {
    const model = this.prisma[this.modelName] as unknown as {
      findUnique: (args: { where: { email: string } }) => Promise<User | null>;
    };
    return model.findUnique({
      where: { email },
    });
  }

  async verifyPassword(email: string, password: string): Promise<boolean> {
    const user = await this.findByEmail(email);
    if (!user) return false;
    
    return compare(password, user.password);
  }

  async create(data: UserCreateInput): Promise<User> {
    const hashedPassword = await hash(data.password, 10);
    return super.create({
      ...data,
      password: hashedPassword,
    });
  }

  async update(id: number, data: UserUpdateInput): Promise<User> {
    if (data.password) {
      data.password = await hash(data.password, 10);
    }
    return super.update(id, data);
  }

  // Query builder methods
  async where(field: keyof User, value: string | number | boolean | Date) {
    return this.findMany({ [field]: value } as Prisma.JsonObject);
  }

  async orderBy(field: keyof User, order: Prisma.SortOrder = 'asc') {
    const model = this.prisma[this.modelName] as unknown as {
      findMany: (args: { orderBy: { [key: string]: Prisma.SortOrder } }) => Promise<User[]>;
    };
    return model.findMany({
      orderBy: { [field]: order },
    });
  }
} 