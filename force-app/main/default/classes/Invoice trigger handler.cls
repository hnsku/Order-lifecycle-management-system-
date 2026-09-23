public class InvoiceTriggerHandler {
    
    public static void handleAfterUpdate(List<Invoice__c> newList, Map<Id, Invoice__c> oldMap) {
        List<Account> accToUpdate = new List<Account>();
        
        for(Invoice__c inv : newList) {
            if(inv.Status__c == 'Paid' && oldMap.get(inv.Id).Status__c != 'Paid') {
                accToUpdate.add(new Account(
                    Id = inv.Account__c,
                    Last_Payment_Date__c = Date.today()
                ));
            }
        }
        
        if(!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
    
    public static void handleBeforeInsert(List<Invoice__c> newList) {
        for(Invoice__c inv : newList) {
            if(inv.Amount__c <= 0) {
                inv.addError('Invoice Amount must be greater than 0');
            }
        }
    }
}
