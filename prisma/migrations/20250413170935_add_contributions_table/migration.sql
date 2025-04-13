-- CreateEnum
CREATE TYPE "Status" AS ENUM ('PENDING', 'PAID', 'MISSED');

-- CreateTable
CREATE TABLE "Contribution" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "month" TIMESTAMP(3) NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Contribution_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Contribution_user_id_idx" ON "Contribution"("user_id");

-- CreateIndex
CREATE INDEX "Contribution_month_idx" ON "Contribution"("month");

-- CreateIndex
CREATE INDEX "Contribution_status_idx" ON "Contribution"("status");

-- AddForeignKey
ALTER TABLE "Contribution" ADD CONSTRAINT "Contribution_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
