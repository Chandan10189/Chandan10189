public class AccountTargetService {
    
    public static void newTargetInsert(Set<id> accountId){
        Integer count1 = 0;
        Decimal netSum = 0;
        Integer netCount =0;
        
        List<Opportunity> OppList = [SELECT AccountId,CloseDate,Amount,StageName FROM Opportunity WHERE 
                                     StageName = 'Closed Won' AND AccountId IN :accountId ];
        Map<String,wrappercls> OppMap =new Map<String,wrappercls>();
        
        for(Opportunity opp : OppList ){
            
            Integer Month = opp.CloseDate.Month();
            Integer Year = opp.CloseDate.Year();
            String Month1 = MonthConversion.convertMonthIntegerToString(Month);
            
            string Key = opp.AccountId+'-'+Month1+'-'+Year;
            system.debug(Key);
            wrappercls wrp = new wrappercls();
            wrp.amount = opp.Amount;
            wrp.Count = count1++;
            system.debug(wrp);
            OppMap.put(key,wrp);
        }
        
        
        List<Target__c> tarList = [SELECT Account__c,Month__c,Year__c,Actual_Opportunity_Amount__c,Actual_Opportunity_Count__c FROM Target__c
                                   WHERE Account__c IN :accountId ];
        
        for(Target__c tar : tarList ){
            string key1 = tar.Account__c+'-'+tar.Month__c+'-'+tar.Year__c;
            system.debug(key1);
            if(OppMap.containsKey(key1)){
                
                wrappercls wrp = OppMap.get(key1);
                system.debug(wrp);
                
                wrp.amount = wrp.amount + netSum;
                netCount = wrp.Count + 1;
                netSum = wrp.amount;
            }
            system.debug(netSum);
            tar.Actual_Opportunity_Amount__c = netSum;
            tar.Actual_Opportunity_Count__c = netCount;
            upsert tar;
        }
    }
    public static void newTargetInsertforContact(Set<id> accountId){
        
        Integer count1 = 0;
        Decimal netSum = 0;
        Integer netCount =0;
        
        List<Contact> ConList = [SELECT AccountId,CreatedDate,Amount__c FROM Contact WHERE 
                                      AccountId IN :accountId ];
        Map<String,wrappercls> ConMap =new Map<String,wrappercls>();
        
        for(Contact con : ConList ){
            
            Integer Month = con.CreatedDate.Month();
            Integer Year = con.CreatedDate.Year();
            String Month1 = MonthConversion.convertMonthIntegerToString(Month);
            
            string Key = con.AccountId+'-'+Month1+'-'+Year;
            system.debug(Key);
            wrappercls wrp = new wrappercls();
            wrp.amount = con.Amount__c;
            wrp.Count = count1++;
            system.debug(wrp);
            ConMap.put(key,wrp);
        }
        
        
        List<Target__c> tarList = [SELECT Account__c,Month__c,Year__c,Actual_Contact_Amount__c,Actual__c FROM Target__c
                                   WHERE Account__c IN :accountId ];
        
        for(Target__c tar : tarList ){
            string key1 = tar.Account__c+'-'+tar.Month__c+'-'+tar.Year__c;
            system.debug(key1);
            if(ConMap.containsKey(key1)){
                
                wrappercls wrp = ConMap.get(key1);
                system.debug(wrp);
                
                wrp.amount = wrp.amount + netSum;
                netCount = wrp.Count + 1;
                netSum = wrp.amount;
            }
            system.debug(netSum);
            tar.Actual_Contact_Amount__c = netSum;
            tar.Actual__c = netCount;
            upsert tar;
        }
    }
    }