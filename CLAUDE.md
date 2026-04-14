# APEX Bootstrap Project

An Oracle SQLcl project template for bootstrapping new Oracle APEX + database projects.

## Project Structure

```
.dbtools/                     # SQLcl project configuration
  project.config.json         # Project settings (schema, export config, git config)
  project.sqlformat.xml       # SQL formatting rules
  filters/project.filters     # Object export filters
src/database/dimi/      # Database source objects
  tables/                     # Table DDL
  views/                      # View definitions (including JSON duality views)
  indexes/                    # Index definitions
  ref_constraints/            # Foreign key constraints
  sequences/                  # Sequences
  triggers/                   # Triggers
  functions/                  # Standalone functions
  procedures/                 # Standalone procedures
  package_specs/              # Package specifications
  package_bodies/             # Package bodies
  type_specs/                 # Type specifications
  type_bodies/                # Type bodies
  synonyms/                   # Synonyms
  materialized_views/         # Materialized views
  mle_modules/                # MLE (JavaScript) modules
  mle_envs/                   # MLE environments
  ords/                       # ORDS REST module definitions
  aq_queue_tables/            # Advanced Queue tables
  aq_queues/                  # Advanced Queues
  apex_apps/                  # APEX application exports
dist/                         # Build artifacts (empty)
```

## Key Configuration

- **Project name**: `dimi`
- **Schema**: `DIMI`
- **SQLcl version**: 25.3.2.0
- **Connection**: `local-26ai-dimi`
- **APEX export formats**: `READABLE_YAML` and `APPLICATION_SOURCE`
- **Stage format**: Liquibase changesets
- **SQL formatting**: lowercase keywords and identifiers, 4-space indent, 128 char line width

## Skills

This project uses three Claude Code skills (see `skills-lock.json`):

- **apex** (`avhrst/apex-component-modifier`) — Export/patch/import APEX components via SQLcl. Use with `/apex`.
- **sqlcl** (`avhrst/apex-component-modifier`) — Work with Oracle Database and APEX via SQLcl MCP. Use with `/sqlcl`.
- **oracle-db-skills** (`krisrice/oracle-db-skills`) — Oracle Database reference guides.

## Conventions

- All SQL files use lowercase keywords and identifiers (per `.dbtools/project.sqlformat.xml`)
- Schema name is not emitted in DDL (`emitSchema: false`)
- Constraints are exported as ALTER statements (`constraintsAsAlter: true`)
- Liquibase internal tables are filtered from exports (see `project.filters`)
- Example files for each object type are documented in `src/database/dimi/README.md`
