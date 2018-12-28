public with sharing class PaymentContactCalculationSchedulable implements Schedulable{
    public void execute(SchedulableContext ctx) {
        Date currentDate = Date.today();

        List<Payment__c> lstPayments = [SELECT 
                Id,
                Contact__c
            FROM
                Payment__c
            WHERE
                CALENDAR_MONTH(Payment_Date__c) = :currentDate.month()
                AND CALENDAR_YEAR(Payment_Date__c) = :currentDate.year()
                AND Void__c = False];

        PaymentService.calculateTotalPaymentAmountThisMonth(lstPayments);
    }
}
