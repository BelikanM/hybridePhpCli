
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

# Modifications recommandées dans le fichier `api.php`

| Partie du fichier                      | Chemin    | Modifier ?              | Précisions / Pourquoi                                                  |
|--------------------------------------|-----------|------------------------|-----------------------------------------------------------------------|
| En-têtes HTTP & gestion OPTIONS      | `api.php` | **Non (garder intact)** | Assure la gestion CORS et la prévalidation OPTIONS nécessaires pour une API REST |
| Classe `Database` (connexion PDO)    | `api.php` | Modifier avec soin       | Gestion critique de la connexion à la base, modifier uniquement si configuration DB change |
| Méthode `createTables()`              | `api.php` | **Oui**                 | Ajouter ou modifier les tables SQL nécessaires à ton application      |
| Méthode `API::handleRequest()`        | `api.php` | **Oui**                 | Ajouter ou étendre les routes/actions API selon les besoins métiers    |
| Méthodes privées dans la classe API   | `api.php` | **Oui**                 | Implémenter la logique métier dans des méthodes bien organisées       |
| Instanciation & exécution finale      | `api.php` | **Non (garder intact)** | Point d’entrée principal, ne pas modifier pour garantir le bon fonctionnement |


# Modifications recommandées dans le fichier `app.js`

| Partie du fichier                  | Chemin  | Modifier ?           | Précisions / Pourquoi                                                                              |
|----------------------------------|---------|---------------------|--------------------------------------------------------------------------------------------------|
| Configuration globale             | `app.js`| Modifier si besoin  | URL API et variables initiales; à adapter selon structure backend et besoins                      |
| Sélection des éléments DOM        | `app.js`| Modifier si besoin  | Modifier/ajouter éléments HTML manipulés dans le script                                          |
| Enregistrement service worker    | `app.js`| Généralement non    | Gérer l’enregistrement du service worker pour PWA, modifier seulement si évolution du SW        |
| Gestion installation PWA          | `app.js`| Modifier si besoin  | Bouton d’installation, personnalisation affichage et comportement                               |
| Gestion état réseau (online/offline) | `app.js`| Modifier si besoin  | Affichage du statut réseau, actions à effectuer en cas de perte/retour de connexion              |
| Fonction générique `apiRequest()` | `app.js`| Modifier/étendre    | Point d’entrée pour appels API, adapte headers, méthodes, gestion d’erreurs                      |
| Fonctions métier API (ex: loadUsers, addUser) | `app.js`| Modifier/étendre    | Gérer la logique métier frontend, appels API spécifiques, rendu dynamique                        |
| Fonctions UI (ex: renderUsers, showMessage) | `app.js`| Modifier/étendre    | Mise à jour de l’interface utilisateur, messages, listes, etc.                                   |
| Gestionnaire d’événements (ex: formulaire, DOMContentLoaded) | `app.js`| Modifier selon besoin| Interaction utilisateur, soumission de formulaire, initialisation                                |
| Notifications                   | `app.js`| Modifier si besoin  | Demande d’autorisation notifications, gestion basique (possibilité d’étendre pour push notif)    |

# Modifications recommandées dans le fichier `index.html`

| Partie du fichier                  | Chemin      | Modifier ?           | Précisions / Pourquoi                                                                                      |
|----------------------------------|-------------|---------------------|------------------------------------------------------------------------------------------------------------|
| Balises `<head>` (meta, manifest, favicon) | `index.html` | Modifier si besoin  | Metadonnées, configuration PWA (manifest, icônes), changer selon contexte et branding                      |
| Styles CSS intégrés              | `index.html` | Modifier/étendre    | Personnaliser l’apparence, ajouter classes CSS ou modifier le thème graphique                              |
| Structure HTML principale (`<body>`) | `index.html` | Modifier/étendre    | Ajouter des sections/pages, modifier contenu, formulaires, boutons, etc.                                   |
| Conteneurs et identifiants DOM   | `index.html` | Modifier avec prudence | Assurer la cohérence avec `app.js` (ex: IDs `userForm`, `users`, `message`, `loading`, `installBtn`)       |
| Bouton et messages               | `index.html` | Modifier si besoin  | Personnaliser textes, classes pour messages d’erreur, succès, boutons d’installation                        |
| Chargement du script `app.js`   | `index.html` | Généralement garder | Charger le script JavaScript, modifier seulement si changement d’architecture                             |

---













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
