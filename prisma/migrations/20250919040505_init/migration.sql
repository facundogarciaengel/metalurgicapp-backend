-- CreateTable
CREATE TABLE `Usuario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dni` VARCHAR(191) NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `rol` ENUM('ADMIN', 'OPERARIO') NOT NULL,
    `hashPassword` VARCHAR(191) NOT NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `Usuario_dni_key`(`dni`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cliente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `apellido` VARCHAR(191) NOT NULL,
    `documento` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `telefono` VARCHAR(191) NULL,
    `codigo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Cliente_documento_key`(`documento`),
    UNIQUE INDEX `Cliente_codigo_key`(`codigo`),
    INDEX `Cliente_apellido_nombre_idx`(`apellido`, `nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Trabajo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `presupuestoNro` VARCHAR(191) NULL,
    `titulo` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `estado` ENUM('PENDIENTE', 'EN_CURSO', 'FINALIZADO') NOT NULL DEFAULT 'PENDIENTE',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `inicio` DATETIME(3) NULL,
    `fin` DATETIME(3) NULL,
    `clienteId` INTEGER NOT NULL,
    `asignadoAId` INTEGER NULL,

    UNIQUE INDEX `Trabajo_presupuestoNro_key`(`presupuestoNro`),
    INDEX `Trabajo_clienteId_idx`(`clienteId`),
    INDEX `Trabajo_asignadoAId_idx`(`asignadoAId`),
    INDEX `Trabajo_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ParteHora` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `trabajoId` INTEGER NOT NULL,
    `operarioId` INTEGER NOT NULL,
    `inicio` DATETIME(3) NOT NULL,
    `fin` DATETIME(3) NULL,
    `nota` VARCHAR(191) NULL,

    INDEX `ParteHora_trabajoId_idx`(`trabajoId`),
    INDEX `ParteHora_operarioId_idx`(`operarioId`),
    INDEX `ParteHora_inicio_idx`(`inicio`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Trabajo` ADD CONSTRAINT `Trabajo_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `Cliente`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Trabajo` ADD CONSTRAINT `Trabajo_asignadoAId_fkey` FOREIGN KEY (`asignadoAId`) REFERENCES `Usuario`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ParteHora` ADD CONSTRAINT `ParteHora_trabajoId_fkey` FOREIGN KEY (`trabajoId`) REFERENCES `Trabajo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ParteHora` ADD CONSTRAINT `ParteHora_operarioId_fkey` FOREIGN KEY (`operarioId`) REFERENCES `Usuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
