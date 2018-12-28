public with sharing class AccountPaymentsCtl {
    @AuraEnabled
    public static String getAccounts() {
        List<Account> lstAccounts = new List<Account>([SELECT Id, Name FROM Account]);
        AggregateResult[] lstRes = [SELECT COUNT(Id), Account__c FROM Payment__c WHERE Void__c = False GROUP BY Account__c ];

        List<AccountPaymentDto> lstAccountPayments = new List<AccountPaymentDto>();

        for (Account a : lstAccounts) {
            Boolean accountFound = false;
            for (AggregateResult res : lstRes) {
                if (a.Id == res.get('Account__c')) {
                    accountFound = true;
                    AccountPaymentDto apd = new AccountPaymentDto();

                    apd.accountId = a.Id;
                    apd.accountName = a.Name;
                    apd.numberOfPayments = (Integer)res.get('expr0');

                    lstAccountPayments.add(apd);
                }
            }

            if (!accountFound) {
                AccountPaymentDto apd = new AccountPaymentDto();
                apd.accountId = a.Id;
                apd.accountName = a.Name;
                apd.numberOfPayments = 0;

                lstAccountPayments.add(apd);
            }
        }

        return JSON.serialize(lstAccountPayments);
    }

    @AuraEnabled
    public static void voidPayment(String accountId){
        List<Payment__c> lstPayments = [SELECT Id, Void__c FROM Payment__c WHERE Account__c = :accountId];

        for (Payment__c p : lstPayments) {
            p.Void__c = True;
        }

        update lstPayments;

        return;
    }

    public class AccountPaymentDto {
        public String   accountName         { get; set; }
        public String   accountId           { get; set; }
        public Integer  numberOfPayments    { get; set; }
    }
}
