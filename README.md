# 🌍 Wanderlust Mini

Wanderlust Mini is a simple travel-themed web application built with Node.js. It includes a CI/CD pipeline using Jenkins and Docker, and is deployable on an AWS EC2 instance.

## 🚀 Features

- Travel-themed UI
- Node.js + Express backend
- Dockerized application
- CI/CD Pipeline with Jenkins
- Deployed on AWS EC2 (t2.micro)

---

## 📁 Project Structure

wanderlust-mini/
│
├── backend/
│ ├── index.js # Main server file
│ ├── package.json # Node dependencies
│ ├── Dockerfile # Docker build config
│ └── ... # Additional backend files
│
├── frontend/
│ ├── index.html # Frontend page
│ ├── style.css # Frontend styles
│ └── ... # Additional frontend files
│
├── Jenkinsfile # Jenkins pipeline configuration
└── README.md # Project documentation


---

## 🛠️ Setup (Local)

### 1. Clone the Repo
```bash
git clone https://github.com/Setu3011/wanderlust-mini.git
cd wanderlust-mini/backend
npm install
node index.js
# App runs on http://localhost:3000
Build Docker Image
bash
Copy
Edit
cd backend
docker build -t setu3011/wanderlust-mini .
Run Docker Container
bash
Copy
Edit
docker run -p 3000:3000 setu3011/wanderlust-mini
