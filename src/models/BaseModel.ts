import { PrismaClient } from '@prisma/client';

let prisma: PrismaClient;

export abstract class BaseModel<T, CreateInput, UpdateInput> {
  protected prisma: PrismaClient;
  protected modelName: keyof PrismaClient;

  constructor(modelName: keyof PrismaClient) {
    this.modelName = modelName;
    if (!prisma) {
      prisma = new PrismaClient({
        log: ['query', 'info', 'warn', 'error'],
      });
    }
    this.prisma = prisma;
  }

  // CRUD Operations
  async create(data: CreateInput): Promise<T> {
    return (this.prisma[this.modelName] as any).create({
      data,
    });
  }

  async find(id: number): Promise<T | null> {
    return (this.prisma[this.modelName] as any).findUnique({
      where: { id },
    });
  }

  async findMany(where?: any): Promise<T[]> {
    return (this.prisma[this.modelName] as any).findMany({
      where,
    });
  }

  async update(id: number, data: UpdateInput): Promise<T> {
    return (this.prisma[this.modelName] as any).update({
      where: { id },
      data,
    });
  }

  async delete(id: number): Promise<T> {
    return (this.prisma[this.modelName] as any).delete({
      where: { id },
    });
  }

  // Pagination
  async paginate(page: number = 1, perPage: number = 10, where?: any) {
    const skip = (page - 1) * perPage;
    
    const [total, items] = await Promise.all([
      (this.prisma[this.modelName] as any).count({ where }),
      (this.prisma[this.modelName] as any).findMany({
        skip,
        take: perPage,
        where,
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

  // Aggregation
  async count(where?: any): Promise<number> {
    return (this.prisma[this.modelName] as any).count({ where });
  }

  // Utility methods
  protected getPrismaModel() {
    return this.prisma[this.modelName];
  }
} 