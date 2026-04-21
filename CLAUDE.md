# docker-cron — CLAUDE.md

Image Docker Alpine qui exécute des tâches planifiées dans d'autres
conteneurs de l'hôte via le socket Docker.

## Fonctionnement

Au démarrage, `docker-entrypoint` :
1. Génère la crontab depuis `/cron/crontab.json` (via `build-crontab`)
2. Récupère dynamiquement le GID du socket Docker de l'hôte et crée le
   groupe correspondant — évite de hardcoder les permissions
3. Lance `crond`

Chaque entrée de `crontab.json` définit : un nom, un schedule cron, un
nom de conteneur cible, et une commande à exécuter via `docker exec`.

## Intégration dans hormur.com

Le conteneur `hormur_cron` monte `/cron/crontab.json` (défini dans le
projet consommateur) et `/var/run/docker.sock` en lecture seule.

## Gotchas

- Le GID du socket Docker varie selon l'hôte — l'entrypoint le résout
  dynamiquement à chaque démarrage. Ne pas hardcoder de GID.
- Si un conteneur cible n'existe pas ou est arrêté, le `docker exec`
  échoue silencieusement dans les logs cron — vérifier avec
  `journalctl CONTAINER_TAG=hormur_cron`.
