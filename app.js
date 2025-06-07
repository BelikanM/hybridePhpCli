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
