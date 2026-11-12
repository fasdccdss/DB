/*
  Warnings:

  - You are about to drop the column `variable_2` on the `some_model` table. All the data in the column will be lost.
  - You are about to drop the column `variable_3` on the `some_model` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "some_model" DROP COLUMN "variable_2",
DROP COLUMN "variable_3";
