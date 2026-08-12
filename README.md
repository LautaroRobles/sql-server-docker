# SQL Server dockerizado

## Requisitos

- Docker
- Justfile

## Levantar el servidor de SQL

```
just deploy
```

## Restaurar la base de datos al backup

```
just restore-backup
```

## Datos para la conexion

- **User**: `sa`
- **Pass**: `Password1234`
- **Database**: `BDD2026`
- **Port**: `1433`

## Apagar server

```
just down
```

## Ver todos los comandos disponibles

```
just
```
