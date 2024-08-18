FROM sonatype/nexus-platform-cli
LABEL com.github.actions.name="Nexus Repository Publisher for GitHub Actions" \
    com.github.actions.description="Publish components from GitHub Action workflow to Nexus Repository."

RUN sudo apk add --no-cache \
  sed \
  curl

COPY entrypoint.sh /entrypoint.sh
COPY upload-to-yum.sh /upload-to-yum.sh

ENTRYPOINT ["/entrypoint.sh"]