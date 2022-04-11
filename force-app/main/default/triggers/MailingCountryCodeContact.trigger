trigger MailingCountryCodeContact on Contact (before insert) {
if(trigger.isinsert && trigger.isbefore)
    for(contact con:trigger.new)
{
    if(con.Mailing_Country1__c != null)
    {
        if(con.Mailing_Country1__c== 'INDIA')
        {
            con.Country_Code__c= 91 ;
        }
       else if(con.Mailing_Country1__c== 'UK')
        {
            con.Country_Code__c= 44 ;
        }
                if(con.Mailing_Country1__c== 'USA')
        {
            con.Country_Code__c= 1 ;
        }
    }
}
}