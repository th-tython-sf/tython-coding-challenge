@isTest
public with sharing class PaymentServiceTest {
    @isTest
    public static void testPaymentService1() {
        List<Account> lstAccounts = TestDataFactory.createAccounts('test', 1, true);
        List<Contact> lstContacts = TestDataFactory.createContacts('test', 3, true);

        Date d = Date.today();

        List<Payment__c> lstPayments = new List<Payment__c>();

        Payment__c p1 = new Payment__c();
        p1.Account__c = lstAccounts[0].Id;
        p1.Amount__c = 100.1;
        p1.Contact__c = lstContacts[0].Id;
        p1.Payment_Date__c = d;
        p1.Void__c = False;
        lstPayments.add(p1);

        Payment__c p2 = new Payment__c();
        p2.Account__c = lstAccounts[0].Id;
        p2.Amount__c = 200.2;
        p2.Contact__c = lstContacts[0].Id;
        p2.Payment_Date__c = d;
        p2.Void__c = False;
        lstPayments.add(p2);

        Payment__c p3 = new Payment__c();
        p3.Account__c = lstAccounts[0].Id;
        p3.Amount__c = 100.1;
        p3.Contact__c = lstContacts[0].Id;
        p3.Payment_Date__c = d;
        p3.Void__c = True;
        lstPayments.add(p3);

        Payment__c p4 = new Payment__c();
        p4.Account__c = lstAccounts[0].Id;
        p4.Amount__c = 100.1;
        p4.Contact__c = lstContacts[1].Id;
        p4.Payment_Date__c = d;
        p4.Void__c = True;
        lstPayments.add(p4);

        insert lstPayments;

        Test.startTest();
            Contact c1 = [SELECT Id, Total_Payment_Amount_this_Month__c FROM Contact WHERE Id = :lstContacts[0].Id];

        Test.stopTest();

        System.assertEquals(300.3, c1.Total_Payment_Amount_this_Month__c);
    }
}
