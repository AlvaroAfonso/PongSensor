# Pong
Proyecto de Creando interfaces de usuario, asignatura de la ULPGC (Universidad de Las Palmas de Gran Canaria) made by **Álvaro Javier Afonso López**

### Introducción

Esta práctica consiste en hacer una versión del famoso juego llamado Pong, el cuál consiste en una especie de tenis de mesa
en dos dimensiones. La intención de esta primera práctica es tener nuestra primera toma de contacto con el lenguaje Processing.

![Alt Text](https://github.com/AlvaroAfonso/Pong/blob/main/export.gif)

Nota: La velocidad del gif no coincide con la velocidad mientras se juega realmente.

### Desarrollo

Dado que es la primera práctica no he querido adelantar acontecimientos y lo he hecho todo en un solo fichero ya que es la primera toma de contacto, sabiendo que se podría hacer con varias clases aprovechando que está basado en Java.

He tratado de usar (y no creo que fuera posible no usar algo) todos los puntos tratados en los documentos que explicaban los conceptos básicos para la realizaciçon de la práctica.

He tratado lo más posible de crear código reutilizable ubicándolo en funciones con nombres adecuados como para no necesitar de tantos comentarios.

A nivel general, la práctica ha resultado bastante sencilla, con la salvedad de que me quedé bastante atascado en cuanto a la dirección que debía tomar la bola cuando impactaba con alguna de las palas de los jugadores, para ello tomé como referencia la siguiente página: https://qastack.mx/gamedev/4253/in-pong-how-do-you-calculate-the-balls-direction-when-it-bounces-off-the-paddl

Otro problema que me encontré fue a la hora de darle fluidez al juego, ya que al ser para dos jugadores y el lenguaje no poder captar la pulsación de varias teclas simultáneamente, encontré una solución que conseguía un resultado perfecto. Cuando se pulsaran las teclas correspondientes a mover las palas, este avance se haría de forma automática durante las siguientes iteraciones de draw, haciendo innecesario comprobar si la tecla sigue constántemente pulsada, y así solo esperar la siguiente llamada de tecla soltada (keyReleased). Haiendo que el avance de la pala sea automático una vez pulsada una tecla, podremos estar atentos a los controles del otro jugador, y el resultado en la jugabilidad llega a parecer que si que se está detectando los controles de forma simultánea.

      void keyPressed(){
       //modificacion del movimiento de Player 1
       if(key == 'w' && p1PosY - p1MoveY - playersHeight/2 >= 0) p1MoveY = -10;
       if(key == 's' && p1PosY + p1MoveY + playersHeight/2 <= height) p1MoveY = 10;

       //modificacion del movimiento de Player 2
       if(key == 'u' && p2PosY - p2MoveY - playersHeight/2 >= 0 ) p2MoveY = -10;
       if(key == 'j' && p2PosY + p2MoveY + playersHeight/2 <= height) p2MoveY = 10; 
       ...

       //quitamos el movimiento automatico que tenian los bloques de los jugadores, esto da mayor fluidez en la jugabilidad
      void keyReleased(){
       if(key == 'w' || key == 's') p1MoveY = 0;
       if(key == 'u' || key == 'j') p2MoveY = 0;
      }
  


### Controles

* Las teclas 'W' y 'S' son para el jugador uno, el de la izquierda, siendo para mover la pala arriba y abajo, respectivamente.
* Las teclas 'U' y 'J' son para el jugador dos, el de la derecha, funcionando igual que el anterior.
* La tecla espacio se usa para volver al menú inicial
* La tecla enter sirve iniciar el juego o bien reiniciar la partida en la que se encuentra

### Bibliografía

* Documentos de la propia práctica
* Foro: https://qastack.mx/gamedev/4253/in-pong-how-do-you-calculate-the-balls-direction-when-it-bounces-off-the-paddl
* Página oficial de Proccesing
