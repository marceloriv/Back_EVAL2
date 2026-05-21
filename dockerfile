# ── Stage 1: builder ──────────────────────────────────────────
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci --only=production && npm cache clean --force

# ── Stage 2: runner ───────────────────────────────────────────
FROM node:18-alpine AS runner

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --chown=appuser:appgroup . .

USER appuser

EXPOSE 3000

ENV NODE_ENV=production \
    PORT=3000 \
    DB_HOST=db \
    DB_PORT=3306 \
    DB_NAME=proyecto_db \
    DB_USER=app_user \
    DB_PASSWORD=changeme_in_secrets

CMD ["node", "server.js"]
