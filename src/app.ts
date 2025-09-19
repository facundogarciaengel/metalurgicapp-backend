import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import { prisma } from "./prisma.js";
import type { Request, Response, NextFunction, ErrorRequestHandler } from "express";


export const app = express();

app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(cookieParser());

app.get("/health", (_req, res) => res.json({ ok: true }));

app.get("/trabajos", async (_req, res, next) => {
  try {
    const trabajos = await prisma.trabajo.findMany({ take: 50 });
    res.json(trabajos);
  } catch (e) { next(e); }
});

const errorHandler: ErrorRequestHandler = (err, _req: Request, res: Response, _next: NextFunction) => {
  const msg = err instanceof Error ? err.message : "Internal Server Error";
  console.error(err);
  res.status(500).json({ error: msg });
};
app.use(errorHandler);
