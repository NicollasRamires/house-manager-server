/*
  Warnings:

  - The primary key for the `UserPlace` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `UserPlace` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_UserPlace" (
    "Userid" TEXT NOT NULL,
    "Placeid" TEXT NOT NULL,

    PRIMARY KEY ("Userid", "Placeid"),
    CONSTRAINT "UserPlace_Userid_fkey" FOREIGN KEY ("Userid") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserPlace_Placeid_fkey" FOREIGN KEY ("Placeid") REFERENCES "Place" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_UserPlace" ("Placeid", "Userid") SELECT "Placeid", "Userid" FROM "UserPlace";
DROP TABLE "UserPlace";
ALTER TABLE "new_UserPlace" RENAME TO "UserPlace";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
