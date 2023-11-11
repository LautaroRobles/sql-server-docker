# SQL Server dockerizado

## Requisitos

- Docker
- Makefile

## Ejecutar por primera vez

1. En la carpeta `sql` descomprimir el archivo `gd_esquema.Maestra.Table.rar`. El contenido de la carpeta deberia quedar como:
    ```
    sql
    ├─ .gitignore
    ├─ gd_esquema.Maestra.sql
    ├─ gd_esquema.Maestra.Table.rar
    ├─ gd_esquema.Maestra.Table.sql
    └─ gd_esquema.Schema.sql
    ```

2. Iniciar servidor y ejecutar el restore (va a tardar un rato)
    ```
    make start restore-db
    ```

3. La base de datos es persistente, por lo tanto en otros momentos solo ejecutar
    ```
    make start logs
    ```

### Ahora te podes conectar usando DataGrip o algun otro gestor de bases de datos.

Poner datos:

- User: sa
- Pass: Password1234 (se puede cambiar en el docker-compose)
- Port: 1433 (tambien se puede cambiar en el docker-compose)

## Apagar server

```
make stop
```

## Ver todos los comandos disponibles

```
make help
```
