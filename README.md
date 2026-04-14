# apex-bootstrap-dimi

Oracle APEX and Oracle Database workflow repository for the `dimi` project.

## Source of Truth
Shared `DEV` is authoritative. Git and the SQLcl project are the audited projection of that state.

## Core Commands
- `./scripts/workflow/sync-dev.sh` re-syncs the repository from shared DEV.
- `./scripts/workflow/promote-dev.sh [version] [artifact.zip]` generates or reuses an artifact and deploys it into shared DEV.
- `./scripts/workflow/release-artifact.sh <version>` creates the release artifact from DEV.
- `./scripts/workflow/deploy-test.sh [artifact.zip]` deploys the artifact into TEST.
- `./scripts/validation/run_utplsql.sh` runs database validation.
- `./scripts/validation/run_playwright.sh` runs APEX end-to-end validation.

## Contract
- Root `AGENTS.md` and `CLAUDE.md` describe the workflow in agent-readable form.
- The committed `.agents/skills/` directory carries the default `apex`, `sqlcl`, and `oracle-db-skills` skill content.
- `apex-bootstrap-workflow.yaml` records the environment, command, and promotion contract for this project.
