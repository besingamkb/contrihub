'use client';

import { useState } from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { 
  BuildingOfficeIcon, 
  UserGroupIcon, 
  ChartBarIcon, 
  ArrowRightIcon,
  EnvelopeIcon,
  PhoneIcon,
  MapPinIcon
} from '@heroicons/react/24/outline';

export default function Home() {
  const [activeTab, setActiveTab] = useState('mission');

  return (
    <div className="min-h-screen">
      {/* Jumbotron/Hero Section */}
      <div className="relative h-[600px]">
        <div className="absolute inset-0 bg-gradient-to-r from-blue-600 to-blue-800">
          <div className="absolute inset-0 bg-black/30" />
        </div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-full flex items-center">
          <div className="max-w-2xl">
            <h1 className="text-4xl sm:text-5xl font-bold text-white mb-6">
              Caliya Online Freelancers Organization
            </h1>
            <p className="text-xl text-gray-200 mb-8">
              Empowering communities through collaboration and innovation
            </p>
            <div className="flex gap-4">
              <Link
                href="/dashboard"
                className="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
              >
                Join Now
                <ArrowRightIcon className="ml-2 h-5 w-5" />
              </Link>
              <Link
                href="/about"
                className="inline-flex items-center px-6 py-3 border border-white text-base font-medium rounded-md text-white hover:bg-white/10"
              >
                Learn More
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* Mission & Vision Section */}
      <div className="py-16 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-left mb-12">
            <h2 className="text-3xl font-bold text-gray-900">Our Purpose</h2>
            <p className="mt-4 text-lg text-gray-600">
              Driving positive change through our core values
            </p>
          </div>

          <div className="max-w-3xl space-y-16">
            {/* Mission */}
            <div className="space-y-4">
              <h3 className="text-2xl font-semibold text-gray-900">Our Mission</h3>
              <p className="text-lg text-gray-600">
                At COFA, we are dedicated to revolutionizing the way communities collaborate and contribute. 
                Our mission is to create a seamless platform that connects individuals, organizations, and resources 
                to drive meaningful change and sustainable development. Through innovative technology and a commitment 
                to excellence, we empower our users to make a lasting impact in their communities.
              </p>
            </div>

            {/* Vision */}
            <div className="space-y-4">
              <h3 className="text-2xl font-semibold text-gray-900">Our Vision</h3>
              <p className="text-lg text-gray-600">
                We envision a world where every individual has the power to contribute to positive change. 
                By 2030, COFA aims to be the leading global platform for community collaboration, 
                connecting millions of changemakers and facilitating billions of meaningful contributions. 
                Our vision is to create a future where technology bridges gaps, fosters understanding, 
                and enables collective action for a better tomorrow.
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Organization Chart Section */}
      <div className="py-16 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-left mb-12">
            <h2 className="text-3xl font-bold text-gray-900">Our Organization</h2>
            <p className="mt-4 text-lg text-gray-600">
              Meet the team driving our mission forward
            </p>
          </div>

          <div className="max-w-5xl">
            {/* President */}
            <div className="flex items-center mb-16">
              <div className="relative w-32 h-32 mr-6">
                <Image
                  src="/images/profiles/president.jpg"
                  alt="President"
                  fill
                  className="rounded-full object-cover border-4 border-blue-500"
                />
              </div>
              <div>
                <h3 className="text-xl font-semibold text-gray-900">John Smith</h3>
                <p className="text-blue-600 font-medium">President & CEO</p>
              </div>
            </div>

            {/* Executive Team */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
              {/* VP Operations */}
              <div className="flex items-center">
                <div className="relative w-32 h-32 mr-6">
                  <Image
                    src="/images/profiles/vp-ops.jpg"
                    alt="VP Operations"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 128px) 100vw, 128px"
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Sarah Johnson</h3>
                  <p className="text-blue-600 font-medium">VP Operations</p>
                </div>
              </div>

              {/* VP Technology */}
              <div className="flex items-center">
                <div className="relative w-32 h-32 mr-6">
                  <Image
                    src="/images/profiles/vp-tech.jpg"
                    alt="VP Technology"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 128px) 100vw, 128px"
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Michael Chen</h3>
                  <p className="text-blue-600 font-medium">VP Technology</p>
                </div>
              </div>

              {/* VP Finance */}
              <div className="flex items-center">
                <div className="relative w-32 h-32 mr-6">
                  <Image
                    src="/images/profiles/vp-finance.jpg"
                    alt="VP Finance"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 128px) 100vw, 128px"
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Emily Davis</h3>
                  <p className="text-blue-600 font-medium">VP Finance</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="bg-gray-900 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <h3 className="text-lg font-semibold mb-4">About Us</h3>
              <p className="text-gray-400">
                Building a better future through collaboration and innovation.
              </p>
            </div>
            <div>
              <h3 className="text-lg font-semibold mb-4">Quick Links</h3>
              <ul className="space-y-2">
                <li>
                  <Link href="/about" className="text-gray-400 hover:text-white">
                    About
                  </Link>
                </li>
                <li>
                  <Link href="/contact" className="text-gray-400 hover:text-white">
                    Contact
                  </Link>
                </li>
                <li>
                  <Link href="/privacy" className="text-gray-400 hover:text-white">
                    Privacy Policy
                  </Link>
                </li>
              </ul>
            </div>
            <div>
              <h3 className="text-lg font-semibold mb-4">Contact Us</h3>
              <ul className="space-y-2">
                <li className="flex items-center text-gray-400">
                  <EnvelopeIcon className="h-5 w-5 mr-2" />
                  info@cofa.com
                </li>
                <li className="flex items-center text-gray-400">
                  <PhoneIcon className="h-5 w-5 mr-2" />
                  +1 (555) 123-4567
                </li>
                <li className="flex items-center text-gray-400">
                  <MapPinIcon className="h-5 w-5 mr-2" />
                  123 Business Ave, Suite 100
                </li>
              </ul>
            </div>
            <div>
              <h3 className="text-lg font-semibold mb-4">Follow Us</h3>
              <div className="flex space-x-4">
                <a href="#" className="text-gray-400 hover:text-white">
                  <span className="sr-only">Facebook</span>
                  <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" />
                  </svg>
                </a>
                <a href="#" className="text-gray-400 hover:text-white">
                  <span className="sr-only">Twitter</span>
                  <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
                  </svg>
                </a>
                <a href="#" className="text-gray-400 hover:text-white">
                  <span className="sr-only">LinkedIn</span>
                  <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" />
                  </svg>
                </a>
              </div>
            </div>
          </div>
          <div className="mt-8 pt-8 border-t border-gray-800 text-left text-gray-400">
            <p>&copy; {new Date().getFullYear()} COFA. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
