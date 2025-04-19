import { PrismaClient } from '@prisma/client/edge'
import { Prisma } from '@prisma/client'

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
    const model = this.prisma[this.modelName] as unknown as {
      create: (args: { data: CreateInput }) => Promise<T>;
    };
    return model.create({ data });
  }

  async find(id: number): Promise<T | null> {
    const model = this.prisma[this.modelName] as unknown as {
      findUnique: (args: { where: { id: number } }) => Promise<T | null>;
    };
    return model.findUnique({ where: { id } });
  }

  async findMany(where?: Prisma.JsonObject): Promise<T[]> {
    const model = this.prisma[this.modelName] as unknown as {
      findMany: (args: { where?: Prisma.JsonObject }) => Promise<T[]>;
    };
    return model.findMany({ where });
  }

  async update(id: number, data: UpdateInput): Promise<T> {
    const model = this.prisma[this.modelName] as unknown as {
      update: (args: { where: { id: number }; data: UpdateInput }) => Promise<T>;
    };
    return model.update({ where: { id }, data });
  }

  async delete(id: number): Promise<T> {
    const model = this.prisma[this.modelName] as unknown as {
      delete: (args: { where: { id: number } }) => Promise<T>;
    };
    return model.delete({ where: { id } });
  }

  // Pagination
  async paginate(page = 1, perPage = 10, where?: Prisma.JsonObject) {
    const skip = (page - 1) * perPage;
    
    const model = this.prisma[this.modelName] as unknown as {
      count: (args: { where?: Prisma.JsonObject }) => Promise<number>;
      findMany: (args: { skip: number; take: number; where?: Prisma.JsonObject }) => Promise<T[]>;
    };
    
    const [total, items] = await Promise.all([
      model.count({ where }),
      model.findMany({
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
  async count(where?: Prisma.JsonObject): Promise<number> {
    const model = this.prisma[this.modelName] as unknown as {
      count: (args: { where?: Prisma.JsonObject }) => Promise<number>;
    };
    return model.count({ where });
  }

  // Utility methods
  protected getPrismaModel() {
    return this.prisma[this.modelName] as unknown as {
      create: (args: { data: CreateInput }) => Promise<T>;
      findUnique: (args: { where: { id: number } }) => Promise<T | null>;
      findMany: (args: { where?: Prisma.JsonObject }) => Promise<T[]>;
      update: (args: { where: { id: number }; data: UpdateInput }) => Promise<T>;
      delete: (args: { where: { id: number } }) => Promise<T>;
      count: (args: { where?: Prisma.JsonObject }) => Promise<number>;
      aggregate: (args: { 
        where?: Prisma.JsonObject;
        _sum?: { [key: string]: boolean };
      }) => Promise<{ _sum: { [key: string]: { toNumber: () => number } | null } }>;
    };
  }
} 