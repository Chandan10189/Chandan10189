public with sharing class ContactController{
    @AuraEnabled(cacheable= true)
    public static List<Contact> DisplayContact(String accountId){

        return [SELECT Id,FirstName,LastName,Email,Phone
            FROM Contact where accountId =:accountId ];
    }
        
}