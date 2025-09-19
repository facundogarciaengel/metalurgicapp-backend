import { PrismaClient } from "@prisma/client";

// Instancia única para toda la app (evita abrir muchas conexiones)
export const prisma = new PrismaClient();
