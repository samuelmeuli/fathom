# Installing Fathom

## Install

To install Fathom on your server:

1. [Download the latest Fathom release](https://github.com/samuelmeuli/fathom/releases) suitable for your platform.
2. Extract the archive to `/usr/local/bin`:

```sh
tar -C /usr/local/bin -xzf fathom_$VERSION_$OS_$ARCH.tar.gz
chmod +x /usr/local/bin/fathom
```

3. Confirm that Fathom is installed properly by running `fathom --version`.

_Fathom also provides a Docker image. Read on [here](docker.md) fore details._

## Configuration

> This step is optional. By default, Fathom will use a SQLite database file in the current working directory.

To run the Fathom web server we will need to [configure Fathom](configuration.md) so that it can connect with your database of choice.

Let's create a new directory where we can store our configuration file and SQLite database:

```sh
mkdir ~/my-fathom-site
cd ~/my-fathom-site
```

Then, create a file named `.env` with the following content:

```conf
FATHOM_SERVER_ADDR=9000
FATHOM_GZIP=true
FATHOM_DEBUG=true
FATHOM_DATABASE_DRIVER="sqlite3"
FATHOM_DATABASE_NAME="fathom.db"
FATHOM_SECRET="random-secret-string"
```

If you now run `fathom server`, Fathom will start serving up a website on port 9000 using a SQLite database file named `fathom.db`. If that port is exposed, you should now see your Fathom instance running by browsing to `http://server-ip-address-here:9000`.

Check out the [configuration docs](configuration.md) for all possible options.

## Register your admin user

To register a user in the Fathom instance we just created, run the following command from the directory with your `.env` file:

```sh
fathom user add --email="your@email.com" --password="strong-password"
```

If you would like your dashboard to be public, you can skip this step.

## Using NGINX with Fathom

We recommend using NGINX with Fathom, as it simplifies running multiple sites from the same server and handling SSL certificates with Let's Encrypt.

Create a new file in `/etc/nginx/sites-enabled/my-fathom-site` with the following content. Replace `my-fathom-site.com` with the domain you would like to use for accessing your Fathom installation.

```nginx
server {
	server_name my-fathom-site.com;

	location / {
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $remote_addr;
		proxy_set_header Host $host;
		proxy_pass http://127.0.0.1:9000;
	}
}
```

Test your NGINX configuration and reload NGINX.

```sh
nginx -t
service nginx reload
```

If you now run `fathom server` again, you should be able to access your Fathom installation by browsing to `http://my-fathom-site.com`.

## Automatically starting Fathom on boot

To ensure the Fathom web server keeps running whenever the system reboots, we should use a process manager. Ubuntu 16.04 and later ship with systemd.

Create a new file called `/etc/systemd/system/my-fathom-site.service` with the following content. Replace `$USER` with your actual username and `my-fathom-site` with your site's name:

```conf
[Unit]
Description=Starts the Fathom server
Requires=network.target
After=network.target

[Service]
Type=simple
User=$USER
Restart=always
RestartSec=3
WorkingDirectory=/home/$USER/my-fathom-site
ExecStart=/usr/local/bin/fathom server

[Install]
WantedBy=multi-user.target
```

Reload the systemd configuration and enable your service so Fathom is automatically started whenever the system boots:

```sh
systemctl daemon-reload
systemctl enable my-fathom-site
```

You should now be able to manually start your Fathom web server by issuing the following command:

```sh
systemctl start my-fathom-site
```

## SSL certificate

With [Certbot](https://certbot.eff.org/docs) for Let's Encrypt installed, adding an SSL certificate to your Fathom installation is as easy as running the following command.

```sh
certbot --nginx -d my-fathom-site.com
```

## Content Security Policy

If you use a [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) to specify security policies for your website, Fathom requires the following CSP directives (replace `yourfathom.com` with the URL to your Fathom instance):

```csp
script-src: yourfathom.com;
img-src: yourfathom.com;
```
