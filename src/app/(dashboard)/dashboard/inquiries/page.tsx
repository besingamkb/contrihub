'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useSession } from 'next-auth/react';
import DataTable from '@/components/DataTable';

interface Inquiry {
  id: number;
  name: string;
  email: string;
  subject: string;
  message: string;
  created_at: string;
  updated_at: string;
}

export default function InquiriesPage() {
  const router = useRouter();
  const { data: session, status: sessionStatus } = useSession();
  const [inquiries, setInquiries] = useState<Inquiry[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (sessionStatus === 'loading') return;

    if (!session) {
      router.push('/login');
      return;
    }

    // Check if user is not an admin and redirect to profile
    const user = session.user as { id: string; email: string; name: string; is_admin: boolean };
    if (!user.is_admin) {
      router.push('/dashboard/profile');
      return;
    }

    fetchInquiries();
  }, [router, session, sessionStatus]);

  const fetchInquiries = async () => {
    try {
      const response = await fetch('/api/inquiries');
      if (!response.ok) {
        throw new Error('Failed to fetch inquiries');
      }
      const data = await response.json();
      setInquiries(data);
    } catch (error) {
      setError('Failed to load inquiries');
      console.error('Error fetching inquiries:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleRowClick = (row: Inquiry) => {
    router.push(`/dashboard/inquiries/${row.id}`);
  };

  const columns = [
    {
      header: 'Name',
      accessor: 'name',
    },
    {
      header: 'Email',
      accessor: 'email',
    },
    {
      header: 'Subject',
      accessor: 'subject',
    },
    {
      header: 'Date',
      accessor: 'created_at',
      render: (value: string) => new Date(value).toLocaleDateString(),
    }
  ];

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-center h-64">
          <div className="text-red-600">{error}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="bg-white rounded-lg shadow-md p-6">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold text-gray-900">Inquiries</h1>
        </div>
        <DataTable
          columns={columns}
          data={inquiries}
          searchableColumns={['name', 'email', 'subject']}
          className="mt-4"
          onRowClick={handleRowClick}
        />
      </div>
    </div>
  );
} 