# ============================================================
#  Dockerfile — iDempiere release-12
#  Build depuis les artefacts Maven produits par le pipeline
# ============================================================

FROM eclipse-temurin:11-jre-jammy

LABEL maintainer="ISNOV SARL"
LABEL project="iDempiere"
LABEL branch="release-12"

# ── Variables ─────────────────────────────────────────────
ARG BUILD_NUMBER=0
ARG BRANCH=release-12
ENV IDEMPIERE_HOME=/opt/idempiere
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# ── Dépendances système ───────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# ── Copie des artefacts Maven ─────────────────────────────
# iDempiere produit un répertoire de distribution Linux après mvn verify
# Le chemin exact peut varier — ajuste si besoin après le premier build
WORKDIR ${IDEMPIERE_HOME}

COPY org.idempiere.server-${BRANCH}/ ./
# Fallback : si le répertoire est nommé différemment
# COPY idempiere.gtk.linux.x86_64/ ./

# ── Entrypoint ────────────────────────────────────────────
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# ── Port iDempiere (HTTP) ─────────────────────────────────
EXPOSE 8080

# ── Démarrage ─────────────────────────────────────────────
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["./idempiere"]
