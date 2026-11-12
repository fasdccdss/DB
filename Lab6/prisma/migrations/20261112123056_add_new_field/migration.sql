/*
  Warnings:

  - Added the required column `variable_3` to the `some_model` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "some_model" ADD COLUMN     "variable_3" INTEGER NOT NULL;
