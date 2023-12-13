# OpenVPN Configuration Scripts

Ce référentiel (repo) contient des scripts facilitant la configuration des serveurs et clients OpenVPN. Ces scripts ont été conçus pour simplifier le processus d'installation, de configuration et de gestion d'un réseau privé virtuel (VPN) utilisant OpenVPN.

## Contenu du Répertoire

1. **`server-setup.sh`**: Ce script automatisé guide les utilisateurs à travers le processus de configuration du serveur OpenVPN. Il génère automatiquement les clés, certificats, et fichiers de configuration nécessaires.

2. **`client-setup.sh`**: Facilite la configuration des clients OpenVPN. En utilisant ce script, les utilisateurs peuvent générer rapidement les fichiers de configuration nécessaires pour se connecter au serveur VPN.

3. **`config-templates/`**: Répertoire contenant des modèles de fichiers de configuration pour le serveur et les clients. Ces modèles sont utilisés par les scripts pour générer des configurations personnalisées.

## Guide d'Utilisation

### Configuration du Serveur OpenVPN

1. Exécutez le script `server-setup.sh` en tant qu'administrateur.

```bash
sudo bash server-setup.sh
```

Suivez les instructions à l'écran pour spécifier les paramètres de configuration du serveur, puis lancer le serveur. 
```bash
systemctl start openvpn@server_tap.service
```

### Configuration des Clients OpenVPN
Exécutez le script client-setup.sh pour chaque client.
```bash
bash client-setup.sh
```
Entrez les informations requises, telles que l'adresse IP du serveur et les informations d'identification.

## Prérequis
Configuration requise :
- OS : Dedian 10 (Docker)

## Avertissement

Assurez-vous de comprendre les implications de sécurité associées à la configuration d'un serveur OpenVPN. Il est recommandé de consulter la documentation officielle d'OpenVPN pour des informations détaillées sur la sécurisation de votre déploiement.

## Contribution

Les contributions sont les bienvenues! N'hésitez pas à signaler des problèmes, proposer des améliorations, ou envoyer des demandes de tirage.

## Licence
Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.
