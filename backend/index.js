const express = require('express');
const app = express();
const port = 3000;

// Serve static files (HTML/CSS) from 'public' folder
app.use(express.static('public'));

// Example backend route
app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from backend!' });
});

app.listen(port, () => {
  console.log(`🚀 Server running at http://localhost:${port}`);
});
