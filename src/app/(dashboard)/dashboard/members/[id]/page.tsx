import MemberDetails from './MemberDetails'
import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Member Details',
}

interface PageProps {
  params: {
    id: string
  }
}

export default function Page({ params }: PageProps) {
  return <MemberDetails userId={params.id} />
} 