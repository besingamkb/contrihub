import MemberDetails from './MemberDetails'

export default function Page({ params }: { params: { id: string } }) {
  return <MemberDetails userId={params.id} />
} 