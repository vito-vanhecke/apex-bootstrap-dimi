# Workflow

## Environment Model
- Shared `DEV` is the integration source of truth.
- Shared `TEST` is synchronized from the artifact created in `DEV`.
- Personal local `DEV` is refreshed from shared `DEV`.
- Branch work happens in isolated PDB clones created from the current shared `DEV` state.
- Validation uses a fresh validation PDB cloned from shared `DEV`.

## Daily Flow
1. Refresh the repository from shared `DEV` with `./scripts/workflow/sync-dev.sh`.
2. Refresh personal local data from the shared baseline when required.
3. Create a feature branch and matching isolated PDB.
4. Export branch changes back into the SQLcl project and APEX source.
5. Apply the branch artifact to a fresh validation PDB.
6. Run utPLSQL and Playwright before merge.
7. Let Jenkins promote validated work into shared `DEV`.
8. Generate the `TEST` artifact from `DEV` and deploy it through Jenkins.

## SQLcl Version Rules
- Use SQLcl `25.3.2.317.1117` while bootstrapping local APEX instances.
- Use SQLcl `26.1.0.086.1709` for SQLcl `project` commands.

## Project Defaults
- Project name: `dimi`
- Schema: `DIMI`
- APEX workspace: `DIMI`
- Default branch: `main`
- DEV connection: `${DEV_SQLCL}`
- TEST connection: `${TEST_SQLCL}`
- Validation connection: `${VALIDATION_SQLCL}`
