trigger OpportunityTriiger on Opportunity(after insert, after update, after delete) 
{
    if(Trigger.isAfter && Trigger.isInsert){
            
            OpportunityTriggerHandler.afterInsertHandler(Trigger.new);
            
        }
        
         if(Trigger.isAfter && Trigger.isUpdate) {
            
            OpportunityTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
            
        }
        
         if(Trigger.isAfter && Trigger.isDelete) {
            
            OpportunityTriggerHandler.afterDeleteHandler(Trigger.old);
        }
        
       
    }