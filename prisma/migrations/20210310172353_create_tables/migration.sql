/*
  Warnings:

  - You are about to drop the column `currency` on the `currencies` table. All the data in the column will be lost.
  - You are about to drop the column `iso_4217` on the `currencies` table. All the data in the column will be lost.
  - You are about to drop the column `symbol_id` on the `currencies` table. All the data in the column will be lost.
  - You are about to drop the `currencies_symbols` table. If the table is not empty, all the data it contains will be lost.
  - The migration will add a unique constraint covering the columns `[iso_4217]` on the table `countries`. If there are existing duplicate values, the migration will fail.
  - The migration will add a unique constraint covering the columns `[name,symbol]` on the table `currencies`. If there are existing duplicate values, the migration will fail.
  - Added the required column `iso_4217` to the `countries` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `currencies` table without a default value. This is not possible if the table is not empty.
  - Added the required column `symbol` to the `currencies` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "currencies" DROP CONSTRAINT "currencies_symbol_id_fkey";

-- DropForeignKey
ALTER TABLE "daily_exchange" DROP CONSTRAINT "daily_exchange_currency_id_fkey";

-- DropForeignKey
ALTER TABLE "monthly_exchange" DROP CONSTRAINT "monthly_exchange_currency_id_fkey";

-- DropForeignKey
ALTER TABLE "weekly_exchange" DROP CONSTRAINT "weekly_exchange_currency_id_fkey";

-- DropIndex
DROP INDEX "currencies.iso_4217_unique";

-- DropIndex
DROP INDEX "currencies.currency_unique";

-- AlterTable
ALTER TABLE "countries" ADD COLUMN     "iso_4217" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "currencies" DROP COLUMN "currency",
DROP COLUMN "iso_4217",
DROP COLUMN "symbol_id",
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "symbol" TEXT NOT NULL;

-- DropTable
DROP TABLE "currencies_symbols";

-- CreateIndex
CREATE UNIQUE INDEX "countries.iso_4217_unique" ON "countries"("iso_4217");

-- CreateIndex
CREATE UNIQUE INDEX "currencies.name_symbol_unique" ON "currencies"("name", "symbol");

-- AddForeignKey
ALTER TABLE "daily_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "countries"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "monthly_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "countries"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "weekly_exchange" ADD FOREIGN KEY ("currency_id") REFERENCES "countries"("id") ON DELETE CASCADE ON UPDATE CASCADE;
