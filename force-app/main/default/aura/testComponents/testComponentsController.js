({
download : function(component, event, helper) {
    	//var id = component.find("docId").get("v.value");
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
                "url":b.getReturnValue()
                //'https://cloudelyinc9-dev-ed.my.salesforce.com/sfc/servlet.shepherd/version/download/0685g000004qa40AAA?operationContext=S1'
                //b.getReturnValue()
                
            });
           
            urlEvent.fire();	
        })
      
    },
     doInit : function(component, event, helper) {
        var action = component.get("c.fetchFiles");
        
        action.setParams({
            "linkedRecId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var result = response.getReturnValue()
                component.set("v.filesIds",result);
            }
        });
        $A.enqueueAction(action);
     },
  save : function(component, event, helper) {
        helper.save(component,event);
    },
    
    waiting: function(component, event, helper) {
    	$A.util.addClass(component.find("uploading").getElement(), "uploading");
    	$A.util.removeClass(component.find("uploading").getElement(), "notUploading");
    },
    
    doneWaiting: function(component, event, helper) {
    	$A.util.removeClass(component.find("uploading").getElement(), "uploading");
    	$A.util.addClass(component.find("uploading").getElement(), "notUploading");
    }
   
})