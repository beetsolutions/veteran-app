const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Mock Data

// Mock users for authentication
// NOTE: In production, passwords should be hashed using bcrypt or similar.
// These are plain text only for demo/testing purposes.
const users = [
  { id: '1', username: 'admin', email: 'admin@veteranapp.com', password: 'admin123', name: 'Admin User' },
  { id: '2', username: 'johndoe', email: 'john.doe@example.com', password: 'password123', name: 'John Doe' },
  { id: '3', username: 'janesmith', email: 'jane.smith@example.com', password: 'password123', name: 'Jane Smith' },
];

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

  // Return user info (excluding password)
  res.json({
    success: true,
    message: 'Login successful',
    user: {
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name
    }
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
  console.log(`  GET  /                     - API info`);
  console.log(`  POST /auth/login           - User login`);
  console.log(`  POST /auth/forgot-password - Request password reset`);
  console.log(`  GET  /officials            - Get all officials`);
  console.log(`  GET  /news                 - Get all news items`);
  console.log(`  GET  /members              - Get all members`);
  console.log(`  GET  /members/:id          - Get member by ID`);
  console.log(`  GET  /soccer/current       - Get current soccer match`);
  console.log(`  GET  /soccer/history       - Get soccer match history`);
  console.log(`  GET  /hosting/current      - Get current hosting schedule`);
  console.log(`  GET  /hosting/next         - Get next hosting schedule`);
});

module.exports = app;
