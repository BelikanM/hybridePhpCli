<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

class Database {
    private static $instance = null;
    private $conn;

    // Mettre ici les identifiants root ou un utilisateur ayant droit de créer db + user
    private $rootHost = '127.0.0.1';
    private $rootUser = 'root';
    private $rootPass = ''; // À remplir si tu as un mot de passe root MySQL
    
    private $dbName = 'hybridephp_db';
    private $dbUser = 'BelikanM';
    private $dbPass = 'Dieu19961991??!??!';
    private $dbHost = '127.0.0.1';

    private function __construct() {
        try {
            // Connexion MySQL root pour création base et user si non faits
            $pdoRoot = new PDO("mysql:host={$this->rootHost}", $this->rootUser, $this->rootPass,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

            // Création base si elle n'existe pas
            $pdoRoot->exec("CREATE DATABASE IF NOT EXISTS `{$this->dbName}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");

            // Création utilisateur et attribution privilèges
            // Note : adapte host si nécessaire (ici 'localhost' et 127.0.0.1 autorisés)
            $pdoRoot->exec("CREATE USER IF NOT EXISTS '{$this->dbUser}'@'{$this->dbHost}' IDENTIFIED BY '{$this->dbPass}'");
            $pdoRoot->exec("GRANT ALL PRIVILEGES ON `{$this->dbName}`.* TO '{$this->dbUser}'@'{$this->dbHost}'");
            $pdoRoot->exec("FLUSH PRIVILEGES");

            // Connexion à la base créée avec l’utilisateur dédié
            $this->conn = new PDO(
                "mysql:host={$this->dbHost};dbname={$this->dbName};charset=utf8mb4",
                $this->dbUser,
                $this->dbPass,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );

            // Création des tables (similaire TikTok simplifié)
            $this->createTables();
        } catch (PDOException $e) {
            // Fallback SQLite si MySQL indisponible
            try {
                $this->conn = new PDO('sqlite:hybridephp.db');
                $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->createTables();
            } catch (PDOException $e2) {
                die(json_encode(['success' => false, 'message' => 'Database connection failed', 'error' => $e2->getMessage()]));
            }
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->conn;
    }

    private function createTables() {
        // USERS
        $sqlUsers = "
            CREATE TABLE IF NOT EXISTS users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(50) NOT NULL UNIQUE,
                email VARCHAR(100) NOT NULL UNIQUE,
                password VARCHAR(255) NOT NULL,
                avatar VARCHAR(255),
                bio TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            ) ENGINE=InnoDB;
        ";
        $this->conn->exec($sqlUsers);

        // VIDEOS
        $sqlVideos = "
            CREATE TABLE IF NOT EXISTS videos (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                video_url VARCHAR(255) NOT NULL,
                description TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
            ) ENGINE=InnoDB;
        ";
        $this->conn->exec($sqlVideos);

        // LIKES
        $sqlLikes = "
            CREATE TABLE IF NOT EXISTS likes (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                video_id INT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                UNIQUE KEY unique_like (user_id, video_id),
                FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
            ) ENGINE=InnoDB;
        ";
        $this->conn->exec($sqlLikes);

        // COMMENTS
        $sqlComments = "
            CREATE TABLE IF NOT EXISTS comments (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL,
                video_id INT NOT NULL,
                comment_text TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
            ) ENGINE=InnoDB;
        ";
        $this->conn->exec($sqlComments);

        // FOLLOWERS (abonnements)
        $sqlFollowers = "
            CREATE TABLE IF NOT EXISTS followers (
                id INT AUTO_INCREMENT PRIMARY KEY,
                follower_id INT NOT NULL,
                followed_id INT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                UNIQUE KEY unique_follow (follower_id, followed_id),
                FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
                FOREIGN KEY (followed_id) REFERENCES users(id) ON DELETE CASCADE
            ) ENGINE=InnoDB;
        ";
        $this->conn->exec($sqlFollowers);
    }
}

class API {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function handleRequest() {
        $input = json_decode(file_get_contents('php://input'), true);
        $action = $input['action'] ?? '';

        switch ($action) {
            // ajoute ici tes actions : register, login, postVideo, likeVideo, commentVideo, followUser, etc.
            default:
                return ['success' => false, 'message' => 'Action non reconnue'];
        }
    }

    // méthodes privées correspondant aux actions à ajouter ensuite...
}

// Exécution
$api = new API();
echo json_encode($api->handleRequest());

