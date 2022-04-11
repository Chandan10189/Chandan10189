public class ContactTriggerHelper {
    public static void scoreSum(List<Contact> conList){
        Set<Id> accountIds = new Set<Id>();
        List<Account> acc1 = new List<Account>();
        List<Account> acc2 = new List<Account>();
        
        for(Contact con : conList ){
            accountIds.add(con.AccountId);
        }
        
        for(AggregateResult ar :[SELECT AccountId,SUM(Score1__c) sum1,SUM(Score2__c) sum2 FROM Contact  where AccountId in: accountIds  GROUP BY AccountId]){
            
            acc1.add(new Account(Id = (Id)ar.get('AccountId'),AccountScore1__c= (Decimal)ar.get('sum1') ));
            acc2.add(new Account(Id = (Id)ar.get('AccountId'),AccountScore1__c= (Decimal)ar.get('sum2') ));
        }
        update acc1;
        update acc2;
    }
}