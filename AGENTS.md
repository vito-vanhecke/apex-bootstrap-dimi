# Agents

## Database Object Development

When creating or modifying database objects:

1. Place SQL files in the correct subdirectory under `src/database/dimi/` based on object type
2. Follow the naming and formatting conventions shown in `src/database/dimi/README.md`
3. Always qualify objects with the `dimi` schema prefix
4. Use lowercase for all keywords and identifiers
5. End PL/SQL blocks with `/` on its own line

## APEX Development

Use the `/apex` skill for exporting, patching, and importing APEX components.
Use the `/sqlcl` skill for running SQL, inspecting schemas, and managing the database via SQLcl MCP.

APEX app source lives in `src/database/dimi/apex_apps/`.

## SQLcl Project Commands

This is a SQLcl project. Key commands:

- `project export` — Export database objects to `src/`
- `project stage` — Generate Liquibase changesets from source changes
- `project release` — Create a versioned release artifact in `dist/`

## Object Type Reference

| Directory            | Object Type           |
|----------------------|-----------------------|
| `tables/`            | Tables                |
| `views/`             | Views (incl. duality) |
| `indexes/`           | Indexes               |
| `ref_constraints/`   | Foreign keys          |
| `sequences/`         | Sequences             |
| `triggers/`          | Triggers              |
| `functions/`         | Functions             |
| `procedures/`        | Procedures            |
| `package_specs/`     | Package specs         |
| `package_bodies/`    | Package bodies        |
| `type_specs/`        | Type specs            |
| `type_bodies/`       | Type bodies           |
| `synonyms/`          | Synonyms              |
| `materialized_views/`| Materialized views    |
| `mle_modules/`       | MLE JS modules        |
| `mle_envs/`          | MLE environments      |
| `ords/`              | ORDS REST modules     |
| `aq_queue_tables/`   | AQ queue tables       |
| `aq_queues/`         | AQ queues             |
| `apex_apps/`         | APEX applications     |
