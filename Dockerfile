FROM jenkins/jenkins:lts

USER root

# Install only Docker CLI (lightweight)
RUN apt-get update && \
    apt-get install -y docker-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins