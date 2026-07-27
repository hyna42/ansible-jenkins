pipeline {
    agent any

    options {
        ansiColor('xterm')
    }

    stages {
        stage('Ping Ansible') {
            steps {
                sh 'ansible all -m ping'
            }
        }

        stage('Test JMeter') {
          steps {
            sh '/opt/jmeter/bin/jmeter -n -t tests.jmx -l results.jtl -j /tmp/jmeter.log'
            sh 'cat results.jtl'
            perfReport 'results.jtl'
          }
        }
    }
}
