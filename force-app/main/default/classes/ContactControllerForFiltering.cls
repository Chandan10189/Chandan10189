public with sharing class ContactControllerForFiltering {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        return [SELECT Id, Name, Title, Email from Contact];
    }
}