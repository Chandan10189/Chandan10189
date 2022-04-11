public class CalculateAggregateResults {
    public static void Calculation(set<Id> AccIds){
                 List<AggregateResult> results = [
            SELECT AccountId,COUNT(Id) totalContacts,SUM(Amount__c	) AmountSum
            FROM Contact
            WHERE AccountId IN :AccIds
            GROUP BY AccountId,CreatedDate
            //system.debug('results');
        ];
        // build final list of accounts to update
        // system.debug('results');
        List<Target__c> TargetToUpdate = new List<Target__c>();
        for (AggregateResult result : results) {
            // get account id and number of count and sum of amount
            String accId = String.valueOf(result.get('AccountId'));
            Integer totalContacts = Integer.valueOf(result.get('totalContacts'));
            Integer AmountSum = Integer.valueOf(result.get('AmountSum'));
            //  use Id feild in our target to update it
            Account acc=new Account(id = accId);
            upsert acc;
            Target__c tar = new Target__c(Account__c = accId, Actual__c= totalContacts,Actual_Contact_Amount__c= AmountSum);
            upsert tar;
        }
    }
}