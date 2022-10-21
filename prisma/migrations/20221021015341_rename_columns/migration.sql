/*
  Warnings:

  - The primary key for the `UserPlace` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Placeid` on the `UserPlace` table. All the data in the column will be lost.
  - You are about to drop the column `Userid` on the `UserPlace` table. All the data in the column will be lost.
  - Added the required column `placeId` to the `UserPlace` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `UserPlace` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_UserPlace" (
    "userId" TEXT NOT NULL,
    "placeId" TEXT NOT NULL,

    PRIMARY KEY ("userId", "placeId"),
    CONSTRAINT "UserPlace_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserPlace_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "Place" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
DROP TABLE "UserPlace";
ALTER TABLE "new_UserPlace" RENAME TO "UserPlace";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
