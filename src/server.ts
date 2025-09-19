import dotenv from "dotenv";
dotenv.config();

import { app } from "./app.js";

const PORT = process.env.PORT ?? 3001;

// Punto de entrada: levanta HTTP
app.listen(PORT, () => {
  console.log(`API escuchando en http://localhost:${PORT}`);
});
