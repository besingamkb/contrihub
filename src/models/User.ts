import { BaseModel } from './BaseModel';
import { hash, compare } from 'bcrypt';

type User = {
  id: number;
  fullname: string;
  email: string;
  password: string;
  is_admin: boolean;
  created_at: Date;
  updated_at: Date;
};

type UserCreateInput = {
  fullname: string;
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
    return this.getPrismaModel().findUnique({
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
  async where(field: keyof User, value: any) {
    return this.findMany({ [field]: value });
  }

  async orderBy(field: keyof User, order: 'asc' | 'desc' = 'asc') {
    return this.getPrismaModel().findMany({
      orderBy: { [field]: order },
    });
  }
} 