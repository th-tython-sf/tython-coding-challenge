public with sharing class PaymentService {
    public static void calculateTotalPaymentAmountThisMonth(List<Payment__c> lstPayments) {
        System.debug('PaymentService::calculateTotalPaymentAmountThisMonth');

        List<Id> lstContactIds = new List<Id>();

        for (Payment__c p : lstPayments) {
            lstContactIds.add(p.Contact__c);
        }

        Map<Id, Contact> mapContacts = new Map<Id, Contact>([SELECT
                Id,
                Total_Payment_Amount_this_Month__c
            FROM
                Contact
            WHERE
                Id IN :lstContactIds]);

        System.debug('Map contacts' + mapContacts);

        Date currentDate = Date.today();

        List<Payment__c> lstPaymentsOnContact = [SELECT 
                Id,
                Contact__c,
                Amount__c
            FROM
                Payment__c
            WHERE
                Contact__c IN :lstContactIds
                AND CALENDAR_MONTH(Payment_Date__c) = :currentDate.month()
                AND CALENDAR_YEAR(Payment_Date__c) = :currentDate.year()
                AND Void__c = False];

        // Key is ContactId, Value is List<Payment__c>
        Map<Id, List<Payment__c>> mapPayments = new Map<Id, List<Payment__c>>();

        for (Payment__c p : lstPaymentsOnContact) {
            if (p.Contact__c != null) {
                if (!mapPayments.containsKey(p.Contact__c)) {
                    mapPayments.put(p.Contact__c, new List<Payment__c>());
                }

                mapPayments.get(p.Contact__c).add(p);
            }
        }

        for (Id contactId : mapContacts.keySet()) {
            List<Payment__c> lstContactPayments = mapPayments.get(contactId);

            System.debug('contact payments' + lstContactPayments);
            Double totalPrice = 0;
            if (lstContactPayments != null) {
                for (Payment__c p : lstContactPayments) {
                    totalPrice += p.Amount__c;
                }
            }

            mapContacts.get(contactId).Total_Payment_Amount_this_Month__c = totalPrice;
        }

        System.debug('New MapContacts' + mapContacts);

        update mapContacts.values();
    }

    public static void schedulePaymentServiceFirstDayOfMonth() {
        PaymentContactCalculationSchedulable s = new PaymentContactCalculationSchedulable();
        String sch = '1 0 1 * * *';
        String jobID = system.schedule('Payment Contact Calculation', sch, s);
    }
}
