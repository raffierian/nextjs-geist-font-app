CREATE DATABASE IF NOT EXISTS rsud_survey;
USE rsud_survey;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS survey_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    require_fullname BOOLEAN DEFAULT TRUE,
    require_nik BOOLEAN DEFAULT TRUE,
    timer_duration INT DEFAULT 300,
    service_areas JSON,
    service_types JSON,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS survey_responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(255),
    nik VARCHAR(16),
    service_area VARCHAR(100) NOT NULL,
    service_type VARCHAR(100) NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, password) VALUES ('admin', '$2b$10$YourHashedPasswordHere');

-- Insert default settings
INSERT INTO survey_settings (
    require_fullname,
    require_nik,
    timer_duration,
    service_areas,
    service_types
) VALUES (
    true,
    true,
    300,
    '["Rawat Jalan", "Rawat Inap", "Penunjang", "Lainnya"]',
    '{
        "Rawat Jalan": ["Poli Umum", "Poli Gigi", "Poli Anak", "Poli Mata"],
        "Rawat Inap": ["Kelas 1", "Kelas 2", "Kelas 3", "VIP"],
        "Penunjang": ["Laboratorium", "Radiologi", "Farmasi", "Rehabilitasi"],
        "Lainnya": ["Administrasi", "Pendaftaran", "Kasir"]
    }'
);
