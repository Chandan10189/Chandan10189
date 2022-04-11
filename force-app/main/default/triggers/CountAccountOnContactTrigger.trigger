trigger CountAccountOnContactTrigger on Contact (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountContactHandler.checkContactCountOnAccount(Trigger.New);
        }
    }
}