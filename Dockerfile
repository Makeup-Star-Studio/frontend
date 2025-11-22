# -------------------------
# STAGE 1 — Build Flutter Web
# -------------------------
    FROM ghcr.io/cirruslabs/flutter:3.22.3 AS build

    # Create a non-root user
    RUN useradd -m -s /bin/bash flutteruser
    
    # Set permissions
    RUN chown -R flutteruser:flutteruser /sdks/flutter
    RUN git config --global --add safe.directory /sdks/flutter
    
    USER flutteruser
    WORKDIR /home/flutteruser/app
    
    # Copy project files
    COPY --chown=flutteruser:flutteruser . .
    
    # Enable web, get dependencies and build
    RUN flutter config --enable-web
    RUN flutter pub get
    RUN flutter build web --release
    
    # -------------------------
    # STAGE 2 — Serve with Nginx
    # -------------------------
    FROM nginx:alpine
    
    # Clean default html
    RUN rm -rf /usr/share/nginx/html/*
    
    # Copy Flutter build
    COPY --from=build /home/flutteruser/app/build/web /usr/share/nginx/html
    
    # Ensure .well-known folder exists for Certbot ACME challenge
    RUN mkdir -p /usr/share/nginx/html/.well-known/acme-challenge
    
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    