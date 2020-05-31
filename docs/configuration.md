# Configuration

All configuration in Fathom is optional. If you supply no configuration values, Fathom will default to using a SQLite database in the current working directory.

If you're already running MySQL or PostgreSQL on your server, you'll most likely want to use one of those as your database driver. To do so, either create a `.env` file in the working directory of your Fathom application or point Fathom to your configuration file by specifying the `--config` flag when starting Fathom:

```sh
fathom --config=/path/to/fathom.env server
```

The default configuration looks like this:

```conf
FATHOM_GZIP=true
FATHOM_DEBUG=true
FATHOM_DATABASE_DRIVER="sqlite3"
FATHOM_DATABASE_NAME="fathom.db"
FATHOM_DATABASE_USER=""
FATHOM_DATABASE_PASSWORD=""
FATHOM_DATABASE_HOST=""
FATHOM_DATABASE_SSLMODE=""
FATHOM_SECRET="random-secret-string"
```

### Accepted values and defaults

| Name | Default | Description |
| :-- | :-- | :-- |
| `FATHOM_DEBUG` | `false` | If set to `true`, Fathom will output more log messages. |
| `FATHOM_SERVER_ADDR` | `:8080` | The server address to listen on. |
| `FATHOM_GZIP` | `false` | If set to `true`, HTTP content will be gzipped. |
| `FATHOM_DATABASE_DRIVER` | `sqlite3` | The database driver to use: `sqlite3`, `mysql` or `postgres`. |
| `FATHOM_DATABASE_NAME` |  | The name of the database to connect to. For SQLite3, this is the path to the database file. |
| `FATHOM_DATABASE_USER` |  | Database username. |
| `FATHOM_DATABASE_PASSWORD` |  | Database password. |
| `FATHOM_DATABASE_HOST` |  | Database host. |
| `FATHOM_DATABASE_SSLMODE` |  | For a list of valid values, look [here for PostgreSQL](https://www.postgresql.org/docs/9.1/static/libpq-ssl.html#LIBPQ-SSL-PROTECTION) and [here for MySQL](https://github.com/Go-SQL-Driver/MySQL/#tls). |
| `FATHOM_DATABASE_URL` |  | Can be used to specify the connection string for your database, as an alternative to the previous five options. |
| `FATHOM_SECRET` |  | Random string used for signing session cookies. |

When using `FATHOM_DATABASE_URL` to manually specify your database connection string, there are a few important things to consider.

- When using MySQL, include `?parseTime=true&loc=Local` in your DSN.
- When using SQLite, include `?_loc=auto` in your DSN.

Examples of valid values:

```conf
FATHOM_DATABASE_DRIVER=mysql
FATHOM_DATABASE_URL=root:@tcp/fathom1?loc=Local&parseTime=true
```
