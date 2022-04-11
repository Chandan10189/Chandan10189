trigger opportunityTrigger on Opportunity (before insert,after insert,before update,after update,before delete,after delete) {
    if(trigger.isAfter && trigger.isInsert){
        opportunityHelper.oppAmountCount(Trigger.new);
    }
}