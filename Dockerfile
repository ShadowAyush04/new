FROM node:latest

WORKDIR /app

# ❌ copies everything (no .dockerignore)
COPY . .

# ❌ runs as root
# ❌ installs deps after copying full source (cache killer)
RUN npm install

# ❌ no healthcheck
# ❌ shell form CMD (PID 1 issue)
EXPOSE 3000
CMD node app.js
