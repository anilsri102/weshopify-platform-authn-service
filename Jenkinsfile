pipeline{
    agent{
        label "worker-01-jenkins"
    }
    tools{
        maven 'MAVEN_HOME'
    }
    stages{
        stage("Pull the Code From SCM"){
            steps{
                echo "========Pull the Code From SCM========"
                git branch: 'master',
                    url: 'https://github.com/anilsri102/weshopify-platform-authn-service.git'
                echo "========source code pulling completed========"
            }
        }
        stage("Build the Source Code"){
            steps{
                echo "========Code Building is Starting========"
                sh 'mvn clean package -DskipTests=true'
                echo "========Artifact Generated========"
            }
        }
        stage("Sonar Quality Analysis"){
            steps{
                echo "========Sonar Quality Gate Starting========"
                sh 'mvn verify sonar:sonar -Dsonar.projectKey=weshopify-platform-authn-service -Dsonar.projectName=weshopify-platform-authn-service -Dsonar.host.url=http://3.109.8.134:9000 -Dsonar.token=sqp_26b6c07b2cb0165bbb7f5157e4473a8bfb66778f -DskipTests=true'
                echo "========Sonar Quality Gate Analyzed the Artifact========"
            }
        }
        stage("Deploy to Artifactory"){
            steps{
                echo "========Deploying to Artifactory Started========"
                sh 'mvn deploy -DskipTests=true'
                echo "========Artifact Deploy is Completed========"
            }
        }
        stage("copy the files to ansible server"){
            steps{
                echo "Connecting to Ansible Server"
                sshagent(['ANSIBLE_SERVER']){
                    sh 'scp Dockerfile ansible-admin@172.31.0.106:/opt/weshopify-authn-svc'
                    sh 'scp weshopify-autn-svc-playbook.yml ansible-admin@172.31.0.106:/opt/weshopify-authn-svc'
                    sh 'scp jfrog.sh ansible-admin@172.31.0.106:/opt/weshopify-authn-svc'
                    sh '''
                        ssh -tt ansible-admin@172.31.0.106 << EOF
                            ansible-playbook /opt/weshopify-authn-svc/weshopify-autn-svc-playbook.yml
                            exit
                        EOF
                    '''
                }
            }
        }
      
    }
}
