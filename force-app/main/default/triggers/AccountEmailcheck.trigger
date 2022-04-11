trigger AccountEmailcheck on Account (after update) {
   
     if(trigger.isUpdate){
         
      
       EmailCheck.checkEmailUpdate(Trigger.new, trigger.old);
    }
}