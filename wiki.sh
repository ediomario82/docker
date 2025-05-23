
docker run -d \
        -p 8080:3000 \
        -p 8443:3443 \
        -e "ADMIN_EMAIL=user@example.com" \
        -e "ADMIN_PASS=SuperSecret123" \
        -e "LETSENCRYPT_DOMAIN=wiki.example.com" \
        -e "LETSENCRYPT_EMAIL=admin@example.com" \
        --name wiki \
        --restart unless-stopped \
        -e "DB_TYPE=postgres" \
        -e "DB_HOST=db" \
        -e "DB_PORT=5432" \
        -e "DB_USER=wikijs" \
        -e "DB_PASS=wikijsrocks" \
        -e "DB_NAME=wiki" ghcr.io/requarks/wiki:latest
