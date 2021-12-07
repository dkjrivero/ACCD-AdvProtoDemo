#include "config.h"

#include "Adafruit_Sensor.h"
#include "Adafruit_AM2320.h"
Adafruit_AM2320 am2320 = Adafruit_AM2320();

#define TRIG_PIN 33
#define ECHO_PIN 32
int LIGHT_PIN = A2;
int photocellReading;

int current_light = 0;
int prev_light = -1;
int current_distance = 0;
int prev_distance = -1;
int current_temp = 0;
int prev_temp = -1;

AdafruitIO_Feed *lightFeed = io.feed("lightFeed");
AdafruitIO_Feed *distanceFeed = io.feed("distanceFeed");
AdafruitIO_Feed *tempFeed = io.feed("tempFeed");


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  // Setup the sensor;
  am2320.begin();
  pinMode(LIGHT_PIN, INPUT);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  // wait for serial monitor to open
  while(! Serial);
  // connect to io.adafruit.com
  Serial.print("Connecting to Adafruit IO");
  io.connect();
  // wait for a connection
  while(io.status() < AIO_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  // we are connected
  Serial.println();
  Serial.println(io.statusText());


}

void loop() {
  io.run();
  
  // TEMP
  float tempC = am2320.readTemperature();
  float tempF = tempC * 1.8 + 32;
  Serial.print("Temperature: ");
  Serial.print(tempC);
  Serial.print(" \xC2\xB0"); // shows degree symbol
  Serial.print("C  |  ");
  Serial.print(tempF);
  Serial.print(" \xC2\xB0"); // shows degree symbol
  Serial.println("F");

  //LIGHT
  photocellReading = analogRead(LIGHT_PIN);

  Serial.print("Light = ");
  Serial.println(photocellReading);

  //PROXIMITY
  long duration, distance;
  digitalWrite(TRIG_PIN, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(TRIG_PIN, HIGH);
  //  delayMicroseconds(1000); - Removed this line
  delayMicroseconds(10); // Added this line
  digitalWrite(TRIG_PIN, LOW);
  duration = pulseIn(ECHO_PIN, HIGH);
  distance = (duration / 2) / 29.1;

  if (distance >= 500 || distance <= 0) {
    Serial.println("Distance: Out of range");
  }
  else {
    Serial.print("Distance: ");
    Serial.print(distance);
    Serial.println(" cm");
  }


  //IO
  current_light = analogRead(LIGHT_PIN);
  current_temp = tempF;
  current_distance = distance;

  if(current_light != prev_light){
    Serial.print("sending light -> ");
    Serial.println(current_light);
    lightFeed->save(current_light);
    prev_light = current_light;
    }

    if(current_temp != prev_temp){
    Serial.print("sending temperature -> ");
    Serial.println(current_temp);
    tempFeed->save(current_temp);
    prev_temp = current_temp;
    }

    if(current_distance != prev_distance){
    Serial.print("sending distance -> ");
    Serial.println(current_distance);
    distanceFeed->save(current_distance);
    prev_distance = current_distance;
    }

  
  // Wait 2 seconds between readings:
  delay(8000);

}
