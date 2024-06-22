# Use Keycloak 12.0.0 image from quay.io
FROM quay.io/keycloak/keycloak:12.0.0

# Create necessary directories
USER root
RUN mkdir -p /opt/jboss/keycloak/themes/Espritook

# Copy theme and configuration files
COPY ./themes/Espritook /opt/jboss/keycloak/themes/Espritook
COPY ./standalone/configuration /opt/jboss/keycloak/standalone/configuration

# Change ownership of copied files
RUN chown -R jboss:jboss /opt/jboss/keycloak/themes/Espritook /opt/jboss/keycloak/standalone/configuration

# Create the admin user
RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh --user admin --password admin

# Switch to jboss user
USER jboss

# Define environment variables
ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin

# Expose the port
EXPOSE 8080

# Run Keycloak
ENTRYPOINT ["/opt/jboss/keycloak/bin/standalone.sh", "-b", "0.0.0.0"]
