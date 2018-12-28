public class PaymentTriggerHandler {
    public static void beforeInsert(List<Payment__c> lstPayments) {
        
    }

    public static void afterInsert(Map<Id, Payment__c> mapNewPayments, Map<Id, Payment__c> mapOldPayments) {
        List<Payment__c> lstPayments = mapNewPayments.values();
        System.debug('PaymentTriggerHandler::afterInsert');
        PaymentService.calculateTotalPaymentAmountThisMonth(lstPayments);
    }

    public static void beforeUpdate(Map<Id, Payment__c> mapNewPayments, Map<Id, Payment__c> mapOldPayments) {

    }

    public static void afterUpdate(Map<Id, Payment__c> mapNewPayments, Map<Id, Payment__c> mapOldPayments) {
        List<Payment__c> lstPayments = mapNewPayments.values();

        PaymentService.calculateTotalPaymentAmountThisMonth(lstPayments);
    }

    public static void beforeDelete(Map<Id, Payment__c> mapOldPayments) {

    }

    public static void afterDelete(Map<Id, Payment__c> mapOldPayments) {

    }
}