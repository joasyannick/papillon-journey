# Chrysal Studio Server

The backend API service for **Chrysal Studio**, responsible for managing users, projects, and algebraic specifications. Built with **Node.js**, **Express**, **TypeScript**, and **Prisma ORM**.

---

## 🚀 Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v20.19+ recommended)
- [npm](https://www.npmjs.com/)
- [Prisma CLI](https://www.prisma.io/docs)

---

### 🛠 Setup

```bash
# Install dependencies
npm install

# Generate Prisma client
npx prisma generate

# Apply DB migrations (creates dev.db for SQLite)
npx prisma migrate dev --name init

# Start development server
npm run dev
```

---

## 📂 Project Structure

```
chrysal-studio-server/
├── prisma/              # Prisma schema and migrations
│   └── schema.prisma
├── src/
│   ├── index.ts         # Entry point
│   ├── routes/          # API route definitions
│   ├── middleware/      # Auth middleware
│   └── types/           # Shared TS types
├── package.json
└── README.md
```

---

## 🔐 Authentication

- `POST /api/auth/register` – create a new user
- `POST /api/auth/login` – authenticate and receive a JWT
- JWT is required for protected routes, passed via `Authorization: Bearer <token>`

---

## 🧩 Prisma Commands

These must be run from the **project root** (where `prisma/` is).

```bash
# Generate the Prisma client from schema.prisma
npx prisma generate

# Apply schema changes and create a migration
npx prisma migrate dev --name <migration-name>

# Open a GUI to view/edit the database
npx prisma studio
```

---