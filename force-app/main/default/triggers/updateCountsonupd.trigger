trigger updateCountsonupd on Account (after update) {
    public static Integer Count=1;
   List<Account> newRecord = new List<Account>();
    if(Trigger.isafter && Trigger.isUpdate){
        newRecord.addall(trigger.old);
        system.debug('New Record is'+newRecord);
        for(Account acc: newRecord){
            
          if(Trigger.new != Trigger.old){
                //acc.UpdateCount__c=1;
                if(acc.UpdateCount__c != Null){
                    acc.UpdateCount__c=acc.UpdateCount__c+1;
                    
                }
                else{
                    acc.UpdateCount__c=1;
                }
            }
            
        }
        system.debug('Count trigger call'+count);
        update newRecord;
        count++ ;
    }
}