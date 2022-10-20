/*
  Warnings:

  - You are about to drop the `House` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "House";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Place" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "UserPlace" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "Userid" TEXT NOT NULL,
    "Placeid" TEXT NOT NULL,
    CONSTRAINT "UserPlace_Userid_fkey" FOREIGN KEY ("Userid") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserPlace_Placeid_fkey" FOREIGN KEY ("Placeid") REFERENCES "Place" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
