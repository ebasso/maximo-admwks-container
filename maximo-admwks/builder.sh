#!/bin/bash
#

MAXIMO_DIR=/opt/IBM/SMP/maximo/applications/maximo
MAXIMO_PROPERTIES=/opt/IBM/SMP/maximo/applications/maximo/properties/maximo.properties
MAXIMO_PAE_PROPERTIES=/opt/IBM/pae-input.properties
MAXIMO_DB_PROPERTIES=/opt/IBM/pae-db-input.properties
MAXIMO_DEPLOY=/opt/IBM/SMP/maximo/deployment


function configure_maximo_properties_for_db2 {

  cat > ${MAXIMO_PROPERTIES} <<EOF
#************************************************************************************************
#** Database user that the server uses to attach to the database server.
#************************************************************************************************
mxe.db.user=${MX_DB_USER}

#************************************************************************************************
#** Owner of the database schema. Must be dbo for SQLServer and same as mxe.db.user
#** for Oracle.
#************************************************************************************************
mxe.db.schemaowner=${MX_DB_SCHEMA}

#************************************************************************************************
#** Password for the database user name.
#************************************************************************************************
mxe.db.password=${MX_DB_PASSWORD}
mxe.encrypted=false

#************************************************************************************************
#** Name to bind the MXServer server object to in the RMI registry.
#************************************************************************************************
mxe.name=MAXIMO

#************************************************************************************************
#** RMI communication port. If set at zero, RMI uses any available port. You can
#** select another available port number.
#************************************************************************************************
mxe.rmi.port=0

#************************************************************************************************
#** The port number used to bind RMI/JRMP communications. Default is 13400.
#************************************************************************************************
mxe.registry.port=13400

#************************************************************************************************
#** Set to true in production environments, to improve system performance. Set to
#** false for development work, or for custom applications.
#************************************************************************************************
mxe.allowLocalObjects=1

#************************************************************************************************
#** Defines what the minimum level of database is required for an upgrade. An
#** example value would be 7100.
#************************************************************************************************
maximo.min.required.db.version=7100

#************************************************************************************************
#** Integration user default password.
#************************************************************************************************
maximo.int.dfltuserpassword=${MX_MXINTADM_PASSWORD}

#************************************************************************************************
#** Java class name of the JDBC driver.
#************************************************************************************************
mxe.db.driver=com.ibm.db2.jcc.DB2Driver

#************************************************************************************************
#** JDBC URL of the database.
#************************************************************************************************
mxe.db.url=jdbc:db2://${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}

#************************************************************************************************
#** Number of database connections to create when the application server is started.
#************************************************************************************************
mxe.db.initialConnections=8

#************************************************************************************************
#** Maximum number of free database connections available in the connection pool.
#************************************************************************************************
mxe.db.maxFreeConnections=8

#************************************************************************************************
#** Minimum number of free database connections needed in the connection pool in
#** order for more connections to be allocated.
#************************************************************************************************
mxe.db.minFreeConnections=5

#************************************************************************************************
#** Number of new connections to be created when the minimum free connections are
#** available in the connection pool.
#************************************************************************************************
mxe.db.newConnectionCount=3

#************************************************************************************************
#** The system install sets the value to: TRANSACTION_READ_COMMITTED.
#************************************************************************************************
mxe.db.transaction_isolation=TRANSACTION_READ_COMMITTED

#************************************************************************************************
#** This value defines the database uppercase function for the system.
#************************************************************************************************
mxe.db.format.upper=UPPER

#************************************************************************************************
#** This value sets the autocommit mode used for the Write connections. Can be
#** either true or false. The default is false.
#************************************************************************************************
mxe.db.autocommit=0

#************************************************************************************************
#** System date format.
#************************************************************************************************
mxe.db.systemdateformat=current timestamp

#************************************************************************************************
#** The database-specific format of the null value function.
#************************************************************************************************
mxe.db.format.nullvalue=COALESCE

#mxe.crontask.donotrun=ALL
EOF

}

function configure_maximo_properties_for_oracle {

  if [ "${MX_DB_SERVICENAME}" != "" ]; then
    ORACLE_DB_URL=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_SERVICENAME}
  else
    ORACLE_DB_URL=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}
  fi

  cat > ${MAXIMO_PROPERTIES} <<EOF
#************************************************************************************************
#** Database user that the server uses to attach to the database server.
#************************************************************************************************
mxe.db.user=${MX_DB_USER}

#************************************************************************************************
#** Owner of the database schema. Must be dbo for SQLServer and same as mxe.db.user
#** for Oracle.
#************************************************************************************************
mxe.db.schemaowner=${MX_DB_SCHEMA}

#************************************************************************************************
#** Password for the database user name.
#************************************************************************************************
mxe.db.password=${MX_DB_PASSWORD}
mxe.encrypted=false

#************************************************************************************************
#** Name to bind the MXServer server object to in the RMI registry.
#************************************************************************************************
mxe.name=MAXIMO

#************************************************************************************************
#** RMI communication port. If set at zero, RMI uses any available port. You can
#** select another available port number.
#************************************************************************************************
mxe.rmi.port=0

#************************************************************************************************
#** The port number used to bind RMI/JRMP communications. Default is 13400.
#************************************************************************************************
mxe.registry.port=13400

#************************************************************************************************
#** Set to true in production environments, to improve system performance. Set to
#** false for development work, or for custom applications.
#************************************************************************************************
mxe.allowLocalObjects=1

#************************************************************************************************
#** Defines what the minimum level of database is required for an upgrade. An
#** example value would be 7100.
#************************************************************************************************
maximo.min.required.db.version=7100

#************************************************************************************************
#** Integration user default password.
#************************************************************************************************
maximo.int.dfltuserpassword=${MX_MXINTADM_PASSWORD}

#************************************************************************************************
#** Java class name of the JDBC driver.
#************************************************************************************************
mxe.db.driver=mxe.db.driver=oracle.jdbc.OracleDriver

#************************************************************************************************
#** JDBC URL of the database.
#************************************************************************************************
mxe.db.url=${ORACLE_DB_URL}

#************************************************************************************************
#** Number of database connections to create when the application server is started.
#************************************************************************************************
mxe.db.initialConnections=8

#************************************************************************************************
#** Maximum number of free database connections available in the connection pool.
#************************************************************************************************
mxe.db.maxFreeConnections=8

#************************************************************************************************
#** Minimum number of free database connections needed in the connection pool in
#** order for more connections to be allocated.
#************************************************************************************************
mxe.db.minFreeConnections=5

#************************************************************************************************
#** Number of new connections to be created when the minimum free connections are
#** available in the connection pool.
#************************************************************************************************
mxe.db.newConnectionCount=3

#************************************************************************************************
#** The system install sets the value to: TRANSACTION_READ_COMMITTED.
#************************************************************************************************
mxe.db.transaction_isolation=TRANSACTION_READ_COMMITTED

#************************************************************************************************
#** This value defines the database uppercase function for the system.
#************************************************************************************************
mxe.db.format.upper=UPPER

#************************************************************************************************
#** This value sets the autocommit mode used for the Write connections. Can be
#** either true or false. The default is false.
#************************************************************************************************
mxe.db.autocommit=0

#************************************************************************************************
#** System date format.
#************************************************************************************************
mxe.db.systemdateformat=current timestamp

#************************************************************************************************
#** The database-specific format of the null value function.
#************************************************************************************************
mxe.db.format.nullvalue=COALESCE

#mxe.crontask.donotrun=ALL
EOF

}


function configure_maximo_pae_for_db2 {

  cat > ${MAXIMO_PAE_PROPERTIES} <<EOF
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
mxe.db.password=${MX_DB_PASSWORD}
mxe.db.schemaowner=${MX_DB_SCHEMA}
mxe.db.driver=com.ibm.db2.jcc.DB2Driver
mxe.db.url=jdbc:db2://${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}

Database.Vendor=DB2
Database.DB2.ServerHostName=${MX_DB_HOSTNAME}
Database.DB2.ServerPort=${MX_DB_PORT}
Database.DB2.DatabaseName=${MX_DB_NAME}
EOF
  
  cat >> ${MAXIMO_DB_PROPERTIES} <<EOF02
#************************************************************************************************
#** Database Configuration Parameters
#************************************************************************************************
Database.DB2.ServerHostName=${MX_DB_HOSTNAME}
Database.DB2.ServerPort=${MX_DB_PORT}
Database.DB2.DatabaseName=${MX_DB_NAME}
Database.DB2.Vargraphic=true
Database.DB2.TextSearchEnabled=false
#Database.DB2.DataTablespaceName=${DB_TABLE_SPACE}
#Database.DB2.TempTablespaceName=${DB_TEMP_SPACE}
#Database.DB2.IndexTablespaceName=${DB_INDEX_SPACE}
EOF02

fi

}


function configure_maximo_pae_for_oracle {

  if [ "${MX_DB_SERVICENAME}" != "" ]; then
    ORACLE_DB_URL=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_SERVICENAME}
  else
    ORACLE_DB_URL=jdbc:oracle:thin:@${MX_DB_HOSTNAME}:${MX_DB_PORT}/${MX_DB_NAME}
  fi

  cat > ${MAXIMO_PAE_PROPERTIES} <<EOF
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
mxe.db.driver=oracle.jdbc.OracleDriver
mxe.db.url=${ORACLE_DB_URL}

Database.Vendor=Oracle
Database.Oracle.ServerHostName=${MX_DB_HOSTNAME}
Database.Oracle.ServerPort=${MX_DB_PORT}
Database.Oracle.InstanceName=${MX_DB_NAME}
Database.Oracle.ServiceName=${MX_DB_SERVICENAME}
EOF
  
  cat >> ${MAXIMO_DB_PROPERTIES} <<EOF02
#************************************************************************************************
#** Database Configuration Parameters
#************************************************************************************************
Database.Oracle.ServerHostName=${MX_DB_HOSTNAME}
Database.Oracle.ServerPort=${MX_DB_PORT}
Database.Oracle.InstanceName=${MX_DB_NAME}
Database.Oracle.ServiceName=${MX_DB_SERVICENAME}
Database.DB2.Vargraphic=true
Database.DB2.TextSearchEnabled=false
#Database.DB2.DataTablespaceName=${DB_TABLE_SPACE}
#Database.DB2.TempTablespaceName=${DB_TEMP_SPACE}
#Database.DB2.IndexTablespaceName=${DB_INDEX_SPACE}
EOF02

fi

}


function reconfigure_pae_change_db_password {

  echo "# Run Configuration Tool reconfigurePae.sh"
  echo "# ------------------------------------------------------"
  # https://www.ibm.com/docs/en/mam/7.6.1.2?topic=configuration-command-line-interface-parameters
  /opt/IBM/SMP/ConfigTool/scripts/reconfigurePae.sh -action deployConfiguration -inputfile ${MAXIMO_PAE_PROPERTIES} 
  RC01=$?

  # Check if the command failed
  if [ ${RC01} -ne 0 ]; then
      echo "Command reconfigurePae.sh deployConfiguration failed with return code ${RC01}. Exiting."
      exit ${RC01}
  fi

  /opt/IBM/SMP/ConfigTool/scripts/reconfigurePae.sh -action updateApplication -inputfile ${MAXIMO_DB_PROPERTIES} 
  RC02=$?

  ## Check if the command failed
  #if [ ${RC02} -ne 0 ]; then
  #    echo "Command reconfigurePae.sh updateDatabaseConfiguration failed with return code ${RC02}. Exiting."
  #    exit ${RC02}
  #fi
}

function explode_customization_classes {

  echo "# Exploding Custom Classes "
  echo "# ------------------------------------------------------"
  if [ -f /resources/custom_classes.zip ]; then
      cd /opt/IBM/SMP
      unzip /resources/custom_classes.zip
  fi

}

function build_maximo_ear {

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

}

########################## Main Part of Shell Script ##########################
mkdir -p ${MAXIMO_DIR}/properties
mkdir -p ${MAXIMO_DEPLOY}

if [ "${MX_DB_VENDOR}" = "DB2" ]; then
    configure_maximo_properties_for_db2
    configure_maximo_pae_for_db2

elif [ "${MX_DB_VENDOR}" = "Oracle" ]; then
    configure_maximo_properties_for_oracle
    configure_maximo_pae_for_oracle
fi

explode_customization_classes

#reconfigure_pae_change_db_password

build_maximo_ear