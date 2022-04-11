public with sharing class AccountOpportunityService {
    public static string Key;
    public static void updateCountAmountOpportunity(Set<Id> accountIds) {
        List<Opportunity> OppList =[SELECT AccountId,StageName,CloseDate,Amount FROM Opportunity where AccountId IN :accountIds 
                                    AND StageName='Closed Won'];
        // get aggregate result for all accounts
        Map<String,ContactTargetWrap> OppMap =new Map<String,ContactTargetWrap>();
        Map<String,ContactTargetWrap> TarMap =new Map<String,ContactTargetWrap>();
        Decimal netAmount=0;
        Integer netCOunt = 0;
        
        
        Integer Count1=0;
        
        for(Opportunity opp :OppList){
            Integer Month=opp.CloseDate.Month();
            Integer Year =opp.CloseDate.Year();
            String Month1=MonthConversion.convertMonthIntegerToString(Month);
            string Key = opp.AccountId+'-'+Month1+'-'+Year;
            ContactTargetWrap wrp = new ContactTargetWrap();
            wrp.amount = opp.Amount;
            wrp.Count = count1++;
            
            OppMap.put(key,wrp);
            
            if(OppMap.containskey(key)){
                ContactTargetWrap wrp1 = OppMap.get(key);
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
                OppMap.put(key,wrp1);
                TarMap.put(key,wrp1);
                
            }
            // system.debug(wrp.amount);
            system.debug(Key);
        }
        List<Target__c> TargetList = [SELECT Account__c,Actual_Opportunity_Amount__c,Actual_Opportunity_Count__c ,Month__c,Year__c	FROM Target__c];
        
        for(String keys:OppMap.keySet()){
            
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
                tar.Actual_Opportunity_Amount__c = wrp.amount;
                tar.Actual_Opportunity_Count__c = wrp.Count;
                
                update tar;
            }
            
        }
        //upsert TargetList;
        
    }
}