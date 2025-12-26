# Étape 1 : Utilisez une image Node.js officielle
FROM node:18-alpine

# Créez le répertoire de l'application
WORKDIR /app

# Copiez les fichiers de configuration
COPY package*.json ./

# Installez les dépendances
RUN npm ci --only=production

# Copiez le reste du code source
COPY . .

# Construisez l'application
RUN npm run build

# Exposez le port sur lequel votre application écoute
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["npm", "start"]
