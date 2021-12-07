
#include <Adafruit_NeoPixel.h>
#include <Adafruit_GFX.h>
#include <Adafruit_NeoMatrix.h>
#include "Adafruit_Sensor.h"

#define PIN 32
#define NUMPIXELS 64
int inputPin = 33;
int pirState = LOW;
int val = 0;
int LIGHT_PIN = A2;
int photocellReading;

int current_light = 0;
int prev_light = -1;
int current_pir = 0;
int prev_pir = -1;
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_RGB + NEO_KHZ800);
int delayval = 10;

const int arrowPixelCount = 28;
const int arrowFrames = 4;
int arrow_list[arrowFrames][arrowPixelCount] = {{4, 8, 11, 12, 15, 16, 18, 19, 22, 23, 25, 26, 29, 30, 33, 34, 37, 38, 42, 43, 46, 47, 52, 52, 55, 56, 60, 64}, {3, 7, 10, 11, 14, 15, 17, 18, 21, 22, 25, 28, 29, 32, 33, 36, 37, 40, 41, 42, 45, 46, 50, 51, 54, 55, 59, 63}, {2, 6, 9, 10, 13, 14, 17, 20, 21, 24, 27, 28, 31, 32, 35, 36, 39, 40, 41, 44, 45, 48, 48, 50, 53, 54, 58, 62}, {1, 5, 9, 12, 13, 16, 19, 20, 23, 24, 26, 27, 30, 31, 34, 35, 38, 39, 43, 44, 47, 48, 49, 52, 53, 56, 57, 61}};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  // Setup the sensor;
  pixels.begin();
  pinMode(LIGHT_PIN, INPUT);
  pinMode(inputPin, INPUT);
}

void loop() {
  photocellReading = analogRead(LIGHT_PIN);
  Serial.print("Light = ");
  Serial.println(photocellReading);

  val = digitalRead(inputPin);
  Serial.print("PIR = ");
  Serial.println(val);

  //MATRIX
  if (photocellReading <= 100 && val == HIGH) {
    Serial.println("Motion detected, light low");
    for (int i = 0; i < arrowFrames; i++) {
      for (int j = 0; j < arrowPixelCount; j++) {
        pixels.setPixelColor(arrow_list[i][j], 0, 255, 0);
      }
      pixels.show();
      delay(200);
      pixels.clear();
    }
  }
  else {
    pixels.clear();
    for (int i = 0; i < arrowFrames; i++) {
      for (int j = 0; j < arrowPixelCount; j++) {
        pixels.setPixelColor(arrow_list[i][j], 0, 0, 0);
      }
      pixels.show();
    }
  }
}
