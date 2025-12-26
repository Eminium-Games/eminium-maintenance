# Étape 1 : Utilisez une image Node.js officielle
FROM node:18-alpine

# Créez le répertoire de l'application
WORKDIR /app

# Copiez les fichiers de configuration
COPY package.json yarn.lock .yarnrc ./

# Installez Yarn globalement
RUN npm install -g yarn

# Installez les dépendances
RUN yarn install --frozen-lockfile --network-timeout 1000000

# Copiez le reste du code source
COPY . .

# Construisez l'application
RUN yarn build

# Exposez le port sur lequel votre application écoute
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["yarn", "start"]
