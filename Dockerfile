FROM keymetrics/pm2:10-alpine

# Update dan instalasi dependensi sistem
RUN apk update && apk upgrade && \
    apk add --no-cache bash git curl openssh

# Set label sebagai pengganti MAINTAINER
LABEL maintainer="Rossi"

# Tentukan direktori kerja
WORKDIR /usr/src/apps

# Salin package.json dan package-lock.json jika ada
COPY package*.json ./

# Bersihkan cache dan instal dependensi
RUN npm cache clean --force && npm install

# Salin seluruh file proyek
COPY . .

# Ekspos port aplikasi
EXPOSE 3000

# Jalankan dengan PM2 Runtime
CMD [ "pm2-runtime", "start", "pm2.json", "--env", "production"]