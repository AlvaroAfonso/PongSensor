int val = 0;
int analogPin = 0;   // potentiometer connected to analog pin 3

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(analogPin);  // read the input pin
  
  Serial.println(val);
  delay(20);
}

// analogRead values go from 0 to 1023, analogWrite values from 0 to 255
