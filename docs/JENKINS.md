# Jenkins Contract

Jenkins is the only system allowed to promote validated changes into shared `DEV`.

## Pipeline Responsibilities
- Export and verify the SQLcl project against shared `DEV`.
- Build the next release artifact from shared `DEV`.
- Apply the artifact to `TEST`.
- Run utPLSQL and Playwright in the validation stage.

## Expected Inputs
- SQLcl connections for `DEV`, `VALIDATION`, and `TEST`, either as saved connection names or raw connect strings.
- The SQLcl versions defined in `apex-bootstrap-workflow.yaml`.
- Credentials and agent-neutral repository files committed with the project.
