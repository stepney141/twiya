const puppeteer = require("puppeteer");
require("dotenv").config();

const user_name = process.env.TWITTER_ACCOUNT;
const password = process.env.TWITTER_PASSWORD;

(async () => {
  const browser = await puppeteer.launch({
    defaultViewport: {
      width: 1024,
      height: 749,
    },
    headless: false,
    slowMo: 50,
  });
  const page = await browser.newPage();

  // open twitter
  await page.goto("https://twitter.com/login", {
    waitUntil: "networkidle2",
  });

  // Login
  await page.type('input[name="session[username_or_email]"]', user_name);
  await page.type('input[name="session[password]"]', password);
  page.click('div[role="button"]');

  // wait until the page is loaded
  await page.waitForNavigation({
    timeout: 60000,
    waitUntil: "networkidle2",
  });

  await page.screenshot({ path: "test.png" });

  const networkLogs = [];
  page.on("request", (request) => {
    networkLogs.push({
      ts: Date.now(),
      network: "request",
      url: request.url(),
    });
  });
  page.on("response", (response) => {
    networkLogs.push({
      ts: Date.now(),
      network: "response",
      url: response.url(),
    });
  });

  await browser.close();

  console.log(networkLogs);
})();
