global class WeatherAPIService {   
    @AuraEnabled (cacheable=true)
    global static WeatherData weatherCallout(String location,String postalCode) {
        HttpRequest req = new HttpRequest();
        if (location != ''){
            req.setEndpoint('callout:WeatherApi?city=' + location + '&key=222f5227192e4be69aacb6c8deb11337');  
        }
        if (postalCode != ''){
            req.setEndpoint('callout:WeatherApi?postal_code=' + postalCode + '&key=222f5227192e4be69aacb6c8deb11337');   
          }     
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        JSONParser parser = JSON.createParser(res.getBody());     
        
        WeatherData weather = new WeatherData();
        
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                parser.nextValue();
                system.debug('---->'+parser.getCurrentName() );
                switch on parser.getCurrentName() {
                    when 'temp' {
                        weather.cityTemp = Decimal.valueOf(parser.getText());
                    }
                    when 'city_name' {
                        weather.cityName = parser.getText();
                    }
                    when 'state_code' {
                        weather.state = parser.getText();
                    } 
                    when 'timezone' {
                        weather.cityTimeZone = parser.getText();
                    } 
                    when 'wind_spd' {
                        weather.cityWindSpeed = Decimal.valueOf(parser.getText());
                    } 
                    when 'lon' {
                        weather.longitude = parser.getText();
                    } 
                    when 'lat' {
                        weather.latitude = parser.getText();
                    } 
                    when 'sunrise' {
                        weather.sunRise =  parser.getText() ;
                    } 
                    when 'sunset' {
                        weather.sunSet =  parser.getText() ;
                    } 
                    
                }
                
            }
        }
        
        return weather;
    }
    
    
    global class WeatherData {
        @AuraEnabled public String cityName;
        @AuraEnabled public String cityTimeZone;
        @AuraEnabled public Decimal cityTemp;
        @AuraEnabled public String sunRise;
        @AuraEnabled public String sunSet;
        @AuraEnabled public String state;
        @AuraEnabled public Decimal cityWindSpeed;
        @AuraEnabled public String latitude;
        @AuraEnabled public String longitude;
        
    }
}