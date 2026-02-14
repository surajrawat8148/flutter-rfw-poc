const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(express.json()); // Enable JSON parsing

// In-memory user storage
const users = [];

// Sample RFW widget library string
const rfwData = `
  import core.widgets;
  import core.material;

  widget root = Scaffold(
    appBar: AppBar(
      title: Text(text: "RFW Home"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: "center",
        children: [
          Text(text: "Hello from Node.js!", style: { fontSize: 24.0, fontWeight: "bold" }),
          SizedBox(height: 20.0),
          Text(text: "This UI is served dynamically via RFW."),
        ],
      ),
    ),
  );
`;

const fs = require('fs');
const path = require('path');

// Helper to read RFW files
const getRfwContent = (filename) => {
  try {
    const filePath = path.join(__dirname, 'rfw', filename);
    return fs.readFileSync(filePath, 'utf8');
  } catch (err) {
    console.error(`Error reading ${filename}:`, err);
    return null;
  }
};

// ... existing rfwData ...

app.get('/ui/home', (req, res) => {
  res.json({
    library: rfwData
  });
});

// UI Routes
app.get('/ui/register', (req, res) => {
  const content = getRfwContent('register.rfw');
  if (!content) return res.status(500).json({ error: 'Failed to load RFW file' });
  res.json({ screen: 'register', library: content });
});

app.get('/ui/login', (req, res) => {
  const content = getRfwContent('login.rfw');
  if (!content) return res.status(500).json({ error: 'Failed to load RFW file' });
  res.json({ screen: 'login', library: content });
});

app.get('/ui/dashboard', (req, res) => {
  const content = getRfwContent('dashboard.rfw');
  if (!content) return res.status(500).json({ error: 'Failed to load RFW file' });
  res.json({ screen: 'dashboard', library: content });
});

// Auth Endpoints

// Register
app.post('/auth/register', (req, res) => {
  const { phoneNumber, password } = req.body;

  if (!phoneNumber || !password) {
    return res.status(400).json({ error: 'PhoneNumber and Password are required' });
  }

  const existingUser = users.find(u => u.phoneNumber === phoneNumber);
  if (existingUser) {
    return res.status(409).json({ error: 'User already exists' });
  }

  const newUser = { id: Date.now(), phoneNumber, password };
  users.push(newUser);

  console.log(`User registered: ${phoneNumber}`);
  res.status(201).json({ message: 'User registered successfully', user: { id: newUser.id, phoneNumber } });
});

// Login
app.post('/auth/login', (req, res) => {
  const { phoneNumber, password } = req.body;

  if (!phoneNumber || !password) {
    return res.status(400).json({ error: 'PhoneNumber and Password are required' });
  }

  const user = users.find(u => u.phoneNumber === phoneNumber && u.password === password);
  if (!user) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }

  console.log(`User logged in: ${phoneNumber}`);
  res.json({ message: 'Login successful', token: 'mock-jwt-token-' + user.id, user: { id: user.id, phoneNumber } });
});

app.listen(port, () => {
  console.log(`RFW Server listening at http://localhost:${port}`);
});
