import { LightningElement, track } from 'lwc';
import weatherCallout from '@salesforce/apex/WeatherAPIService.weatherCallout';
export default class WeatherForecasting extends LightningElement {
    @track lat;
    @track lon;
    @track mapMarkers = [];
    zoomLevel = 10;
    @track result;
    cityValue = 'Maunath Bhanjan';
    postalValue ='275101';
    cityName;
    sunSet;
    sunRise;
    temperature;
    currentWindSpeed;
    latitude;
    longitude;
    weatherchk =false;

    handleChange(event) {
       if (event.target.label === 'City Name'){
        this.cityValue = event.target.value;
       }
       if (event.target.label === 'Postal code'){
        this.postalValue = event.target.value;
       }
    }
        /* Method to check weather  */
        weatherCheck(event){
            weatherCallout({ location: this.cityValue ,postalCode:this.postalValue })
            .then(data => {
    
                //To assign the longitude and latitude to map
                this.mapMarkers = [{
                    location: {
                        Latitude: data['latitude'],
                        Longitude: data['longitude']
                    },
                    title: data['cityName'] + ', ' + data['state'],
                }];
                this.result = data;
    
                if (this.result) {
                    this.weatherchk =true
                    this.cityName = this.result.cityName + ' Information';
                    this.sunSet = this.result.sunSet ;
                    this.sunRise = this.result.sunRise ;
                    this.temperature = this.result.cityTemp;
                    this.currentWindSpeed = this.result.cityWindSpeed;
                    this.latitude = this.result.latitude ;
                    this.longitude = this.result.longitude;
                }
            }).catch(err => console.log(err));
    
        }
    
}