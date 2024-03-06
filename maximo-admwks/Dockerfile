FROM maximo-admwks/ibm-im:1.9

ARG url=http://images
ARG mam_image=MAM_7.6.1.0_LINUX64.tar.gz

ENV MX_MAXADMIN_PASSWORD passw0rd
ENV MX_MAXREG_PASSWORD passw0rd
ENV MX_MXINTADM_PASSWORD passw0rd
ENV MX_BASE_LANG en
ENV MX_ADMIN_EMAIL_ADDRESS root@localhost
ENV MX_SMTP_SERVER_HOST_NAME localhost

ENV MX_DB_VENDOR Oracle
ENV MX_DB_HOSTNAME orcl.maximo.com
ENV MX_DB_PORT 1521
ENV MX_DB_USER maximo
ENV MX_DB_PASSWORD maximo
ENV MX_DB_SCHEMA maximo
ENV MX_DB_NAME maxdb.maximo.com
ENV MX_DB_URL maxdb.maximo.com
#ENV MX_DB_TABLE_SPACE MAXDATA
#ENV MX_DB_TEMP_SPACE MAXTEMP
#ENV MX_DB_INDEX_SPACE MAXINDEX

ENV MX_APP_VENDOR weblogic

ENV TEMP /tmp
WORKDIR /resources
WORKDIR /Launchpad

ENV BYPASS_PRS=True

## Install Maximo V7.6.1
RUN wget -q -O mam76.tar $url/$mam_image \
 && tar -xpf mam76.tar \
 && /opt/IBM/InstallationManager/eclipse/tools/imcl -log /opt/IBM/mam_install.log -acceptLicense \
 -input /Launchpad/SilentResponseFiles/Unix/ResponseFile_MAM_Install_Unix.xml \
 && mkdir -p /opt/IBM/SMP/maximo/deployment/default \
 && rm -rf *

WORKDIR /work

COPY builder.sh /work
RUN chmod +x /work/builder.sh
ENTRYPOINT ["/work/builder.sh"]
