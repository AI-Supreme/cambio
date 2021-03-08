/*
  Warnings:

  - You are about to drop the column `symbol` on the `countries` table. All the data in the column will be lost.
  - You are about to drop the column `cambio` on the `countries` table. All the data in the column will be lost.
  - You are about to drop the column `codigo_postal` on the `people` table. All the data in the column will be lost.
  - You are about to drop the column `provincia` on the `people` table. All the data in the column will be lost.
  - You are about to drop the column `cidade` on the `people` table. All the data in the column will be lost.
  - You are about to drop the column `bairro` on the `people` table. All the data in the column will be lost.
  - You are about to drop the column `quarteirao` on the `people` table. All the data in the column will be lost.
  - You are about to drop the column `casa` on the `people` table. All the data in the column will be lost.
  - The migration will add a unique constraint covering the columns `[iso_4217]` on the table `currencies`. If there are existing duplicate values, the migration will fail.
  - Added the required column `symbol` to the `currencies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `iso_4217` to the `currencies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `l_name` to the `people` table without a default value. This is not possible if the table is not empty.
  - Added the required column `l_name` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `last_access` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "countries" DROP COLUMN "symbol",
DROP COLUMN "cambio";

-- AlterTable
ALTER TABLE "currencies" ADD COLUMN     "symbol" TEXT NOT NULL,
ADD COLUMN     "iso_4217" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "people" DROP COLUMN "codigo_postal",
DROP COLUMN "provincia",
DROP COLUMN "cidade",
DROP COLUMN "bairro",
DROP COLUMN "quarteirao",
DROP COLUMN "casa",
ADD COLUMN     "l_name" TEXT NOT NULL,
ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "l_name" TEXT NOT NULL,
ADD COLUMN     "last_access" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "daily_exchange" (
    "id" SERIAL NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "open" INTEGER NOT NULL,
    "high" INTEGER NOT NULL,
    "low" INTEGER NOT NULL,
    "close" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "weekly_exchange" (
    "id" SERIAL NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "open" INTEGER NOT NULL,
    "high" INTEGER NOT NULL,
    "low" INTEGER NOT NULL,
    "close" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "monthly_exchange" (
    "id" SERIAL NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "open" INTEGER NOT NULL,
    "high" INTEGER NOT NULL,
    "low" INTEGER NOT NULL,
    "close" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "id" SERIAL NOT NULL,
    "house_number" INTEGER,
    "user_id" TEXT,
    "person_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provinces" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "Zip_code" INTEGER,
    "province_id" INTEGER NOT NULL,
    "address_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "neighborhoods" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "city_id" INTEGER NOT NULL,
    "address_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blocks" (
    "id" SERIAL NOT NULL,
    "block" INTEGER NOT NULL,
    "neighborhood_id" INTEGER NOT NULL,
    "address_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "address_user_id_unique" ON "address"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "address_person_id_unique" ON "address"("person_id");

-- CreateIndex
CREATE UNIQUE INDEX "provinces_address_id_unique" ON "provinces"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "cities_address_id_unique" ON "cities"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "neighborhoods_address_id_unique" ON "neighborhoods"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "blocks_address_id_unique" ON "blocks"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "currencies.iso_4217_unique" ON "currencies"("iso_4217");

-- AddForeignKey
ALTER TABLE "daily_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "currencies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "weekly_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "currencies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "monthly_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "currencies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD FOREIGN KEY ("person_id") REFERENCES "people"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provinces" ADD FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cities" ADD FOREIGN KEY ("province_id") REFERENCES "provinces"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cities" ADD FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "neighborhoods" ADD FOREIGN KEY ("city_id") REFERENCES "cities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "neighborhoods" ADD FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blocks" ADD FOREIGN KEY ("neighborhood_id") REFERENCES "neighborhoods"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "blocks" ADD FOREIGN KEY ("address_id") REFERENCES "address"("id") ON DELETE SET NULL ON UPDATE CASCADE;
