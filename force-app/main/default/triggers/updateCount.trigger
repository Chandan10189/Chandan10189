trigger updateCount on Opportunity (after update,before update) {
    Integer count=0;
    if(trigger.isupdate && trigger.isafter ){
        if(trigger.new != trigger.old){
            system.debug('triggerafter');
        }
        
        
    }
   
    if(trigger.isupdate && trigger.isbefore ){
         if(trigger.new != trigger.old){
        system.debug('triggerbefore');
    }
        
    }
    
}