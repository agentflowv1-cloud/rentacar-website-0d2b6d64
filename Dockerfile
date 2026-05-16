# ── Build stage ──────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
# Build the app. If a build script exists it MUST succeed — otherwise we'd
# end up serving raw TSX/TS source files (browsers reject those with a MIME
# type error, producing a white screen).
RUN set -e; \
    if [ -f "package.json" ]; then \
      npm install --legacy-peer-deps || npm install; \
      if node -e "process.exit(require('./package.json').scripts && require('./package.json').scripts.build ? 0 : 1)"; then \
        npm run build; \
      else \
        echo "info: no build script defined, will look for pre-built assets"; \
      fi; \
    fi

# Collect build output. Only accept REAL build artifacts (dist/build/out).
# Never copy raw source — that would expose .tsx/.ts files which nginx serves
# as application/octet-stream, breaking module script loading.
RUN set -e; \
    if   [ -d "dist"  ] && [ -f "dist/index.html"  ]; then cp -r dist  /srv/static; \
    elif [ -d "build" ] && [ -f "build/index.html" ]; then cp -r build /srv/static; \
    elif [ -d "out"   ] && [ -f "out/index.html"   ]; then cp -r out   /srv/static; \
    elif [ -f "index.html" ] && ! grep -q "/src/" index.html; then \
      mkdir -p /srv/static && cp -r . /srv/static; \
    else \
      mkdir -p /srv/static; \
      printf '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Deploying…</title><style>*{box-sizing:border-box;margin:0;padding:0}body{font-family:system-ui,sans-serif;display:flex;align-items:center;justify-content:center;min-height:100vh;background:#0f172a;color:#e2e8f0}.card{text-align:center;padding:2rem;max-width:420px}.icon{font-size:3rem;margin-bottom:1rem}h1{font-size:1.5rem;margin-bottom:.5rem}p{color:#94a3b8;line-height:1.6}</style></head><body><div class="card"><div class="icon">🚀</div><h1>Build did not produce dist/</h1><p>The build step did not generate a production bundle. Check CI logs and ensure <code>npm run build</code> succeeds locally.</p></div></body></html>' \
      > /srv/static/index.html; \
    fi

# ── Serve stage ───────────────────────────────────────────────────────────────
FROM nginx:1.25-alpine
COPY --from=builder /srv/static /usr/share/nginx/html/
# nginx config: explicit MIME types for ES modules, gzip, SPA fallback, cache headers.
# The default mime.types covers most cases but we override .js/.mjs/.css to be explicit
# (some module loaders are strict about charset=utf-8 on JS).
RUN printf 'server {\n  listen 8080;\n  server_name _;\n  root /usr/share/nginx/html;\n  index index.html;\n  \n  # Explicit MIME types for ES module scripts — strict browsers reject octet-stream\n  types {\n    text/html                             html htm;\n    application/javascript                js mjs;\n    text/css                              css;\n    application/json                      json;\n    image/svg+xml                         svg svgz;\n    image/png                             png;\n    image/jpeg                            jpg jpeg;\n    image/webp                            webp;\n    image/x-icon                          ico;\n    font/woff                             woff;\n    font/woff2                            woff2;\n    application/wasm                      wasm;\n    application/manifest+json             webmanifest;\n  }\n  default_type application/octet-stream;\n  charset utf-8;\n  \n  # Hashed assets: cache forever\n  location /assets/ {\n    try_files $uri =404;\n    expires 1y;\n    add_header Cache-Control "public, immutable";\n  }\n  \n  # SPA fallback — but only for non-asset paths\n  location / {\n    try_files $uri $uri/ /index.html;\n  }\n  \n  # Don'\''t cache index.html so deploys are picked up immediately\n  location = /index.html {\n    add_header Cache-Control "no-cache, no-store, must-revalidate";\n  }\n}\n' > /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
