import { BaseModel } from './BaseModel';

type Contribution = {
  id: number;
  user_id: number;
  amount: number;
  month: Date;
  status: 'PENDING' | 'PAID' | 'MISSED';
  notes: string | null;
  created_at: Date;
  updated_at: Date;
};

type ContributionCreateInput = {
  user_id: number;
  amount: number;
  month: Date;
  status?: 'PENDING' | 'PAID' | 'MISSED';
  notes?: string;
};

type ContributionUpdateInput = Partial<Omit<Contribution, 'id' | 'created_at' | 'updated_at'>>;

export class ContributionModel extends BaseModel<Contribution, ContributionCreateInput, ContributionUpdateInput> {
  constructor() {
    super('contribution');
  }

  async findByUserId(userId: number): Promise<Contribution[]> {
    return this.findMany({ user_id: userId });
  }

  async findByMonth(month: Date): Promise<Contribution[]> {
    return this.findMany({
      month: {
        gte: new Date(month.getFullYear(), month.getMonth(), 1),
        lt: new Date(month.getFullYear(), month.getMonth() + 1, 1),
      },
    });
  }

  async getTotalContributions(userId: number): Promise<number> {
    const result = await this.getPrismaModel().aggregate({
      where: { user_id: userId },
      _sum: { amount: true },
    });
    return result._sum.amount?.toNumber() || 0;
  }

  async getMonthlyContributions(month: Date): Promise<number> {
    const result = await this.getPrismaModel().aggregate({
      where: {
        month: {
          gte: new Date(month.getFullYear(), month.getMonth(), 1),
          lt: new Date(month.getFullYear(), month.getMonth() + 1, 1),
        },
        status: 'PAID',
      },
      _sum: { amount: true },
    });
    return result._sum.amount?.toNumber() || 0;
  }
} 