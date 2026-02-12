const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Mock Data
const officials = [
  { name: 'Etukeni Ndecha', role: 'President', service: 'Army', imageUrl: null },
  { name: 'Jane Smith', role: 'Vice President', service: 'Navy', imageUrl: null },
  { name: 'Robert Johnson', role: 'Secretary', service: 'Air Force', imageUrl: null },
  { name: 'Mary Williams', role: 'Treasurer', service: 'Marines', imageUrl: null },
  { name: 'James Brown', role: 'Member', service: 'Coast Guard', imageUrl: null },
  { name: 'Patricia Davis', role: 'Member', service: 'Army', imageUrl: null },
  { name: 'Michael Miller', role: 'Member', service: 'Navy', imageUrl: null }
];

const news = [
  {
    title: 'Annual Veterans Day Ceremony',
    description: 'Join us for our annual Veterans Day ceremony honoring all who have served. The event will feature guest speakers, a memorial service, and community gathering.',
    date: 'Nov 11, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    title: 'New Healthcare Benefits Available',
    description: 'We are pleased to announce new healthcare benefits for all members. Visit our office to learn more about the expanded coverage options.',
    date: 'Nov 5, 2026',
    category: 'Benefits',
    imageUrl: null
  },
  {
    title: 'Community Outreach Program Success',
    description: 'Our recent community outreach program was a great success! Over 200 veterans received assistance with job placement and career counseling.',
    date: 'Oct 28, 2026',
    category: 'News',
    imageUrl: null
  },
  {
    title: 'Monthly Member Meeting Scheduled',
    description: 'Our monthly member meeting is scheduled for the first Friday of next month. All members are encouraged to attend and participate.',
    date: 'Oct 15, 2026',
    category: 'Events',
    imageUrl: null
  },
  {
    title: 'Scholarship Opportunities',
    description: 'Multiple scholarship opportunities are now available for veterans and their families. Applications are being accepted through the end of the year.',
    date: 'Oct 10, 2026',
    category: 'Education',
    imageUrl: null
  }
];

const members = [
  { id: '1', name: 'John Doe', location: 'New York, NY', isPaid: true, status: 'active', role: 'President', service: 'Army' },
  { id: '2', name: 'Jane Smith', location: 'Los Angeles, CA', isPaid: true, status: 'active', role: 'Vice President', service: 'Navy' },
  { id: '3', name: 'Robert Johnson', location: 'Chicago, IL', isPaid: false, status: 'active', role: 'Secretary', service: 'Air Force' },
  { id: '4', name: 'Mary Williams', location: 'Houston, TX', isPaid: true, status: 'active', role: 'Treasurer', service: 'Marines' },
  { id: '5', name: 'James Brown', location: 'Phoenix, AZ', isPaid: false, status: 'active', role: 'Member', service: 'Coast Guard' },
  { id: '6', name: 'Patricia Garcia', location: 'Philadelphia, PA', isPaid: true, status: 'suspended', role: 'Member', service: 'Army' },
  { id: '7', name: 'Michael Davis', location: 'San Antonio, TX', isPaid: false, status: 'suspended', role: 'Member', service: 'Navy' },
  { id: '8', name: 'Linda Martinez', location: 'San Diego, CA', isPaid: true, status: 'active', role: 'Member', service: 'Air Force' },
  { id: '9', name: 'Thomas Wilson', location: 'Dallas, TX', isPaid: false, status: 'dismissed', role: 'Member', service: 'Air Force' },
  { id: '10', name: 'Jennifer Martinez', location: 'San Jose, CA', isPaid: false, status: 'dismissed', role: 'Member', service: 'Marines' }
];

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
function getHostingSchedule(isNext = false) {
  const now = new Date();
  const referenceDate = new Date('2024-01-01');
  const daysSinceReference = Math.floor((now - referenceDate) / (1000 * 60 * 60 * 24));
  const periodNumber = Math.floor(daysSinceReference / 14) + (isNext ? 1 : 0);
  
  const startDate = new Date(referenceDate);
  startDate.setDate(startDate.getDate() + periodNumber * 14);
  
  const endDate = new Date(startDate);
  endDate.setDate(endDate.getDate() + 14);
  
  const activeMembers = members.filter(m => m.status === 'active');
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

// Health check
app.get('/', (req, res) => {
  res.json({ 
    message: 'Veteran App REST API',
    version: '1.0.0',
    status: 'running'
  });
});

// Get all officials
app.get('/officials', (req, res) => {
  res.json(officials);
});

// Get all news items
app.get('/news', (req, res) => {
  res.json(news);
});

// Get all members
app.get('/members', (req, res) => {
  res.json(members);
});

// Get member by ID
app.get('/members/:id', (req, res) => {
  const member = members.find(m => m.id === req.params.id);
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

// Get current hosting schedule
app.get('/hosting/current', (req, res) => {
  res.json(getHostingSchedule(false));
});

// Get next hosting schedule
app.get('/hosting/next', (req, res) => {
  res.json(getHostingSchedule(true));
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
  console.log(`  GET  /                  - API info`);
  console.log(`  GET  /officials         - Get all officials`);
  console.log(`  GET  /news              - Get all news items`);
  console.log(`  GET  /members           - Get all members`);
  console.log(`  GET  /members/:id       - Get member by ID`);
  console.log(`  GET  /soccer/current    - Get current soccer match`);
  console.log(`  GET  /soccer/history    - Get soccer match history`);
  console.log(`  GET  /hosting/current   - Get current hosting schedule`);
  console.log(`  GET  /hosting/next      - Get next hosting schedule`);
});

module.exports = app;
