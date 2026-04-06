#include <ArduinoJson.h>
#include <FirebaseESP32.h> // Ensure you install "Firebase ESP32 Client" by Mobizt in Arduino IDE
#include <WebServer.h>
#include <WiFi.h>

// ================= Configurations =================

// WiFi config
// "Wokwi-GUEST" is an open network provided by Wokwi for internet access
const char *ssid = "Wokwi-GUEST";
const char *password = "";

// Firebase config
#define FIREBASE_HOST "greengrid-hill-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "AIzaSyD2tjiyP4KgFh_ClonJMtLF8n_4Y9M_eT4"
#define FIREBASE_USER_ID "6c92Tm65AHOMMq2l31lfvZG6j2i1"

FirebaseData firebaseData;
WebServer server(80);

// Hardware Pins Configuration
// Moisture Sensors (Analog pins on ESP32, e.g., GPIO36/VP)
#define SENSOR_ZONE_A 36
#define SENSOR_ZONE_B 39
#define SENSOR_ZONE_C 34
#define SENSOR_ZONE_D 35

// Pump Control Relays (Digital Outputs)
#define PUMP_1_RELAY 26
#define PUMP_2_RELAY 27
#define PUMP_3_RELAY 14
#define PUMP_4_RELAY 12

// Tank Level Sensors (Ultrasonic)
#define TANK_MAIN_TRIG 19
#define TANK_MAIN_ECHO 18
#define TANK_RESERVE_TRIG 5
#define TANK_RESERVE_ECHO 17

// Global State Variables
String pump1_mode = "auto";
String pump2_mode = "auto";
String pump3_mode = "auto";
String pump4_mode = "auto";
bool pump1_status = false;
bool pump2_status = false;
bool pump3_status = false;
bool pump4_status = false;

unsigned long lastCommandTime = 0;
unsigned long lastFirebaseUpdate = 0;

// ================= Setup =================

void setup() {
  Serial.begin(115200);

  // Initialize pump pins
  pinMode(PUMP_1_RELAY, OUTPUT);
  pinMode(PUMP_2_RELAY, OUTPUT);
  pinMode(PUMP_3_RELAY, OUTPUT);
  pinMode(PUMP_4_RELAY, OUTPUT);
  digitalWrite(PUMP_1_RELAY, LOW); 
  digitalWrite(PUMP_2_RELAY, LOW);
  digitalWrite(PUMP_3_RELAY, LOW);
  digitalWrite(PUMP_4_RELAY, LOW);

  // Initialize tank sensor pins
  pinMode(TANK_MAIN_TRIG, OUTPUT);
  pinMode(TANK_MAIN_ECHO, INPUT);
  pinMode(TANK_RESERVE_TRIG, OUTPUT);
  pinMode(TANK_RESERVE_ECHO, INPUT);

  // Connect to WiFi
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP()); 

  // Initialize Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  Serial.println("Firebase Initialized");

  // Setup Routing for HTTP API
  setupRouting();
  server.begin();
  Serial.println("HTTP Server started on port 80");
}

// ================= Main Loop =================

void loop() {
  // Handle incoming HTTP client requests
  server.handleClient();

  // Sync Data to Firebase every 5 seconds
  if (millis() - lastFirebaseUpdate > 5000) {
    updateFirebase();
    lastFirebaseUpdate = millis();
  }
}

// ================= HTTP API Routing & Handlers =================

void setupRouting() {
  server.on("/api/pump/control", HTTP_POST, handlePumpControl);
  server.on("/api/pump/mode", HTTP_POST, handlePumpMode);
  server.on("/api/emergency/stop", HTTP_POST, handleEmergencyStop);

  // Status endpoints for all 4 pumps
  server.on("/api/pump/status/pump_1", HTTP_GET, []() {
    sendPumpStatus("pump_1", pump1_status, pump1_mode, "Terrace Zone 1");
  });
  server.on("/api/pump/status/pump_2", HTTP_GET, []() {
    sendPumpStatus("pump_2", pump2_status, pump2_mode, "Terrace Zone 2");
  });
  server.on("/api/pump/status/pump_3", HTTP_GET, []() {
    sendPumpStatus("pump_3", pump3_status, pump3_mode, "Terrace Zone 3");
  });
  server.on("/api/pump/status/pump_4", HTTP_GET, []() {
    sendPumpStatus("pump_4", pump4_status, pump4_mode, "Terrace Zone 4");
  });

  // Handle CORS and 404
  server.onNotFound([]() {
    if (server.method() == HTTP_OPTIONS) {
      server.sendHeader("Access-Control-Allow-Origin", "*");
      server.sendHeader("Access-Control-Allow-Headers", "Content-Type");
      server.send(204);
    } else {
      server.send(404, "application/json",
                  "{\"error\":\"Endpoint not found\"}");
    }
  });
}

void handlePumpControl() {
  server.sendHeader("Access-Control-Allow-Origin", "*");

  if (millis() - lastCommandTime < 2000) {
    server.send(429, "application/json",
                "{\"success\":false,\"error\":\"Too many requests - safety debounce active\"}");
    return;
  }

  String body = server.arg("plain");
  DynamicJsonDocument doc(512);
  DeserializationError error = deserializeJson(doc, body);

  if (error) {
    server.send(400, "application/json",
                "{\"success\":false,\"error\":\"Invalid JSON payload\"}");
    return;
  }

  String pumpId = doc["pumpId"] | "";
  String action = doc["action"] | ""; 

  bool* statusRef;
  String* modeRef;
  int relayPin;

  if (pumpId == "pump_1") {
    statusRef = &pump1_status; modeRef = &pump1_mode; relayPin = PUMP_1_RELAY;
  } else if (pumpId == "pump_2") {
    statusRef = &pump2_status; modeRef = &pump2_mode; relayPin = PUMP_2_RELAY;
  } else if (pumpId == "pump_3") {
    statusRef = &pump3_status; modeRef = &pump3_mode; relayPin = PUMP_3_RELAY;
  } else if (pumpId == "pump_4") {
    statusRef = &pump4_status; modeRef = &pump4_mode; relayPin = PUMP_4_RELAY;
  } else {
    server.send(404, "application/json", "{\"success\":false,\"error\":\"Pump not found\"}");
    return;
  }

  if (*modeRef == "auto") {
    server.send(400, "application/json", "{\"success\":false,\"error\":\"Pump is in auto mode. Switch to manual first.\"}");
    return;
  }

  *statusRef = (action == "on");
  digitalWrite(relayPin, *statusRef ? HIGH : LOW);

  lastCommandTime = millis();

  String response = "{\"success\":true,\"pumpId\":\"" + pumpId +
                    "\",\"status\":\"" + action + "\"}";
  server.send(200, "application/json", response);
}

void handlePumpMode() {
  server.sendHeader("Access-Control-Allow-Origin", "*");

  String body = server.arg("plain");
  DynamicJsonDocument doc(512);
  deserializeJson(doc, body);

  String pumpId = doc["pumpId"] | "";
  String mode = doc["mode"] | ""; 

  if (pumpId == "pump_1") {
    pump1_mode = mode;
  } else if (pumpId == "pump_2") {
    pump2_mode = mode;
  } else if (pumpId == "pump_3") {
    pump3_mode = mode;
  } else if (pumpId == "pump_4") {
    pump4_mode = mode;
  } else {
    server.send(404, "application/json", "{\"success\":false,\"error\":\"Pump not found\"}");
    return;
  }

  String response = "{\"success\":true,\"pumpId\":\"" + pumpId +
                    "\",\"mode\":\"" + mode + "\"}";
  server.send(200, "application/json", response);
}

void sendPumpStatus(String pumpId, bool status, String mode, String zone) {
  server.sendHeader("Access-Control-Allow-Origin", "*");

  DynamicJsonDocument doc(256);
  doc["pumpId"] = pumpId;
  doc["isActive"] = status;
  doc["controlMode"] = mode;
  doc["zone"] = zone;
  doc["flowRate"] = status ? 12.5 : 0.0;
  doc["pressure"] = status ? 45.5 : 0.0;

  String response;
  serializeJson(doc, response);
  server.send(200, "application/json", response);
}

void handleEmergencyStop() {
  server.sendHeader("Access-Control-Allow-Origin", "*");

  pump1_status = false;
  pump2_status = false;
  pump3_status = false;
  pump4_status = false;
  digitalWrite(PUMP_1_RELAY, LOW);
  digitalWrite(PUMP_2_RELAY, LOW);
  digitalWrite(PUMP_3_RELAY, LOW);
  digitalWrite(PUMP_4_RELAY, LOW);

  server.send(200, "application/json",
              "{\"success\":true,\"message\":\"All pumps stopped\",\"stoppedPumps\":[\"pump_1\",\"pump_2\",\"pump_3\",\"pump_4\"]}");
}

// ================= Sensors & Firebase Sync =================

float readMoisture(int pin) {
  int rawValue = analogRead(pin);
  float moisturePercent = map(rawValue, 4095, 0, 0, 100);
  if (moisturePercent < 0) moisturePercent = 0;
  if (moisturePercent > 100) moisturePercent = 100;
  return moisturePercent;
}

void updateFirebase() {
  float moistureA = readMoisture(SENSOR_ZONE_A);
  float moistureB = readMoisture(SENSOR_ZONE_B);
  float moistureC = readMoisture(SENSOR_ZONE_C);
  float moistureD = readMoisture(SENSOR_ZONE_D);

  // Sync moisture data string for Terrace (T1, T2, T3, T4)
  String moistureData = "T1:" + String(moistureA, 0) + 
                       ",T2:" + String(moistureB, 0) + 
                       ",T3:" + String(moistureC, 0) + 
                       ",T4:" + String(moistureD, 0);
  
  // Update both the legacy and individual paths for compatibility
  // Note: TelemetryService expects a "moisture_data" field in the user path
  // We'll update the /terrace path as defined in AppConstants
  
  String userPath = "/users/" + String(FIREBASE_USER_ID) + "/moisture_data";
  Firebase.setString(firebaseData, userPath, moistureData);

  // Zone A
  Firebase.setFloat(firebaseData, "/terrace/sensor_zone_a/moistureLevel", moistureA);
  Firebase.setString(firebaseData, "/terrace/sensor_zone_a/status", moistureA > 30 ? "Safe" : "Critical");
  Firebase.setString(firebaseData, "/terrace/sensor_zone_a/location", "Terrace Zone 1");

  // Zone B
  Firebase.setFloat(firebaseData, "/terrace/sensor_zone_b/moistureLevel", moistureB);
  Firebase.setString(firebaseData, "/terrace/sensor_zone_b/status", moistureB > 30 ? "Safe" : "Critical");
  Firebase.setString(firebaseData, "/terrace/sensor_zone_b/location", "Terrace Zone 2");

  // Zone C
  Firebase.setFloat(firebaseData, "/terrace/sensor_zone_c/moistureLevel", moistureC);
  Firebase.setString(firebaseData, "/terrace/sensor_zone_c/status", moistureC > 30 ? "Safe" : "Critical");
  Firebase.setString(firebaseData, "/terrace/sensor_zone_c/location", "Terrace Zone 3");

  // Zone D
  Firebase.setFloat(firebaseData, "/terrace/sensor_zone_d/moistureLevel", moistureD);
  Firebase.setString(firebaseData, "/terrace/sensor_zone_d/status", moistureD > 30 ? "Safe" : "Critical");
  Firebase.setString(firebaseData, "/terrace/sensor_zone_d/location", "Terrace Zone 4");

  // Push Pump Status
  Firebase.setBool(firebaseData, "/pumps/pump_1/isActive", pump1_status);
  Firebase.setString(firebaseData, "/pumps/pump_1/controlMode", pump1_mode);
  
  Firebase.setBool(firebaseData, "/pumps/pump_2/isActive", pump2_status);
  Firebase.setString(firebaseData, "/pumps/pump_2/controlMode", pump2_mode);

  Firebase.setBool(firebaseData, "/pumps/pump_3/isActive", pump3_status);
  Firebase.setString(firebaseData, "/pumps/pump_3/controlMode", pump3_mode);

  Firebase.setBool(firebaseData, "/pumps/pump_4/isActive", pump4_status);
  Firebase.setString(firebaseData, "/pumps/pump_4/controlMode", pump4_mode);
}
