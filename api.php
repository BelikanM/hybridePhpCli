<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Configuration base de données
class Database {
    private static $instance = null;
    private $conn;
    
    private function __construct() {
        $host = 'localhost';
        $dbname = 'hybridephp_db';
        $username = 'root';
        $password = '';
        
        // Pour Docker
        if (getenv('DOCKER_ENV')) {
            $host = 'mysql';
            $username = 'hybridephp_user';
            $password = 'hybridephp_pass';
        }
        
        try {
            $this->conn = new PDO(
                "mysql:host=$host;dbname=$dbname;charset=utf8",
                $username,
                $password,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );
            $this->createTables();
        } catch(PDOException $e) {
            // Fallback vers SQLite si MySQL indisponible
            try {
                $this->conn = new PDO('sqlite:hybridephp.db');
                $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->createTables();
            } catch(PDOException $e2) {
                die(json_encode(['success' => false, 'message' => 'Database connection failed']));
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
        $sql = "CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTO_INCREMENT,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) NOT NULL UNIQUE,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )";
        
        // Pour SQLite
        if ($this->conn->getAttribute(PDO::ATTR_DRIVER_NAME) === 'sqlite') {
            $sql = str_replace('AUTO_INCREMENT', 'AUTOINCREMENT', $sql);
        }
        
        $this->conn->exec($sql);
        
        // Ajouter des données de test
        $count = $this->conn->query("SELECT COUNT(*) FROM users")->fetchColumn();
        if ($count == 0) {
            $users = [
                ['John Doe', 'john@example.com'],
                ['Jane Smith', 'jane@example.com'],
                ['Bob Johnson', 'bob@example.com']
            ];
            
            $stmt = $this->conn->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
            foreach ($users as $user) {
                try {
                    $stmt->execute($user);
                } catch(PDOException $e) {
                    // Ignorer les doublons
                }
            }
        }
    }
}

// API Handler
class API {
    private $db;
    
    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }
    
    public function handleRequest() {
        $input = json_decode(file_get_contents('php://input'), true);
        $action = $input['action'] ?? '';
        
        switch ($action) {
            case 'getUsers':
                return $this->getUsers();
            case 'addUser':
                return $this->addUser($input);
            default:
                return ['success' => false, 'message' => 'Action non reconnue'];
        }
    }
    
    private function getUsers() {
        try {
            $stmt = $this->db->query("SELECT * FROM users ORDER BY created_at DESC");
            $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
            return ['success' => true, 'data' => $users];
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    private function addUser($data) {
        if (empty($data['name']) || empty($data['email'])) {
            return ['success' => false, 'message' => 'Nom et email requis'];
        }
        
        try {
            $stmt = $this->db->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
            $stmt->execute([$data['name'], $data['email']]);
            
            return [
                'success' => true,
                'message' => 'Utilisateur ajouté',
                'id' => $this->db->lastInsertId()
            ];
        } catch (Exception $e) {
            return ['success' => false, 'message' => 'Email déjà utilisé'];
        }
    }
}

// Exécution
$api = new API();
echo json_encode($api->handleRequest());
?>
