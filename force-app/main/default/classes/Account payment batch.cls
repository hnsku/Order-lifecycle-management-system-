public class AccountPaymentBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    public Integer totalProcessed = 0;
    public Integer totalFailed = 0;
    
    // 1. START: Fetch all pending invoices
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Amount__c, Status__c, Account__c 
            FROM Invoice__c 
            WHERE Status__c = 'Pending'
        ]);
    }
    
    // 2. EXECUTE: Process invoices and mark as Paid
    public void execute(Database.BatchableContext bc, List<Invoice__c> invoices) {
        List<Invoice__c> toUpdate = new List<Invoice__c>();
        
        for(Invoice__c inv : invoices) {
            try {
                inv.Status__c = 'Paid';
                inv.Payment_Date__c = Date.today();
                toUpdate.add(inv);
                totalProcessed++;
            } catch(Exception e) {
                totalFailed++;
                System.debug('Error processing invoice ' + inv.Id + ': ' + e.getMessage());
            }
        }
        
        if(!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
    
    // 3. FINISH: Log summary
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed! Total Processed: ' + totalProcessed + ' Total Failed: ' + totalFailed);
