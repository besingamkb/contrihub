import MemberDetails from './MemberDetails'
import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Member Details',
}

export default async function Page({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params;
  return <MemberDetails userId={id} />
} 