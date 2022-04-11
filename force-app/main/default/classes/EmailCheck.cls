public class EmailCheck {
    
    public static void checkEmailUpdate(List<Account> newRecord, List<Account> oldRecord)
    {
        
        set<id> AccIds = new set<id>();
        if(newRecord != oldRecord ){
            
            for(Account acc :newRecord ){
                
                AccIds.add(acc.Id);
            }
        }
       
        
            List<contact> conList = [select MailingStreet,MailingCity, MailingState,MailingPostalCode,MailingCountry 
                         from Contact where AccountId IN :AccIds];
        for(Account acc :newRecord ){
            Integer HoursDifference = system.now().hour() - acc.LastMOdifiedDate.hour() ; 
            
            if(HoursDifference < 24 && (newRecord != oldRecord )){
               
                acc.BillingCity = conList[0].MailingCity;
                acc.BillingCountry = conList[0].MailingCountry;
                update newRecord;
            }
            
        }
             //if((system.now()- acc.LastMdifiedDate) * 24)
          
    }
}