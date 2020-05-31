# Updating Fathom

To update your existing Fathom installation to the latest version, first rename your existing Fathom installation so you can move the new version in its place:

```sh
mv /usr/local/bin/fathom /usr/local/bin/fathom-old
```

Then, [download the latest release from the release page](https://github.com/samuelmeuli/fathom/releases/latest) and place it in `/usr/local/bin`:

```sh
tar -C /usr/local/bin -xzf fathom_$VERSION_$OS_$ARCH.tar.gz
chmod +x /usr/local/bin/fathom
```

If you now run `fathom --version`, you should see that your system is using the latest version.

### Restarting your Fathom web server

To start serving up the updated version of Fathom, you will have to restart the process that is running the web server. If you've followed the [installation instructions](installing-fathom.md), you are using systemd to manage the Fathom process. Run the following command to restart it:

```sh
systemctl restart my-fathom-site
```

Alternatively, kill the running Fathom process by issuing the following command:

```sh
pkill fathom
```
