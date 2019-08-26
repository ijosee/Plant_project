# Plant project [Net Core 2.2]


Automatic irrigation of plant with web monitoring.
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 
You need dowload the web project and api project: 
 - git clone link : https://github.com/ijosee/Plant.Web
 - gir clone link : https://github.com/ijosee/Plant.Api

Install sql BBDD
  * get your script here (https://github.com/ijosee/Plant_project/blob/master/sql_database.sql)

Download .ino file and load in your ESP8622
  * get your file here (https://github.com/ijosee/Plant_project/blob/master/arduino_script.io)

### Prerequisites

Before your start to build your own project will need a bit of hardware : 
 - Esp8622
 - Arduino hygrometer
 - Arduino temperature/humidity sensor
 - 5v watter pump
 - ... a plant ;)
 
### Installing

Download the code and buid solutions : 
```
cd {project_folder}
dotnet build
```
then run 
```
dotnet run
```

- Local url for api -> localhost:5000
- Local url for web -> localhost:8081

Create a mysql database

```
mysql -u root -p

mysql>create datebase Arduino_plant
mysql>source /path_file/plant_project_bbdd.sql
```

At this point you have all the front and back ready to go. Now we gonna set up ESP8622 with arduino framework.

## Deployment

To deploy your web and api you can use Azure (http://www.portal.azure.com), you can get until ten free runnig services.

## Built With

* [Visual Studio Code](http://www.code.visualstudio.com/) - The web framework used
* [Arduino](https://www.arduino.cc/) - The web framework used

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **José Enrique Mateu Soro** - *Initial work* - [PlantProject](https://github.com/ijosee/Plant_project/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Iot
* Arduino
* c++

