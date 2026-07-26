pipeline {
    agent any

    options {
        ansiColor('xterm')
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', credentialsId: 'github-credentials', url: 'https://github.com/hyna42/ansible-jenkins.git'
            }
        }
        stage('Ping Ansible') {
            steps {
                sh 'ansible all -m ping'
            }
        }
        stage('Deploy nginx') {
            steps {
                ansiblePlaybook(
                    colorized: true,
                    become: true,
                    inventory: 'hosts.yml',
                    playbook: 'playbook.yml'
                )
            }
        }

        stage('Test JMeter') {
          steps {
            sh '/opt/jmeter/bin/jmeter -n -t tests.jmx -l results.jtl -l results.jtl'
            sh 'cat results.jtl'
            perfReport 'results.jtl'
          }
        }
    }
}
