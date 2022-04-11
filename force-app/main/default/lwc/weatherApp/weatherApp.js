import { LightningElement,track,api } from 'lwc';

export default class WeatherApp extends LightningElement {

    @track var1;
    @track data;
    getConvertedTemp;
    getCurrentTemp;
    getCurrentWindSpeed;
    getCityName;
    cloudsVal;
    gethumidity;
    CityName(event){
        this.var1 = event.target.value;
    }

    save1(){
        alert('City Selected');
        var city = this.var1;
        var calloutURI= "https://api.openweathermap.org/data/2.5/weather?q="+city+"&APPID=bd17cc4cf44c75b56c3701174826b579";
          alert(city);
        fetch(calloutURI,{
            method : "GET",
            headers : {
                "Accept" : "application/json"
            }
        }).then(
            (response) => {
            if(response.ok){
                    return response.json();
                    console.log(response.json());
                }
            }
        ).then(responseJSON =>{
            alert('hii');
            console.log(responseJSON);
            this.getConvertedTemp = parseInt(responseJSON.main.temp - 273) + "C";
           
           this.getCityName = responseJSON.name;
           this.cloudsVal = responseJSON.clouds.all;
           this.gethumidity = responseJSON.main.humidity;
        }).catch((err) => {
            console.log(err);
        });
    }
}