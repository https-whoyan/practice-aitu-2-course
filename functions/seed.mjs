// Сидер тестовых данных для Firebase Emulator Suite.
//
// Создаёт по одному admin/teacher/student (Auth + users + profiles) для
// локальной отладки шагов 7–9. Использует firebase-admin (обходит Security
// Rules), пишет только в эмулятор.
//
// Запуск (эмуляторы должны быть подняты):
//   cd functions && node seed.mjs
import admin from "firebase-admin";

process.env.FIRESTORE_EMULATOR_HOST ||= "127.0.0.1:8080";
process.env.FIREBASE_AUTH_EMULATOR_HOST ||= "127.0.0.1:9099";

admin.initializeApp({ projectId: "demo-eduapp-dev" });
const auth = admin.auth();
const db = admin.firestore();

const PASSWORD = "password123";
const seed = [
  { email: "admin@eduapp.dev", role: "admin", first: "Админ", last: "Системы" },
  { email: "teacher@eduapp.dev", role: "teacher", first: "Пётр", last: "Петров" },
  { email: "student@eduapp.dev", role: "student", first: "Иван", last: "Иванов" },
];

for (const u of seed) {
  let rec;
  try {
    rec = await auth.getUserByEmail(u.email);
  } catch {
    rec = await auth.createUser({
      email: u.email,
      password: PASSWORD,
      emailVerified: true,
      displayName: `${u.first} ${u.last}`,
    });
  }
  // Роль в custom claims — для серверных проверок (шаг 8 / Сессия 2).
  await auth.setCustomUserClaims(rec.uid, { role: u.role });

  const now = admin.firestore.FieldValue.serverTimestamp();
  await db.collection("users").doc(rec.uid).set(
    {
      email: u.email,
      role: u.role,
      status: "active",
      emailVerified: true,
      createdAt: now,
      lastLoginAt: null,
    },
    { merge: true },
  );
  await db.collection("profiles").doc(rec.uid).set(
    {
      firstName: u.first,
      lastName: u.last,
      displayName: `${u.first} ${u.last}`,
      photoUrl: null,
      groupIds: [],
      courseIds: [],
      teacherCourseIds: [],
      createdAt: now,
      updatedAt: now,
    },
    { merge: true },
  );
  console.log(`seeded ${u.role.padEnd(7)} ${u.email} (uid=${rec.uid})`);
}

console.log(`\nГотово. Пароль для всех: ${PASSWORD}`);
process.exit(0);
