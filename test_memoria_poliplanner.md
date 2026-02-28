Puedes simular bastante bien el entorno de Fly.io usando Docker local, porque Fly corre
contenedores con cgroups estrictos de CPU y memoria.
La clave es **forzar los mismos límites y el mismo modelo de concurrencia**, y luego **estresar
el proceso**.

Primero, limita recursos del contenedor.
Docker usa cgroups igual que Fly.

Ejemplo directo con `docker run`:

```
docker run \
  --memory=256m \
  --memory-swap=256m \
  --cpus=1 \
  --pids-limit=128 \
  -p 8080:8080 \
  tu-imagen
```

Equivalencias importantes con Fly:

* `--memory` ≈ `memory_mb`
* `--cpus` ≈ `cpus`
* `--memory-swap=memory` evita swap (Fly no da swap)
* `--pids-limit` simula el límite de procesos/hilos

Si usas `docker-compose`:

```
services:
  app:
    image: tu-imagen
    deploy:
      resources:
        limits:
          cpus: "1.0"
          memory: 256M
```

Segundo, simula presión real de memoria.
Muchos servicios “funcionan” hasta que el kernel empieza a matar procesos.

Para ver comportamiento OOM real:

* usa `--oom-kill-disable=false` (default)
* revisa `dmesg | grep -i oom`
* observa si tu proceso recibe SIGKILL (Fly hace lo mismo)

Tercero, controla concurrencia como en Fly.
Fly no protege tu app de sobrecarga; si aceptas demasiadas requests simultáneas, te matas solo.

En Go, por ejemplo:

* limita `GOMAXPROCS` al número de CPUs asignadas
* usa pools o semáforos para requests concurrentes
* evita goroutines sin límite

Ejemplo:

```
GOMAXPROCS=1 ./app
```

Cuarto, estresa la app correctamente.
No sirve curl manual.

Herramientas:

* `wrk` / `wrk2` para HTTP
* `hey` para cargas simples
* `ab` solo si no tienes otra cosa

Ejemplo:

```
wrk -t2 -c100 -d60s http://localhost:8080
```

Sube concurrencia hasta que:

* latencia se dispara
* RSS crece sin bajar
* el proceso muere por OOM

Quinto, monitorea como lo hace Fly.
Dentro del contenedor:

```
cat /sys/fs/cgroup/memory.current
cat /sys/fs/cgroup/cpu.stat
```

Eso es exactamente lo que Fly ve.

Sexto, replica el arranque y shutdown.
Fly mata instancias agresivamente.

Verifica:

* que tu app responda a SIGTERM en < 5s
* que no asuma memoria “caliente” persistente
* que arranque rápido bajo CPU limitada

Séptimo, simula múltiples instancias.
Fly escala horizontal, no vertical.

Levanta varias copias:

```
docker run ... -p 8081:8080 tu-imagen
docker run ... -p 8082:8080 tu-imagen
```

Y balancea con nginx o `wrk` apuntando a varias.

Limitaciones de la simulación:

* no replicas exactamente el scheduler de Fly
* no replicas cold starts reales
* red y latencia son más “limpias”

Pero para **detectar OOM, leaks, mal manejo de concurrencia y saturación de CPU**, esto es
prácticamente equivalente.

Si quieres, dime:

* lenguaje y runtime
* memoria/cpus objetivo de Fly
* tipo de carga (CPU-bound, IO, streaming)

Y te doy un setup de stress específico.
