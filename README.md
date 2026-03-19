# 📱 Atelier Pro — Application mobile de gestion de couture

Application Flutter complète pour la gestion d'un atelier de couture.  
Conforme au cahier des charges — clients, mesures, commandes, paiements, agenda.

---

## 🚀 Obtenir l'APK en ligne (sans rien installer)

### Étape 1 — Créer un compte GitHub
Aller sur [github.com](https://github.com) → **Sign up** (gratuit)

### Étape 2 — Créer un nouveau repository
1. Cliquer **New repository**
2. Nom : `atelier-couture`
3. Visibilité : **Public** (obligatoire pour GitHub Actions gratuit)
4. Cliquer **Create repository**

### Étape 3 — Uploader les fichiers
1. Dans le repository, cliquer **uploading an existing file**
2. Glisser-déposer **tout le contenu du dossier `flutter/`**
3. Cliquer **Commit changes**

### Étape 4 — Le build démarre automatiquement
GitHub Actions démarre automatiquement le build.  
Aller dans l'onglet **Actions** pour suivre la progression (~8 minutes).

### Étape 5 — Télécharger les APKs
1. Cliquer sur le build terminé ✅
2. Descendre jusqu'à **Artifacts**
3. Télécharger **APK-Demo** ou **APK-Production**

### Étape 6 — Installer sur Android
```
1. Envoyer l'APK sur le téléphone (WhatsApp, email, câble USB)
2. Ouvrir le fichier .apk sur le téléphone
3. Activer "Installer des applications inconnues" si demandé
4. Appuyer sur Installer ✅
```

---

## 🔑 Configuration API_URL (APK Production)

Pour l'APK connecté au back-end Django :

1. Dans GitHub, aller dans **Settings → Secrets → Actions**
2. Cliquer **New repository secret**
3. Nom : `API_URL`
4. Valeur : `https://votre-app.up.railway.app/api`

---

## 📂 Structure du projet

```
flutter/
├── lib/
│   ├── main.dart                    # Point d'entrée — mode démo ou prod
│   ├── data/
│   │   └── demo_data.dart           # Données fictives (mode démo)
│   ├── models/
│   │   ├── commande.dart            # Modèles de données
│   │   └── client.dart
│   ├── providers/
│   │   ├── auth_provider.dart       # Authentification
│   │   ├── commande_provider.dart   # État des commandes
│   │   └── client_provider.dart    # État des clients
│   ├── screens/
│   │   ├── splash_screen.dart       # Écran de démarrage
│   │   ├── login_screen.dart        # Connexion
│   │   ├── dashboard_screen.dart    # Tableau de bord
│   │   ├── commandes_list_screen.dart
│   │   ├── commande_detail_screen.dart
│   │   ├── commande_form_screen.dart
│   │   ├── clients_list_screen.dart
│   │   ├── client_detail_screen.dart
│   │   ├── catalogue_screen.dart
│   │   └── agenda_screen.dart
│   └── widgets/
│       └── commande_widgets.dart    # Composants réutilisables
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml      # Permissions Android
├── .github/workflows/
│   └── build-apk.yml               # Build automatique GitHub Actions
└── pubspec.yaml                     # Dépendances Flutter
```

---

## 🔧 Mode démo vs production

| | APK Démo | APK Production |
|---|---|---|
| Back-end requis | ❌ Non | ✅ Oui (Django) |
| Données | Fictives (8 clients, 6 commandes) | Réelles (base Django) |
| Connexion internet | Non requise | Requise |
| Usage | Démonstration, tests | Exploitation réelle |

En mode démo, identifiant et mot de passe **admin / demo123** (ou n'importe quoi).

---

## 🛠️ Prochaines étapes

- [ ] Déployer le back-end Django sur Railway
- [ ] Ajouter le secret `API_URL` dans GitHub
- [ ] Générer l'APK Production
- [ ] Module mesures complet
- [ ] Génération de reçus PDF
- [ ] Notifications push Firebase
