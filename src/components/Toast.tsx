'use client'

import { useEffect, useState } from 'react'

interface ToastProps {
  message: string
  type: 'success' | 'error'
  onClose: () => void
}

export default function Toast({ message, type, onClose }: ToastProps) {
  const [isVisible, setIsVisible] = useState(true)

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false)
      onClose()
    }, 3000)

    return () => clearTimeout(timer)
  }, [onClose])

  if (!isVisible) return null

  return (
    <div className="fixed bottom-4 right-4 z-50">
      <div
        className={`${
          type === 'success' ? 'bg-green-500' : 'bg-red-500'
        } text-white px-4 py-2 rounded-lg shadow-lg flex items-center`}
      >
        <span>{message}</span>
        <button
          onClick={() => {
            setIsVisible(false)
            onClose()
          }}
          className="ml-2 text-white hover:text-gray-200"
        >
          ×
        </button>
      </div>
    </div>
  )
}
 