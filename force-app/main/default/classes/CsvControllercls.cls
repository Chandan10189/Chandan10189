public with sharing class CsvControllercls {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name,Phone,AnnualRevenue,Industry FROM Account];
    }
}