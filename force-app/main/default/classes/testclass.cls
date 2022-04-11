public with sharing class testclass {
    @AuraEnabled(cacheable=true)
    public static string DownloadAttachment(id DownloadAttachmentID){
    //  Id DownloadAttachmentID = '0065g00000FmTVFAA3';
        ContentVersion oldCV = [Select Id,Title from ContentVersion Where ContentDocumentId=:DownloadAttachmentID and IsLatest = true ];
        System.Debug('Old LV INitial :'+ oldCV.Id);
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
        String URlDownload = fullFileURL+'/sfc/servlet.shepherd/version/download/'+oldCV.Id;
        system.debug('Download URL:' +URlDownload);
        return URlDownload;
    }
     @AuraEnabled
    public static List<Attachment> fetchFiles(String linkedRecId){
        system.debug('Record Id is'+linkedRecId);
		//List<ContentDocumentLink> cdlList = [SELECT ContentDocumentId,ContentDocument.title,contentDocument.ContentSize,contentDocument.CreatedDate,contentDocument.FileType,ContentDocument.ParentId FROM ContentDocumentLink WHERE LinkedEntityId =: linkedRecId];
		List<Attachment> cdlList= [SELECT Parentid, Id, ContentType, Name, Body, BodyLength, CreatedDate  FROM Attachment WHERE Parentid =: linkedRecId];
        system.debug(cdlList);
        return cdlList;
      //  system.debug('Attachment Query Resul is'+cdlList);
    }
    
   @AuraEnabled
    public static Id saveTheFile(String parentId, String fileName, String base64Data, String contentType) { 
        system.debug('Parent ID =='+parentId);
         system.debug('FileName=='+fileName);
         system.debug('Content Type =='+contentType);
         
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
         system.debug('base64Data =='+base64Data);
        Attachment a = new Attachment();
        
        a.parentId = parentId;

        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        system.debug('Attachment to insert=='+a);
        insert a;
        
        return a.Id;
    }
    
    @AuraEnabled
    public static Id saveTheChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) { 
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id = :fileId
        ];
        
     	String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update a;
    }
}