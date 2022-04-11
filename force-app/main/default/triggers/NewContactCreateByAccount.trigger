trigger NewContactCreateByAccount on Account (After insert) {
    List<Contact> contacts=new List<Contact>();
    For(Account acc:trigger.new){
        Contact cont=new Contact();
        cont.FirstName='Info';
        cont.LastName='Default';
        cont.Email='info@websitedomain.tld';
        List<Contact> c=[select Id from Contact Where account.id=: acc.Id];//problem
        IF(c.size()>0){
            cont.Account.Only_Default_Contac__c=False;
        } Else{
            cont.Account.Only_Default_Contac__c=True;
        }
        
        contacts.add(cont);
    }
}