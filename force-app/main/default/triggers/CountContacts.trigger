trigger CountContacts on Contact (after insert, after update,after delete) {
 
    if(trigger.isInsert && trigger.isAfter){
        ContactTriggerHandlerrr.countContactOnInsert(trigger.new);
    }
    
    if(trigger.isafter&& trigger.isUpdate){
              ContactTriggerHandlerrr.countContactOnUpdate(trigger.newMap, trigger.oldMap);  
        
    }
    
    if(trigger.isAfter && trigger.isDelete){
        
    }
}