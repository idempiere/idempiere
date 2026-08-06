// ============================================================
//  Pipeline CI/CD — iDempiere release-12
//  Repo  : https://github.com/idempiere/idempiere
//  Infra : Jenkins :8080 | SonarQube :9000 | Docker Hub germain24/
// ============================================================

pipeline {

    agent any

    // ── Paramètres ────────────────────────────────────────────
    parameters {
        booleanParam(
            name        : 'SKIP_MAVEN_BUILD',
            defaultValue: false,
            description : 'Sauter le build Maven (pour tester les stages Docker uniquement)'
        )
        booleanParam(
            name        : 'DEPLOY',
            defaultValue: false,
            description : 'Activer le déploiement (désactivé tant que le serveur cible n\'est pas défini)'
        )
        string(
            name        : 'DEPLOY_HOST',
            defaultValue: '192.168.2.183',
            description : 'IP ou hostname du serveur de déploiement'
        )
    }

    // ── Variables globales ────────────────────────────────────
    environment {
        // SCM — repo public, pas de credentials
        REPO_URL    = 'https://github.com/idempiere/idempiere'
        BRANCH      = 'release-12'

        // Docker Hub
        IMAGE_NAME  = 'germain24/idempiere-release12'
        IMAGE_TAG   = "${BUILD_NUMBER}"
        IMAGE_FULL  = "germain24/idempiere-release12:${BUILD_NUMBER}"
        IMAGE_LATEST= 'germain24/idempiere-release12:latest'

        // SonarQube
        SONAR_PROJECT_KEY = 'idempiere-release12'

        // Déploiement
        DEPLOY_USER = 'isnov-promote'
        DEPLOY_DIR  = '/home/isnov-promote/idempiere-release12'
    }

    // ── Options ───────────────────────────────────────────────
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 120, unit: 'MINUTES')   // build iDempiere peut être long
        disableConcurrentBuilds()
    }

    // ── Stages ───────────────────────────────────────────────
    stages {

        // ── 1. Checkout ──────────────────────────────────────
        stage('Checkout') {
            steps {
                echo "==> Checkout iDempiere ${BRANCH}"
                git url: "${REPO_URL}",
                    branch: "${BRANCH}"
                    // Pas de credentials : repo public GitHub
            }
        }

        // ── 2. SonarQube Analysis ────────────────────────────
        stage('SonarQube Analysis') {
            steps {
                echo "==> Analyse SonarQube"
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                            -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                            -Dsonar.projectName='iDempiere Release-12' \
                            -Dsonar.java.source=11 \
                            -DskipTests=true \
                            --batch-mode \
                            --no-transfer-progress
                    """
                }
            }
        }

        // ── 3. Quality Gate ──────────────────────────────────
        stage('Quality Gate') {
            steps {
                echo "==> Attente du Quality Gate SonarQube"
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        // ── 4. Trivy FS Scan ─────────────────────────────────
        stage('Trivy FS Scan') {
            steps {
                echo "==> Scan Trivy filesystem (secrets + vulnérabilités)"
                sh """
                    trivy fs . \
                        --exit-code 1 \
                        --severity HIGH,CRITICAL \
                        --scanners vuln,secret \
                        --format table \
                        --no-progress \
                        --timeout 10m \
                        2>&1 | tee trivy-fs-report.txt || true
                """
                // 'true' en fin : ne bloque pas le pipeline sur FS scan
                // Ajuste exit-code à 1 si tu veux bloquer sur CRITICAL
            }
        }

        // ── 5. Maven Build ───────────────────────────────────
        stage('Maven Build') {
            when {
                expression { !params.SKIP_MAVEN_BUILD }
            }
            steps {
                echo "==> Build Maven iDempiere (peut durer 30-60 min)"
                sh """
                    mvn clean verify \
                        -DskipTests=false \
                        --batch-mode \
                        --no-transfer-progress \
                        -Dmaven.test.failure.ignore=false
                """
                // Les tests unitaires iDempiere tournent ici
                // Pas de tests d'intégration (pas de DB éphémère pour l'instant)
            }
            post {
                always {
                    // Publier les résultats de tests JUnit si présents
                    junit allowEmptyResults: true,
                          testResults: '**/target/surefire-reports/*.xml'
                }
            }
        }

        // ── 6. Docker Build ──────────────────────────────────
        stage('Docker Build') {
            steps {
                echo "==> Build image Docker ${IMAGE_FULL}"
                sh """
                    docker build \
                        --build-arg BUILD_NUMBER=${BUILD_NUMBER} \
                        --build-arg BRANCH=${BRANCH} \
                        -t ${IMAGE_FULL} \
                        -t ${IMAGE_LATEST} \
                        -f Dockerfile \
                        .
                """
            }
        }

        // ── 7. Trivy Image Scan ──────────────────────────────
        stage('Trivy Image Scan') {
            steps {
                echo "==> Scan Trivy image Docker"
                sh """
                    trivy image \
                        --exit-code 1 \
                        --severity CRITICAL \
                        --format table \
                        --no-progress \
                        --timeout 10m \
                        ${IMAGE_FULL} \
                        2>&1 | tee trivy-image-report.txt
                """
                // Bloque sur CRITICAL uniquement (exit-code 1)
            }
        }

        // ── 8. Push Docker Hub ───────────────────────────────
        stage('Push Docker Hub') {
            steps {
                echo "==> Push ${IMAGE_FULL} vers Docker Hub"
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
                        docker push ${IMAGE_FULL}
                        docker push ${IMAGE_LATEST}
                        docker logout
                    """
                }
            }
        }

        // ── 9. Deploy ────────────────────────────────────────
        stage('Deploy') {
            when {
                expression { params.DEPLOY == true }
            }
            steps {
                echo "==> Déploiement sur ${params.DEPLOY_HOST}"
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'deploy-ssh-key',
                        keyFileVariable: 'SSH_KEY'
                    ),
                    string(
                        credentialsId: 'db-password',
                        variable     : 'DB_PASS'
                    )
                ]) {
                    // Copier docker-compose.yml sur le serveur cible
                    sh """
                        scp -i ${SSH_KEY} \
                            -o StrictHostKeyChecking=no \
                            docker-compose.yml \
                            ${DEPLOY_USER}@${params.DEPLOY_HOST}:${DEPLOY_DIR}/docker-compose.yml
                    """

                    // Générer le .env et déployer
                    sh """
                        ssh -i ${SSH_KEY} \
                            -o StrictHostKeyChecking=no \
                            ${DEPLOY_USER}@${params.DEPLOY_HOST} << 'ENDSSH'

                            set -e
                            cd ${DEPLOY_DIR}

                            # Générer le .env (sans exposer le mot de passe dans les logs)
                            cat > .env << EOF
IMAGE_NAME=${IMAGE_FULL}
DB_HOST=localhost
DB_PORT=5444
DB_NAME=idempiere
DB_USER=adempiere
DB_PASSWORD=${DB_PASS}
APP_PORT=8099
EOF

                            echo "==> .env généré :"
                            grep -v PASSWORD .env

                            # Pull + redémarrage
                            docker compose pull
                            docker compose up -d --remove-orphans

ENDSSH
                    """
                }
            }
        }

        // ── 10. Health Check ─────────────────────────────────
        stage('Health Check') {
            when {
                expression { params.DEPLOY == true }
            }
            steps {
                echo "==> Health Check iDempiere"
                sh """
                    sleep 30
                    curl --retry 5 \
                         --retry-delay 15 \
                         --retry-connrefused \
                         -f \
                         http://${params.DEPLOY_HOST}:8099/webui/index.zul \
                    && echo "==> iDempiere UP" \
                    || (echo "==> iDempiere ne répond pas" && exit 1)
                """
            }
        }

    }

    // ── Post-actions ──────────────────────────────────────────
    post {
        success {
            echo "==> Pipeline terminé avec succès — image : ${IMAGE_FULL}"
        }
        failure {
            echo "==> Pipeline en échec — consulter les logs ci-dessus"
        }
        always {
            // Archiver les rapports Trivy
            archiveArtifacts artifacts: 'trivy-*.txt',
                             allowEmptyArchive: true

            // Nettoyer les images locales pour économiser l'espace disque
            sh """
                docker rmi ${IMAGE_FULL} ${IMAGE_LATEST} || true
                docker image prune -f || true
            """
            cleanWs()
        }
    }

}
