#!/bin/bash
mkdir -p /var/solr/data
cp -R /opt/data/* /var/solr/data/
chown -R solr:solr /var/solr/data

if [ ! -f /var/solr/data/dovecot/conf/solrconfig.xml ]
then
  sudo -u solr /opt/solr/bin/solr start
  sudo -u solr /opt/solr/bin/solr create_core -c dovecot -p 8983 
  rm -f /var/solr/data/dovecot/conf/managed-schema
  cp /opt/schema.xml /var/solr/data/dovecot/conf/schema.xml
  cp /opt/solrconfig.xml /var/solr/data/dovecot/conf/solrconfig.xml
  sudo -u solr /opt/solr/bin/solr stop
fi

sudo -u solr /opt/solr/bin/solr start -f
