## intersystems-iris-docker-rest-data-api-for-hotel-Overbooking

This is a demo of a REST API application built with ObjectScript in InterSystems IRIS.
It also has OPEN API spec, 
can be developed with Docker and VSCode,
can be deployed as ZPM module.
can be used as Overbooking System data REST api.

## Prerequisites

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
Make sure you have a Java environment. JDK 1.8.0 is recommended.

## Installation for InterSystems IRIS Data Platform Development

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone git@github.com:BroadCastAir/hotel_api.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

After the installation is complete, InterSystem Iris as shown below:

![image](https://github.com/BroadCastAir/Hotel_API_Contest/blob/master/png/iris_platform.png)
## Install SpringBoot For Hotel Over-Booking Management System

- InterSystems IRIS Data Platform provide RESTful API for Hotel OverBooking Management System.
- InterSystems IRIS makes it easier to build high-performance applications that connect data and application silos.
- For more details about the Hotel OverBooking Management System, 
see in: https://github.com/BroadCastAir/Hotel_OverBooking_Sys

## Building RESTful Web Services in InterSystems IRIS

Using Atelier, load the REST.Example.cls file to the USER namespace. Compile REST.Example. Create the CSP application /rest/example for the USER namespace. Set the Dispatch Class option for /rest/example to REST.Example.

The Web Service built on InterSystems IRIS provides API services for the Hotel Overbooking system. For details, see below:

![image](https://github.com/BroadCastAir/Hotel_API_Contest/blob/master/png/api_web_service.png)

## Hotel Over-Booking Management System

By analyzing the hotel operation flow data, we first calculate and summarize the trend of price with lead_time by dividing the lead_time distribution of the price range, then by considering the hotel's room inventory for each room pricing analysis, and finally to view the booking of a specific date (choose a more scheduled 10 days).

- dashboard01
![image](https://github.com/BroadCastAir/Hotel_API_Contest/blob/master/png/overbooking_sys_1.png)


- dashboard02
![image](https://github.com/BroadCastAir/Hotel_API_Contest/blob/master/png/overbooking_sys_2.png)


- dashboard03
![image](https://github.com/BroadCastAir/Hotel_API_Contest/blob/master/png/overbooking_sys_3.png)



## Use REST Data API for Hotel-Booking System

We write the relevant analysis and calculation results to the InterSystems IRIS, and then set up the data API interface through the Iris Data platform, which makes it easy for the Hotel Overbooking System to use the data API service directly. A more flexible and decoupled system architecture is built by separating the relevant system side from the data analysis side.

The example as below： 

```
@Service("interSysService")
public class interSysServiceImpl implements interSysService {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Override
    public List getOverSoldList() {

        String URL ="http://127.0.0.1:52773/oversold/all";
        List overSoldlist = new ArrayList();

        //1.get httpclient
        CloseableHttpClient httpclient = HttpClients.custom().setConnectionManager(HttpConnectionManagerApi.getPoolingHttpClientConnectionManager()).setConnectionManagerShared(true).build();

        //2.generate get method
        HttpGet httpGet = new HttpGet(URL);
        httpGet.addHeader("Authorization","Basic X1NZU1RFTTpTWVM=");
        String resultJson = null;
        List<OneBox> overSoldList = new ArrayList<>();
        overSoldlist = getDockResultList(overSoldlist, httpclient, httpGet);
        
        return overSoldlist;
    }
}
```


## How to Work With it

This Hotel Data API creates REST web-application on IRIS which implements 4 types of communication: GET, POST, PUT and DELETE aka CRUD operations.
These interface works with many table classes such as: Sample.Orders/Sample.Hotel/Sample.Oversold/Sample.PriceTrend/Sample.NoshowFore etc...

Open http://localhost:52773/swagger-ui/index.html to test the REST API

# Testing GET requests

To test GET you need to have some data. You can create it with POST request (see below), or you can create some fake testing data. to do that open IRIS terminal or web terminal on /localhost:52773/terminal/.

You can get swagger Open API 2.0 documentation on:
```
localhost:yourport/_spec
```

This REST API exposes two GET requests: all the data and one record.
To get all the data in JSON call:

```
localhost:52773/hotel/all
```

To request the data for a particular record provide the id in GET request like 'localhost:52773/hotel/id' . E.g.:

```
localhost:52773/hotel/1
```

This will return JSON data for the hotel with ID=1, something like that:

```
{"ID":"62","booking_date":"2015/5/1","room_price":122.9352,"room_max":146,"unshow_fore":9,"resultMax":17714.2491,"resultMax_sold":156,"arrival_rate":0.9658,"arrival_rate_fore":0.9408}
```


## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/cls/Package/Classname.cls

The script in Installer.cls will import everything you place under /src/cls into IRIS.

## What's insde the repo

# Dockerfile

The simplest dockerfile to start IRIS and load ObjectScript from /src/cls folder
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.

# .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

# .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
