const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 3000;

// JWT Secret (In production, use environment variable)
const JWT_ACCESS_SECRET = process.env.JWT_ACCESS_SECRET || 'your-secret-key-change-in-production';
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'your-refresh-secret-key-change-in-production';

// Token expiration times
const ACCESS_TOKEN_EXPIRY = '15m'; // 15 minutes
const REFRESH_TOKEN_EXPIRY = '7d'; // 7 days

// Middleware
app.use(cors());
app.use(express.json());

// Mock Data

// Mock organizations
const organizations = [
  { id: 'org1', name: 'Veterans United', location: 'New York, NY' },
  { id: 'org2', name: 'Heroes Association', location: 'Los Angeles, CA' },
  { id: 'org3', name: 'Freedom Veterans', location: 'Chicago, IL' },
];

// Mock users for authentication
// NOTE: In production, passwords should be hashed using bcrypt or similar.
// These are plain text only for demo/testing purposes.
const users = [
  { 
    id: '1', 
    username: 'admin', 
    email: 'admin@veteranapp.com', 
    password: 'admin123', 
    name: 'Admin User',
    organizationIds: ['org1', 'org2', 'org3'] // User belongs to multiple organizations
  },
  { 
    id: '2', 
    username: 'johndoe', 
    email: 'john.doe@example.com', 
    password: 'password123', 
    name: 'John Doe',
    organizationIds: ['org1', 'org2'] // User belongs to two organizations
  },
  { 
    id: '3', 
    username: 'janesmith', 
    email: 'jane.smith@example.com', 
    password: 'password123', 
    name: 'Jane Smith',
    organizationIds: ['org1'] // User belongs to one organization
  },
];

// Store refresh tokens (In production, use a database)
const refreshTokens = new Set();

// Mock officials - now organization-specific
const officials = [
  // org1 - Veterans United
  { organizationId: 'org1', name: 'Etukeni Ndecha', role: 'President', service: 'Army', imageUrl: null },
  { organizationId: 'org1', name: 'Jane Smith', role: 'Vice President', service: 'Navy', imageUrl: null },
  { organizationId: 'org1', name: 'Robert Johnson', role: 'Secretary', service: 'Air Force', imageUrl: null },
  { organizationId: 'org1', name: 'Mary Williams', role: 'Treasurer', service: 'Marines', imageUrl: null },
  { organizationId: 'org1', name: 'James Brown', role: 'Member', service: 'Coast Guard', imageUrl: null },
  { organizationId: 'org1', name: 'Patricia Davis', role: 'Member', service: 'Army', imageUrl: null },
  { organizationId: 'org1', name: 'Michael Miller', role: 'Member', service: 'Navy', imageUrl: null },
  // org2 - Heroes Association
  { organizationId: 'org2', name: 'Sarah Johnson', role: 'President', service: 'Navy', imageUrl: null },
  { organizationId: 'org2', name: 'Michael Chen', role: 'Vice President', service: 'Army', imageUrl: null },
  { organizationId: 'org2', name: 'Emily Rodriguez', role: 'Secretary', service: 'Marines', imageUrl: null },
  { organizationId: 'org2', name: 'David Martinez', role: 'Treasurer', service: 'Air Force', imageUrl: null },
  { organizationId: 'org2', name: 'Lisa Thompson', role: 'Member', service: 'Coast Guard', imageUrl: null },
  // org3 - Freedom Veterans
  { organizationId: 'org3', name: 'William Anderson', role: 'President', service: 'Marines', imageUrl: null },
  { organizationId: 'org3', name: 'Jessica White', role: 'Vice President', service: 'Army', imageUrl: null },
  { organizationId: 'org3', name: 'Christopher Lee', role: 'Secretary', service: 'Navy', imageUrl: null },
  { organizationId: 'org3', name: 'Amanda Brown', role: 'Treasurer', service: 'Air Force', imageUrl: null },
  { organizationId: 'org3', name: 'Daniel Harris', role: 'Member', service: 'Army', imageUrl: null },
];

// Mock news - now organization-specific
const news = [
  // org1 - Veterans United
  {
    organizationId: 'org1',
    title: 'Annual Veterans Day Ceremony',
    description: 'Join us for our annual Veterans Day ceremony honoring all who have served. The event will feature guest speakers, a memorial service, and community gathering.',
    date: 'Nov 11, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    organizationId: 'org1',
    title: 'New Healthcare Benefits Available',
    description: 'We are pleased to announce new healthcare benefits for all members. Visit our office to learn more about the expanded coverage options.',
    date: 'Nov 5, 2026',
    category: 'Benefits',
    imageUrl: null
  },
  {
    organizationId: 'org1',
    title: 'Community Outreach Program Success',
    description: 'Our recent community outreach program was a great success! Over 200 veterans received assistance with job placement and career counseling.',
    date: 'Oct 28, 2026',
    category: 'News',
    imageUrl: null
  },
  {
    organizationId: 'org1',
    title: 'Monthly Member Meeting Scheduled',
    description: 'Our monthly member meeting is scheduled for the first Friday of next month. All members are encouraged to attend and participate.',
    date: 'Oct 15, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    organizationId: 'org1',
    title: 'Scholarship Opportunities',
    description: 'Multiple scholarship opportunities are now available for veterans and their families. Applications are being accepted through the end of the year.',
    date: 'Oct 10, 2026',
    category: 'Education',
    imageUrl: null
  },
  // org2 - Heroes Association
  {
    organizationId: 'org2',
    title: 'Heroes Association Annual Gala',
    description: 'Join us for our annual gala fundraiser supporting veteran families. Evening includes dinner, awards ceremony, and special entertainment.',
    date: 'Dec 15, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    organizationId: 'org2',
    title: 'New Mental Health Support Program',
    description: 'We are launching a comprehensive mental health support program with free counseling services for all members and their families.',
    date: 'Nov 20, 2026',
    category: 'Benefits',
    imageUrl: null
  },
  {
    organizationId: 'org2',
    title: 'Job Fair for Veterans',
    description: 'Our quarterly job fair connects veterans with employers. Over 50 companies will be attending to meet with job seekers.',
    date: 'Nov 8, 2026',
    category: 'News',
    imageUrl: null
  },
  // org3 - Freedom Veterans
  {
    organizationId: 'org3',
    title: 'Freedom Veterans Memorial Dedication',
    description: 'Join us for the dedication ceremony of our new memorial honoring fallen heroes. Special guest speakers and family members will attend.',
    date: 'Nov 25, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    organizationId: 'org3',
    title: 'Housing Assistance Program Launch',
    description: 'New housing assistance program now available for veterans experiencing homelessness or housing instability.',
    date: 'Nov 12, 2026',
    category: 'Benefits',
    imageUrl: null
  },
  {
    organizationId: 'org3',
    title: 'Youth Mentorship Program',
    description: 'Veterans needed for our new youth mentorship program. Share your experience and guidance with the next generation.',
    date: 'Oct 30, 2026',
    category: 'News',
    imageUrl: null
  },
];

// Mock members - now organization-specific
const members = [
  // org1 - Veterans United
  { id: 'org1-1', organizationId: 'org1', name: 'John Doe', location: 'New York, NY', isPaid: true, status: 'active', role: 'President', service: 'Army' },
  { id: 'org1-2', organizationId: 'org1', name: 'Jane Smith', location: 'New York, NY', isPaid: true, status: 'active', role: 'Vice President', service: 'Navy' },
  { id: 'org1-3', organizationId: 'org1', name: 'Robert Johnson', location: 'Brooklyn, NY', isPaid: false, status: 'active', role: 'Secretary', service: 'Air Force' },
  { id: 'org1-4', organizationId: 'org1', name: 'Mary Williams', location: 'Queens, NY', isPaid: true, status: 'active', role: 'Treasurer', service: 'Marines' },
  { id: 'org1-5', organizationId: 'org1', name: 'James Brown', location: 'Bronx, NY', isPaid: false, status: 'active', role: 'Member', service: 'Coast Guard' },
  { id: 'org1-6', organizationId: 'org1', name: 'Patricia Garcia', location: 'Staten Island, NY', isPaid: true, status: 'suspended', role: 'Member', service: 'Army' },
  { id: 'org1-7', organizationId: 'org1', name: 'Michael Davis', location: 'Manhattan, NY', isPaid: false, status: 'suspended', role: 'Member', service: 'Navy' },
  { id: 'org1-8', organizationId: 'org1', name: 'Linda Martinez', location: 'New York, NY', isPaid: true, status: 'active', role: 'Member', service: 'Air Force' },
  { id: 'org1-9', organizationId: 'org1', name: 'Thomas Wilson', location: 'Brooklyn, NY', isPaid: false, status: 'dismissed', role: 'Member', service: 'Air Force' },
  { id: 'org1-10', organizationId: 'org1', name: 'Jennifer Martinez', location: 'Queens, NY', isPaid: false, status: 'dismissed', role: 'Member', service: 'Marines' },
  // org2 - Heroes Association
  { id: 'org2-1', organizationId: 'org2', name: 'Sarah Johnson', location: 'Los Angeles, CA', isPaid: true, status: 'active', role: 'President', service: 'Navy' },
  { id: 'org2-2', organizationId: 'org2', name: 'Michael Chen', location: 'Los Angeles, CA', isPaid: true, status: 'active', role: 'Vice President', service: 'Army' },
  { id: 'org2-3', organizationId: 'org2', name: 'Emily Rodriguez', location: 'Santa Monica, CA', isPaid: true, status: 'active', role: 'Secretary', service: 'Marines' },
  { id: 'org2-4', organizationId: 'org2', name: 'David Martinez', location: 'Pasadena, CA', isPaid: true, status: 'active', role: 'Treasurer', service: 'Air Force' },
  { id: 'org2-5', organizationId: 'org2', name: 'Lisa Thompson', location: 'Beverly Hills, CA', isPaid: false, status: 'active', role: 'Member', service: 'Coast Guard' },
  { id: 'org2-6', organizationId: 'org2', name: 'Kevin Anderson', location: 'Long Beach, CA', isPaid: true, status: 'active', role: 'Member', service: 'Navy' },
  { id: 'org2-7', organizationId: 'org2', name: 'Rachel Kim', location: 'Burbank, CA', isPaid: false, status: 'suspended', role: 'Member', service: 'Army' },
  { id: 'org2-8', organizationId: 'org2', name: 'Daniel Park', location: 'Glendale, CA', isPaid: true, status: 'active', role: 'Member', service: 'Marines' },
  // org3 - Freedom Veterans
  { id: 'org3-1', organizationId: 'org3', name: 'William Anderson', location: 'Chicago, IL', isPaid: true, status: 'active', role: 'President', service: 'Marines' },
  { id: 'org3-2', organizationId: 'org3', name: 'Jessica White', location: 'Chicago, IL', isPaid: true, status: 'active', role: 'Vice President', service: 'Army' },
  { id: 'org3-3', organizationId: 'org3', name: 'Christopher Lee', location: 'Evanston, IL', isPaid: true, status: 'active', role: 'Secretary', service: 'Navy' },
  { id: 'org3-4', organizationId: 'org3', name: 'Amanda Brown', location: 'Oak Park, IL', isPaid: true, status: 'active', role: 'Treasurer', service: 'Air Force' },
  { id: 'org3-5', organizationId: 'org3', name: 'Daniel Harris', location: 'Naperville, IL', isPaid: false, status: 'active', role: 'Member', service: 'Army' },
  { id: 'org3-6', organizationId: 'org3', name: 'Sophia Taylor', location: 'Aurora, IL', isPaid: true, status: 'active', role: 'Member', service: 'Navy' },
  { id: 'org3-7', organizationId: 'org3', name: 'Matthew Clark', location: 'Joliet, IL', isPaid: false, status: 'active', role: 'Member', service: 'Air Force' },
  { id: 'org3-8', organizationId: 'org3', name: 'Olivia Lewis', location: 'Rockford, IL', isPaid: true, status: 'suspended', role: 'Member', service: 'Marines' },
];

// Mock meetings - now organization-specific with more meetings per organization
const meetings = [
  // org1 - Veterans United
  {
    id: 'org1-1',
    organizationId: 'org1',
    title: 'Monthly General Meeting',
    date: 'Feb 1, 2026',
    venue: 'Veterans Community Center',
    attendance: 45,
    minutes: 'The monthly general meeting was called to order at 6:00 PM by President John Doe. The minutes from the previous meeting were read and approved. The treasurer reported a current balance of $25,000. Discussion included upcoming Veterans Day ceremony planning and new member recruitment strategies. The meeting was adjourned at 8:00 PM.',
    actionPoints: [
      'Form committee for Veterans Day ceremony planning',
      'Create recruitment flyer for new members',
      'Schedule maintenance for community center',
      'Review and update membership database'
    ],
    fines: [
      { memberName: 'James Brown', amount: 25.00, reason: 'Late arrival' },
      { memberName: 'Patricia Garcia', amount: 50.00, reason: 'Unexcused absence from previous meeting' }
    ]
  },
  {
    id: 'org1-2',
    organizationId: 'org1',
    title: 'Emergency Board Meeting',
    date: 'Jan 20, 2026',
    venue: 'Online via Video Conference',
    attendance: 12,
    minutes: 'Emergency board meeting convened to address urgent facility maintenance issues. The board discussed and approved emergency repair funding of $3,000 for roof repairs. All board members present voted unanimously in favor. Meeting concluded with plans to schedule contractor visits.',
    actionPoints: [
      'Contact three contractors for repair quotes',
      'Schedule emergency repairs within two weeks',
      'Document all expenses for insurance claims'
    ],
    fines: []
  },
  {
    id: 'org1-3',
    organizationId: 'org1',
    title: 'Annual Planning Session',
    date: 'Jan 5, 2026',
    venue: 'Veterans Community Center',
    attendance: 38,
    minutes: 'Annual planning session covered goals and objectives for 2026. Key discussion points included membership growth targets, fundraising initiatives, and community outreach programs. The organization set a goal of 200 total members by year end. Budget allocation for various programs was reviewed and approved.',
    actionPoints: [
      'Develop marketing plan for membership growth',
      'Organize quarterly fundraising events',
      'Establish partnership with local schools for outreach',
      'Create annual budget spreadsheet'
    ],
    fines: [
      { memberName: 'Michael Davis', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org1-4',
    organizationId: 'org1',
    title: 'Quarterly Financial Review',
    date: 'Dec 15, 2025',
    venue: 'Veterans Community Center',
    attendance: 32,
    minutes: 'Quarterly financial review presented by Treasurer Mary Williams. Total income for Q4 was $8,500, with expenses of $6,200. Net positive balance of $2,300 for the quarter. Discussed allocation of funds for upcoming projects and initiatives. All financial reports were approved by attending members.',
    actionPoints: [
      'Prepare detailed expense report for membership',
      'Plan budget allocation for next quarter',
      'Review and update financial policies'
    ],
    fines: [
      { memberName: 'Thomas Wilson', amount: 50.00, reason: 'Unexcused absence from previous meeting' },
      { memberName: 'James Brown', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org1-5',
    organizationId: 'org1',
    title: 'Special Events Committee Meeting',
    date: 'Dec 1, 2025',
    venue: 'Online via Video Conference',
    attendance: 15,
    minutes: 'Special events committee met to plan holiday celebration and Veterans Day ceremony. Committee members volunteered for various roles including decorations, catering coordination, and program planning. Budget of $1,500 approved for holiday event. Next committee meeting scheduled for early January.',
    actionPoints: [
      'Book venue for holiday celebration',
      'Confirm catering arrangements',
      'Create event program and agenda',
      'Send invitations to all members'
    ],
    fines: []
  },
  {
    id: 'org1-6',
    organizationId: 'org1',
    title: 'Membership Drive Committee',
    date: 'Nov 18, 2025',
    venue: 'Veterans Community Center',
    attendance: 22,
    minutes: 'Committee meeting focused on planning the annual membership drive. Discussed strategies for recruiting new members including social media campaigns, community events, and referral programs. Set target of 50 new members by end of fiscal year.',
    actionPoints: [
      'Launch social media recruitment campaign',
      'Design membership brochures',
      'Schedule community presence at local events',
      'Create member referral incentive program'
    ],
    fines: [
      { memberName: 'Linda Martinez', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org1-7',
    organizationId: 'org1',
    title: 'Veterans Day Ceremony Planning',
    date: 'Oct 28, 2025',
    venue: 'Veterans Community Center',
    attendance: 28,
    minutes: 'Detailed planning meeting for upcoming Veterans Day ceremony. Assigned roles for ceremony participants, finalized program agenda, and confirmed venue arrangements. Guest speakers confirmed and memorial service details approved.',
    actionPoints: [
      'Finalize ceremony program',
      'Confirm all guest speakers',
      'Arrange for ceremony equipment rental',
      'Coordinate with local media for coverage'
    ],
    fines: []
  },
  {
    id: 'org1-8',
    organizationId: 'org1',
    title: 'Fundraising Committee Meeting',
    date: 'Oct 10, 2025',
    venue: 'Online via Video Conference',
    attendance: 18,
    minutes: 'Fundraising committee reviewed current fundraising efforts and planned upcoming events. Discussed annual gala, charity auction, and partnership opportunities with local businesses. Set fundraising goal of $50,000 for the year.',
    actionPoints: [
      'Schedule annual gala date and venue',
      'Solicit donations for charity auction',
      'Contact local businesses for sponsorships',
      'Create fundraising promotional materials'
    ],
    fines: []
  },
  // org2 - Heroes Association
  {
    id: 'org2-1',
    organizationId: 'org2',
    title: 'Heroes Association Monthly Meeting',
    date: 'Feb 5, 2026',
    venue: 'LA Community Hall',
    attendance: 52,
    minutes: 'Monthly meeting opened by President Sarah Johnson. Financial report showed strong membership growth and increased donations. Discussed expansion of mental health support services and upcoming job fair planning.',
    actionPoints: [
      'Hire additional counseling staff',
      'Finalize job fair vendor list',
      'Update membership database',
      'Plan quarterly newsletter'
    ],
    fines: [
      { memberName: 'Rachel Kim', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org2-2',
    organizationId: 'org2',
    title: 'Mental Health Services Expansion Meeting',
    date: 'Jan 25, 2026',
    venue: 'LA Community Hall',
    attendance: 35,
    minutes: 'Special meeting to discuss expansion of mental health services. Committee presented proposal for adding two counselors and extending service hours. Budget of $75,000 approved for program expansion over next year.',
    actionPoints: [
      'Post job listings for counselor positions',
      'Establish extended service hours',
      'Create marketing materials for new services',
      'Set up intake process for new clients'
    ],
    fines: []
  },
  {
    id: 'org2-3',
    organizationId: 'org2',
    title: 'Annual Gala Planning Committee',
    date: 'Jan 12, 2026',
    venue: 'Online via Video Conference',
    attendance: 20,
    minutes: 'First planning meeting for annual gala fundraiser. Selected venue, discussed theme and decorations, and formed subcommittees for entertainment, catering, and sponsorships. Ticket sales to begin next month.',
    actionPoints: [
      'Finalize venue contract',
      'Book entertainment',
      'Design event invitations',
      'Reach out to potential sponsors'
    ],
    fines: []
  },
  {
    id: 'org2-4',
    organizationId: 'org2',
    title: 'Veterans Job Fair Coordination',
    date: 'Dec 20, 2025',
    venue: 'LA Community Hall',
    attendance: 25,
    minutes: 'Coordination meeting for upcoming veterans job fair. Confirmed participation from 50+ employers. Discussed layout, registration process, and volunteer needs. Projected attendance of 300+ job seekers.',
    actionPoints: [
      'Finalize floor plan and booth assignments',
      'Create job seeker registration system',
      'Recruit and train volunteers',
      'Develop promotional campaign'
    ],
    fines: []
  },
  {
    id: 'org2-5',
    organizationId: 'org2',
    title: 'Quarterly Financial Review',
    date: 'Dec 5, 2025',
    venue: 'LA Community Hall',
    attendance: 40,
    minutes: 'Treasurer David Martinez presented Q4 financial review. Total revenue of $92,000 with expenses of $68,000. Strong financial position allows for program expansion. Budget for next quarter approved unanimously.',
    actionPoints: [
      'Distribute financial summary to members',
      'Plan Q1 budget allocation',
      'Review expense approval processes',
      'Schedule annual financial audit'
    ],
    fines: [
      { memberName: 'Lisa Thompson', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org2-6',
    organizationId: 'org2',
    title: 'Community Outreach Committee',
    date: 'Nov 22, 2025',
    venue: 'Online via Video Conference',
    attendance: 18,
    minutes: 'Outreach committee meeting focused on strengthening community partnerships. Discussed collaboration with local schools, businesses, and other veteran organizations. Planned several joint events for upcoming year.',
    actionPoints: [
      'Schedule meetings with school administrators',
      'Create partnership proposal template',
      'Plan joint community service events',
      'Develop outreach marketing materials'
    ],
    fines: []
  },
  // org3 - Freedom Veterans
  {
    id: 'org3-1',
    organizationId: 'org3',
    title: 'Freedom Veterans General Assembly',
    date: 'Feb 8, 2026',
    venue: 'Chicago Veterans Center',
    attendance: 48,
    minutes: 'General assembly addressed memorial dedication planning, housing assistance program launch, and youth mentorship initiative. President William Anderson recognized outstanding member contributions. Strong member participation in all programs.',
    actionPoints: [
      'Finalize memorial dedication ceremony details',
      'Launch housing assistance application process',
      'Recruit mentors for youth program',
      'Update organization website'
    ],
    fines: []
  },
  {
    id: 'org3-2',
    organizationId: 'org3',
    title: 'Memorial Dedication Planning',
    date: 'Jan 28, 2026',
    venue: 'Chicago Veterans Center',
    attendance: 32,
    minutes: 'Planning committee met to finalize memorial dedication ceremony. Selected speakers, planned program order, and coordinated with families of fallen heroes. Invitations to be sent to 200+ attendees.',
    actionPoints: [
      'Confirm all ceremony speakers',
      'Send invitations to families',
      'Arrange for memorial unveiling',
      'Coordinate with city for ceremony permits'
    ],
    fines: [
      { memberName: 'Olivia Lewis', amount: 50.00, reason: 'Unexcused absence from previous meeting' }
    ]
  },
  {
    id: 'org3-3',
    organizationId: 'org3',
    title: 'Housing Assistance Program Launch',
    date: 'Jan 15, 2026',
    venue: 'Online via Video Conference',
    attendance: 26,
    minutes: 'Committee meeting to launch new housing assistance program. Reviewed application process, eligibility criteria, and funding allocation. Program aims to help 30 veterans in first year with housing stability.',
    actionPoints: [
      'Publish housing assistance program guidelines',
      'Set up application review committee',
      'Partner with local housing agencies',
      'Create program promotional materials'
    ],
    fines: []
  },
  {
    id: 'org3-4',
    organizationId: 'org3',
    title: 'Youth Mentorship Initiative',
    date: 'Dec 28, 2025',
    venue: 'Chicago Veterans Center',
    attendance: 30,
    minutes: 'Kickoff meeting for youth mentorship program. Discussed program structure, mentor training, and partnership with local schools. Goal to match 50 mentors with youth in first year.',
    actionPoints: [
      'Develop mentor training curriculum',
      'Partner with local schools',
      'Create mentor-mentee matching process',
      'Establish program evaluation metrics'
    ],
    fines: []
  },
  {
    id: 'org3-5',
    organizationId: 'org3',
    title: 'Annual Budget Planning Session',
    date: 'Dec 10, 2025',
    venue: 'Chicago Veterans Center',
    attendance: 35,
    minutes: 'Annual budget planning for fiscal year 2026. Treasurer Amanda Brown presented budget proposal with allocations for new programs, operations, and emergency funds. Budget of $180,000 approved for the year.',
    actionPoints: [
      'Distribute approved budget to all committees',
      'Establish monthly financial reporting',
      'Set up program-specific budget tracking',
      'Plan quarterly budget reviews'
    ],
    fines: [
      { memberName: 'Matthew Clark', amount: 25.00, reason: 'Late arrival' }
    ]
  },
  {
    id: 'org3-6',
    organizationId: 'org3',
    title: 'Membership Engagement Committee',
    date: 'Nov 20, 2025',
    venue: 'Online via Video Conference',
    attendance: 22,
    minutes: 'Committee focused on improving member engagement and retention. Discussed member survey results, planned social events, and new member orientation program improvements.',
    actionPoints: [
      'Implement member survey recommendations',
      'Plan quarterly social events',
      'Revamp new member orientation',
      'Create member engagement tracking system'
    ],
    fines: []
  },
];

// Mock constitutions - organization-specific
const constitutions = {
  org1: {
    organizationId: 'org1',
    organizationName: 'Veterans United',
    articles: [
      {
        title: 'Article I: Name and Purpose',
        sections: [
          'Section 1: The name of this organization shall be the Veterans United.',
          'Section 2: The purpose of this organization is to support and advocate for veterans and their families, to promote camaraderie among veterans, to provide assistance and resources to those in need, and to preserve the memory and legacy of those who have served.',
          'Section 3: This organization shall be non-partisan and non-sectarian in nature.',
        ]
      },
      {
        title: 'Article II: Membership',
        sections: [
          'Section 1: Membership is open to all veterans who have served honorably in the armed forces of the United States.',
          'Section 2: Associate membership may be granted to family members of veterans and others who support the organization\'s mission.',
          'Section 3: All members in good standing shall have the right to vote on organizational matters.',
          'Section 4: Members who fail to pay dues or violate the code of conduct may have their membership suspended or revoked by a two-thirds vote of the Executive Board.',
        ]
      },
      {
        title: 'Article III: Rights and Responsibilities',
        sections: [
          'Section 1: All members have the right to participate in organizational activities, attend meetings, and vote on important matters.',
          'Section 2: Members are expected to conduct themselves in a manner that reflects positively on the organization and the veteran community.',
          'Section 3: Members have the responsibility to pay annual dues as determined by the membership.',
          'Section 4: Members are encouraged to volunteer their time and resources to further the organization\'s mission.',
        ]
      },
      {
        title: 'Article IV: Officers and Executive Board',
        sections: [
          'Section 1: The officers of this organization shall consist of a President, Vice President, Secretary, and Treasurer.',
          'Section 2: Officers shall be elected by majority vote of the membership at the annual meeting and shall serve for a term of two years.',
          'Section 3: The Executive Board shall consist of the elected officers and three at-large members.',
          'Section 4: The Executive Board shall meet quarterly and shall have the authority to manage the affairs of the organization between general membership meetings.',
          'Section 5: Officers may be removed from office for cause by a two-thirds vote of the membership.',
        ]
      },
      {
        title: 'Article V: Duties of Officers',
        sections: [
          'Section 1: The President shall preside at all meetings, appoint committee chairs, and represent the organization in official matters.',
          'Section 2: The Vice President shall assume the duties of the President in their absence and shall chair the Membership Committee.',
          'Section 3: The Secretary shall keep minutes of all meetings, maintain membership records, and handle correspondence.',
          'Section 4: The Treasurer shall manage the organization\'s finances, collect dues, pay bills, and provide financial reports to the membership.',
        ]
      },
      {
        title: 'Article VI: Meetings',
        sections: [
          'Section 1: Regular meetings shall be held monthly at a time and place determined by the Executive Board.',
          'Section 2: An annual meeting shall be held in the first quarter of each year for the election of officers and presentation of annual reports.',
          'Section 3: Special meetings may be called by the President or upon written request of ten members.',
          'Section 4: A quorum for conducting business shall consist of fifteen members or twenty percent of the membership, whichever is less.',
        ]
      },
      {
        title: 'Article VII: Committees',
        sections: [
          'Section 1: The following standing committees shall be maintained: Membership, Programs, Finance, Veterans Assistance, and Community Outreach.',
          'Section 2: The President may appoint special committees as needed to accomplish specific tasks.',
          'Section 3: Committee chairs shall report their activities at regular meetings.',
        ]
      },
      {
        title: 'Article VIII: Finances',
        sections: [
          'Section 1: The fiscal year of the organization shall be from January 1 to December 31.',
          'Section 2: Annual membership dues shall be determined by a majority vote of the membership.',
          'Section 3: All funds shall be deposited in a bank account in the organization\'s name.',
          'Section 4: The Treasurer shall present a financial report at each regular meeting.',
          'Section 5: An annual audit of the organization\'s finances shall be conducted by an independent auditor or audit committee.',
        ]
      },
      {
        title: 'Article IX: Amendments',
        sections: [
          'Section 1: This constitution may be amended by a two-thirds vote of the members present at any regular meeting.',
          'Section 2: Proposed amendments must be submitted in writing to the Secretary at least thirty days before the meeting at which they will be considered.',
          'Section 3: Notice of proposed amendments must be provided to the membership at least two weeks before the vote.',
        ]
      },
      {
        title: 'Article X: Dissolution',
        sections: [
          'Section 1: This organization may be dissolved by a three-fourths vote of the entire membership.',
          'Section 2: In the event of dissolution, all assets shall be distributed to one or more organizations that support veterans or their families, as determined by the membership.',
          'Section 3: No member shall receive any financial benefit from the dissolution of the organization.',
        ]
      },
      {
        title: 'Article XI: Parliamentary Authority',
        sections: [
          'Section 1: Robert\'s Rules of Order, latest edition, shall govern all meetings of this organization where they are not in conflict with this constitution.',
        ]
      },
    ],
    adoptedDate: 'January 15, 2020',
    lastAmended: 'March 10, 2024',
  },
  org2: {
    organizationId: 'org2',
    organizationName: 'Heroes Association',
    articles: [
      {
        title: 'Article I: Name and Mission',
        sections: [
          'Section 1: This organization shall be known as the Heroes Association.',
          'Section 2: Our mission is to honor the service of military veterans, provide comprehensive support services, and foster a strong community of heroes and their families.',
          'Section 3: The Association shall operate as a non-profit, non-political organization dedicated to veteran welfare.',
        ]
      },
      {
        title: 'Article II: Membership Eligibility',
        sections: [
          'Section 1: Full membership is available to all honorably discharged veterans of the United States Armed Forces.',
          'Section 2: Associate memberships are available to spouses, family members, and supporters of veterans.',
          'Section 3: Honorary memberships may be bestowed upon individuals who have made extraordinary contributions to the veteran community.',
          'Section 4: Membership applications must be approved by the Membership Committee.',
        ]
      },
      {
        title: 'Article III: Member Rights and Duties',
        sections: [
          'Section 1: Members shall have access to all programs, services, and events sponsored by the Association.',
          'Section 2: Members are entitled to vote in elections and on organizational matters requiring membership approval.',
          'Section 3: Members are expected to uphold the values and reputation of the Association.',
          'Section 4: Members must pay annual dues and comply with all organizational policies.',
        ]
      },
      {
        title: 'Article IV: Leadership Structure',
        sections: [
          'Section 1: The Association shall be led by a President, Vice President, Secretary, and Treasurer, collectively known as Executive Officers.',
          'Section 2: Executive Officers are elected to three-year terms by membership vote at the annual convention.',
          'Section 3: A Board of Directors consisting of Executive Officers and five elected directors shall govern the Association.',
          'Section 4: The Board shall meet monthly and have authority over Association operations and policies.',
        ]
      },
      {
        title: 'Article V: Officer Responsibilities',
        sections: [
          'Section 1: The President serves as chief executive, presides over meetings, and represents the Association publicly.',
          'Section 2: The Vice President assists the President and chairs the Program Development Committee.',
          'Section 3: The Secretary maintains records, manages communications, and ensures meeting documentation.',
          'Section 4: The Treasurer oversees finances, prepares budgets, and provides quarterly financial reports.',
        ]
      },
      {
        title: 'Article VI: Meetings and Assemblies',
        sections: [
          'Section 1: General membership meetings shall occur quarterly.',
          'Section 2: An annual convention shall be held each year for officer elections and strategic planning.',
          'Section 3: Emergency meetings may be called by the President or by petition of twenty-five members.',
          'Section 4: A quorum of thirty members or fifteen percent of active membership, whichever is greater, is required for official business.',
        ]
      },
      {
        title: 'Article VII: Programs and Services',
        sections: [
          'Section 1: The Association shall maintain programs for veteran assistance, mental health support, career services, and family support.',
          'Section 2: New programs may be established by Board approval and adequate funding.',
          'Section 3: All programs shall be evaluated annually for effectiveness and sustainability.',
        ]
      },
      {
        title: 'Article VIII: Financial Management',
        sections: [
          'Section 1: The fiscal year runs from July 1 to June 30.',
          'Section 2: Membership dues and all financial policies shall be set by Board vote.',
          'Section 3: All funds must be held in FDIC-insured accounts under the Association\'s name.',
          'Section 4: Annual financial audits by certified public accountants are mandatory.',
          'Section 5: The Association may accept grants and donations consistent with its mission.',
        ]
      },
      {
        title: 'Article IX: Constitutional Amendments',
        sections: [
          'Section 1: Amendments require approval by three-fourths of members present at a general meeting or annual convention.',
          'Section 2: Amendment proposals must be submitted to the Board sixty days before the vote.',
          'Section 3: All members must receive notice of proposed amendments at least thirty days before voting.',
        ]
      },
      {
        title: 'Article X: Dissolution Procedures',
        sections: [
          'Section 1: Dissolution requires approval by four-fifths of the entire active membership.',
          'Section 2: Upon dissolution, assets shall be transferred to qualified veteran service organizations as selected by the membership.',
          'Section 3: Dissolution must comply with all applicable state and federal regulations.',
        ]
      },
    ],
    adoptedDate: 'August 5, 2018',
    lastAmended: 'November 12, 2025',
  },
  org3: {
    organizationId: 'org3',
    organizationName: 'Freedom Veterans',
    articles: [
      {
        title: 'Article I: Organization Identity',
        sections: [
          'Section 1: This organization is designated as Freedom Veterans.',
          'Section 2: Freedom Veterans exists to serve, support, and empower veterans through community engagement, advocacy, and comprehensive assistance programs.',
          'Section 3: The organization maintains a strictly apolitical and inclusive stance.',
        ]
      },
      {
        title: 'Article II: Membership Categories',
        sections: [
          'Section 1: Regular membership is open to veterans with honorable service in any branch of the U.S. military.',
          'Section 2: Supporting membership is available to civilians who wish to assist in the organization\'s mission.',
          'Section 3: Lifetime memberships may be awarded for exceptional service to the organization.',
          'Section 4: All membership categories must meet eligibility requirements established by the Board.',
        ]
      },
      {
        title: 'Article III: Member Privileges and Obligations',
        sections: [
          'Section 1: Members enjoy full access to organizational resources, events, and support services.',
          'Section 2: Members possess voting rights on matters affecting the organization\'s direction and policies.',
          'Section 3: Members shall conduct themselves with honor and respect for fellow members and the community.',
          'Section 4: Regular members must fulfill annual dues obligations and participate in at least one organization activity per year.',
        ]
      },
      {
        title: 'Article IV: Governance and Leadership',
        sections: [
          'Section 1: The organization is governed by a President, Vice President, Secretary, and Treasurer.',
          'Section 2: Officers serve four-year staggered terms to ensure leadership continuity.',
          'Section 3: A Governing Council comprises the officers plus six elected council members.',
          'Section 4: The Council meets bi-monthly and exercises authority over organizational operations.',
          'Section 5: Officers and council members may be recalled by a two-thirds membership vote.',
        ]
      },
      {
        title: 'Article V: Executive Duties',
        sections: [
          'Section 1: The President leads the organization, chairs meetings, and serves as official spokesperson.',
          'Section 2: The Vice President supports the President and oversees the Outreach and Engagement Committee.',
          'Section 3: The Secretary documents proceedings, maintains organizational records, and handles official correspondence.',
          'Section 4: The Treasurer manages financial affairs, prepares budgets, and reports financial status monthly.',
        ]
      },
      {
        title: 'Article VI: General and Special Meetings',
        sections: [
          'Section 1: General meetings are held on a monthly basis.',
          'Section 2: An annual assembly occurs each spring for elections, reports, and strategic planning.',
          'Section 3: Special meetings may be convened by the President or upon petition by fifteen members.',
          'Section 4: Twenty-five members or ten percent of active membership constitutes a quorum.',
        ]
      },
      {
        title: 'Article VII: Committees and Task Forces',
        sections: [
          'Section 1: Standing committees include Housing Assistance, Mental Health, Youth Mentorship, and Veteran Advocacy.',
          'Section 2: The President appoints committee chairs with Council approval.',
          'Section 3: Task forces may be formed for specific projects with defined objectives and timelines.',
          'Section 4: All committees report progress at monthly meetings.',
        ]
      },
      {
        title: 'Article VIII: Financial Administration',
        sections: [
          'Section 1: The fiscal year operates from October 1 to September 30.',
          'Section 2: Dues amounts are determined annually by majority vote.',
          'Section 3: Organizational funds must be held in federally insured financial institutions.',
          'Section 4: Financial transparency is ensured through monthly reports and annual independent audits.',
          'Section 5: Fundraising activities must align with the organization\'s mission and values.',
        ]
      },
      {
        title: 'Article IX: Amendment Process',
        sections: [
          'Section 1: Constitutional amendments require a three-fourths affirmative vote at a general or annual meeting.',
          'Section 2: Amendment proposals must be presented to the Council forty-five days before voting.',
          'Section 3: Members must receive written notice of amendments at least twenty-one days before the vote.',
        ]
      },
      {
        title: 'Article X: Termination Clause',
        sections: [
          'Section 1: Organizational dissolution requires approval by eighty percent of active members.',
          'Section 2: Remaining assets upon dissolution shall be distributed to veteran-serving charitable organizations.',
          'Section 3: No individual member may personally benefit from organizational dissolution.',
        ]
      },
    ],
    adoptedDate: 'May 20, 2019',
    lastAmended: 'January 8, 2026',
  },
};

const currentSoccerMatch = {
  matchDay: 'Saturday, February 10, 2026',
  homeTeam: 'Veterans United FC',
  awayTeam: 'City Rovers',
  homeScore: 3,
  awayScore: 1,
  referee: 'John Smith',
  assistantReferee1: 'Mike Johnson',
  assistantReferee2: 'Sarah Williams',
  goals: [
    { playerName: 'David Martinez', minute: '23\'', team: 'Home' },
    { playerName: 'James Wilson', minute: '45\'', team: 'Away' },
    { playerName: 'David Martinez', minute: '67\'', team: 'Home' },
    { playerName: 'Robert Brown', minute: '82\'', team: 'Home' }
  ],
  assists: [
    { playerName: 'Chris Anderson', minute: '23\'', team: 'Home' },
    { playerName: 'Tom Davis', minute: '45\'', team: 'Away' },
    { playerName: 'Chris Anderson', minute: '67\'', team: 'Home' },
    { playerName: 'Kevin Moore', minute: '82\'', team: 'Home' }
  ],
  yellowCards: [
    { playerName: 'Paul Taylor', minute: '31\'', team: 'Away', reason: 'Unsporting behavior' },
    { playerName: 'Mark Thompson', minute: '58\'', team: 'Home', reason: 'Time wasting' },
    { playerName: 'Steve Harris', minute: '74\'', team: 'Away', reason: 'Tactical foul' }
  ],
  redCards: [
    { playerName: 'Alex White', minute: '89\'', team: 'Away', reason: 'Violent conduct' }
  ]
};

// Helper function to calculate hosting schedule
function getHostingSchedule(isNext = false, organizationId = null) {
  const now = new Date();
  const referenceDate = new Date('2024-01-01');
  const daysSinceReference = Math.floor((now - referenceDate) / (1000 * 60 * 60 * 24));
  const periodNumber = Math.floor(daysSinceReference / 14) + (isNext ? 1 : 0);
  
  const startDate = new Date(referenceDate);
  startDate.setDate(startDate.getDate() + periodNumber * 14);
  
  const endDate = new Date(startDate);
  endDate.setDate(endDate.getDate() + 14);
  
  // Filter members by organization if provided
  let activeMembers = members.filter(m => m.status === 'active');
  if (organizationId) {
    activeMembers = activeMembers.filter(m => m.organizationId === organizationId);
  }
  
  const hostIndices = [
    (periodNumber * 3) % activeMembers.length,
    (periodNumber * 3 + 1) % activeMembers.length,
    (periodNumber * 3 + 2) % activeMembers.length
  ];
  const hosts = hostIndices.map(i => activeMembers[i]);
  
  return {
    id: `schedule_${periodNumber}`,
    startDate: startDate.toISOString(),
    endDate: endDate.toISOString(),
    hosts: hosts,
    allMembers: activeMembers,
    contributionAmount: 30.0
  };
}

// Routes

// Helper functions for JWT tokens
function generateAccessToken(user) {
  return jwt.sign(
    { id: user.id, username: user.username, email: user.email },
    JWT_ACCESS_SECRET,
    { expiresIn: ACCESS_TOKEN_EXPIRY }
  );
}

function generateRefreshToken(user) {
  return jwt.sign(
    { id: user.id, username: user.username },
    JWT_REFRESH_SECRET,
    { expiresIn: REFRESH_TOKEN_EXPIRY }
  );
}

// Middleware to extract organization ID from request
// Can be from header (X-Organization-ID) or query parameter (organizationId)
function extractOrganizationId(req, res, next) {
  const orgId = req.headers['x-organization-id'] || req.query.organizationId;
  
  if (!orgId) {
    return res.status(400).json({ 
      success: false,
      message: 'Organization ID is required. Provide via X-Organization-ID header or organizationId query parameter.' 
    });
  }

  // Validate that organization exists
  const org = organizations.find(o => o.id === orgId);
  if (!org) {
    return res.status(404).json({ 
      success: false,
      message: 'Organization not found' 
    });
  }

  req.organizationId = orgId;
  next();
}

// Health check
app.get('/', (req, res) => {
  res.json({ 
    message: 'Veteran App REST API',
    version: '1.0.0',
    status: 'running'
  });
});

// Authentication endpoints

// User login
app.post('/auth/login', (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ 
      success: false,
      message: 'Username and password are required' 
    });
  }

  // Find user by username or email
  const user = users.find(u => 
    u.username === username || u.email === username
  );

  if (!user) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid username or password' 
    });
  }

  if (user.password !== password) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid username or password' 
    });
  }

  // Generate tokens
  const accessToken = generateAccessToken(user);
  const refreshToken = generateRefreshToken(user);
  
  // Store refresh token
  refreshTokens.add(refreshToken);

  // Get user's organizations
  const userOrganizations = organizations.filter(org => 
    user.organizationIds.includes(org.id)
  );

  // Set current organization to the first one by default
  const currentOrganization = userOrganizations.length > 0 ? userOrganizations[0] : null;

  // Return user info with tokens (excluding password)
  res.json({
    success: true,
    message: 'Login successful',
    user: {
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name,
      organizations: userOrganizations,
      currentOrganizationId: currentOrganization?.id || null
    },
    accessToken: accessToken,
    refreshToken: refreshToken
  });
});

// Forgot password
app.post('/auth/forgot-password', (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ 
      success: false,
      message: 'Email is required' 
    });
  }

  // Check if user exists with this email
  const user = users.find(u => u.email === email);

  if (!user) {
    // For security reasons, we still return success even if user doesn't exist
    // This prevents email enumeration attacks
    return res.json({
      success: true,
      message: 'If an account exists with this email, a password reset link has been sent'
    });
  }

  // In a real app, you would send an email here
  // For now, we just return success
  res.json({
    success: true,
    message: 'If an account exists with this email, a password reset link has been sent'
  });
});

// Get user's organizations
app.get('/auth/organizations', (req, res) => {
  const authHeader = req.headers.authorization;
  
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ 
      success: false,
      message: 'Authorization token required' 
    });
  }

  const token = authHeader.substring(7);
  
  try {
    // Verify access token
    const decoded = jwt.verify(token, JWT_ACCESS_SECRET);
    
    // Find user
    const user = users.find(u => u.id === decoded.id);
    
    if (!user) {
      return res.status(401).json({ 
        success: false,
        message: 'User not found' 
      });
    }

    // Get user's organizations
    const userOrganizations = organizations.filter(org => 
      user.organizationIds.includes(org.id)
    );

    res.json({
      success: true,
      organizations: userOrganizations
    });
  } catch (error) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid or expired token' 
    });
  }
});

// Switch current organization
app.post('/auth/switch-organization', (req, res) => {
  const { organizationId } = req.body;
  const authHeader = req.headers.authorization;
  
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ 
      success: false,
      message: 'Authorization token required' 
    });
  }

  if (!organizationId) {
    return res.status(400).json({ 
      success: false,
      message: 'Organization ID is required' 
    });
  }

  const token = authHeader.substring(7);
  
  try {
    // Verify access token
    const decoded = jwt.verify(token, JWT_ACCESS_SECRET);
    
    // Find user
    const user = users.find(u => u.id === decoded.id);
    
    if (!user) {
      return res.status(401).json({ 
        success: false,
        message: 'User not found' 
      });
    }

    // Check if user belongs to this organization
    if (!user.organizationIds.includes(organizationId)) {
      return res.status(403).json({ 
        success: false,
        message: 'User does not belong to this organization' 
      });
    }

    // Find the organization
    const organization = organizations.find(org => org.id === organizationId);
    
    if (!organization) {
      return res.status(404).json({ 
        success: false,
        message: 'Organization not found' 
      });
    }

    res.json({
      success: true,
      message: 'Organization switched successfully',
      currentOrganizationId: organizationId,
      organization: organization
    });
  } catch (error) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid or expired token' 
    });
  }
});

// Refresh token
app.post('/auth/refresh', (req, res) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    return res.status(400).json({ 
      success: false,
      message: 'Refresh token is required' 
    });
  }

  // Check if refresh token exists in our store
  if (!refreshTokens.has(refreshToken)) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid refresh token' 
    });
  }

  try {
    // Verify refresh token
    const decoded = jwt.verify(refreshToken, JWT_REFRESH_SECRET);
    
    // Find user
    const user = users.find(u => u.id === decoded.id);
    
    if (!user) {
      return res.status(401).json({ 
        success: false,
        message: 'User not found' 
      });
    }

    // Generate new access token
    const accessToken = generateAccessToken(user);

    res.json({
      success: true,
      message: 'Token refreshed successfully',
      accessToken: accessToken
    });
  } catch (error) {
    return res.status(401).json({ 
      success: false,
      message: 'Invalid or expired refresh token' 
    });
  }
});

// Get all officials (organization-specific)
app.get('/officials', extractOrganizationId, (req, res) => {
  const orgOfficials = officials.filter(o => o.organizationId === req.organizationId);
  res.json(orgOfficials);
});

// Get all news items (organization-specific)
app.get('/news', extractOrganizationId, (req, res) => {
  const orgNews = news.filter(n => n.organizationId === req.organizationId);
  res.json(orgNews);
});

// Get all members (organization-specific)
app.get('/members', extractOrganizationId, (req, res) => {
  const orgMembers = members.filter(m => m.organizationId === req.organizationId);
  res.json(orgMembers);
});

// Get member by ID (organization-specific)
app.get('/members/:id', extractOrganizationId, (req, res) => {
  const member = members.find(m => m.id === req.params.id && m.organizationId === req.organizationId);
  if (member) {
    res.json(member);
  } else {
    res.status(404).json({ error: 'Member not found' });
  }
});

// Get current soccer match
app.get('/soccer/current', (req, res) => {
  res.json(currentSoccerMatch);
});

// Get soccer match history
app.get('/soccer/history', (req, res) => {
  res.json([currentSoccerMatch]);
});

// Get current hosting schedule (organization-specific)
app.get('/hosting/current', extractOrganizationId, (req, res) => {
  res.json(getHostingSchedule(false, req.organizationId));
});

// Get next hosting schedule (organization-specific)
app.get('/hosting/next', extractOrganizationId, (req, res) => {
  res.json(getHostingSchedule(true, req.organizationId));
});

// Get all meetings (organization-specific)
app.get('/meetings', extractOrganizationId, (req, res) => {
  const orgMeetings = meetings.filter(m => m.organizationId === req.organizationId);
  res.json(orgMeetings);
});

// Mark payment for hosting
app.post('/hosting/mark-payment', (req, res) => {
  const { memberId, scheduleId, isPaid } = req.body;

  if (!memberId || !scheduleId || typeof isPaid !== 'boolean') {
    return res.status(400).json({ 
      success: false,
      message: 'memberId, scheduleId, and isPaid (boolean) are required' 
    });
  }

  // Find the member
  const member = members.find(m => m.id === memberId);
  if (!member) {
    return res.status(404).json({ 
      success: false,
      message: 'Member not found' 
    });
  }

  // Get the current schedule to verify the member is a host
  const currentSchedule = getHostingSchedule(false);
  const isHost = currentSchedule.hosts.some(h => h.id === memberId);

  if (!isHost) {
    return res.status(403).json({ 
      success: false,
      message: 'Only hosting members can mark their payment status' 
    });
  }

  // Update the member's payment status
  member.isPaid = isPaid;

  res.json({
    success: true,
    message: 'Payment status updated successfully',
    member: member
  });
});

// Get meeting by ID (organization-specific)
app.get('/meetings/:id', extractOrganizationId, (req, res) => {
  const meeting = meetings.find(m => m.id === req.params.id && m.organizationId === req.organizationId);
  if (meeting) {
    res.json(meeting);
  } else {
    res.status(404).json({ error: 'Meeting not found' });
  }
});

// Get constitution (organization-specific)
app.get('/constitution', extractOrganizationId, (req, res) => {
  const constitution = constitutions[req.organizationId];
  if (constitution) {
    res.json(constitution);
  } else {
    res.status(404).json({ error: 'Constitution not found for this organization' });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Veteran App REST API server is running on port ${PORT}`);
  console.log(`\nAvailable endpoints:`);
  console.log(`  GET  /                                                  - API info`);
  console.log(`  POST /auth/login                                        - User login`);
  console.log(`  POST /auth/refresh                                      - Refresh access token`);
  console.log(`  POST /auth/forgot-password                              - Request password reset`);
  console.log(`  GET  /auth/organizations                                - Get user's organizations`);
  console.log(`  POST /auth/switch-organization                          - Switch current organization`);
  console.log(`  GET  /officials?organizationId=<id>                     - Get officials (org-specific)`);
  console.log(`  GET  /news?organizationId=<id>                          - Get news items (org-specific)`);
  console.log(`  GET  /members?organizationId=<id>                       - Get members (org-specific)`);
  console.log(`  GET  /members/:id?organizationId=<id>                   - Get member by ID (org-specific)`);
  console.log(`  GET  /meetings?organizationId=<id>                      - Get meetings (org-specific)`);
  console.log(`  GET  /meetings/:id?organizationId=<id>                  - Get meeting by ID (org-specific)`);
  console.log(`  GET  /constitution?organizationId=<id>                  - Get constitution (org-specific)`);
  console.log(`  GET  /soccer/current                                    - Get current soccer match`);
  console.log(`  GET  /soccer/history                                    - Get soccer match history`);
  console.log(`  GET  /hosting/current?organizationId=<id>               - Get current hosting schedule (org-specific)`);
  console.log(`  GET  /hosting/next?organizationId=<id>                  - Get next hosting schedule (org-specific)`);
  console.log(`\nNote: Organization-specific endpoints require organizationId parameter or X-Organization-ID header`);
});

module.exports = app;
