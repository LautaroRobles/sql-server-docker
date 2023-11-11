# Detecto si docker se debe ejecutar con sudo o sin sudo
ifneq (,$(findstring docker,$(shell groups $$USER)))
    docker = docker
else
    docker = sudo docker
endif

default: help

#- Deploy -#

#: Iniciar servidor
start:
	$(docker) compose up -d

#: Detener servidor
stop:
	$(docker) compose down

#: Mostrar logs servidor
logs:
	$(docker) logs sql1 --follow

#: Ejecutar terminal dentro del servidor sql
terminal:
	$(docker) exec -it sql1 bash

#: Restaurar la base de datos con los datos de /sql
restore-db:
	$(docker) exec sql1 ./restore-db.sh

#- Ayuda -#

#: Mostrar listado de comandos disponibles
help: SHELL:=/bin/bash
help:
	@linea_horizontal=$$(eval printf '%.0s-' {1..$$(tput cols)}); \
    export linea_horizontal; \
	sed '1s;^;\n;' Makefile \
	| perl -pe 's/#[^:^-](.*)\n//g' \
	| grep -zoP "((\n#:.*)+\n[^:]+:|\n#-(.*)-#)" \
	| perl -pe 's/\0/\n/g' \
	| perl -0777 -pe 's/((#: (.*)\n)+)(.*):/ make $$4$$1\n/g' \
	| perl -0777 -pe 's/\n#: /\n|||/g' \
	| perl -0777 -pe 's/#: /|||/g' \
    | column --table \
    		 --separator '|||' \
    		 --output-width $$(tput cols) \
    		 --table-columns C1,C2,C3,C4 \
    		 --table-hide C2,C3 \
             --table-wrap C4 \
			--table-noheadings \
	| perl -0777 -pe 's/-#(\s*)\n#-/\n/g' \
	| perl -0777 -pe 's/#-([^-#]*)-#(\s*)\n/$$ENV{linea_horizontal}\n$$1\n$$ENV{linea_horizontal}\n/g' \

# Eliminar mensaje de "target" not found
%:
	@: