public class opportunityHelper {
    public static void oppAmountCount(List<Opportunity> oppList){
        Set<id> accountIdSet= new Set<Id>();
        Map<String,Opportunity> oppMap = new Map<String,Opportunity>();
        for(Opportunity oppObj:oppList){
            if(oppObj.AccountId != null && oppObj.StageName=='Closed Won'){
                accountIdSet.add(oppObj.AccountId);
                String key=oppObj.AccountId + '-'+'Month'+'-'+ 'Year';
                oppMap.put(key,oppObj);
            }
        }
        if(accountIdSet!=null && accountIdSet.size()>0){
            for(AggregateResult agrResultObj:[select count(id) oppCount,SUM(Amount) SumAmount,AccountId from Opportunity where AccountId in:accountIdSet Group By AccountId ]){
               Account accObj= new Account();
                accObj.Id= (Id)agrResultObj.get('AccountId');
                String key=accObj.Id+'-'+'month'+'-'+'year';
                //system.debug('key');
                Opportunity opp = new Opportunity();
                opp.Id= (Id)agrResultObj.get('AccountId');
                oppMap.put(key,opp);
            }
            if(oppMap!=null && oppMap.size()>0){
                update oppMap.values();
            }
        }
    }
}