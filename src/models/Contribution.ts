import { BaseModel } from './BaseModel';

type Contribution = {
  id: number;
  user_id: number;
  amount: number;
  month: string;
  year: number;
  status: 'PENDING' | 'PAID' | 'MISSED';
  notes: string | null;
  created_at: Date;
  updated_at: Date;
};

type ContributionCreateInput = {
  user_id: number;
  amount: number;
  month: string;
  year: number;
  status?: 'PENDING' | 'PAID' | 'MISSED';
  notes?: string;
};

type ContributionUpdateInput = {
  amount?: number;
  month?: string;
  year?: number;
  status?: 'PENDING' | 'PAID' | 'MISSED';
  notes?: string;
};

export class ContributionModel extends BaseModel<Contribution, ContributionCreateInput, ContributionUpdateInput> {
  constructor() {
    super('contribution');
  }

  async findByUserId(userId: number): Promise<Contribution[]> {
    return this.findMany({ user_id: userId });
  }

  async findByMonthAndYear(month: string, year: number): Promise<Contribution[]> {
    return this.findMany({
      month,
      year,
    });
  }

  async getTotalContributions(userId: number): Promise<number> {
    const result = await this.getPrismaModel().aggregate({
      where: { user_id: userId },
      _sum: { amount: true },
    });
    return result._sum.amount?.toNumber() || 0;
  }

  async getMonthlyContributions(month: string, year: number): Promise<number> {
    const result = await this.getPrismaModel().aggregate({
      where: {
        month,
        year,
        status: 'PAID',
      },
      _sum: { amount: true },
    });
    return result._sum.amount?.toNumber() || 0;
  }
} 