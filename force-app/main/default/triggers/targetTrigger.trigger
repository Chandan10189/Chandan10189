trigger targetTrigger on Target__c (after insert,after update,after delete) {
if(Trigger.isafter && Trigger.isInsert){
            
            TargetTriggerHelper.inserTarget(Trigger.new);
}
    if(Trigger.isafter && Trigger.isUpdate) {
            
            TargetTriggerHelper.afterUpdateTarget(Trigger.new, Trigger.oldMap);
            
        }
    if(Trigger.isafter && Trigger.isdelete) {
            
            TargetTriggerHelper.afterUpdateTarget(Trigger.new, Trigger.oldMap);
            
        }
}