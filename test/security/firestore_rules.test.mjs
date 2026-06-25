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
import { doc, getDoc, setDoc, updateDoc } from "firebase/firestore";

const env = await initializeTestEnvironment({
  projectId: "demo-eduapp-dev",
  firestore: {
    rules: readFileSync(new URL("../../firestore.rules", import.meta.url), "utf8"),
    host: "127.0.0.1",
    port: 8080,
  },
});

// Базовые документы — пишем в обход правил.
await env.withSecurityRulesDisabled(async (ctx) => {
  const db = ctx.firestore();
  await setDoc(doc(db, "users/admin1"), { email: "a@x.dev", role: "admin", status: "active" });
  await setDoc(doc(db, "users/student1"), { email: "s@x.dev", role: "student", status: "active" });
  await setDoc(doc(db, "users/student2"), { email: "s2@x.dev", role: "student", status: "active" });
  await setDoc(doc(db, "profiles/student1"), { firstName: "S" });
});

const admin = env.authenticatedContext("admin1").firestore();
const student = env.authenticatedContext("student1").firestore();
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

console.log("default deny:");
await check("произвольная коллекция закрыта",
  assertFails(getDoc(doc(student, "secrets/x"))));

await env.cleanup();
console.log(`\n${pass} passed, ${fail} failed`);
process.exit(fail ? 1 : 0);
