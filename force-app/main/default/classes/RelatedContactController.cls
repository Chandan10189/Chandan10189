public class RelatedContactController {
    public List<WrapperClass> wrapList{get;set;}
    Public List<Contact> conList{get;set;}
    public Account acc = new Account();
    public boolean bool{get;set;}
    
    public RelatedContactController(ApexPages.StandardController Controller){
        wrapList = new List<WrapperClass>();
        conList = new List<Contact>();
        acc = (Account)Controller.getRecord();
        if(acc.Id !=null){
            conList = [Select accountId, firstName, lastName, phone, email from contact where accountId =: acc.Id];
         }
            if(conList.size()>0){
                for(Contact con: conList){
                    wrapList.add(new WrapperClass(con,false));
                }
            }   
        }
  
    
    public void del(){
        List<Contact> conDelList = new List<Contact>();
        List<WrapperClass> wrapDelList = new List<WrapperClass>();
        for(WrapperClass wrap: wrapList){
            if(wrap.checked){
                conDelList.add(wrap.con);
            }
            else{
                wrapDelList.add(wrap);
            }
        }
        if(conDelList.size()>0){
            delete conDelList;
            wrapList = wrapDelList;
        }
    }
    
    public void selectAll(){
       if(bool){
            for(WrapperClass wrap : wrapList){
                wrap.checked = true;
            }
        }
            else{
                for(WrapperClass wrap : wrapList){
                    wrap.checked = false;
                }
            }
        }
    
    public PageReference save() {
        List<Contact> contactList = new List<Contact>();
        for(WrapperClass cc :wrapList){
            contactList.add(cc.con);
        }
        if(!contactList.isEmpty()){
            upsert contactList;  
        }
        upsert this.acc;
        return null;
    }
    
    public void addContact(){
        Contact c = new Contact();
        c.AccountId = acc.Id;
        WrapperClass wrp = new WrapperClass(c,false);
        wrapList.add(wrp);
    }
    
    public PageReference cancel() {
         
        return null;
    }
    
    
    public class WrapperClass{
        public boolean checked{get;set;}
        public Contact con{get;set;}
        public WrapperClass(Contact con, boolean ischeck){
            this.con = con;
            checked = ischeck ;
        }
    }
}