
# HybridePhpCli

🚀 **HybridePhp** - Le framework PHP + PWA le plus simple au monde !

---

## 🌟 Pourquoi choisir HybridePhp ?

HybridePhp est un framework PHP novateur qui combine :

- La puissance de **PHP** pour le backend.
- La légèreté et la modularité avec une architecture simple à comprendre.
- Une **Progressive Web App (PWA)** prête à l’emploi.
- La compatibilité avec **MySQL** (et fallback SQLite).
- Le support **Docker** natif pour un environnement isolé.
- Une installation en une seule commande, sans configuration complexe.

### Ses points forts par rapport aux autres frameworks PHP :

| Fonctionnalité             | HybridePhp   | Laravel | Symfony | CodeIgniter |
|---------------------------|--------------|---------|---------|-------------|
| **Installation simple**    | 🚀 Facile, 1 commande | ⚙️ Complexe | ⚙️ Complexe | 🛠️ Moyenne  |
| **PWA intégrée**           | ✅ Oui       | ❌ Non  | ❌ Non  | ❌ Non      |
| **Docker prêt à l’emploi** | ✅ Oui       | Parfois | Oui     | Parfois    |
| **Base légère**            | ✅ Très légère | Plus lourde | Lourd   | Légère     |
| **Multibase (MySQL + SQLite)** | ✅ Oui    | Via packages | Via bundles | Natif MySQL|
| **Interfaces modernes**    | ✅ Front Reactif + PWA | Via packages | Via bundles | Natif PHP  |
| **Zéro configuration**     | ✅ Oui       | Non     | Non     | Moyenne    |
| **API facile**             | ✅ Ultra-simple | Moyen | Complexe | Simple     |
| **Environnement Node.js**  | ✅ Inclus    | Option | Option  | Option     |

---

## 🚀 Installation rapide

Pour démarrer avec HybridePhp, ouvrez votre terminal et exécutez :

```bash
git clone https://github.com/BelikanM/hybridePhpCli.git
cd hybridePhpCli
./install.sh mon-projet




# hybridephp-app

🚀 **Application HybridePhp** - Le framework PHP + PWA le plus simple !

## ✨ Fonctionnalités

- ✅ **PWA complète** (installable, offline, notifications)
- ✅ **PHP + MySQL** backend ultra-simple
- ✅ **Node.js** pour le développement
- ✅ **Docker** pour l'environnement
- ✅ **Zéro configuration** - Tout fonctionne immédiatement !

## 🚀 Démarrage ultra-rapide

```bash
# Installer les dépendances
npm install

# Démarrer avec Node.js (recommandé)
npm start

# Ou démarrer avec PHP
php -S localhost:8000

# Ou démarrer avec Docker
npm run docker
```

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

```bash
npm start          # Démarrer l'app
npm run docker     # Démarrer avec Docker
npm run serve      # Serveur PHP simple
```

## 📁 Structure

```
hybridephp-app/
├── index.html          # Interface PWA
├── app.js             # Logique JavaScript
├── api.php            # Backend PHP
├── manifest.json      # Configuration PWA
├── sw.js             # Service Worker
├── server.js         # Serveur Node.js
├── docker-compose.yml # Configuration Docker
└── package.json      # Dépendances Node.js
```

## 🎯 Développement

1. **Frontend** : Modifiez `index.html` et `app.js`
2. **Backend** : Modifiez `api.php`
3. **Base de données** : Automatiquement créée (SQLite/MySQL)

## 🚀 Déploiement

- **Vercel/Netlify** : Upload des fichiers
- **Heroku** : `git push heroku main`
- **VPS** : `docker-compose up -d`

---

**Créé avec ❤️ par HybridePhp Framework**
