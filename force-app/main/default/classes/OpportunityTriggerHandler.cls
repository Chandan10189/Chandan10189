public with sharing class OpportunityTriggerHandler {
    
    
    public static void afterInsertHandler(List<Opportunity> newOpportunity) {
        
        
        Set<Id> accountIds = new Set<Id>();
        
        
        for (Opportunity opp : newOpportunity) {
            
            
            if (String.isNotBlank(opp.AccountId)) {
                
                //st
                accountIds.add(opp.AccountId);
            }
        }
        
        
        AccountOpportunityService.updateCountAmountOpportunity(accountIds);
        
    }
    
    
    
    public static void afterUpdateHandler(List<Opportunity> newOpportunity, Map<Id, Opportunity> oldOpportunityMap) {
        
        
        Set<Id> accountIds = new Set<Id>();
        
        
        for (Opportunity opp : newOpportunity) {
            
            
            // capture the account id only if amount value is changed
            
            
            if (String.isNotBlank(opp.AccountId) && oldOpportunityMap.get(opp.Id).Amount != opp.Amount) {
                
                
                // write automation logic here
                
                
                accountIds.add(opp.AccountId);
                
            } 
            
            else if (oldOpportunityMap.get(opp.Id).AccountId != opp.AccountId)
                
            {
                accountIds.add(opp.AccountId);
                
                
               // accountIds.add(oldContactsMap.get(con.Id).AccountId);
                
            }
            
        }
        
        
       AccountOpportunityService.updateCountAmountOpportunity(accountIds);
        
    }
    
    
    
    public static void afterDeleteHandler(List<Opportunity> oldOpportunity) {
        
        
        Set<Id> accountIds = new Set<Id>();
        
        
        for (Opportunity opp : oldOpportunity) {
            
            
            if (String.isNotBlank(opp.AccountId)) {
                
                
                // write automation logic here
                
                
                accountIds.add(opp.AccountId);
                
            }
            
        }
        
        
        AccountOpportunityService.updateCountAmountOpportunity(accountIds);
        
        
    }
    
   
}