trigger AccountDefaultContactTrigger on Account (after insert) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountContactHandler.createDefaultContactForAccount(Trigger.newMap);
        }
    }
}