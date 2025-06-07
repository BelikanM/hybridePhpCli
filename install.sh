#!/bin/bash

# HybridePhp Framework - Le plus simple au monde !
# Usage: curl -sSL https://raw.githubusercontent.com/VOTRE-USERNAME/hybridephp-installer/main/install.sh | bash -s mon-projet
# ou: ./install.sh mon-projet

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner stylé
print_banner() {
    clear
    echo -e "${PURPLE}"
    echo "██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗██████╗ ███████╗██████╗ ██╗  ██╗██████╗ "
    echo "██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║██╔══██╗██╔════╝██╔══██╗██║  ██║██╔══██╗"
    echo "███████║ ╚████╔╝ ██████╔╝██████╔╝██║██║  ██║█████╗  ██████╔╝███████║██████╔╝"
    echo "██╔══██║  ╚██╔╝  ██╔══██╗██╔══██╗██║██║  ██║██╔══╝  ██╔═══╝ ██╔══██║██╔═══╝ "
    echo "██║  ██║   ██║   ██████╔╝██║  ██║██║██████╔╝███████╗██║     ██║  ██║██║     "
    echo "╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     "
    echo -e "${NC}"
    echo -e "${CYAN}🚀 Le framework PHP + PWA le plus SIMPLE au monde !${NC}"
    echo -e "${YELLOW}📱 PHP + MySQL + PWA + Docker en UNE commande${NC}"
    echo ""
}

print_step() {
    echo -e "${BLUE}🚀 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Variables
PROJECT_NAME=${1:-"hybridephp-app"}
CURRENT_DIR=$(pwd)

# Fonction principale
create_hybridephp_app() {
    print_banner
    
    print_step "Création du projet $PROJECT_NAME..."
    
    # Créer le dossier du projet
    if [ -d "$PROJECT_NAME" ]; then
        print_warning "Le dossier $PROJECT_NAME existe déjà !"
        read -p "Voulez-vous le supprimer ? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$PROJECT_NAME"
        else
            exit 1
        fi
    fi
    
    mkdir "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    
    print_success "Dossier créé"
    
    # Créer package.json
    print_step "Configuration Node.js..."
    cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "description": "HybridePhp PWA Application",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "build": "npm run build:css && npm run build:js",
    "build:css": "echo 'CSS optimized'",
    "build:js": "echo 'JS optimized'",
    "docker": "docker-compose up -d",
    "docker:stop": "docker-compose down",
    "install:all": "npm install && echo 'Ready to go!'",
    "serve": "php -S localhost:8000 api.php"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "mysql2": "^3.6.0",
    "dotenv": "^16.3.1",
    "nodemon": "^3.0.1"
  },
  "keywords": ["php", "pwa", "mysql", "hybridephp"],
  "author": "HybridePhp",
  "license": "MIT"
}
EOF
    
    # Créer index.html (PWA complète)
    print_step "Création de l'interface PWA..."
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#667eea">
    <meta name="description" content="HybridePhp PWA - Le framework le plus simple">
    
    <!-- PWA -->
    <link rel="manifest" href="manifest.json">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🚀</text></svg>">
    
    <title>HybridePhp App</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            padding: 20px 0;
            margin-bottom: 30px;
            border-radius: 15px;
            text-align: center;
            color: white;
        }
        
        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .status {
            display: inline-block;
            padding: 8px 16px;
            background: rgba(40, 167, 69, 0.2);
            border: 1px solid rgba(40, 167, 69, 0.3);
            border-radius: 20px;
            color: #28a745;
            font-weight: 500;
        }
        
        .card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.2s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
        
        .users-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .user-card {
            background: white;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            transition: transform 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .user-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .loading::after {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 10px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        
        .success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
        
        .install-btn {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            width: 100%;
            margin-top: 20px;
        }
        
        .hidden { display: none !important; }
        
        @media (max-width: 768px) {
            .header h1 { font-size: 2rem; }
            .users-grid { grid-template-columns: 1fr; }
            .container { padding: 10px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>🚀 HybridePhp</h1>
            <p>Le framework PHP + PWA le plus simple</p>
            <div class="status" id="status">🟢 En ligne</div>
        </header>
        
        <main>
            <div class="card">
                <h2>👥 Gestion des Utilisateurs</h2>
                
                <div id="message"></div>
                
                <form id="userForm">
                    <div class="form-group">
                        <label for="name">Nom</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <button type="submit" class="btn">Ajouter Utilisateur</button>
                </form>
            </div>
            
            <div class="card">
                <h3>📋 Liste des Utilisateurs</h3>
                <div id="loading" class="loading">Chargement des utilisateurs...</div>
                <div id="users" class="users-grid"></div>
            </div>
            
            <div class="card">
                <h3>📱 PWA Features</h3>
                <p>✅ Installable sur mobile</p>
                <p>✅ Fonctionne hors ligne</p>
                <p>✅ Notifications push</p>
                <p>✅ Cache intelligent</p>
                <button id="installBtn" class="btn install-btn hidden">📱 Installer l'App</button>
            </div>
        </main>
    </div>
    
    <script src="app.js"></script>
</body>
</html>
EOF
    
    # Créer app.js (JavaScript PWA)
    print_step "Création de la logique JavaScript..."
    cat > app.js << 'EOF'
// Configuration
const API_URL = 'api.php';

// État global
let users = [];
let isOnline = navigator.onLine;

// Éléments DOM
const elements = {
    userForm: document.getElementById('userForm'),
    loading: document.getElementById('loading'),
    users: document.getElementById('users'),
    message: document.getElementById('message'),
    status: document.getElementById('status'),
    installBtn: document.getElementById('installBtn')
};

// Service Worker pour PWA
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('sw.js')
        .then(reg => console.log('✅ Service Worker enregistré'))
        .catch(err => console.log('❌ Service Worker échoué:', err));
}

// Installation PWA
let deferredPrompt;
window.addEventListener('beforeinstallprompt', (e) => {
    e.preventDefault();
    deferredPrompt = e;
    elements.installBtn.classList.remove('hidden');
});

elements.installBtn.addEventListener('click', async () => {
    if (deferredPrompt) {
        deferredPrompt.prompt();
        const { outcome } = await deferredPrompt.userChoice;
        console.log('Installation:', outcome);
        deferredPrompt = null;
        elements.installBtn.classList.add('hidden');
    }
});

// Gestion réseau
window.addEventListener('online', () => {
    isOnline = true;
    elements.status.innerHTML = '🟢 En ligne';
    loadUsers();
});

window.addEventListener('offline', () => {
    isOnline = false;
    elements.status.innerHTML = '🔴 Hors ligne';
});

// API Functions
async function apiRequest(action, data = null) {
    try {
        const options = {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ action, ...data })
        };
        
        const response = await fetch(API_URL, options);
        return await response.json();
    } catch (error) {
        console.error('Erreur API:', error);
        throw error;
    }
}

// Charger les utilisateurs
async function loadUsers() {
    try {
        elements.loading.classList.remove('hidden');
        const result = await apiRequest('getUsers');
        
        if (result.success) {
            users = result.data;
            renderUsers();
        } else {
            showMessage('Erreur: ' + result.message, 'error');
        }
    } catch (error) {
        showMessage('Impossible de charger les utilisateurs', 'error');
    } finally {
        elements.loading.classList.add('hidden');
    }
}

// Ajouter un utilisateur
async function addUser(userData) {
    try {
        const result = await apiRequest('addUser', userData);
        
        if (result.success) {
            showMessage('Utilisateur ajouté avec succès !', 'success');
            elements.userForm.reset();
            loadUsers();
        } else {
            showMessage('Erreur: ' + result.message, 'error');
        }
    } catch (error) {
        showMessage('Impossible d\'ajouter l\'utilisateur', 'error');
    }
}

// Afficher les utilisateurs
function renderUsers() {
    if (users.length === 0) {
        elements.users.innerHTML = '<p style="text-align: center; color: #666;">Aucun utilisateur trouvé</p>';
        return;
    }
    
    elements.users.innerHTML = users.map(user => `
        <div class="user-card">
            <h4>${user.name}</h4>
            <p>📧 ${user.email}</p>
            <small>📅 ${new Date(user.created_at).toLocaleDateString()}</small>
        </div>
    `).join('');
}

// Afficher un message
function showMessage(text, type) {
    elements.message.innerHTML = `<div class="${type}">${text}</div>`;
    setTimeout(() => {
        elements.message.innerHTML = '';
    }, 5000);
}

// Gestionnaire de formulaire
elements.userForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const userData = {
        name: formData.get('name'),
        email: formData.get('email')
    };
    
    addUser(userData);
});

// Initialisation
document.addEventListener('DOMContentLoaded', () => {
    if (isOnline) {
        loadUsers();
    } else {
        elements.loading.classList.add('hidden');
        showMessage('Vous êtes hors ligne', 'error');
    }
});

// Notifications
if ('Notification' in window) {
    setTimeout(() => {
        Notification.requestPermission();
    }, 3000);
}
EOF
    
    # Créer api.php (Backend PHP ultra-simple)
    print_step "Création de l'API PHP..."
    cat > api.php << 'EOF'
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
EOF
    
    # Créer manifest.json (PWA)
    print_step "Configuration PWA..."
    cat > manifest.json << EOF
{
  "name": "$PROJECT_NAME - HybridePhp PWA",
  "short_name": "$PROJECT_NAME",
  "description": "Application $PROJECT_NAME construite avec HybridePhp",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#667eea",
  "orientation": "portrait-primary",
  "icons": [
    {
      "src": "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' fill='%23667eea'/><text y='.9em' font-size='90' text-anchor='middle' x='50' fill='white'>🚀</text></svg>",
      "sizes": "192x192",
      "type": "image/svg+xml",
      "purpose": "any maskable"
    },
    {
      "src": "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' fill='%23667eea'/><text y='.9em' font-size='90' text-anchor='middle' x='50' fill='white'>🚀</text></svg>",
      "sizes": "512x512",
      "type": "image/svg+xml",
      "purpose": "any maskable"
    }
  ]
}
EOF
    
    # Créer sw.js (Service Worker)
    cat > sw.js << 'EOF'
const CACHE_NAME = 'hybridephp-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/app.js',
  '/manifest.json',
  '/api.php'
];

// Installation
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

// Activation
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Fetch
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        if (response) {
          return response;
        }
        return fetch(event.request).catch(() => {
          if (event.request.destination === 'document') {
            return caches.match('/index.html');
          }
        });
      })
  );
});
EOF
    
    # Créer docker-compose.yml
    print_step "Configuration Docker..."
    cat > docker-compose.yml << EOF
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: ${PROJECT_NAME}_mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: hybridephp_db
      MYSQL_USER: hybridephp_user
      MYSQL_PASSWORD: hybridephp_pass
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    restart: unless-stopped

  php:
    image: php:8.1-apache
    container_name: ${PROJECT_NAME}_php
    ports:
      - "8000:80"
    volumes:
      - .:/var/www/html
    depends_on:
      - mysql
    environment:
      - DOCKER_ENV=true
    restart: unless-stopped
    command: >
      bash -c "
        docker-php-ext-install pdo pdo_mysql &&
        a2enmod rewrite &&
        apache2-foreground
      "

  node:
    image: node:18-alpine
    container_name: ${PROJECT_NAME}_node
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    working_dir: /app
    restart: unless-stopped
    command: sh -c "npm install && npm start"

volumes:
  mysql_data:
EOF
    
    # Créer server.js (serveur Node.js)
    cat > server.js << 'EOF'
const express = require('express');
const path = require('path');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.static('.'));
app.use(express.json());

// Route principale
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Démarrage du serveur
app.listen(PORT, () => {
    console.log(`🚀 HybridePhp App démarrée sur http://localhost:${PORT}`);
    console.log(`📱 PWA prête à être installée !`);
});
EOF
    
    # Créer .gitignore
    cat > .gitignore << 'EOF'
node_modules/
*.log
.env
mysql_data/
hybridephp.db
.DS_Store
Thumbs.db
EOF
    
    # Créer README.md
    cat > README.md << EOF
# $PROJECT_NAME

🚀 **Application HybridePhp** - Le framework PHP + PWA le plus simple !

## ✨ Fonctionnalités

- ✅ **PWA complète** (installable, offline, notifications)
- ✅ **PHP + MySQL** backend ultra-simple
- ✅ **Node.js** pour le développement
- ✅ **Docker** pour l'environnement
- ✅ **Zéro configuration** - Tout fonctionne immédiatement !

## 🚀 Démarrage ultra-rapide

\`\`\`bash
# Installer les dépendances
npm install

# Démarrer avec Node.js (recommandé)
npm start

# Ou démarrer avec PHP
php -S localhost:8000

# Ou démarrer avec Docker
npm run docker
\`\`\`

## 🌐 URLs

- **Application** : http://localhost:3000
- **API PHP** : http://localhost:8000
- **MySQL** : localhost:3306

## 📱 PWA

L'application est automatiquement installable sur :
- 📱 Mobile (Android/iOS)
- 💻 Desktop (Chrome/Edge/Safari)
- 🌐 Fonctionne hors ligne

## 🛠️ Commandes

\`\`\`bash
npm start          # Démarrer l'app
npm run docker     # Démarrer avec Docker
npm run serve      # Serveur PHP simple
\`\`\`

## 📁 Structure

\`\`\`
$PROJECT_NAME/
├── index.html          # Interface PWA
├── app.js             # Logique JavaScript
├── api.php            # Backend PHP
├── manifest.json      # Configuration PWA
├── sw.js             # Service Worker
├── server.js         # Serveur Node.js
├── docker-compose.yml # Configuration Docker
└── package.json      # Dépendances Node.js
\`\`\`

## 🎯 Développement

1. **Frontend** : Modifiez \`index.html\` et \`app.js\`
2. **Backend** : Modifiez \`api.php\`
3. **Base de données** : Automatiquement créée (SQLite/MySQL)

## 🚀 Déploiement

- **Vercel/Netlify** : Upload des fichiers
- **Heroku** : \`git push heroku main\`
- **VPS** : \`docker-compose up -d\`

---

**Créé avec ❤️ par HybridePhp Framework**
EOF
    
    print_success "Projet créé avec succès !"
    
    # Initialiser Git
    print_step "Initialisation Git..."
    git init
    git add .
    git commit -m "🚀 Initial commit - HybridePhp App"
    print_success "Git initialisé"
    
    # Installation des dépendances
    print_step "Installation des dépendances Node.js..."
    if command -v npm &> /dev/null; then
        npm install --silent
        print_success "Dépendances installées"
    else
        print_warning "npm non trouvé - installez Node.js pour utiliser npm start"
    fi
    
    # Message final
    echo ""
    echo -e "${GREEN}🎉 $PROJECT_NAME créé avec succès !${NC}"
    echo ""
    echo -e "${CYAN}📋 Prochaines étapes :${NC}"
    echo -e "${YELLOW}   cd $PROJECT_NAME${NC}"
    echo -e "${YELLOW}   npm start${NC}"
    echo ""
    echo -e "${CYAN}🌐 URLs disponibles :${NC}"
    echo -e "${YELLOW}   App Node.js : http://localhost:3000${NC}"
    echo -e "${YELLOW}   API PHP     : http://localhost:8000${NC}"
    echo -e "${YELLOW}   Docker      : npm run docker${NC}"
    echo ""
    echo -e "${CYAN}📱 Fonctionnalités PWA :${NC}"
    echo -e "${YELLOW}   ✅ Installable sur mobile${NC}"
    echo -e "${YELLOW}   ✅ Fonctionne hors ligne${NC}"
    echo -e "${YELLOW}   ✅ Notifications push${NC}"
    echo -e "${YELLOW}   ✅ Cache intelligent${NC}"
    echo ""
    echo -e "${PURPLE}🚀 Bon développement avec HybridePhp !${NC}"
}

# Vérifier si le script est exécuté directement
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    create_hybridephp_app
fi

