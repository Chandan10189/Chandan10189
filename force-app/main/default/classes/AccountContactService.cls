public with sharing class AccountContactService {
    public static string Key;
    public static void updateCountAmountContacts(Set<Id> accountIds) {
        List<Contact> ConList =[SELECT AccountId,CreatedDate,Amount__c FROM Contact where AccountId In:accountIds];
        // get aggregate result for all accounts
        Map<String,ContactTargetWrap> ConMap =new Map<String,ContactTargetWrap>();
        Map<String,ContactTargetWrap> TarMap =new Map<String,ContactTargetWrap>();
        Decimal netAmount=0;
        Integer netCOunt = 0;
        
        
        Integer Count1=0;
        
        for(contact con:ConList){
            Integer Month=con.CreatedDate.Month();
            Integer Year =con.CreatedDate.Year();
            String Month1=MonthConversion.convertMonthIntegerToString(Month);
            string Key = con.AccountId+'-'+Month1+'-'+Year;
            ContactTargetWrap wrp = new ContactTargetWrap();
            wrp.amount = con.Amount__c;
            wrp.Count = count1++;
            
            ConMap.put(key,wrp);
            
            if(ConMap.containskey(key)){
                ContactTargetWrap wrp1 = ConMap.get(key);
                // List<ContactTargetWrap> netValues = ConMap.values();
                //  system.debug(netValues);
                
                wrp1.amount = wrp1.amount + netAmount;
                wrp1.Count = wrp1.Count+ 1;
                netAmount=wrp1.amount;
                
                // netAmount = netAmount + net.amount ;
                // netCOunt = netCOunt + net.Count;
                //  system.debug(net);
                
                // wrp.amount = netAmount;
                // wrp.Count = netCOunt;
                ConMap.put(key,wrp1);
                TarMap.put(key,wrp1);
                
            }
            // system.debug(wrp.amount);
            system.debug(Key);
        }
        List<Target__c> TargetList = [SELECT Account__c,Actual_Contact_Amount__c,Actual__c ,Month__c,Year__c	FROM Target__c];
        
        for(String keys:ConMap.keySet()){
            
            //  ContactTargetWrap wrp = new ContactTargetWrap();
            /*   if(ConMap.containskey(keys)){
ContactTargetWrap wrp = ConMap.get(keys);
// List<ContactTargetWrap> netValues = ConMap.values();
//  system.debug(netValues);

wrp.amount = wrp.amount + netAmount;
wrp.Count = wrp.Count+ 1;
// netAmount = netAmount + net.amount ;
// netCOunt = netCOunt + net.Count;
//  system.debug(net);

// wrp.amount = netAmount;
// wrp.Count = netCOunt;
ConMap.put(keys,wrp);
TarMap.put(keys,wrp);

} */
            //system.debug(wrp.amount);
        }
        for(Target__c tar : TargetList){
            String Month = tar.Month__c;
            String Year = tar.Year__c ;
            string Key1 = tar.Account__c+'-'+Month+'-'+Year;
            system.debug(Key1);
            
            if(TarMap.containskey(Key1)){
                //    ContactTargetWrap wrp = new ContactTargetWrap();
                ContactTargetWrap wrp = TarMap.get(key1);
                tar.Actual_Contact_Amount__c = wrp.amount;
                tar.Actual__c = wrp.Count;
                system.debug(TarMap.get(Key1));
                system.debug(tar.Actual_Contact_Amount__c);
                system.debug(wrp.amount);
                update tar;
            }
            
        }
        //upsert TargetList;
        
    }
}