// Тесты Firestore Security Rules на эмуляторе (шаг 8).
//
// Якорь безопасности: студент не читает чужой users-документ и не меняет свою
// role/status; самостоятельная регистрация не может создать admin; админ видит
// всё. К этим тестам добавляются правила по мере фич в Сессии 2.
//
// Запуск (эмулятор Firestore должен быть поднят):
//   cd test/security && npm install && npm test
import {
  initializeTestEnvironment,
  assertFails,
  assertSucceeds,
} from "@firebase/rules-unit-testing";
import { readFileSync } from "node:fs";
import {
  doc,
  getDoc,
  setDoc,
  updateDoc,
  serverTimestamp,
} from "firebase/firestore";

const DAY = 86400000;
const past = () => new Date(Date.now() - DAY);
const future = () => new Date(Date.now() + DAY);

const env = await initializeTestEnvironment({
  projectId: "demo-eduapp-dev",
  firestore: {
    rules: readFileSync(new URL("../../firestore.rules", import.meta.url), "utf8"),
    host: "127.0.0.1",
    port: 8080,
  },
});

// Чистим данные эмулятора, чтобы прогон был идемпотентным (create-тесты не
// должны превращаться в update из-за документов от прошлого запуска).
await env.clearFirestore();

// Базовые документы — пишем в обход правил.
await env.withSecurityRulesDisabled(async (ctx) => {
  const db = ctx.firestore();
  await setDoc(doc(db, "users/admin1"), { email: "a@x.dev", role: "admin", status: "active" });
  await setDoc(doc(db, "users/student1"), { email: "s@x.dev", role: "student", status: "active" });
  await setDoc(doc(db, "users/student2"), { email: "s2@x.dev", role: "student", status: "active" });
  await setDoc(doc(db, "users/teacher1"), { email: "t1@x.dev", role: "teacher", status: "active" });
  await setDoc(doc(db, "users/teacher2"), { email: "t2@x.dev", role: "teacher", status: "active" });
  await setDoc(doc(db, "profiles/student1"), { firstName: "S" });

  // P0-4: курсы с разными преподавателями.
  await setDoc(doc(db, "courses/course1"), { title: "C1", teacherIds: ["teacher1"] });
  await setDoc(doc(db, "courses/course2"), { title: "C2", teacherIds: ["teacher2"] });

  // P0-5/P0-3: задания (публикация + дедлайн + поздняя сдача).
  await setDoc(doc(db, "assignments/asgn_open"), { courseId: "course1", isPublished: true, deadline: future(), allowLateSubmission: false });
  await setDoc(doc(db, "assignments/asgn_closed"), { courseId: "course1", isPublished: true, deadline: past(), allowLateSubmission: false });
  await setDoc(doc(db, "assignments/asgn_late"), { courseId: "course1", isPublished: true, deadline: past(), allowLateSubmission: true });
  await setDoc(doc(db, "assignments/asgn_unpub"), { courseId: "course1", isPublished: false });

  // P0-4: отправки и оценки student1 по course1.
  await setDoc(doc(db, "submissions/sub_open"), { assignmentId: "asgn_open", courseId: "course1", studentId: "student1", status: "draft" });
  await setDoc(doc(db, "submissions/sub_closed"), { assignmentId: "asgn_closed", courseId: "course1", studentId: "student1", status: "draft" });
  await setDoc(doc(db, "submissions/sub_late"), { assignmentId: "asgn_late", courseId: "course1", studentId: "student1", status: "draft" });
  await setDoc(doc(db, "grades/grade1"), { studentId: "student1", courseId: "course1", teacherId: "teacher1", score: 80 });

  // P0-1: попытка квиза student1 в процессе.
  await setDoc(doc(db, "quizAttempts/att1"), {
    quizId: "quiz_pub", studentId: "student1", courseId: "course1",
    questionSnapshot: [{ questionId: "q1", points: 5 }], answers: {},
    score: null, maxScore: 5, status: "inProgress", attemptNumber: 1,
  });

  // P0-5: квизы/недели/материалы (опубликованные и нет).
  await setDoc(doc(db, "quizzes/quiz_pub"), { courseId: "course1", isPublished: true });
  await setDoc(doc(db, "quizzes/quiz_unpub"), { courseId: "course1", isPublished: false });
  await setDoc(doc(db, "courseWeeks/week_pub"), { courseId: "course1", isPublished: true });
  await setDoc(doc(db, "courseWeeks/week_unpub"), { courseId: "course1", isPublished: false });
  await setDoc(doc(db, "materials/mat_pub"), { courseId: "course1", isPublished: true });
  await setDoc(doc(db, "materials/mat_unpub"), { courseId: "course1", isPublished: false });
});

const admin = env.authenticatedContext("admin1").firestore();
const student = env.authenticatedContext("student1").firestore();
const student2 = env.authenticatedContext("student2").firestore();
const teacher1 = env.authenticatedContext("teacher1").firestore();
const teacher2 = env.authenticatedContext("teacher2").firestore();
const anon = env.unauthenticatedContext().firestore();

let pass = 0;
let fail = 0;
async function check(name, promise) {
  try {
    await promise;
    console.log("  ✓", name);
    pass++;
  } catch (e) {
    console.log("  ✗", name, "—", e.message);
    fail++;
  }
}

console.log("users:");
await check("student читает свой users",
  assertSucceeds(getDoc(doc(student, "users/student1"))));
await check("student НЕ читает чужой users",
  assertFails(getDoc(doc(student, "users/student2"))));
await check("student НЕ меняет свою role",
  assertFails(updateDoc(doc(student, "users/student1"), { role: "admin" })));
await check("student НЕ меняет свой status",
  assertFails(updateDoc(doc(student, "users/student1"), { status: "blocked" })));
await check("admin читает любой users",
  assertSucceeds(getDoc(doc(admin, "users/student2"))));
await check("аноним НЕ читает users",
  assertFails(getDoc(doc(anon, "users/student1"))));

console.log("регистрация:");
await check("новый юзер создаёт свой users c role student",
  assertSucceeds(setDoc(doc(env.authenticatedContext("newbie").firestore(), "users/newbie"),
    { email: "n@x.dev", role: "student", status: "pendingVerification" })));
await check("регистрация НЕ создаёт admin (эскалация запрещена)",
  assertFails(setDoc(doc(env.authenticatedContext("evil").firestore(), "users/evil"),
    { email: "e@x.dev", role: "admin", status: "active" })));

console.log("profiles:");
await check("student правит свой profile",
  assertSucceeds(setDoc(doc(student, "profiles/student1"), { firstName: "X" }, { merge: true })));
await check("student НЕ правит чужой profile",
  assertFails(setDoc(doc(student, "profiles/student2"), { firstName: "hack" })));

console.log("P0-1 попытка квиза (лок полей):");
await check("student меняет только answers",
  assertSucceeds(updateDoc(doc(student, "quizAttempts/att1"), { answers: { q1: 1 } })));
await check("student НЕ подменяет questionSnapshot",
  assertFails(updateDoc(doc(student, "quizAttempts/att1"), { questionSnapshot: [{ questionId: "q1", points: 999 }] })));
await check("student НЕ подменяет score",
  assertFails(updateDoc(doc(student, "quizAttempts/att1"), { score: 100 })));
await check("student отправляет (status+finishedAt серверным временем)",
  assertSucceeds(updateDoc(doc(student, "quizAttempts/att1"), { status: "submitted", finishedAt: serverTimestamp() })));
await check("чужой НЕ правит попытку",
  assertFails(updateDoc(doc(student2, "quizAttempts/att1"), { answers: { q1: 0 } })));

console.log("P0-3 дедлайн задания (submit):");
await check("student отправляет до дедлайна",
  assertSucceeds(updateDoc(doc(student, "submissions/sub_open"), { status: "submitted" })));
await check("student НЕ отправляет после дедлайна без late",
  assertFails(updateDoc(doc(student, "submissions/sub_closed"), { status: "submitted" })));
await check("student отправляет после дедлайна при allowLateSubmission",
  assertSucceeds(updateDoc(doc(student, "submissions/sub_late"), { status: "submitted" })));

console.log("P0-4 преподаватель видит только свои курсы:");
await check("teacher1 читает submission своего курса",
  assertSucceeds(getDoc(doc(teacher1, "submissions/sub_open"))));
await check("teacher2 НЕ читает submission чужого курса",
  assertFails(getDoc(doc(teacher2, "submissions/sub_open"))));
await check("teacher1 читает grade своего курса",
  assertSucceeds(getDoc(doc(teacher1, "grades/grade1"))));
await check("teacher2 НЕ читает grade чужого курса",
  assertFails(getDoc(doc(teacher2, "grades/grade1"))));
await check("student2 НЕ читает чужую оценку",
  assertFails(getDoc(doc(student2, "grades/grade1"))));

console.log("P0-5 студент не читает неопубликованное:");
await check("student читает опубликованное задание",
  assertSucceeds(getDoc(doc(student, "assignments/asgn_open"))));
await check("student НЕ читает черновик задания",
  assertFails(getDoc(doc(student, "assignments/asgn_unpub"))));
await check("teacher1 читает черновик задания",
  assertSucceeds(getDoc(doc(teacher1, "assignments/asgn_unpub"))));
await check("student НЕ читает неопубликованный квиз",
  assertFails(getDoc(doc(student, "quizzes/quiz_unpub"))));
await check("student НЕ читает скрытую неделю",
  assertFails(getDoc(doc(student, "courseWeeks/week_unpub"))));
await check("student НЕ читает скрытый материал",
  assertFails(getDoc(doc(student, "materials/mat_unpub"))));
await check("student читает опубликованный материал",
  assertSucceeds(getDoc(doc(student, "materials/mat_pub"))));

console.log("default deny:");
await check("произвольная коллекция закрыта",
  assertFails(getDoc(doc(student, "secrets/x"))));

await env.cleanup();
console.log(`\n${pass} passed, ${fail} failed`);
process.exit(fail ? 1 : 0);
