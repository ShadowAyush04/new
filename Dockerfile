# ❌ UNOPTIMIZED DOCKERFILE FOR TESTING
FROM ubuntu:latest

# ❌ Running as root
USER root

# ❌ Multiple RUN layers and no cleanup
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y curl

WORKDIR /app

# ❌ Copying everything (no .dockerignore used)
COPY . .

# ❌ Installing dependencies with dev tools
RUN npm install

EXPOSE 3000

# ❌ No healthcheck and shell form CMD
CMD node app.js
