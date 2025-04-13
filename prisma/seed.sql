-- Insert test users
INSERT INTO "User" (email, password, fullname, is_admin, created_at, updated_at) VALUES
('admin@example.com', '$2b$10$K7L1OJ45/4Y2nIvhRVpCe.FSmhDdWoXehVzJptJ/op0lSsvqNuWkm', 'Admin User', true, NOW(), NOW()),
('john@example.com', '$2b$10$K7L1OJ45/4Y2nIvhRVpCe.FSmhDdWoXehVzJptJ/op0lSsvqNuWkm', 'John Doe', false, NOW(), NOW()),
('jane@example.com', '$2b$10$K7L1OJ45/4Y2nIvhRVpCe.FSmhDdWoXehVzJptJ/op0lSsvqNuWkm', 'Jane Smith', false, NOW(), NOW()),
('bob@example.com', '$2b$10$K7L1OJ45/4Y2nIvhRVpCe.FSmhDdWoXehVzJptJ/op0lSsvqNuWkm', 'Bob Johnson', false, NOW(), NOW());

-- Insert test contributions for the last 6 months
WITH RECURSIVE months AS (
  SELECT CURRENT_DATE - INTERVAL '5 months' as month
  UNION ALL
  SELECT month + INTERVAL '1 month'
  FROM months
  WHERE month < CURRENT_DATE
),
users AS (
  SELECT id FROM "User" WHERE is_admin = false
)
INSERT INTO "Contribution" (user_id, amount, month, status, notes, created_at, updated_at)
SELECT 
  u.id,
  (FLOOR(RANDOM() * 1000 + 500)::INTEGER)::DECIMAL(10,2), -- Random amount between 500 and 1500
  m.month,
  CASE 
    WHEN RANDOM() < 0.7 THEN 'PAID'::"Status"
    ELSE 'PENDING'::"Status"
  END,
  CASE 
    WHEN RANDOM() < 0.3 THEN 'Monthly contribution'
    ELSE NULL
  END,
  NOW(),
  NOW()
FROM users u
CROSS JOIN months m;

-- Insert one missed contribution for each user from 2 months ago
INSERT INTO "Contribution" (user_id, amount, month, status, notes, created_at, updated_at)
SELECT 
  id,
  (FLOOR(RANDOM() * 1000 + 500)::INTEGER)::DECIMAL(10,2),
  CURRENT_DATE - INTERVAL '2 months',
  'MISSED'::"Status",
  'Missed contribution',
  NOW(),
  NOW()
FROM "User"
WHERE is_admin = false; 