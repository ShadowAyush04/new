FROM node:20-slim AS builder

WORKDIR /app

# Install only production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application source
COPY . .

FROM node:20-slim

WORKDIR /app

# Copy built app from builder
COPY --from=builder /app /app

# Install curl for healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Create non‑root user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser && chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/ || exit 1

CMD ["node","app.js"]