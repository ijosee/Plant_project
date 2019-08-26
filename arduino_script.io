#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <ESP8266HTTPClient.h>
#include <DHT.h>
 
/* Set these to your desired credentials. */
const char *ssid = "Majos_wifi";  //ENTER YOUR WIFI SETTINGS
const char *password = "28052016";
 
//Web/Server address to read/write from 
const String host = "192.168.1.130";
//const String host = "192.168.1.129";

const int higrometerPin = A0;
const int lightPin = D0;
const int servoPin = D1;

// Definimos el pin digital donde se conecta el sensor
#define DHTPIN 2 // esto es D4 en ESP8622
// Dependiendo del tipo de sensor
#define DHTTYPE DHT11

// Inicializamos el sensor DHT11
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);
  // setup led 
  pinMode(lightPin, OUTPUT);
  digitalWrite(lightPin, HIGH);
  // setup watter pum
  pinMode(servoPin, OUTPUT);
  digitalWrite(servoPin, HIGH);

  // Comenzamos el sensor DHT
  dht.begin();

  WiFi.mode(WIFI_OFF);            //Prevents reconnection issue (taking too long to connect)
  delay(1000);
  WiFi.mode(WIFI_STA);            //This line hides the viewing of ESP as wifi hotspot
  WiFi.begin(ssid, password);     //Connect to your WiFi router
  Serial.println("");
  Serial.print("Connecting");
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
  //If connection successful show IP address in serial monitor
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());  //IP address assigned to your ESP

}

void loop() {

  float humidityValue = getHumidityValue();
  //int humidityValue = 49;
  if(humidityValue > 0){
    sendPostMeasureHumidity(humidityValue);
    }
    
  float temperatureValue = getTemperatureValue();
  //int temperatureValue = 49;
  if(temperatureValue  > 0 ) {
    sendPostMeasureTemperature(temperatureValue);
    }

   int higrometerValue = getHigrometerValue();
    //int higrometerValue = 49;
    sendPostMeasureHigrometer(higrometerValue);
  
  if(higrometerValue >= 0 && higrometerValue <= 25){ // muy seco
    
      Serial.print("\t Very dry ");
      Serial.print("\t higrometer value  = ");
      Serial.println(higrometerValue);
      
      blinkLight(4);
      openServo(1500);
    }
    else if(higrometerValue > 25 && higrometerValue <= 50){ // seco
      Serial.print("\t Dry ");
      Serial.print("\t higrometer value  = ");
      Serial.println(higrometerValue);
      
      blinkLight(3);
      openServo(1000);
    }
    else if(higrometerValue > 50 && higrometerValue <= 75){ // humedo
      Serial.print("\t Wet ");
      Serial.print("\t higrometer value  = ");
      Serial.println(higrometerValue);
      
      blinkLight(2);
      openServo(500);
    }
    else if(higrometerValue > 75 && higrometerValue <= 100){ // muy humedo
      blinkLight(1);
      Serial.print("\t Too wet ");
      Serial.print("\t higrometer value  = ");
      Serial.println(higrometerValue);
      
    }

 int lapseTime = 30000;
 Serial.println("Waiting " + String(lapseTime) + " .... ");
 delay(lapseTime);
 
}

// ------------------------------------
// helper functions for higrometer
// ------------------------------------

int getHigrometerValue(){

  int result = 0 ;
  result = analogRead(higrometerPin);
  result = map(result, 4, 640, 0, 100); // (value,minValue,macValue,mapMinvalue,mapMaxValue)
  return result;
  }

void sendPostMeasureHigrometer(int value){   
   HTTPClient http;    //Declare object of class HTTPClient
   
   String station, postData;
   
   //Post Data
   postData = "{'value' : "+String(value)+"}" ;
   Serial.println("post data [higrometer]: " + postData);
   
   http.begin("http://"+host+":5000/api/Higrometer");              //Specify request destination
   Serial.println("url : http://"+host+":5000/api/Higrometer");
   http.addHeader("Content-Type", "application/json");    //Specify content-type header
   
   int httpCode = http.POST(postData);   //Send the request
   String payload = http.getString();    //Get the response payload

   Serial.println("http response code  : ");
   Serial.print(httpCode);   //Print HTTP return code
   
   Serial.println(payload);    //Print request response payload
   
   http.end();  //Close connection
  }



// ------------------------------------
// helper functions for Humidity
// ------------------------------------

float getHumidityValue(){

  float result = 0 ;
  // relativity humidity
  result = dht.readHumidity();
   Serial.println("\t Humidity value  [" + String(result) +"] %");
   
  // Comprobamos si ha habido algún error en la lectura
  if (isnan(result)) {
    Serial.println("Error obteniendo los datos del sensor DHT11 . Humedad");
    return -1;
  }
  
  return result;
  }

void sendPostMeasureHumidity(float value){   
   HTTPClient http;    //Declare object of class HTTPClient
   
   String station, postData;
   
   //Post Data
   postData = "{'value' : "+String(value)+"}" ;
   Serial.println("post data [humidity]: " + postData);
   
   http.begin("http://"+host+":5000/api/Humidity");              //Specify request destination
   Serial.println("url : http://"+host+":5000/api/Humidity");
   http.addHeader("Content-Type", "application/json");    //Specify content-type header
   
   int httpCode = http.POST(postData);   //Send the request
   String payload = http.getString();    //Get the response payload

   Serial.println("http response code  : ");
   Serial.print(httpCode);   //Print HTTP return code
   
   Serial.println(payload);    //Print request response payload
   
   http.end();  //Close connection
  }

// ------------------------------------
// helper functions for Temperature
// ------------------------------------

float getTemperatureValue(){

  float result = 0 ;
  // relativity temmperature
  result = dht.readTemperature();
  Serial.println("\t Temperature value  [" + String(result) +"] Cª");
  
  // Comprobamos si ha habido algún error en la lectura
  if (isnan(result)) {
    Serial.println("Error obteniendo los datos del sensor DHT11 . Temperatura");
    return -1;
  }
  
  return result;
  }

void sendPostMeasureTemperature(float value){   
   HTTPClient http;    //Declare object of class HTTPClient
   
   String station, postData;
   
   //Post Data
   postData = "{'value' : "+String(value)+"}" ;
   Serial.println("post data [temperature]: " + postData);
   
   http.begin("http://"+host+":5000/api/Temperature");              //Specify request destination
   Serial.println("url : http://"+host+":5000/api/Temperature");
   http.addHeader("Content-Type", "application/json");    //Specify content-type header
   
   int httpCode = http.POST(postData);   //Send the request
   String payload = http.getString();    //Get the response payload

   Serial.println("http response code  : ");
   Serial.print(httpCode);   //Print HTTP return code
   
   Serial.println(payload);    //Print request response payload
   
   http.end();  //Close connection
  }

  

// ------------------------------------
// helper functions for servo
// ------------------------------------

void openServo(int openedTime){
  
    Serial.println("\t OPENING WATTER PUM FOR  [" + String(openedTime) +"] seconds");
    digitalWrite(servoPin, LOW);
    delay(openedTime);
    Serial.println("\t CLOSING WATTER PUM.");
    digitalWrite(servoPin, HIGH);

    int fakeCaudal = 0;
    Serial.print("\t OpenedTime : "+String(openedTime));
    switch(openedTime){
      case 1500 :
        Serial.println("\t FakeCaudal : [90] ml");
        fakeCaudal = 90;
        break;
      case 1000 :
        Serial.println("\t FakeCaudal : [50] ml");
        fakeCaudal = 50;
        break;
      case 500 :
        Serial.println("\t FakeCaudal : [10] ml");
        fakeCaudal = 10;
        break;
     default :
        Serial.println("\t default : [0] ml");
        fakeCaudal = 0;
        break;
      }
    
    sendPostMeasureServo(fakeCaudal,fakeCaudal,openedTime);
  }


void sendPostMeasureServo(int value, int flow,int openedTimeInSeconds){   
   HTTPClient http;    //Declare object of class HTTPClient
   
   String station, postData;
   
   //Post Data
   postData = "{'value' : "+String(value)+", 'flow' : "+String(flow)+", 'openedTimeInSeconds' : "+String(openedTimeInSeconds)+"}" ;
   Serial.println("post data [servo]: " + postData);
   http.begin("http://"+host+":5000/api/WatterPump");              //Specify request destination
   Serial.println("url : http://"+host+":5000/api/WatterPump");
   http.addHeader("Content-Type", "application/json");    //Specify content-type header
   
   int httpCode = http.POST(postData);   //Send the request
   String payload = http.getString();    //Get the response payload
   
   Serial.println("http response code  : ");
   Serial.print(httpCode);   //Print HTTP return code
   
   Serial.println(payload);    //Print request response payload
   
   http.end();  //Close connection
  }
  

// ------------------------------------
// helper functions for light
// ------------------------------------

void blinkLight(int times){

  Serial.println("Blinking light "+ String (times) + " times" );
  for(int a = 0 ; a < times ; a++){
    
      digitalWrite(lightPin, LOW);
      delay(500);
      digitalWrite(lightPin, HIGH);
      delay(500);
      
    }
    
  sendPostMeasureLight(times);
  }


void sendPostMeasureLight(int value){   
   HTTPClient http;    //Declare object of class HTTPClient
   
   String station, postData;
   
   //Post Data
   postData = "{'value' : '"+String(value)+"'}" ;
   Serial.println("post data [light]: " + postData);
   
   http.begin("http://"+host+":5000/api/Light");              //Specify request destination
   Serial.println("url : http://"+host+":5000/api/Light");
   http.addHeader("Content-Type", "application/json");    //Specify content-type header
   
   int httpCode = http.POST(postData);   //Send the request
   String payload = http.getString();    //Get the response payload
   
   Serial.println("http response code  : ");
   Serial.print(httpCode);   //Print HTTP return code
   
   Serial.println(payload);    //Print request response payload
   
   http.end();  //Close connection
  }
