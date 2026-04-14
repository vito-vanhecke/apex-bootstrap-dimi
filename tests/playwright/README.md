# Playwright

The validation script bootstraps `@playwright/test` locally when needed and then runs the placeholder APEX smoke test. Replace the placeholder test with project-specific APEX coverage.

Suggested bootstrap:

```bash
npm install --no-fund --no-audit --no-package-lock
./scripts/validation/run_playwright.sh
```
