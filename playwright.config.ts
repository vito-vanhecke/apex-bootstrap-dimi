import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests/playwright',
  timeout: 30_000,
  use: {
    baseURL:
      process.env.PLAYWRIGHT_BASE_URL ||
      'http://localhost:8181/ords/',
    trace: 'retain-on-failure',
  },
});
