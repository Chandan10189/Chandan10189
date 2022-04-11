@RestResource(urlMapping = '/Welcome/*')
global class Welcomemesswebservice {
    global final static String Welcome_Message = 'Welcome to the world of Salesforce';
   
    @httpGet
    global static string greetingMessage(){
        
        return Welcome_Message;
    }
}