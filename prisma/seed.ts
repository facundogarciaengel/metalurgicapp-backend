import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

async function main() {
  // Passwords hasheadas
  const adminPass = await bcrypt.hash("admin123", 10);
  const operarioPass = await bcrypt.hash("operario123", 10);

  // Usuario Admin
  const admin = await prisma.usuario.upsert({
    where: { dni: "100" },
    update: {},
    create: {
      dni: "100",
      nombre: "Administrador",
      rol: "ADMIN",
      hashPassword: adminPass,
      activo: true,
    },
  });

  // Usuario Operario
  const operario = await prisma.usuario.upsert({
    where: { dni: "200" },
    update: {},
    create: {
      dni: "200",
      nombre: "Operario Demo",
      rol: "OPERARIO",
      hashPassword: operarioPass,
      activo: true,
    },
  });

  // Cliente
  const cliente = await prisma.cliente.upsert({
    where: { documento: "20-12345678-9" },
    update: {},
    create: {
      nombre: "Juan",
      apellido: "Pérez",
      documento: "20-12345678-9",
      email: "juanperez@test.com",
      telefono: "1111-2222",
      // `codigo` se genera con uuid() automáticamente
    },
  });

  // Trabajo con todos los campos posibles
  const trabajo = await prisma.trabajo.create({
    data: {
      presupuestoNro: "P-0001",
      titulo: "Trabajo inicial",
      descripcion: "Fabricación de estructura metálica",
      estado: "PENDIENTE",
      clienteId: cliente.id,
      asignadoAId: null,        // aún no tomado por operario
      inicio: null,             // arranca cuando lo tomen
      fin: null,                // termina cuando lo cierren
    },
  });


  console.log("✅ Seed ejecutado con éxito");
  console.log({ admin, operario, cliente, trabajo });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
