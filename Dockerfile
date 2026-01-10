ARG NODE_VERSION=18.20.4
FROM node:${NODE_VERSION}

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["npm", "start"]
