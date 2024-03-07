pipeline {
    agent any

    environment {
        IP_ADDRESS = 'your_ip_address_here'
        RUN_BUILD_IIM = true
        RUN_BUILD_SMP_7610 = true
        RUN_BUILD_SMP_7613 = true
        RUN_BUILD_ADMWKS = true
        RUN_BUILD_MAXIMOEAR = true
        MX_DB_VENDOR = 'Oracle'
        MX_DB_HOSTNAME = 'orcl.maximo.com'
        MX_DB_PORT = '1521'
        MX_DB_USER = 'maximo'
        MX_DB_PASSWORD = 'passw0rd'
        MX_DB_SCHEMA = 'maximo'
        MX_DB_NAME = 'maxdb.maximo.com'
        MX_APP_VENDOR = 'weblogic'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git 'https://github.com/ebasso/maximo-admwks-container.git'
                }
            }
        }

        stage('Build IBM Installation Manager image') {
            when {
                expression { return env.RUN_BUILD_IIM }
            }
            steps {
                script {
                    dir('maximo-admwks-container/ibm-im') {
                        sh 'podman build -t maximo-admwks/ibm-im:1.9 --build-arg url="http://${IP_ADDRESS}" .'
                    }
                }
            }
        }
        stage('Build IBM Maximo FixPack 7.6.1') {
            when {
                expression { return env.RUN_BUILD_SMP_7610 }
            }
            steps {
                script {
                    dir('maximo-admwks-container/maximo-smp') {
                        sh 'podman build -t maximo-admwks/maximo-smp-fp:7.6.1.0 --build-arg url="http://${IP_ADDRESS}" .'
                    }
                }
            }
        }

        stage('Build IBM Maximo FixPack 7.6.1.3') {
            when {
                expression { return env.RUN_BUILD_SMP_7613 }
            }
            steps {
                script {
                    dir('maximo-admwks-container/maximo-smp-7613') {
                        sh 'podman build -t maximo-admwks/maximo-smp-fp:7.6.1.3 --build-arg url="http://${IP_ADDRESS}" .'
                    }
                }
            }
        }

        stage('Build IBM Maximo 7.6.1.3 with IFIX') {
            when {
                expression { return env.RUN_BUILD_SMP_7613 }
            }
            steps {
                script {
                    dir('maximo-admwks-container/maximo-smp-7613') {
                        sh 'podman build -t maximo-admwks/maximo-smp:7.6.1.3 --build-arg url="http://${IP_ADDRESS}" --build-arg ifix=20230914-0042 --build-arg mam_ifix_image=TPAE_7613_IFIX.20230914-0042.im.zip .'
                    }
                }
            }
        }

        stage('Build IBM Maximo Administrative Workstation') {
            when {
                expression { return env.RUN_BUILD_ADMWKS }
            }
            steps {
                script {
                    dir('maximo-admwks-container/maximo-admwks') {
                        sh 'podman build -t maximo-admwks/maximo-admwks:1.0 .'
                    }
                }
            }
        }

        stage('Build maximo.ear') {
            when {
                expression { return env.RUN_BUILD_MAXIMOEAR }
            }
            steps {
                script {
                    dir('maximo-admwks-container/maximo-admwks/resources') {
                        sh "podman run -it --rm -v $(pwd):/resources -e MX_DB_VENDOR=${MX_DB_VENDOR} -e MX_DB_HOSTNAME=${MX_DB_HOSTNAME} -e MX_DB_PORT=${MX_DB_PORT} -e MX_DB_USER=${MX_DB_USER} -e MX_DB_PASSWORD=${MX_DB_PASSWORD} -e MX_DB_SCHEMA=${MX_DB_SCHEMA} -e MX_DB_NAME=${MX_DB_NAME} -e MX_APP_VENDOR=${MX_APP_VENDOR} maximo-admwks/maximo-admwks:1.0"
                    }
                }
            }
        }
    }
}
