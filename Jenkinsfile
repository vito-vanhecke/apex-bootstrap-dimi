pipeline {
  agent any

  environment {
    DEV_CONNECTION = 'DEV'
    VALIDATION_CONNECTION = 'VALIDATION'
    TEST_CONNECTION = 'TEST'
    PROJECT_SCHEMA = 'DIMI'
  }

  stages {
    stage('Sync DEV') {
      steps {
        sh './scripts/workflow/sync-dev.sh'
      }
    }

    stage('Database Validation') {
      steps {
        sh './scripts/validation/run_utplsql.sh'
      }
    }

    stage('APEX Validation') {
      steps {
        sh './scripts/validation/run_playwright.sh'
      }
    }

    stage('Release Artifact') {
      when {
        branch 'main'
      }
      steps {
        sh './scripts/workflow/release-artifact.sh "${BUILD_NUMBER}"'
      }
    }

    stage('Deploy TEST') {
      when {
        branch 'main'
      }
      steps {
        sh './scripts/workflow/deploy-test.sh'
      }
    }
  }
}
