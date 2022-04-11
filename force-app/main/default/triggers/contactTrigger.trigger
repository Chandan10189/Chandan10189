trigger contactTrigger on Contact (before insert,after insert,before update,after update,after delete,after unDelete) {
    
    if((Trigger.isInsert || Trigger.isUpdate || trigger.isundelete ) &&(Trigger.isAfter))  {
        ContactTriggerHelper.ScoreSum(trigger.new);
    }
}