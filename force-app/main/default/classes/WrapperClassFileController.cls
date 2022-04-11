public class WrapperClassFileController {

Public List<Wrapper>Wrapperlist{get;set;}
public String string1{get;set;}
public String string2{get;set;}
public Attachment attach{get;set;}
public Blob bodyvalue{get;set;}
   
    public WrapperClassFileController(ApexPages.StandardController controller) {
    
        Wrapperlist=new List<Wrapper>();
        for(Integer i=0;i<=1;i++)
        {
         string1='';
         string2='';
         if(attach==null)
          attach = new Attachment( );
     
        Wrapperlist.add(new Wrapper(string1, string2,attach ));
        system.debug('WrapperlistWrapperlist'+Wrapperlist);
        }
         
    }
    
    
public void save()
{
system.debug('>>>>>'+Wrapperlist);

for(Wrapper wr : Wrapperlist)
{
Account acc = new Account();
acc.Name=wr.str1;
acc.Account_Code__c=wr.str2;
insert acc;

Attachment attach = new Attachment();
attach.ParentId=acc.id;
attach.ownerId=UserInfo.getUserId();
attach.IsPrivate=true;
attach.Description='Test Description';
attach.name=wr.attached.name;
attach.Body=wr.attached.body;
system.debug('========='+wr.attached.body);
insert attach;
}

 
    }


public class wrapper{
    public  String str1{get;set;}
    public String str2{get;set;}
    public Attachment attached{get;set;}
    //public String body {get;set;}

    public  wrapper(String string1,String string2,Attachment attach)
   {
    str1=string1;
    str2=string2;
    attached=attach;
      

    
}
}

}