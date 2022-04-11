public class TargetTriggerHelper {
    public static void inserTarget(List<Target__c> newTarget){
        Set<Id> accList = new Set<Id>();
        for(Target__c tar : newTarget){
            if(tar.Account__c != Null){
                accList.add(tar.Account__c);
            }
        }
        AccountTargetService.newTargetInsert(accList);
        AccountTargetService.newTargetInsertforContact(accList);
    }
    
    public static void afterUpdateTarget(List<Target__c> newTarget, Map<Id, Target__c> oldTargetMap) {
        
        
        Set<Id> accountIds = new Set<Id>();
        
        
        for (Target__c tar : newTarget) {
            
            
            // capture the account id only if amount value is changed
            
            
            if (String.isNotBlank(tar.Account__c) && ((oldTargetMap.get(tar.Id).Month__c != tar.Month__c) || (oldTargetMap.get(tar.Id).Year__c != tar.Year__c)))
            
            {
                
                
                // write automation logic here
                
                
                accountIds.add(tar.Account__c);
                
            } 
            
            else if (oldTargetMap.get(tar.Id).Account__c != tar.Account__c)
                
            {
                accountIds.add(tar.Account__c);
                
                
                // accountIds.add(oldContactsMap.get(con.Id).AccountId);
                
            }
            
        }
        
        
        AccountTargetService.newTargetInsert(accountIds);
        AccountTargetService.newTargetInsertforContact(accountIds);
        
    }
    
    public static void afterdelete(List<Target__c> oldTarget){
        
		Set<Id> accList = new Set<Id>();
        for(Target__c tar : oldTarget){
            if(tar.Account__c != Null){
                accList.add(tar.Account__c);
            }
        }
        AccountTargetService.newTargetInsert(accList);
        AccountTargetService.newTargetInsertforContact(accList);
        
    }
    
}