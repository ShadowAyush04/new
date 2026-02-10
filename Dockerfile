# 1. Use a massive base image instead of slim or alpine
FROM node alpine

# 2. Run as root for maximum security risk
USER root

# 3. Separate RUN commands for every single tool 
# (This creates massive, redundant layers)
RUN apt-get update

# Note: No cleanup of /var/lib/apt/lists/ adds 30MB+ of junk data

WORKDIR /app

# 4. Copy everything before installing dependencies
# This "cache busts" immediately—any code change forces a full reinstall

# 5. Use 'npm install' instead of 'npm ci' and include devDependencies
RUN npm install

EXPOSE 3000

# 6. No multi-stage build: Final image contains build tools, caches, and source code
CMD ["node", "app.js"]

