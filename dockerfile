# Usar la imagen oficial de Node.js (versión 18, versión ligera basada en Alpine)
FROM node:18-alpine

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el package.json y package-lock.json (si existe)
# Esto optimiza la caché de Docker durante la construcción
COPY package*.json ./

# Instalar las dependencias del proyecto
RUN npm install

# Copiar el resto del código fuente del proyecto
COPY . .

EXPOSE 3000

# Comando por defecto para arrancar la aplicación (modo producción)
CMD ["npm", "start"]
