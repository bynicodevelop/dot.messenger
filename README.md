# dot_messenger

# Installation de firebase

Se connecter à votre compte Firebase a l'aide de la commande : 

```
firebase login
```

Installation de firebase en local : 

```
cd server

npm --prefix functions install
```

Créer un fichier `.firebaserc` à la racine du dossier `server`.

Ajouter les lignes suivante en remplace `ID_PROJECT` par votre projet.

```
{
  "projects": {
    "default": "ID_PROJECT"
  }
}
```

# Démarrage de l'émulateur Firebase

```
npm --prefix functions run serve
```

# Installation de l'application

Initialiser les fichiers de configuration Firebase en suivant la documentation : https://firebase.google.com/docs/flutter/setup?platform=android

# démarrage de l'application sur Simulateur

(Note: Actuellement testé que sur IOS)

Ouvrir le fichier `main.dart`.

Demarrage de l'applications avec VSCode.