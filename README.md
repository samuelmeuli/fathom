# Fathom – Simple Website Analytics

**This is a fork of [Fathom v1](https://github.com/usefathom/fathom) with bug fixes and improvements.**

Fathom is a website analytics tool which respects the privacy of your users and doesn't collect any personally identifiable information. All while giving you the information you need about your site, so you can make smarter decisions about your design and content.

![Screenshot of the Fathom dashboard](assets/src/img/fathom.jpg)

## Usage

You can install Fathom on your server by following [these instructions](docs/installing-fathom.md).

To start tracking, create a site in your Fathom dashboard and copy the tracking snippet to the website(s) you want to track.

## Docs

- **[Installing Fathom](docs/installing-fathom.md)**
- **[Updating Fathom](docs/updating-fathom.md)**
- **[Configuration](docs/configuration.md)**
- [FAQ](docs/faq.md)
- [Fathom with Docker](docs/docker.md)

## Development

### Setup

For getting a development version of Fathom up and running, follow these steps:

1. Ensure you have Go and NPM installed
2. Clone this repository: `git clone https://github.com/samuelmeuli/fathom`
3. In the project directory, run the build command: `make build`
4. Set [custom configuration values](docs/configuration.md) (optional)
5. Register a user account: `./fathom user add --email=<email> --password=<password>`
6. Start the web server with `./fathom server` and visit http://localhost:8080 to access your analytics dashboard

### Contributing

Suggestions and contributions are always welcome! Please discuss larger changes via issue before submitting a pull request.
