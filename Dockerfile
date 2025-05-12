FROM n8nio/n8n:latest

ENV NODE_ENV=production
ENV N8N_PORT=5678
ENV WEBHOOK_URL=https://${RAILWAY_STATIC_URL}
ENV N8N_PROTOCOL=https
ENV N8N_HOST=${RAILWAY_STATIC_URL}
ENV N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_URL=${DB_POSTGRESDB_URL}
ENV DB_SQLITE_DISABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Instalar ferramenta de linha de comando para PostgreSQL
RUN apt-get update && apt-get install -y postgresql-client

# Expor porta
EXPOSE 5678

# Script para verificar conectividade e iniciar n8n
CMD ["sh", "-c", "echo 'Tentando conectar ao PostgreSQL...' && PGPASSWORD=$(echo $DB_POSTGRESDB_URL | cut -d: -f3 | cut -d@ -f1) psql -h postgres.railway.internal -U postgres -d railway -c 'SELECT 1;' && echo 'Conexão PostgreSQL OK! Iniciando n8n...' && n8n start"]
