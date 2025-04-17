'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function Navigation() {
  const pathname = usePathname();
  const isHomePage = pathname === '/';

  return (
    <div className="sticky top-0 left-0 right-0 z-50">
      <div className="absolute inset-0 bg-gradient-to-r from-blue-600 to-blue-800">
        <div className="absolute inset-0 bg-black/30" />
      </div>
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
        <div className="flex gap-8">
          <Link
            href="/"
            className="text-white hover:text-blue-200 transition-colors font-medium"
          >
            Home
          </Link>
          <Link
            href={isHomePage ? "#purpose" : "/#purpose"}
            className="text-white hover:text-blue-200 transition-colors font-medium"
          >
            Our Purpose
          </Link>
          <Link
            href={isHomePage ? "#team" : "/#team"}
            className="text-white hover:text-blue-200 transition-colors font-medium"
          >
            Our Team
          </Link>
          <Link
            href="/contact"
            className="text-white hover:text-blue-200 transition-colors font-medium"
          >
            Contact Us
          </Link>
        </div>
      </div>
    </div>
  );
} 