# Jenkins Contract

Jenkins is the only system allowed to promote validated changes into shared `DEV`.

## Pipeline Responsibilities
- Invoke the standalone `apex-bootstrap-workflow` CLI to create validation PDBs, validate, promote, and deploy.
- Generate an artifact from the merged repository state and deploy it into shared `DEV`.
- Re-export and verify the SQLcl project against shared `DEV`.
- Build the next release artifact from shared `DEV`.
- Apply the artifact to `TEST`.
- Run utPLSQL and Playwright in the validation stage.

## Expected Inputs
- The standalone `apex-bootstrap-workflow` binary available on the Jenkins agent `PATH`.
- Runtime environment variables or saved SQLcl connections that satisfy the values referenced by `apex-bootstrap-workflow.yaml`.
- The SQLcl versions defined in `apex-bootstrap-workflow.yaml`.
- Credentials and agent-neutral repository files committed with the project.
