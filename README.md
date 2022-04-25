# PongSensor

Proyecto de Creando interfaces de usuario, asignatura de la ULPGC (Universidad de Las Palmas de Gran Canaria) hecho por **Álvaro Javier Afonso López y Victor Sánchez**

### Introducción

Esta práctica es una mejora de la práctica Pong, disponible en este perfil. Dicha mejora consiste en añadir otro modo de control con un sensor, el cual mide la distancia hasta el objeto
que tiene delante, lo que nos permite controlar los elementos con los gestos.

![Alt Text](https://github.com/AlvaroAfonso/Pong/blob/main/export.gif)

Nota: La velocidad del gif no coincide con la velocidad mientras se juega realmente.

### Desarrollo
Como ya se ha dicho, partimos de la práctica mencionada, pero para introducir el manejo de sensores se ha necesitado usar Arduino, el cual simplemente lee los datos del sensor
y los muestra por el puerto serial, que será nuestra herramienta para que processing pueda usar dichos datos, actuándo como puente entre ambos lenguajes. Desde processing leemos
los datos del puerto serial que Arduino va mostrando (ambos proyectos deben estar en ejecución al mismo tiempo) y con ellos manejamos una de las palas de un jugador, ya que
solo disponemos de un único sensor.

### Controles

* Tecla 'm' para altenar entre control con teclas y control por sensor.
* Las teclas 'W' y 'S' son para el jugador uno, el de la izquierda, siendo para mover la pala arriba y abajo, respectivamente.
* Las teclas 'U' y 'J' son para el jugador dos, el de la derecha, funcionando igual que el anterior.
* La tecla espacio se usa para volver al menú inicial
* La tecla enter sirve iniciar el juego o bien reiniciar la partida en la que se encuentra

### Bibliografía

* Documentos de la propia práctica
* Foro: https://qastack.mx/gamedev/4253/in-pong-how-do-you-calculate-the-balls-direction-when-it-bounces-off-the-paddl
* Página oficial de Proccesing
* Página oficial de Arduino
