public with sharing class AccountController{
    @AuraEnabled(cacheable=true)
        public static List<Account> getAccounts(){
            return [SELECT id,name,AccountNumber,phone,Industry FROM Account];
        }

}