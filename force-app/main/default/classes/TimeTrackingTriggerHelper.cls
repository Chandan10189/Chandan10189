public class TimeTrackingTriggerHelper {
    
    public static void checkHourValidation(List<TimeTracking__c> newRecord){
        for(TimeTracking__c tt :newRecord){
            if(tt.Hours__c == Null){
                tt.Hours__c.addError('Hours can not be Empty');
            }
        }
        
    }
    
    public static void checkTimesheet(List<TimeTracking__c> newTimeRecord){
        
        for(TimeTracking__c tt : newTimeRecord){
            date currentDate = tt.Date__c;
            system.debug(currentDate);
            date weekStart = currentDate.toStartofWeek();
            system.debug(weekStart);
            date weekEnd = weekStart.addDays(6);
            system.debug(weekEnd);
            List<Timesheet__c> totalTimeSheetRecord = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStart AND End_Date__c= :weekEnd AND User__c = :tt.User__c ];
            //  for(Timesheet__c ts :totalTimeSheetRecord ){
            //     if(ts.Start_Date__c >weekStart && ts.End_Date__c )
            //  }
            system.debug(totalTimeSheetRecord.size());
            List<Timesheet__c> tss = new List<Timesheet__c>();
            if(totalTimeSheetRecord.size() == 0){ 
                Timesheet__c ts = new Timesheet__c();
                ts.Start_Date__c = weekStart;
                ts.End_Date__c = weekEnd;
                ts.Name = tt.Name+dateTime.now();
                ts.Total_Hours__c = tt.Hours__c;
                ts.User__c = tt.User__c;
                    insert ts;
                
                
            }
            
            
            else{
                Decimal sum =0;
                for(Timesheet__c ts:totalTimeSheetRecord){
                    //  Timesheet__c ts1 = new Timesheet__c();
                    if(ts.Total_Hours__c == null){
                        ts.Total_Hours__c = sum + tt.Hours__c;  
                        
                    }
                    else
                        ts.Total_Hours__c = ts.Total_Hours__c + tt.Hours__c;
                }
                update totalTimeSheetRecord;
                
                
            }
            
            
            
        }
    }
    public static void updateTimesheet(List<TimeTracking__c> newTimeTracking, Map<Id, TimeTracking__c> oldTimeTrackingMap){
        for(TimeTracking__c tt :newTimeTracking){
            system.debug('old Date is'+oldTimeTrackingMap.get(tt.Id).Date__c);
            system.debug('New Date is'+tt.Date__c);
            date currentDate = tt.Date__c;
            system.debug('Current Date is'+currentDate);
            date weekStart = currentDate.toStartofWeek();
            system.debug('week Start Date is'+weekStart);
            date weekEnd = weekStart.addDays(6);
            if(oldTimeTrackingMap.get(tt.Id).Date__c != tt.Date__c){
                date currentDateOld = oldTimeTrackingMap.get(tt.Id).Date__c;
                system.debug('currentDateOld is'+currentDateOld);
                date weekStartOld = currentDateOld.toStartofWeek();
                system.debug('weekStartOld is'+weekStartOld);
                date weekEndOld = weekStartOld.addDays(6);
                system.debug('weekEndOld is'+weekEndOld);
                //  system.debug('old Date is'+oldTimeTrackingMap.get(tt.Id).Date__c);
                //  system.debug('New Date is'+tt.Date__c);
                //  date currentDate = tt.Date__c;
                // system.debug('Current Date is'+currentDate);
                // date weekStart = currentDate.toStartofWeek();
                // system.debug('week Start Date is'+weekStart);
                // date weekEnd = weekStart.addDays(6);
                List<Timesheet__c> totalTimeSheetRecord1 = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStart AND End_Date__c= :weekEnd AND User__c = :tt.User__c ];
                system.debug('Total TimeSheetRecord'+totalTimeSheetRecord1.size());
                List<Timesheet__c> totalTimeSheetRecordOld = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStartOld AND End_Date__c= :weekEndOld AND User__c = :tt.User__c ];
                // system.debug('Total TimeSheetRecord'+totalTimeSheetRecord1.size());
                //for(Timesheet__c ts1 : totalTimeSheetRecord1){
                Timesheet__c ts1 = new Timesheet__c();
                system.debug('Timesheet Start Date'+ts1.Start_Date__c);
                system.debug('week Start Date'+weekStart);
                system.debug('Timesheet End Date'+ts1.End_Date__c);
                system.debug('week End Date'+weekEnd);
                
                if((totalTimeSheetRecord1.size() ==0) && (ts1.Start_Date__c !=weekStart) && (ts1.End_Date__c != weekEnd)){ 
                    for(Timesheet__c ts:totalTimeSheetRecordOld){
                        system.debug('I am at new week days whn total time sheet record is zero');
                        //  Timesheet__c ts1 = new Timesheet__c();
                        // if(ts.Total_Hours__c == null){
                        //    ts.Total_Hours__c =  tt.Hours__c ;  
                        
                        // }
                        //else
                        ts.Total_Hours__c = ts.Total_Hours__c - tt.Hours__c;
                        //totalTimeSheetRecordOld.add(ts);
                        // update ts;
                    }
                    update totalTimeSheetRecordOld;
                    //update totalTimeSheetRecordOld;
                    // Decimal sum =0;
                    Timesheet__c ts = new Timesheet__c();
                    ts.Start_Date__c = weekStart;
                    ts.End_Date__c = weekEnd;
                    ts.Name = tt.Name;
                    ts.Total_Hours__c = tt.Hours__c;
                    ts.User__c = tt.User__c;
                    
                    insert ts;
                    
                }
                if( (totalTimeSheetRecord1.size() > 0) &&(ts1.Start_Date__c !=weekStart) && (ts1.End_Date__c != weekEnd)){
                    system.debug('New Week is selected');
                    Decimal sum =0;
                    for(Timesheet__c ts:totalTimeSheetRecord1){
                        //  Timesheet__c ts1 = new Timesheet__c();
                        if(ts.Total_Hours__c == null){
                            ts.Total_Hours__c =  tt.Hours__c - sum;  
                            
                        }
                        else
                            ts.Total_Hours__c = ts.Total_Hours__c - tt.Hours__c;
                    }
                    update totalTimeSheetRecord1;
                }
                
                /*else{
Decimal sum =0;
for(Timesheet__c ts:totalTimeSheetRecord){
//  Timesheet__c ts1 = new Timesheet__c();
if(ts.Total_Hours__c == null){
ts.Total_Hours__c = sum + tt.Hours__c;  

}
else
ts.Total_Hours__c = ts.Total_Hours__c - tt.Hours__c;
}
update totalTimeSheetRecord;
} */
                // }
            }
            
            if(oldTimeTrackingMap.get(tt.Id).Hours__c != tt.Hours__c){
                List<Timesheet__c> totalTimeSheetRecord4 = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStart AND End_Date__c= :weekEnd AND User__c = :tt.User__c ];
                for(Timesheet__c ts : totalTimeSheetRecord4 ){
                    ts.Total_Hours__c = tt.Hours__c;
                    update totalTimeSheetRecord4;
                }
            } 
            if(oldTimeTrackingMap.get(tt.Id).User__c != tt.User__c){
                system.debug('I am in User Update');
                date currentDateOld = oldTimeTrackingMap.get(tt.Id).Date__c;
                system.debug('currentDateOld is'+currentDateOld);
                date weekStartOld = currentDateOld.toStartofWeek();
                system.debug('weekStartOld is'+weekStartOld);
                date weekEndOld = weekStartOld.addDays(6);
                system.debug('weekEndOld is'+weekEndOld);
                List<Timesheet__c> totalTimeSheetRecordOld = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStartOld AND End_Date__c= :weekEndOld AND User__c = :tt.User__c ];
                system.debug(totalTimeSheetRecordOld.size());
                List<Timesheet__c> totalTimeSheetRecord2 = [SELECT Id, Start_Date__c, End_Date__c, User__c, Total_Hours__c, Name__c FROM Timesheet__c where Start_Date__c= :weekStart AND End_Date__c= :weekEnd AND User__c = :tt.User__c ];
                system.debug(totalTimeSheetRecord2.size());
                for(Timesheet__c ts2 : totalTimeSheetRecordOld){
                    
                    system.debug('Total Hours in Timesheet before'+ts2.Total_Hours__c);
                    ts2.Total_Hours__c = ts2.Total_Hours__c - tt.Hours__c;
                    system.debug('Total Hours in Timesheet after'+ts2.Total_Hours__c);
                    update totalTimeSheetRecordOld;
                }
             //   for(Timesheet__c ts2 : totalTimeSheetRecord2){
                    system.debug('Total no. of TimesheetRecord'+totalTimeSheetRecord2.size());
                    if((totalTimeSheetRecord2.size() ==0)){ 
                       // Integer Count =0;
                       // Decimal sum =0;
                        Timesheet__c ts = new Timesheet__c();
                        ts.Start_Date__c = weekStart;
                        ts.End_Date__c = weekEnd;
                       
                        ts.Name = tt.Name+dateTime.now();
                        ts.Total_Hours__c = tt.Hours__c;
                        ts.User__c = tt.User__c;
                        
                        insert ts;
                        
                    }
                    if((totalTimeSheetRecord2.size() >0)){
                        
                        Decimal sum =0;
                        for(Timesheet__c ts:totalTimeSheetRecord2){
                            //  Timesheet__c ts1 = new Timesheet__c();
                            
                            ts.Total_Hours__c = ts.Total_Hours__c + tt.Hours__c;
                            
                        }
                        update totalTimeSheetRecord2;
                    }
               // }
                
            }
        }
        
        
    }
}