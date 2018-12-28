trigger PaymentTrigger on Payment__c (before insert, after insert, before update, after update, before delete, after delete) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            PaymentTriggerHandler.beforeInsert(Trigger.new);
        }
        else {
            PaymentTriggerHandler.afterInsert(Trigger.newMap, Trigger.oldMap);
        }
    }
    else if (Trigger.IsUpdate) {
        if (Trigger.isBefore) {
            PaymentTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
        else {
            PaymentTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
    else if (Trigger.isDelete) {
        if (Trigger.isBefore) {
            PaymentTriggerHandler.beforeDelete(Trigger.oldMap);
        }
        else {
            PaymentTriggerHandler.afterDelete(Trigger.oldMap);
        }
    }
}