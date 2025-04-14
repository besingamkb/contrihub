-- Clear existing data
TRUNCATE TABLE contributions CASCADE;
TRUNCATE TABLE users CASCADE;

-- Insert test users
INSERT INTO users (fullname, email, password, is_admin, created_at, updated_at) VALUES
('John Doe', 'john.doe@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', true, NOW(), NOW()),
('Jane Smith', 'jane.smith@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Mike Johnson', 'mike.johnson@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Sarah Williams', 'sarah.williams@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', true, NOW(), NOW()),
('David Brown', 'david.brown@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Emily Davis', 'emily.davis@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Robert Wilson', 'robert.wilson@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Lisa Anderson', 'lisa.anderson@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Michael Taylor', 'michael.taylor@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW()),
('Jennifer Martinez', 'jennifer.martinez@example.com', '$2a$10$X7z3DBkUxUZG1hGYWQz6UeBZJQN9QZQZQZQZQZQZQZQZQZQZQZQZ', false, NOW(), NOW());

-- Insert test contributions
INSERT INTO contributions (user_id, amount, month, status, created_at, updated_at) VALUES
(1, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(1, 1000.00, '2024-02-01', 'APPROVED', NOW(), NOW()),
(2, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(2, 1000.00, '2024-02-01', 'PENDING', NOW(), NOW()),
(3, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(3, 1000.00, '2024-02-01', 'REJECTED', NOW(), NOW()),
(4, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(4, 1000.00, '2024-02-01', 'APPROVED', NOW(), NOW()),
(5, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(5, 1000.00, '2024-02-01', 'PENDING', NOW(), NOW()),
(6, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(6, 1000.00, '2024-02-01', 'APPROVED', NOW(), NOW()),
(7, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(7, 1000.00, '2024-02-01', 'REJECTED', NOW(), NOW()),
(8, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(8, 1000.00, '2024-02-01', 'PENDING', NOW(), NOW()),
(9, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(9, 1000.00, '2024-02-01', 'APPROVED', NOW(), NOW()),
(10, 1000.00, '2024-01-01', 'APPROVED', NOW(), NOW()),
(10, 1000.00, '2024-02-01', 'PENDING', NOW(), NOW()); 