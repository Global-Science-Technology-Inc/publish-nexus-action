#!/bin/sh -l

pwd
ls -al

find "$6" -type f -name "*$5" -print | while read -r file; 
  do 
    filedir=$(dirname "${file}")
    filename=$(basename "${file}")
    /upload-to-yum.sh \
      --url $1 \
      --user $2 \
      --pass $3 \
      --repo $4 \
      --args -k \
      --rpmdir "${filedir}" \
      --file "${filename}"
  done

#export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
#export PATH=$JAVA_HOME/bin:$PATH

#groovy /opt/sonatype/bin/NexusPublisher.groovy --serverurl $1 --username $2 --password $3 --format $4 --repository $5 --filename $GITHUB_WORKSPACE/$8 $(echo -C$6 | sed 's/ / -C/g') $(echo -A$7 | sed 's/ / -A/g')
