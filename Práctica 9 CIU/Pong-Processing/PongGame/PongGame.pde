import processing.sound.*;
//import gifAnimation.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

boolean manual;
float trueValue;
float[] auxMean;
int counter;
int bufferLength;

SoundFile ballCollide;
SoundFile guitar;

int p1Points = 0;
int p2Points = 0;

float ballMoveX;
float ballMoveY;;
float ballPosX;
float ballPosY;
float ballDiameter = 30;

float p1PosX = 40;
float p2PosX = width - 40;
float p1PosY;
float p2PosY;
float p1MoveY;
float p2MoveY;

float playersWidth = 10;
float playersHeight = 70;

boolean showMenu = true;

//GifMaker gifExport;

void setup(){
  size(1000, 800);
  bufferLength=20;
  
  manual = true;
  auxMean = new float[bufferLength];
  for(int i=0; i<bufferLength;i++) auxMean[i]=0.0;
  trueValue=0.0;
  counter=0;
  
  
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  ballCollide = new SoundFile(this, "Bass-Drum-1.wav");
  guitar = new SoundFile(this, "Alesis-Fusion-Clean-Guitar-C3.wav");
  
  resetValues();
    
  menu();
}

void draw(){
  
  if ( myPort.available() > 0)
  {  // If data is available,
    val = myPort.readStringUntil('\n'); // read it and store it in val
  }
  
  if(showMenu){
    menu();
  }else{
    game();
  }
  if(val != null) println(val);  
}

void game(){
  background(1);
  
  //linea separatoria
  stroke(255,255,255);
  for(float i = 5; i <= height - 30; i += 30){
    line(width/2, i, width/2, i + 10);
  }
  
  //puntuaciones
  textSize(30);
  text(p1Points, (width/2)/2, 50);
  text(p2Points, width/2 + (width/2)/2, 50);
  
  fill(255);
  
  //bloques de jugadores
  rectMode(CENTER);
  
  rect(p2PosX, p2PosY, playersWidth, playersHeight);
  if(manual){ 
    //se mantiene el movimiento cumpliendo el constrain para conseguir una jugabilidad mas fluida
    p1PosY += p1MoveY;
  }else if(val != null && float(val) > 200){
    auxMean[counter]=float(val);
    trueValue=0.0;
    for(int i=0;i<bufferLength;i++)trueValue+=auxMean[i];
    trueValue/=bufferLength;
    p1PosY = map(trueValue, 200, 570, 0, height);
    counter++;
    if(counter>bufferLength-1)counter=0;
  }
  
  p1PosY = constrain(p1PosY, playersHeight/2 + 5, height-playersHeight/2 - 5);
  
  rect(p1PosX, p1PosY, playersWidth, playersHeight);
  
  
  
  p2PosY += p2MoveY;
  p2PosY = constrain(p2PosY, playersHeight/2 + 5, height-playersHeight/2 - 5);

  
  //se muestra la bola
  ellipse(ballPosX,ballPosY,ballDiameter,ballDiameter);
  
  checkBall();

}

void ballCollide(){
 ballCollide.play(); 
}

void guitar(){
 guitar.play(); 
}

void checkBall(){
 
  //comprobamos choque de bola en Player 1
  if (ballPosY - ballDiameter/2 <= p1PosY + playersHeight/2 && ballPosY + ballDiameter/2 >= p1PosY - playersHeight/2 && ballPosX - ballDiameter/2 <= p1PosX + playersWidth/2) {
        thread ("ballCollide");
        
        //se calcula donde ha chocado la bola en relacion a la pala
        float relativeIntersect = ballPosY - (p1PosY - playersHeight/2);
        float rad = radians(60);
        float angle = map(relativeIntersect, 0, playersHeight, -rad, rad);
        ballMoveX = 5 * cos(angle);
        ballMoveY = 5 * sin(angle);
        ballPosX = p1PosX + playersWidth/2 + ballDiameter/2;
   }
   
   //comprobamos choque de bola en Player 2
  if (ballPosY - ballDiameter/2 <= p2PosY + playersHeight/2 && ballPosY + ballDiameter/2 >= p2PosY - playersHeight/2 && ballPosX + ballDiameter/2 >= p2PosX - playersWidth/2) {

        thread ("ballCollide");    
    
        //se calcula donde ha chocado la bola en relacion a la pala
        float relativeIntersect = ballPosY - (p2PosY - playersHeight/2);
        float rad120 = radians(120);
        float rad250 = radians(250);
        float angle = map(relativeIntersect, 0, playersHeight, rad250, rad120);
        ballMoveX = 5 * cos(angle);
        ballMoveY = 5 * sin(angle);
        ballPosX = p2PosX - playersWidth/2 - ballDiameter/2 - 1;
   }

    if (ballPosX + ballDiameter/2 < 0) {
      thread ("guitar");
      p2Points++;
      resetValues();
    }

    if (ballPosX - ballDiameter/2 > width) {
      thread ("guitar");
      p1Points++;
      
      resetValues();
      //noLoop();
    }

    if (ballPosY < 0 || ballPosY > height) {
      thread ("ballCollide");
      ballMoveY *= -1;
    }
    
    ballPosX += ballMoveX;
    ballPosY += ballMoveY;
}

void menu(){
 float menuCenter = width/2;
  
  background(0);
  
  textSize(60);
  textAlign(CENTER);
  fill(255);
  text("Pong Game", menuCenter, height*0.2);
  
  textSize(20);
  text("Author: Álvaro Afonso López", menuCenter, height*0.25);
  text("Author: Víctor Sánchez Rodríguez", menuCenter, height*0.29);
  text("-------- Controls --------", menuCenter, height*0.45);
  text("Player 1: W and S", menuCenter, height*0.5);
  text("Player 2: U and J", menuCenter, height*0.55);
  text("Player 1: Press 'm' to control with sensor", menuCenter, height*0.65);
  textSize(50);
  text("ENTER TO PLAY",menuCenter, height*0.8); 
  noLoop();
}

void resetValues(){
  ballPosX = width/2;
  ballPosY = height/2;
  p2PosX = width - 40;
  p1PosY = height/2;
  p2PosY = height/2;
  //pMoveX = 5;
  p1MoveY= 0;
  p2MoveY = 0;
  
  //movimiento inicial de la bola, como maximo un angulo de 60 grados con respecto al eje x
  float angle = random(-PI/3, PI/3 + 0.1);
  ballMoveX = 5 * cos(angle);
  ballMoveY = 5 * sin(angle);
  
  //lo anterior calcula el angulo verticalmente, forzamos aleatoriedad en el eje x
  if(random(-1, 1) < 0){
    ballMoveX *= -1;
  }
  
}

void keyPressed(){
  
  //modificacion del movimiento de Player 1
  if(key == 'w' && p1PosY - p1MoveY - playersHeight/2 >= 0) p1MoveY = -10;
  if(key == 's' && p1PosY + p1MoveY + playersHeight/2 <= height) p1MoveY = 10;
  
  //modificacion del movimiento de Player 2
  if(key == 'u' && p2PosY - p2MoveY - playersHeight/2 >= 0 ) p2MoveY = -10;
  if(key == 'j' && p2PosY + p2MoveY + playersHeight/2 <= height) p2MoveY = 10;
  if(key == 'm') manual = !manual;
  
  //empezar juego
  if(keyCode == ENTER){
    showMenu = false;
    resetValues();
    p1Points = 0;
    p2Points = 0;
    loop();
  }
  
  //terminar juego y mostrar menu
  if(key == ' '){
    showMenu = true;
    menu();
  }    
}

//quitamos el movimiento automatico que tenian los bloques de los jugadores, esto da mayor fluidez en la jugabilidad
void keyReleased(){
  if(key == 'w' || key == 's') p1MoveY = 0;
  if(key == 'u' || key == 'j') p2MoveY = 0;
}
