# Build stage (optional; here just to show structure)
FROM alpine:3.20 AS build
WORKDIR /app
COPY index.html /app/index.html

# Runtime: Nginx serving static content
FROM nginx:1.27-alpine
# Replace default nginx config
COPY nginx.conf /etc/nginx/nginx.conf
# Put the built site in the standard html dir
COPY --from=build /app /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1/ >/dev/null || exit 1

