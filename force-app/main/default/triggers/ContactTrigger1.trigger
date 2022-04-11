trigger ContactTrigger1 on Contact(after insert, after update, after delete, after undelete) 
{
    if(Trigger.isAfter && Trigger.isInsert){
            
            ContactTriggerHandler.afterInsertHandler(Trigger.new);
            
        }
        
         if(Trigger.isAfter && Trigger.isUpdate) {
            
            ContactTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
            
        }
        
         if(Trigger.isAfter && Trigger.isDelete) {
            
            ContactTriggerHandler.afterDeleteHandler(Trigger.old);
        }
        
        if(Trigger.isAfter && Trigger.isUnDelete){
            
            ContactTriggerHandler.afterUndeleteHandler(Trigger.new);
            
        }
    }