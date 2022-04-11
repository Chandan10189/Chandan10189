trigger TimeTrackingTrigger on TimeTracking__c (before insert,after insert,after update) {
    
    if(trigger.isAfter && trigger.isInsert ){
        TimeTrackingTriggerHelper.checkTimesheet(trigger.new);
    }
    if(trigger.isbefore && trigger.isInsert ){
        TimeTrackingTriggerHelper.checkHourValidation(trigger.new);
    }
    
    if(trigger.isUpdate){
        TimeTrackingTriggerHelper.updateTimesheet(Trigger.new, Trigger.oldMap);
    }

}