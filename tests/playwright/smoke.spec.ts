import { expect, test } from '@playwright/test';

const baseUrl =
  process.env.PLAYWRIGHT_BASE_URL ||
  'http://localhost:8181/ords/';

test('APEX sign-in page is reachable', async ({ page }) => {
  const response = await page.goto(baseUrl, { waitUntil: 'domcontentloaded' });

  expect(response).not.toBeNull();
  expect([200, 302]).toContain(response!.status());
  await expect(page.locator('body')).toContainText(/Oracle APEX|Workspace|Sign In/i);
});
