// ==========================
// 📌 IMPORTS
// ==========================
const express = require('express');
const { google } = require('googleapis');
const bodyParser = require('body-parser');
const cors = require('cors');

// ==========================
// 📌 EXPRESS APP
// ==========================
const app = express();

// ✅ CORS: Allow Flutter Web (adjust if deploying)
app.use(cors({
  origin: '*', // or 'http://localhost:57298' if you want to be strict
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type']
}));

app.use(bodyParser.json());

// ==========================
// 📌 OAUTH CONFIG
// ==========================
const CLIENT_ID = '125243843044-76bcr0jo3n7n7d99e9777pbfff856feq.apps.googleusercontent.com';
const CLIENT_SECRET = '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';
const REDIRECT_URI = 'http://localhost:3000/oauth2callback';

// ==========================
// 📌 CREATE OAUTH2 CLIENT
// ==========================
const oauth2Client = new google.auth.OAuth2(
  CLIENT_ID,
  CLIENT_SECRET,
  REDIRECT_URI
);

let savedTokens = null;

// ==========================
// 📌 STEP 1: START OAUTH FLOW
// ==========================
app.get('/auth', (req, res) => {
  const scopes = [
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile'
  ];

  const url = oauth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: scopes,
    prompt: 'consent'
  });

  console.log('👉 Redirecting to Google consent screen...');
  res.redirect(url);
});

// ==========================
// 📌 STEP 2: HANDLE REDIRECT
// ==========================
app.get('/oauth2callback', async (req, res) => {
  try {
    const code = req.query.code;
    console.log('✅ Received auth code:', code);

    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);
    savedTokens = tokens;

    console.log('✅ Tokens saved!');
    res.send('✅ Auth successful! You can now schedule classes.');
  } catch (err) {
    console.error('❌ OAuth callback error:', err);
    res.status(500).send('❌ OAuth error: ' + err.message);
  }
});

// ==========================
// 📌 STEP 3: SCHEDULE CLASS
// ==========================
app.post('/schedule-class', async (req, res) => {
  try {
    if (!savedTokens) {
      return res.status(401).send('❌ Not authenticated. Please visit /auth first.');
    }

    oauth2Client.setCredentials(savedTokens);

    const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
    const { title, startDateTime, endDateTime, studentEmail } = req.body;

    const event = {
      summary: title,
      start: { dateTime: startDateTime, timeZone: 'Asia/Kolkata' },
      end: { dateTime: endDateTime, timeZone: 'Asia/Kolkata' },
      attendees: studentEmail ? [{ email: studentEmail }] : [],
      conferenceData: {
        createRequest: {
          requestId: `${Date.now()}`,
          conferenceSolutionKey: { type: 'hangoutsMeet' },
        },
      },
    };

    const response = await calendar.events.insert({
      calendarId: 'primary',
      resource: event,
      conferenceDataVersion: 1,
    });

    const meetLink = response.data.hangoutLink;
    console.log('✅ Meet link:', meetLink);
    res.json({ meetLink });
  } catch (err) {
    console.error('❌ Scheduling error:', err);
    res.status(500).send('❌ Scheduling failed: ' + err.message);
  }
});

// ==========================
// 📌 START SERVER
// ==========================
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
  console.log(`👉 Visit http://localhost:${PORT}/auth to authenticate`);
});
