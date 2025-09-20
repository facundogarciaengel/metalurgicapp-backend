import jwt from "jsonwebtoken";

const SECRET = process.env.JWT_SECRET;

if (!SECRET) {
  throw new Error("Missing JWT_SECRET");
}

export type Payload = { id: number; rol: "ADMIN" | "OPERARIO" };

export function signAuth(payload: Payload): string {
  return jwt.sign(payload, SECRET, { expiresIn: "7d" });
}

export function verifyAuth(token: string): Payload {
  return jwt.verify(token, SECRET) as Payload;
}
