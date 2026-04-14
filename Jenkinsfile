pipeline {
  agent any

  environment {
    WORKFLOW_CLI = 'apex-bootstrap-workflow'
  }

  stages {
    stage('Validate Branch') {
      steps {
        sh '''
          "$WORKFLOW_CLI" --config apex-bootstrap-workflow.yaml validate \
            --repo . \
            --branch "${BRANCH_NAME:-validation}" \
            --create-validation-pdb
        '''
      }
    }

    stage('Promote DEV') {
      when {
        branch 'main'
      }
      steps {
        sh '''
          "$WORKFLOW_CLI" --config apex-bootstrap-workflow.yaml promote-dev \
            --repo . \
            --version "${BUILD_NUMBER}"
        '''
        sh '''
          "$WORKFLOW_CLI" --config apex-bootstrap-workflow.yaml project sync-dev \
            --repo .
        '''
      }
    }

    stage('Release Artifact') {
      when {
        branch 'main'
      }
      steps {
        sh '''
          "$WORKFLOW_CLI" --config apex-bootstrap-workflow.yaml release \
            --repo . \
            --version "${BUILD_NUMBER}"
        '''
      }
    }

    stage('Deploy TEST') {
      when {
        branch 'main'
      }
      steps {
        sh '''
          "$WORKFLOW_CLI" --config apex-bootstrap-workflow.yaml deploy-test \
            --repo .
        '''
      }
    }
  }
}
