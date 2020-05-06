# FAQ

- **What data does Fathom track?**

  Fathom tracks no personally identifiable information about your visitors.

  When Fathom tracks a pageview, your visitor is assigned a random string which is used to determine whether it's a unique pageview. If your visitor visits another page on your site, the previous pageview is processed and deleted within one minute. If the visitor leaves your site, the pageview is processed and deleted when the session ends (in 30 minutes).

  If "Do Not Track" is enabled in the browser settings, Fathom will respect that.

- **Fathom is not tracking my pageviews.**

  If you have the tracking snippet in place and Fathom is still not tracking you, most likely you have `navigator.doNotTrack` enabled. Fathom respects your browser's "Do Not Track" setting.

- **Fathom panics when trying to connect to PostgreSQL: `pq: SSL is not enabled on the server`.**

  This usually means that you're running PostgreSQL with SSL disabled. Set the `FATHOM_DATABASE_SSLMODE` config option to remedy this.

  ```conf
  FATHOM_DATABASE_SSLMODE=disable
  ```
