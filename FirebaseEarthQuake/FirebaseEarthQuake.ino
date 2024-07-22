#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
// #include <Firebase_ESP_Client.h>

// Define the pin numbers for components
const int sensorPin = 25;  // Vibration sensor pin
const int buzzerPin = 26;  // Buzzer pin
const int redLedPin = 27;  // Red LED pin
const int greenLedPin = 14;  // Green LED pin
const int xPin = 32; // ADXL335 X-axis pin
const int yPin = 35; // ADXL335 Y-axis pin
const int zPin = 34; //ADXL335 Z-axis pin

// Initialize the LCD. Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 16, 2);

// WiFi credentials
const char* ssid = "Axmedmuuse";
const char* password = "axmed585858";

// Firebase credentials
#define FIREBASE_HOST "https://earth-36cd1-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "RkKHG6kP1s8EfvzRmyyHc0QcE34D9RmbzIFiMOwP"
#define API_KEY "AIzaSyC2RUNbbFXtPf9HKekkynaX8o-yResMuZ0"


// Firebase Data object
FirebaseData firebaseData;
FirebaseAuth firebaseAuth;
FirebaseConfig firebaseConfig;

// Threshold for tilt detection (adjust as needed)
const int tiltThreshold = 300; // ADXL335 should output around 512 (midpoint) when flat

void setup() {
  Serial.begin(9600);

  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");

  // Initialize Firebase
  firebaseConfig.host = FIREBASE_HOST;
  firebaseConfig.api_key = API_KEY;
  firebaseAuth.user.email = "wllkahil3@gmail.com";
  firebaseAuth.user.password = "Shaafici7603";

  Firebase.begin(&firebaseConfig, &firebaseAuth);
  Firebase.reconnectWiFi(true);

  // Pin setup
  pinMode(sensorPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);
  pinMode(greenLedPin, OUTPUT);

  // Initialize LCD
  lcd.init();
  lcd.backlight();
  lcd.begin(16, 2);
  lcd.print("WELCOME TO");
  lcd.setCursor(0, 1);
  lcd.print("EARTHQUAKE MONITORING");
  digitalWrite(greenLedPin, HIGH);
}

void loop() {
  int xValue1 = analogRead(xPin);
  int yValue1 = analogRead(yPin);
  int zValue1 = analogRead(zPin);
  int xValue = map(xValue1, 1495, 2267, 0, 100);
  int yValue = map(yValue1, 1492, 2288, 0, 100);
  int zValue = map(zValue1, 1445, 2255, 0, 100);

  // Print values for debugging
  Serial.print("X: ");
  Serial.print(xValue);
  Serial.print(" Y: ");
  Serial.print(yValue);
  Serial.print("Z: ");
  Serial.print(zValue);
  // Upload sensor readings to Firebase
  if (Firebase.setInt(firebaseData, "/sensorrs/xvalue", xValue)) {
    Serial.println("X-axis value sent to Firebase");
  } else {
    Serial.println("Failed to send X-axis value");
    Serial.println(firebaseData.errorReason());
  }

  if (Firebase.setInt(firebaseData, "/sensorrs/yvalue", yValue)) {
    Serial.println("Y-axis value sent to Firebase");
  } else {
    Serial.println("Failed to send Y-axis value");
    Serial.println(firebaseData.errorReason());
  }
  if (Firebase.setInt(firebaseData, "/sensorrs/zvalue", zValue)) {
    Serial.println("Z-axis value sent to Firebase");
  } else {
    Serial.println("Failed to send Z-axis value");
    Serial.println(firebaseData.errorReason());
  }

  // Check if vibration detected or significant tilt detected
  if (digitalRead(sensorPin) || abs(xValue1 - 2048) > tiltThreshold || abs(yValue1 - 2048) > tiltThreshold) {
    Serial.println("Detected vibration or tilt...");
    digitalWrite(buzzerPin, HIGH);
    digitalWrite(redLedPin, HIGH);
    delay(500);
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("EARTHQUAKE");
    lcd.setCursor(0, 1);
    lcd.print("HAPPENING!");

    if (Firebase.setString(firebaseData, "/alert", "EARTHQUAKE HAPPENING!")) {
      Serial.println("Alert sent to Firebase");
    } else {
      Serial.println("Failed to send alert");
      Serial.println(firebaseData.errorReason());
    }
  } else {
    Serial.println("No significant movement detected...");
    digitalWrite(buzzerPin, LOW);
    digitalWrite(redLedPin, LOW);
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("System Ready");
    lcd.setCursor(0, 1);
    lcd.print("Monitoring...");

    if (Firebase.setString(firebaseData, "/alert", "No significant movement")) {
      Serial.println("No movement alert sent to Firebase");
    } else {
      Serial.println("Failed to send no movement alert");
      Serial.println(firebaseData.errorReason());
    }
  }

  delay(1000);
}
