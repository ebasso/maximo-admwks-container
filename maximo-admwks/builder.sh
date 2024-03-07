#!/bin/bash
#

echo "Create maximo-pae-input.properties"
echo "# ------------------------------------------------------"
MAXIMO_DIR=/opt/IBM/SMP/maximo/applications/maximo
MAXIMO_INPUT_PROPERTIES=/opt/IBM/maximo-pae-input.properties
MAXIMO_DEPLOY=/opt/IBM/SMP/maximo/deployment

mkdir -p ${MAXIMO_DIR}/properties
mkdir -p ${MAXIMO_DEPLOY}

cat > ${MAXIMO_INPUT_PROPERTIES} <<EOF
#************************************************************************************************
#** Maximo Configuration Parameters
#************************************************************************************************
mxe.adminuserloginid=maxadmin
mxe.adminPasswd=${MX_MAXADMIN_PASSWORD}

mxe.system.reguser=maxreg
mxe.system.regpassword=${MX_MAXREG_PASSWORD}

mxe.int.dfltuser=mxintadm
maximo.int.dfltuserpassword=${MX_MXINTADM_PASSWORD}

MADT.NewBaseLang=${MX_BASE_LANG}
MADT.NewAddLangs=${MX_ADD_LANGS}

mxe.adminEmail=${MX_ADMIN_EMAIL_ADDRESS}
mail.smtp.host=${MX_SMTP_SERVER_HOST_NAME}

mxe.useAppServerSecurity=0

#************************************************************************************************
#** Database user that the server uses to attach to the database server.
#************************************************************************************************
mxe.db.user=${MX_DB_USER}
mxe.db.password=${MX_DB_MAXIMO_PASSWORD}
mxe.db.schemaowner=${MX_DB_SCHEMA}

EOF


if [ "${MX_DB_VENDOR}" = "Oracle" ] ; then

  cat >> ${MAXIMO_INPUT_PROPERTIES} <<EOF

#************************************************************************************************
#** Database Configuration Parameters
#************************************************************************************************
mxe.db.driver=oracle.jdbc.OracleDriver
mxe.db.url=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}
Database.Vendor=Oracle
Database.UserSpecifiedJDBCURL=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}
Database.Oracle.ServerHostName=${MX_DB_HOSTNAME}
Database.Oracle.ServerPort=${MX_DB_PORT}
Database.Oracle.InstanceName=${MX_DB_NAME}
EOF

#Database.Oracle.DataTablespaceName=${DB_TABLE_SPACE}
#Database.Oracle.TempTablespaceName=${DB_TEMP_SPACE}
#Database.Oracle.IndexTablespaceName=${DB_INDEX_SPACE}


  # Update JDBC Driver from maven repository
  #wget -q "http://search.maven.org/remotecontent?filepath=com/oracle/database/jdbc/ojdbc8/19.7.0.0/ojdbc8-19.7.0.0.jar" -O ${MAXIMO_DIR}/lib/oraclethin.jar
  if [ -f /resources/oraclethin.jar ]; then
    echo "Update Oracle JDBC Driver"
    mv ${MAXIMO_DIR}/lib/oraclethin.jar ${MAXIMO_DIR}/lib/oraclethin.jar.bak
    cp /resources/oraclethin.jar ${MAXIMO_DIR}/lib/oraclethin.jar.bak
  fi

fi


if [ "${MX_DB_VENDOR}" = "DB2" ]
then

  cat >> ${MAXIMO_INPUT_PROPERTIES} <<EOF

#************************************************************************************************
#** Database Configuration Parameters
#************************************************************************************************
mxe.db.driver=com.ibm.db2.jcc.DB2Driver
mxe.db.url=jdbc:db2://${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}
Database.Vendor=DB2
Database.DB2.DatabaseName=${MX_DB_NAME}
Database.DB2.ServerHostName=${MX_DB_HOSTNAME}
Database.DB2.ServerPort=${MX_DB_PORT}
Database.DB2.Vargraphic=true
Database.DB2.TextSearchEnabled=false
EOF

#Database.DB2.DataTablespaceName=${DB_TABLE_SPACE}
#Database.DB2.TempTablespaceName=${DB_TEMP_SPACE}
#Database.DB2.IndexTablespaceName=${DB_INDEX_SPACE}
fi

if [ -s "${MAXIMO_INPUT_PROPERTIES}" ]; then
    echo "Failed to create maximo-pae-input.properties."
    exit 1
fi

echo "# Run Configuration Tool reconfigurePae.sh"
echo "# ------------------------------------------------------"
# https://www.ibm.com/docs/en/mam/7.6.1.2?topic=configuration-command-line-interface-parameters
/opt/IBM/SMP/ConfigTool/scripts/reconfigurePae.sh -action deployDatabaseConfiguration -inputfile ${MAXIMO_INPUT_PROPERTIES} 

RETURN_CODE=$?

# Check if the command failed
if [ ${RETURN_CODE} -ne 0 ]; then
    echo "Command reconfigurePae.sh failed with return code ${RETURN_CODE}. Exiting."
    exit ${RETURN_CODE}
fi


echo "# Exploding Custom Classes "
echo "# ------------------------------------------------------"
if [ -f /resources/custom_classes.zip ]; then
    cd /opt/IBM/SMP
    unzip /resources/custom_classes.zip
fi


cd ${MAXIMO_DEPLOY}

echo "# Compiling maximo.ear "
echo "# ------------------------------------------------------"
if [ "${MX_APP_VENDOR}" = "was" ] ; then 
    echo "Run buildmaximoearwas8.sh for WebSphere"
    bash "buildmaximoearwas8.sh"
    mv ${MAXIMO_DEPLOY}/default/maximo.ear /resources/.
elif [ "${MX_APP_VENDOR}" = "liberty" ] ; then    
    for type in "-xwar" "api-war" "cron-war" "jmsconsumer-ear" "mea-ear" "report-war" "ui-war"
    do
      echo "Run buildmaximo${type}.sh ... for Liberty"
      bash "buildmaximo${type}.sh"
      mv ${MAXIMO_DEPLOY}/default/maximo.${type} /resources/.
    done
elif [ "${MX_APP_VENDOR}" = "weblogic" ] ; then    
    echo "Run buildmaximoear.sh ... for Weblogic"
    bash "buildmaximoear.sh"
    mv ${MAXIMO_DEPLOY}/default/maximo.ear /resources/.
else 
    echo "Compile maximo.ear file for Generic"
    echo "Run buildmaximoear.sh ..."
    bash "buildmaximoear.sh"
    mv ${MAXIMO_DEPLOY}/default/maximo.ear /resources/.
fi



