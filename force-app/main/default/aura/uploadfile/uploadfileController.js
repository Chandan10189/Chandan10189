({
    handleFilesChange : function (component, event, helper) {
        var files = event.getSource().get("v.files");
        console.log(files);
        
        component.set('v.attList',files);
        alert(v.attList);
        console.log(component.get('v.attList'));
        alert(files.length + ' files !!');
    },
    
    download : function(component, event, helper) {
       var id = '0695g000004VowGAAS';       
        alert('Document ID:' +id);
        var actiondownload = component.get("c.DownloadAttachment");
        
        actiondownload.setParams({
          "DownloadAttachmentID":id
        });
        actiondownload.setCallback(this, function(b){
            component.set("v.Baseurl", b.getReturnValue());
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": 'https://cloudelyinc9-dev-ed.my.salesforce.com/sfc/servlet.shepherd/version/download/0685g000004qa40AAA?operationContext=S1'
                //b.getReturnValue()
                
            });
           
            urlEvent.fire();	
        })
      
    }
        
        
    
})