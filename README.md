<h1 align="center">Welcome to docker-cron 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-0.0.1-blue.svg?cacheSeconds=2592000" />
  <a href="https://github.com/adrienherbert/docker-cron" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="#" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> Petit projet pour gérer des actions cron dans des conteneurs via un conteneur.

Ce projet est entièrement personnel. Je laisse le repo complètement ouvert
parce que pas utile de fermer mais soyez juste averti si vous utilisez 
que je ne le modifierai que pour mon usage propre.

### 🏠 [Page d'accueil](https://github.com/adrienherbert/docker-cron)

## Installation

Je conseille de le lancer en docker-compose, avec un tmpfs sur le chemin `/cron-scripts`
du conteneur.

#### Exemple de docker-compose minimaliste :

```yml
services:
  cron:
    build:
      context: .
    restart: unless-stopped
    volumes:
      # Nécessaire pour taper les autres conteneurs
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      # Le fichier de description des crons
      - ./samples/crontab.json:/cron/crontab.json:ro
    tmpfs:
      - /cron-scripts


```

## Usage

On passe en lecture seule un fichier JSON qui se charge de créer la crontab.

Celui-ci se compose d'un tableau d'objets ayant les infos suivantes :

- **name** : Le nom du script
- **comment** : une description courte
- **schedule** : le timer cron
- **container** : Le conteneur docker sur lequel on effectue l'action
- **command** : La commande à exécuter sur le conteneur distant

#### Exemple de JSON minimaliste :


```sh
[
 {
  "name": "Ping",
  "comment": "PING : Vérifie juste que les crons tournent",
  "schedule": "* * * * *",
  "container": "test_cron",
  "command": "echo 'PONG'"
 },
 {
  "name": "Backup",
  "comment": "Sauvegarde de la base de données et des images du site",
  "schedule": "0 1 * * *",
  "container": "backup_system",
  "command": "/helpers/backup.sh"
 }
]
```

**Attention à bien penser à référencer le fichier dans le docker-compose !**

## Auteur

👤 **Adrien Herbert**

* Github: [@adrienherbert](https://github.com/adrienherbert)

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
