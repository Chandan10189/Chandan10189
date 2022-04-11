public with sharing class ProductService {
    
    // getProduct query with filter 
    
    @AuraEnabled
    public static List<WrapProductInfo> getProducts(
        String name,
        FilterWrapper filtersData, 
        Map<String, Object> productIdMap
    ) {
    
        
        Map<String,Decimal> checkAddMap = new Map<String,Decimal>();
        for(String key : productIdMap.keySet()){
            checkAddMap.put(key,getQuantity(productIdMap.get(key)));
        } 
        
        system.debug('--checkAddMap--'+checkAddMap);
        
           
        String nameLike = '%' + name + '%';

        String query = 'SELECT Name, ImageUrl__c, Display_Price__c FROM Product2 WHERE Name like :nameLike';

        System.debug('name ' + name);
        System.debug('filtersData ' + filtersData);
        if (filtersData != null) {
            if (
                filtersData.families != null &&
                filtersData.families.size() > 0
            ) {
                String[] families = filtersData.families;
                query += ' AND Family IN :families';
            }
            if (filtersData.minPrice != null) {
                Decimal minPrice = filtersData.minPrice;
                query += ' AND Display_Price__c >= :minPrice';
            }
            if (filtersData.maxPrice != null) {
                Decimal maxPrice = filtersData.maxPrice;
                query += ' AND Display_Price__c <= :maxPrice';
            }
            
            if (filtersData.brand != null && filtersData.brand.size() > 0 ) {
                String[] brands = filtersData.brand;
                query += ' AND Brand__c IN :brands';
            }
            
            if (filtersData.size != null && filtersData.size.size() > 0 ) {
                String[] sizes = filtersData.size;
                query += ' AND Sizes__c IN :sizes';
            }
            
            
            if (filtersData.color != null && filtersData.color.size() > 0 ) {
                String[] colors = filtersData.color;
                query += ' AND Color__c IN :colors';
            }
            
        }
        
        List<WrapProductInfo> productList = new List<WrapProductInfo>();
        
        for(Product2 obj : (Product2[]) Database.query(query)){
            
            if(checkAddMap != null && checkAddMap.containsKey(obj.Id)){
                Decimal qty = checkAddMap.get(obj.Id);
                Decimal total = 0;
                if(obj.Display_Price__c != null){
                  total  =  obj.Display_Price__c * qty;
                }
                
                productList.add(new WrapProductInfo(obj,total,Integer.valueOf(qty),true));
            
            } else {
            
                productList.add(new WrapProductInfo(obj,0,1,false));
            
            }
            
        }
        
        
        return productList;
    }
    
    public class addCartRecord{
        String recordId{get; set;}
        Integer qty{get; set;}
    }
    
    
    
    // get Selected Product for cart 
    
    @AuraEnabled
    public static OrderInfoWrap getSelectedProducts(
        Map<String, Object> productIdMap
    ) {
        
        OrderInfoWrap wrap = new OrderInfoWrap();
        
        Map<String,Decimal> checkAddMap = new Map<String,Decimal>();
        for(String key : productIdMap.keySet()){
            checkAddMap.put(key,getQuantity(productIdMap.get(key)));
        }
        wrap.count =0;
        system.debug('checkAddMap'+checkAddMap);
        
        if(!checkAddMap.isEmpty()){
          Decimal grandTotal = 0;  
          for(Product2 obj : [SELECT Id,Name, Image_Url__c, Display_Price__c FROM Product2 WHERE Id IN: checkAddMap.keyset()]){
              
              Integer qty = Integer.ValueOf(checkAddMap.get(obj.Id));
              grandTotal += qty * obj.Display_Price__c;   
              wrap.productLineList.add(new ProductLine(obj,qty));
              
            system.debug('product--'+obj );
        
          }
          wrap.count = wrap.productLineList.size();
          wrap.total = grandTotal;
            
        }
        
        system.debug('wrap'+wrap);
        
        return wrap;
    }
    
   // Create Account and Create Order with Order Item 
   @AuraEnabled  
   public static String createOrderRecord(Account acc,Map<String, Object> productIdMap) {  
     
     system.debug('---acc---'+acc);
     
     system.debug('---productIdMap---'+productIdMap);
        
     try{
       
       List<Account> accountList = [SELECT Id FROM Account WHERE Email__c= : acc.Email__c LIMIT 1];  
       if(!accountList.isEmpty()){
           acc.Id = accountList[0].Id;     
       }
       
       upsert acc;
       
       Id standardPriceBookId = [select id, name from Pricebook2 where isStandard = true limit 1].Id;
       Order orderRecord = new Order();
       orderRecord.AccountId = acc.Id;
       orderRecord.Pricebook2Id = standardPriceBookId;
       orderRecord.BillingStreet = acc.BillingStreet;
       orderRecord.BillingCity =  acc.BillingCity;
       orderRecord.BillingState = acc.BillingState;
       orderRecord.BillingCountry = acc.BillingCountry;
       orderRecord.ShippingPostalCode = acc.BillingPostalCode;
       orderRecord.ShippingStreet = acc.BillingStreet;
       orderRecord.ShippingCity =  acc.BillingCity;
       orderRecord.ShippingState = acc.BillingState;
       orderRecord.ShippingCountry = acc.BillingCountry;
       orderRecord.ShippingPostalCode = acc.BillingPostalCode;
       orderRecord.Status = 'Draft';
       orderRecord.EffectiveDate = date.today();
       
       insert orderRecord; 
       
       Map<String,Decimal> checkAddMap = new Map<String,Decimal>();
        for(String key : productIdMap.keySet()){
            checkAddMap.put(key,getQuantity(productIdMap.get(key)));
        }
       
       if(!checkAddMap.isEmpty()){
          
          Map<String,String> priceBookEntryMap = new Map<String,String>();
           
          for(PricebookEntry  obj : [SELECT Id,Product2Id FROM PricebookEntry WHERE Pricebook2Id=:standardPriceBookId AND Product2Id IN:checkAddMap.keyset()]){
              priceBookEntryMap.put(obj.Product2Id,obj.Id);
          }
          
          List<OrderItem> orderLineList = new List<OrderItem>();
             
          for(Product2 obj : [SELECT Id,Name, Image_Url__c	, Display_Price__c FROM Product2 WHERE Id IN: checkAddMap.keyset()]){
              
              if(priceBookEntryMap.containsKey(obj.Id)){
                  
                OrderItem oppLineItem = new OrderItem();
                oppLineItem.OrderId = orderRecord.Id;        
                oppLineItem.PricebookEntryId = priceBookEntryMap.get(obj.Id);
                oppLineItem.UnitPrice = obj.Display_Price__c;
                oppLineItem.Quantity = Integer.ValueOf(checkAddMap.get(obj.Id));
                
                orderLineList.add(oppLineItem);
                       
              }
          }
          
          if(!orderLineList.isEmpty()){
              insert orderLineList;
          }
          
            
       }
                 
        
       return orderRecord.Id;
         
     }catch(Exception e){
       
       system.debug(e.getMessage());
         
       throw new AuraHandledException(getErrorFormat(e.getMessage()));
       
     }
     
   }
   
   // get existing account based on email and populate address
   @AuraEnabled  
   public static Account accountInfo(String emailId) {  
       
     try{
       
       Account accountRecord = [SELECT Id,BillingStreet,BillingCity,BillingCountry,BillingPostalCode,BillingState FROM Account WHERE Email__c= : emailId LIMIT 1];
       
       return accountRecord;
         
     } catch(Exception e){
       
       system.debug(e.getMessage());
         
       throw new AuraHandledException(getErrorFormat(e.getMessage()));
       
     }    
       
   }
    // Filter Wrapper class
    
    public class FilterWrapper {
        @AuraEnabled
        public String[] families { get; set; }

        @AuraEnabled
        public Decimal minPrice { get; set; }

        @AuraEnabled
        public Decimal maxPrice { get; set; }

        @AuraEnabled
        public String[] brand { get; set; }

        @AuraEnabled
        public String[] size { get; set; }
        
        @AuraEnabled
        public String[] color { get; set; }
        
        @AuraEnabled
        public Boolean reset{ get; set; }
         
    }
    
    // ProductInfo list Wrapper class
    
    public class WrapProductInfo{
    
        @AuraEnabled
        public Product2 productRecord { get; set; }

        @AuraEnabled
        public Decimal totalPrice{ get; set; }

        @AuraEnabled
        public Integer quantity{ get; set; }

        @AuraEnabled
        public Boolean isAddedToCart{ get; set; }
        
        public WrapProductInfo(Product2 productRecord ,Decimal totalPrice,Integer quantity,Boolean isAddedToCart){
            
            this.productRecord = productRecord;
            this.totalPrice = totalPrice;
            this.quantity = quantity;
            this.isAddedToCart = isAddedToCart;
             
        }

    }
    
    // Wrapper class for productline use in cart details
    public class ProductLine{
    
        @AuraEnabled
        public Product2 productRecord { get; set; }

        @AuraEnabled
        public Integer quantity { get; set; }

        @AuraEnabled
        public Decimal total { get; set; }
        
        public ProductLine(Product2 productRecord,Integer quantity){
            this.productRecord = productRecord;
            this.quantity = quantity;
            total = quantity * productRecord.Display_Price__c;
            
        }

    }
    
    //Wrapper class for cart details
    public class OrderInfoWrap{
    
        @AuraEnabled
        public List<ProductLine> productLineList { get; set; }

        @AuraEnabled
        public Decimal count{ get; set; }
        
        @AuraEnabled
        public Decimal total { get; set; }
        
        
        public OrderInfoWrap(){
            productLineList  = new List<ProductLine>();
            total = 0;
        }
    }
    
    // get Quantity
    public static Decimal getQuantity(Object qty){
         
         Decimal  val;
         
         if(qty instanceof  String ){
         
             String str = (STRING) qty;
             
             val = decimal.valueOf(str);
         
         } else if(qty instanceof  Decimal){
             val = (Decimal) qty;
         }   
        
        return val;
    }
    
    //get error messaage
    public static string getErrorFormat(String error){
       
       if(error.contains('CUSTOM_VALIDATION_EXCEPTION,')){
            error = error.substringAfter('CUSTOM_VALIDATION_EXCEPTION,');
            error = error.replace('[]','');
       }
        
       return error; 
   } 
    
}