FROM maximo-admwks/maximo-smp:7.6.1.3 as source

FROM registry.access.redhat.com/ubi8/ubi:8.9

ARG url=http://files

ENV MX_MAXADMIN_PASSWORD passw0rd
ENV MX_MAXREG_PASSWORD passw0rd
ENV MX_MXINTADM_PASSWORD passw0rd
ENV MX_BASE_LANG en
ENV MX_ADD_LANGS pt_BR,es
ENV MX_ADMIN_EMAIL_ADDRESS root@localhost
ENV MX_SMTP_SERVER_HOST_NAME localhost

ENV MX_DB_VENDOR Oracle
ENV MX_DB_HOSTNAME orcl.maximo.com
ENV MX_DB_PORT 1521
ENV MX_DB_USER maximo
ENV MX_DB_PASSWORD maximo
ENV MX_DB_SCHEMA maximo
ENV MX_DB_NAME MAXDB76
ENV MX_DB_SERVICENAME maxdb.maximo.com
ENV MX_DB_URL maxdb.maximo.com
#ENV MX_DB_TABLE_SPACE MAXDATA
#ENV MX_DB_TEMP_SPACE MAXTEMP
#ENV MX_DB_INDEX_SPACE MAXINDEX

ENV MX_APP_VENDOR weblogic

ENV TEMP /tmp
WORKDIR /opt/IBM/SMP

# Install required packages
RUN dnf -y install curl wget unzip git && dnf clean all

# Copy the /opt/IBM directory from the source image

COPY --from=source /opt/IBM/SMP /opt/IBM/SMP

# still need to work without root user
# -----------------------
# COPY --chown=1001:0 --from=source /opt/IBM/SMP /opt/IBM/SMP
# USER 1001  # still need to work without root user

COPY builder.sh /opt/IBM
RUN chmod +x /opt/IBM/builder.sh
ENTRYPOINT ["/opt/IBM/builder.sh"]


