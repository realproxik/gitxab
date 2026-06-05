CREATE TABLE users (
    username TEXT PRIMARY KEY,
    password TEXT,
    bio TEXT,
    joined DATE,
    online INTEGER
);

CREATE TABLE communities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    image TEXT,
    members INTEGER
);

CREATE TABLE posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    community_id INTEGER,
    user TEXT,
    content TEXT,
    FOREIGN KEY(community_id) REFERENCES communities(id)
);

CREATE TABLE videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user TEXT,
    title TEXT,
    filepath TEXT

    CREATE TABLE videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user TEXT,
    title TEXT,
    filepath TEXT,
    uploaded DATE DEFAULT CURRENT_DATE
);
CREATE TABLE messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user VARCHAR(255),
    community VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_community_time ON messages(community, created_at);

CREATE TABLE binaries (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    source TEXT,
    binary_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

);
