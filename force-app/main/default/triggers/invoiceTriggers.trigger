trigger InvoiceTrigger on Invoice__c (before insert, after update) {
    
    if(Trigger.isBefore && Trigger.isInsert) {
        InvoiceTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        InvoiceTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}
