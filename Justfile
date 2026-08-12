# Si un usuario no esta en el grupo de docker debe usar `sudo docker`
docker := if `groups` =~ "docker" { "docker" } else { "sudo -E docker" }

# Al ejecutar `just` sin comandos muestra el listado de comandos disponibles
_default:
    @just --list --unsorted

# Iniciar servidor
deploy:
	{{docker}} compose up -d

# Detener servidor
down:
	{{docker}} compose down

# Mostrar logs servidor
logs:
	{{docker}} logs sql1 --follow

# Ejecutar terminal dentro del servidor sql
terminal:
	{{docker}} exec -it sql1 bash

# Restaurar la base de datos al backup
restore-backup:
	{{docker}} exec sql1 /usr/scripts/restore-backup.sh