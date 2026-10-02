# Velosaurus - Deployment

Runs the full Velosaurus stack with Docker Compose:

| Service    | Image                                                                                     | URL                                  |
| ---------- | ----------------------------------------------------------------------------------------- | ------------------------------------ |
| `frontend` | [`dasmuesli/velosaurus-frontend`](https://hub.docker.com/r/dasmuesli/velosaurus-frontend) | <http://localhost:3001>              |
| `api`      | [`dasmuesli/velosaurus-backend`](https://hub.docker.com/r/dasmuesli/velosaurus-backend)   | <http://localhost:8000/swagger>      |
| `db`       | `postgres:18`                                                                             | `localhost:5433` (this machine only) |

Ports can be changed in `.env`.

## Run

```shell
cp .env.example .env    # first time only, then set POSTGRES_PASSWORD
docker compose pull     # get newest published images
docker compose up -d
```

- Health: <http://localhost:8000/health>
- Logs: `docker compose logs -f`
- Stop: `docker compose down` (keeps data), `docker compose down -v` (also deletes database)

Pin a specific version by setting `API_TAG` / `FRONTEND_TAG` in `.env` to a commit sha tag from Docker Hub.

## Database

- psql: `docker compose exec db psql -U postgres -d velosaurus`
- Data lives in the `velosaurus_db-data` volume
