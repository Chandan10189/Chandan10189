({
   // MAX_FILE_SIZE: 750 000, /* 1 000 000 * 3/4 to account for base64 */

    save : function(component,event) {
       // component.set("v.loaded",true);
       
        console.log(component.get('v.loaded'));
        var fileInput =  event.getSource().get("v.files");
       // var fileInput = component.find("file").getElement();
    	var file = fileInput[0];
   
       // if (file.size > this.MAX_FILE_SIZE) {
        //    alert('File size cannot exceed ' + this.MAX_FILE_SIZE + ' bytes.\n' +
    		//  'Selected file size: ' + file.size);
    	  //  return;
     //   }
    
        var fr = new FileReader();
        console.log(fr.result);
	var self = this;
       	fr.onload = function() {
            var fileContents = fr.result;
    	    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;

            fileContents = fileContents.substring(dataStart);
        
    	    self.upload(component, file, fileContents);
        };

        fr.readAsDataURL(file);
    },
        
    upload: function(component, file, fileContents) {
        var action = component.get("c.saveTheFile"); 
		var attachId = '';
        action.setParams({
            parentId: component.get("v.recordId"),
            fileName: file.name,
            base64Data: encodeURIComponent(fileContents), 
            contentType: file.type
        });

        action.setCallback(this, function(a) {
            attachId = a.getReturnValue();
            console.log(attachId);
            alert('done');
          //  component.set("v.loaded", false);
             $A.get('e.force:refreshView').fire();
        });
            
    		
            $A.enqueueAction(action); 
    }
})