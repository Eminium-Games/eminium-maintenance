# Étape 1 : Utilisez une image Node.js officielle
FROM node:18-alpine AS builder

# Créez le répertoire de l'application
WORKDIR /app

# Copiez les fichiers de configuration
COPY package*.json ./

# Installez toutes les dépendances (y compris les dépendances de développement)
RUN npm ci

# Copiez le reste du code source
COPY . .

# Construisez l'application
RUN npm run build

# Deuxième étape : image de production
FROM node:18-alpine

# Créez le répertoire de l'application
WORKDIR /app

# Copiez les fichiers de configuration
COPY package*.json ./

# Installez uniquement les dépendances de production
RUN npm ci --only=production

# Copiez les fichiers construits depuis l'étape de build
COPY --from=builder /app/dist ./dist

# Exposez le port sur lequel votre application écoute
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["npm", "start"]
