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
import Navigation from '@/components/Navigation';
import Footer from '@/components/Footer';

export default function Home() {
  const [activeTab, setActiveTab] = useState('mission');

  return (
    <div className="min-h-screen">
      <Navigation />

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
                href="/contact"
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
      <div id="purpose" className="py-16 bg-white">
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
      <div id="team" className="py-16 bg-gray-50">
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

            {/* Additional Team Members */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {/* Team Member 1 */}
              <div className="flex items-center">
                <div className="relative w-24 h-24 mr-4">
                  <Image
                    src="/images/profiles/placeholder.jpg"
                    alt="Marketing Director"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 96px) 100vw, 96px"
                    priority
                    onError={(e) => {
                      const target = e.target as HTMLImageElement;
                      target.src = '/images/profiles/placeholder.jpg';
                    }}
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Alex Rodriguez</h3>
                  <p className="text-blue-600 font-medium">Marketing Director</p>
                </div>
              </div>

              {/* Team Member 3 */}
              <div className="flex items-center">
                <div className="relative w-24 h-24 mr-4">
                  <Image
                    src="/images/profiles/team-3.jpg"
                    alt="Lead Developer"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 96px) 100vw, 96px"
                    priority
                    onError={(e) => {
                      const target = e.target as HTMLImageElement;
                      target.src = '/images/profiles/placeholder.jpg';
                    }}
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">David Kim</h3>
                  <p className="text-blue-600 font-medium">Lead Developer</p>
                </div>
              </div>

              {/* Team Member 6 */}
              <div className="flex items-center">
                <div className="relative w-24 h-24 mr-4">
                  <Image
                    src="/images/profiles/team-6.jpg"
                    alt="HR Manager"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 96px) 100vw, 96px"
                    priority
                    onError={(e) => {
                      const target = e.target as HTMLImageElement;
                      target.src = '/images/profiles/placeholder.jpg';
                    }}
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Rachel Chen</h3>
                  <p className="text-blue-600 font-medium">HR Manager</p>
                </div>
              </div>

              {/* Team Member 7 */}
              <div className="flex items-center">
                <div className="relative w-24 h-24 mr-4">
                  <Image
                    src="/images/profiles/team-7.jpg"
                    alt="Project Manager"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 96px) 100vw, 96px"
                    priority
                    onError={(e) => {
                      const target = e.target as HTMLImageElement;
                      target.src = '/images/profiles/placeholder.jpg';
                    }}
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Marcus Brown</h3>
                  <p className="text-blue-600 font-medium">Project Manager</p>
                </div>
              </div>

              {/* Team Member 8 */}
              <div className="flex items-center">
                <div className="relative w-24 h-24 mr-4">
                  <Image
                    src="/images/profiles/team-8.jpg"
                    alt="Data Analyst"
                    fill
                    className="rounded-full object-cover border-4 border-blue-500"
                    sizes="(max-width: 96px) 100vw, 96px"
                    priority
                    onError={(e) => {
                      const target = e.target as HTMLImageElement;
                      target.src = '/images/profiles/placeholder.jpg';
                    }}
                  />
                </div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Olivia Taylor</h3>
                  <p className="text-blue-600 font-medium">Data Analyst</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <Footer />
    </div>
  );
}
