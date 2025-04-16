import { Dialog, Transition } from '@headlessui/react';
import { Fragment, useState } from 'react';
import { FullCalendarEvent } from '@/types/calendar';
import { format } from 'date-fns';
import { CheckCircleIcon, XCircleIcon, ClockIcon, QuestionMarkCircleIcon, TrashIcon } from '@heroicons/react/24/outline';
import { useSession } from 'next-auth/react';

interface EventDetailsModalProps {
  isOpen: boolean;
  onClose: () => void;
  event: FullCalendarEvent | null;
  onDelete?: (eventId: string) => Promise<void>;
}

export default function EventDetailsModal({ isOpen, onClose, event, onDelete }: EventDetailsModalProps) {
  const [isDeleting, setIsDeleting] = useState(false);
  const { data: session } = useSession();
  const isCreator = event?.creator?.id?.toString() === session?.user?.id?.toString();

  if (!event) return null;

  const handleDelete = async () => {
    if (!onDelete) return;
    
    setIsDeleting(true);
    try {
      await onDelete(event.id);
      onClose();
    } catch (error) {
      console.error('Failed to delete event:', error);
    } finally {
      setIsDeleting(false);
    }
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'ACCEPTED':
        return <CheckCircleIcon className="h-5 w-5 text-green-500" />;
      case 'DECLINED':
        return <XCircleIcon className="h-5 w-5 text-red-500" />;
      case 'PENDING':
        return <ClockIcon className="h-5 w-5 text-gray-400" />;
      case 'TENTATIVE':
        return <QuestionMarkCircleIcon className="h-5 w-5 text-yellow-500" />;
      default:
        return null;
    }
  };

  return (
    <Transition appear show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-40" onClose={onClose}>
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-black/40" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                <Dialog.Title
                  as="div"
                  className="flex justify-between items-center"
                >
                  <h3 className="text-lg font-medium leading-6 text-gray-900">
                    {event.title}
                  </h3>
                  {onDelete && isCreator && (
                    <button
                      onClick={handleDelete}
                      disabled={isDeleting}
                      className="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-md text-red-700 bg-red-100 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                    >
                      <TrashIcon className="h-4 w-4 mr-1" />
                      {isDeleting ? 'Deleting...' : 'Delete'}
                    </button>
                  )}
                </Dialog.Title>

                <div className="mt-4 space-y-4">
                  <div>
                    <p className="text-sm text-gray-500">Date & Time</p>
                    <p className="text-sm text-gray-900">
                      {format(new Date(event.start), 'MMMM d, yyyy')}
                      <br />
                      {format(new Date(event.start), 'h:mm a')} - {format(new Date(event.end), 'h:mm a')}
                    </p>
                  </div>

                  {event.location && (
                    <div>
                      <p className="text-sm text-gray-500">Location</p>
                      <p className="text-sm text-gray-900">{event.location}</p>
                    </div>
                  )}

                  {event.description && (
                    <div>
                      <p className="text-sm text-gray-500">Description</p>
                      <p className="text-sm text-gray-900">{event.description}</p>
                    </div>
                  )}

                  <div>
                    <p className="text-sm text-gray-500">Organizer</p>
                    <p className="text-sm text-gray-900">{event.creator?.name}</p>
                  </div>

                  {event.attendees && event.attendees.length > 0 && (
                    <div>
                      <p className="text-sm text-gray-500">Attendees</p>
                      <div className="mt-1 max-h-40 overflow-y-auto scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                        {event.attendees.map((attendee) => (
                          <div key={attendee.user.id} className="flex items-center space-x-2 py-1">
                            {getStatusIcon(attendee.status)}
                            <p className="text-sm text-gray-900">{attendee.user.name}</p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>

                <div className="mt-6">
                  <button
                    type="button"
                    className="inline-flex justify-center rounded-md border border-transparent bg-blue-100 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
                    onClick={onClose}
                  >
                    Close
                  </button>
                </div>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
} 