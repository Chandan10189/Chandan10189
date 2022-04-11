public class ContactCreationController {
      @AuraEnabled
    public static List<Contact> createContacts(List<Contact> contactList){
        insert contactList;
            return contactList;
    }
}