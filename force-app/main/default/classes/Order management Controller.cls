public with sharing class OrderManagementController {
    
    @AuraEnabled
    public static String createOrderWithItems(String accountId, List<Map<String, Object>> products) {
        try {
            Order newOrder = new Order(
                AccountId = accountId,
                EffectiveDate = Date.today(),
                Status = 'Draft'
            );
            insert newOrder;
            
            List<OrderItem> items = new List<OrderItem>();
            for(Map<String, Object> prod : products) {
                OrderItem oi = new OrderItem(
                    OrderId = newOrder.Id,
                    PricebookEntryId = (String)prod.get('pbeId'),
                    Quantity = (Integer)prod.get('qty'),
                    UnitPrice = (Decimal)prod.get('price')
                );
                items.add(oi);
            }
            insert items;
            return newOrder.Id;
            
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Order> getOrders(String accId) {
        return [SELECT Id, OrderNumber, Status, TotalAmount FROM Order WHERE AccountId =: accId];
    }
}
