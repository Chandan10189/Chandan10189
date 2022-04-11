public class ContactTriggerHandlerrr {
    public static void countContactOnInsert(List<Contact> contactList){
        // we need to count all the contacts related to a account whenever a contact is inserted
        set<id> accountIdSet = new set<id>();
        Map<id,Account> accountMap = new Map<id, Account>();
        for(Contact con : contactList){
            if(con.AccountId != null){
                accountIdSet.add(con.AccountId);
            }
            
        }
        for(AggregateResult agrResult :[Select count(id) countContact, AccountId From Contact where
                                        AccountId IN : accountIdSet Group by AccountId]){
                                            Account actObj = new Account(id = (id)agrResult.get('AccountId'), 
                                                                         Contact_Count__c = (Decimal)agrResult.get('countContact'));
                                            
                                            accountMap.put(actObj.id, actObj);        
                                            
                                        }
        if(accountMap.size() >0){
            system.debug('accountMap Size is'+accountMap.size());
            update accountMap.values();
            
        }
        
    }
    public static void countContactOnUpdate(Map<id,Contact> contNewMap , Map<id,Contact> contOldMap){
        set<id> accountIdSet = new set<id>();
         Map<id,Account> accountMap = new Map<id, Account>();
        for(Contact con :contNewMap.values()){
            if(contNewMap.get(con.Id).AccountId != contOldMap.get(con.Id).AccountId){
                if(contNewMap.get(con.Id).AccountId != null){
                    accountIdSet.add(contNewMap.get(con.Id).AccountId);
                }
                if(contOldMap.get(con.Id).AccountId != null){
                    accountIdSet.add(contOldMap.get(con.Id).AccountId);
                }
            }
        }
        if(accountIdSet.size()>0){
            for(AggregateResult agrResult :[Select count(id) countContact, AccountId From Contact where
                                            AccountId IN : accountIdSet Group by AccountId]){
                                                Account actObj = new Account(id = (id)agrResult.get('AccountId'), 
                                                                             Contact_Count__c = (Decimal)agrResult.get('countContact'));
                                                
                                                accountMap.put(actObj.id, actObj);        
                                                
                                            }
        }
        if(accountMap.size()>0){
            update accountMap.values();
        }
        
    }
}