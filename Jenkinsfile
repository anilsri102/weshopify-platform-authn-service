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
                git branch: 'deploy',
                    url: 'https://github.com/anilsri102/weshopify-platform-authn-service.git'
                echo "========source code pulling completed========"
            }
        }
        stage("copy the manifest to ansible server"){
            steps{
                echo "Connecting to Ansible Server"
                sshagent(['ANSIBLE_SERVER']){
                    sh 'scp authn-deployment.yml ansible-admin@172.31.0.106:/opt/weshopify-authn-svc-deploy'
                    sh 'scp authn-service.yml ansible-admin@172.31.0.106:/opt/weshopify-authn-svc-deploy'
                    sh 'scp weshopify-autn-svc-deploy-playbook.yml ansible-admin@172.31.0.106:/opt/weshopify-authn-svc-deploy'
                    sh '''
                        ssh -tt ansible-admin@172.31.0.106 << EOF
                            ansible-playbook /opt/weshopify-authn-svc-deploy/weshopify-autn-svc-deploy-playbook.yml
                            exit
                        EOF
                    '''
                }
            }
        }
    }
}
