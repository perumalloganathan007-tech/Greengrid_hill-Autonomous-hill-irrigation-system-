# ESP32 API Documentation

## GreenGrid ESP32 Gateway Configuration

This document describes the HTTP API endpoints that the ESP32 should implement to communicate with the GreenGrid mobile application.

## Base Configuration

- **Default IP Address**: `192.168.1.100`
- **Port**: `80` (HTTP)
- **Content-Type**: `application/json`
- **Timeout**: 5 seconds

## API Endpoints

### 1. Pump Control

**Endpoint**: `POST /api/pump/control`

**Description**: Toggle pump on/off

**Request Body**:
```json
{
  "pumpId": "pump_1",
  "action": "on",  // or "off"
  "timestamp": "2026-01-30T12:34:56.789Z"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "pumpId": "pump_1",
  "status": "on",
  "timestamp": "2026-01-30T12:34:56.789Z"
}
```

**Error Response** (400/500):
```json
{
  "success": false,
  "error": "Pump not found"
}
```

---

### 2. Set Pump Mode

**Endpoint**: `POST /api/pump/mode`

**Description**: Switch between automatic and manual control modes

**Request Body**:
```json
{
  "pumpId": "pump_1",
  "mode": "auto"  // or "manual"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "pumpId": "pump_1",
  "mode": "auto"
}
```

---

### 3. Get Pump Status

**Endpoint**: `GET /api/pump/status/{pumpId}`

**Description**: Retrieve current pump status and metrics

**Response** (200 OK):
```json
{
  "pumpId": "pump_1",
  "isActive": true,
  "flowRate": 12.5,
  "pressure": 45.5,
  "lastToggled": "2026-01-30T12:00:00.000Z",
  "controlMode": "Auto",
  "zone": "Zone A"
}
```

---

### 4. Emergency Stop

**Endpoint**: `POST /api/emergency/stop`

**Description**: Immediately stop all pumps (safety feature)

**Request Body**:
```json
{}
```

**Response** (200 OK):
```json
{
  "success": true,
  "message": "All pumps stopped",
  "stoppedPumps": ["pump_1", "pump_2"]
}
```

---

## Firebase Realtime Database Structure

The ESP32 should also sync sensor data to Firebase in the following structure:

### Sensor Data Path: `/sensors/{sensorId}`

```json
{
  "sensorId": "sensor_zone_a",
  "moistureLevel": 65.5,
  "timestamp": "2026-01-30T12:34:56.789Z",
  "status": "Safe",
  "location": "Zone A"
}
```

### Tank Data Path: `/tanks/{tankId}`

```json
{
  "tankId": "main_tank",
  "levelPercentage": 75.5,
  "volumeLiters": 1510,
  "capacityLiters": 2000,
  "timestamp": "2026-01-30T12:34:56.789Z",
  "status": "Normal"
}
```

### Pump Data Path: `/pumps/{pumpId}`

```json
{
  "pumpId": "pump_1",
  "isActive": false,
  "flowRate": 0.0,
  "pressure": 45.5,
  "lastToggled": "2026-01-30T11:00:00.000Z",
  "controlMode": "Auto",
  "zone": "Zone A"
}
```

### Analytics Data Path: `/analytics/water_usage/{date}`

```json
{
  "date": "2026-01-30T00:00:00.000Z",
  "litersUsed": 450.0,
  "litersSaved": 320.0,
  "activationCount": 5,
  "averageMoisture": 55.5
}
```

---

## ESP32 Hardware Pins Configuration (Example)

```cpp
// Moisture Sensors (Analog)
#define SENSOR_ZONE_A A0
#define SENSOR_ZONE_B A1
#define SENSOR_ZONE_C A2
#define SENSOR_ZONE_D A3

// Pump Control Relays (Digital)
#define PUMP_1_RELAY 5
#define PUMP_2_RELAY 6

// Tank Level Sensors (Ultrasonic)
#define TANK_MAIN_TRIG 9
#define TANK_MAIN_ECHO 10
#define TANK_RESERVE_TRIG 11
#define TANK_RESERVE_ECHO 12

// Flow Rate Sensors
#define FLOW_SENSOR_1 2
#define FLOW_SENSOR_2 3

// Pressure Sensors (Analog)
#define PRESSURE_SENSOR_1 A4
#define PRESSURE_SENSOR_2 A5
```

---

## WiFi Configuration

The ESP32 should connect to the same network as the mobile device:

```cpp
const char* ssid = "YourWiFiSSID";
const char* password = "YourWiFiPassword";
const char* staticIP = "192.168.1.100";
```

---

## Safety Features

1. **Debounce Protection**: Ignore commands within 2 seconds of the last command
2. **Emergency Stop**: Immediately disable all pumps on `/api/emergency/stop`
3. **Watchdog Timer**: Reset ESP32 if it becomes unresponsive
4. **Over-pressure Protection**: Auto-stop pumps if pressure exceeds 60 PSI
5. **Low Tank Protection**: Stop pumps if tank level < 10%

---

## Testing Commands

### Using curl:

```bash
# Toggle pump on
curl -X POST http://192.168.1.100/api/pump/control \
  -H "Content-Type: application/json" \
  -d '{"pumpId":"pump_1","action":"on","timestamp":"2026-01-30T12:00:00.000Z"}'

# Get pump status
curl http://192.168.1.100/api/pump/status/pump_1

# Set auto mode
curl -X POST http://192.168.1.100/api/pump/mode \
  -H "Content-Type: application/json" \
  -d '{"pumpId":"pump_1","mode":"auto"}'

# Emergency stop
curl -X POST http://192.168.1.100/api/emergency/stop \
  -H "Content-Type: application/json" \
  -d '{}'
```

---

## Required Libraries for ESP32

- **WiFi.h** - WiFi connectivity
- **WebServer.h** - HTTP server
- **ArduinoJson.h** - JSON parsing
- **FirebaseESP32.h** - Firebase integration
- **DHT.h** - If using DHT sensors (optional)

---

## Example ESP32 Response Code

```cpp
void handlePumpControl() {
  if (server.method() != HTTP_POST) {
    server.send(405, "application/json", "{\"error\":\"Method not allowed\"}");
    return;
  }
  
  String body = server.arg("plain");
  DynamicJsonDocument doc(512);
  deserializeJson(doc, body);
  
  String pumpId = doc["pumpId"];
  String action = doc["action"];
  
  // Apply debounce check
  if (millis() - lastCommandTime < 2000) {
    server.send(429, "application/json", "{\"error\":\"Too many requests\"}");
    return;
  }
  
  // Control pump relay
  if (pumpId == "pump_1") {
    digitalWrite(PUMP_1_RELAY, action == "on" ? HIGH : LOW);
  }
  
  lastCommandTime = millis();
  
  server.send(200, "application/json", "{\"success\":true}");
}
```

---

## Next Steps

1. Flash ESP32 with the web server code
2. Configure WiFi credentials
3. Set static IP to 192.168.1.100
4. Test endpoints with curl
5. Connect sensors and relays to pins
6. Update mobile app Settings with ESP32 IP if different
