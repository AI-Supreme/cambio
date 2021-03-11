/*
  Warnings:

  - You are about to drop the column `symbol` on the `currencies` table. All the data in the column will be lost.
  - Added the required column `symbol_id` to the `currencies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "currencies" DROP COLUMN "symbol",
ADD COLUMN     "symbol_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "currencies_symbols" (
    "id" SERIAL NOT NULL,
    "symbol" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "currencies_symbols.symbol_unique" ON "currencies_symbols"("symbol");

-- AddForeignKey
ALTER TABLE "currencies" ADD FOREIGN KEY ("symbol_id") REFERENCES "currencies_symbols"("id") ON DELETE CASCADE ON UPDATE CASCADE;
