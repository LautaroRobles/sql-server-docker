# SQL Server dockerizado

## Requisitos

- Docker

## Como ejecutar

```
sudo docker compose up -d
```

Ahora te podes conectar usando DataGrip o algun otro gestor de bases de datos.

Poner datos:

- User: sa
- Pass: Password1234 (se puede cambiar en el docker-compose)
- Port: 1433 (tambien se puede cambiar en el docker-compose)

## Ver logs de la base de datos

```
sudo docker logs sql1
```

## Apagar server

```
sudo docker compose down
```
