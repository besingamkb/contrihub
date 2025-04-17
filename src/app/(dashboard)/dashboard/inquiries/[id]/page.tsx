'use client';

import { useState, useEffect } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import { ArrowLeftIcon } from '@heroicons/react/24/outline';

interface Inquiry {
  id: number;
  name: string;
  email: string;
  subject: string;
  message: string;
  created_at: string;
  updated_at: string;
}

export default function InquiryDetailsPage() {
  const router = useRouter();
  const params = useParams();
  const { data: session, status: sessionStatus } = useSession();
  const [inquiry, setInquiry] = useState<Inquiry | null>(null);
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

    fetchInquiry();
  }, [router, session, sessionStatus, params]);

  const fetchInquiry = async () => {
    try {
      const response = await fetch(`/api/inquiries/${params.id}`);
      if (!response.ok) {
        throw new Error('Failed to fetch inquiry');
      }
      const data = await response.json();
      setInquiry(data);
    } catch (error) {
      setError('Failed to load inquiry');
      console.error('Error fetching inquiry:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      </div>
    );
  }

  if (error || !inquiry) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="flex items-center justify-center h-64">
          <div className="text-red-600">{error || 'Inquiry not found'}</div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="max-w-3xl mx-auto">
        <div className="mb-6">
          <Link
            href="/dashboard/inquiries"
            className="inline-flex items-center text-blue-600 hover:text-blue-800"
          >
            <ArrowLeftIcon className="h-4 w-4 mr-2" />
            Back to Inquiries
          </Link>
        </div>

        <div className="bg-white rounded-lg shadow-md p-6">
          <div className="border-b pb-4 mb-4">
            <h1 className="text-2xl font-bold text-gray-900">{inquiry.subject}</h1>
            <p className="text-sm text-gray-500 mt-1">
              Submitted on {new Date(inquiry.created_at).toLocaleDateString()}
            </p>
          </div>

          <div className="space-y-6">
            <div>
              <h2 className="text-sm font-medium text-gray-500">From</h2>
              <div className="mt-1">
                <p className="text-base font-medium text-gray-900">{inquiry.name}</p>
                <p className="text-sm text-gray-500">{inquiry.email}</p>
              </div>
            </div>

            <div>
              <h2 className="text-sm font-medium text-gray-500">Message</h2>
              <div className="mt-1 text-base text-gray-900 whitespace-pre-wrap">
                {inquiry.message}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
} 