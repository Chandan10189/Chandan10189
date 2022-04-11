public class getContactList {
    public static void getContact(Set <id> caseId){
        set<id> accountIds = new set<id>();
        List<case> caseList = [Select id, AccountId from Case where AccountId IN :caseId ];
        if(caseList.size()>0){
             for(case cs :caseList ){
                 
                     accountIds.add(cs.AccountId);
                 }
            }
            List<Contact> conList = [SELECT AccountId,Name FROM Contact where AccountId In :accountIds];
            for(Contact con : conList ){
                system.debug('Contact Information is'+con.Name);
            }
        
        }
       
    }