public with sharing class TestDataFactory {
    public static List<Contact> createContacts(Integer numberOfRecords, Boolean doInsert) {
        List<Contact> lstContacts = new List<Contact>();

        for (Integer i=0; i<numberOfRecords; i++) {
            Contact c = new Contact();
            lstContacts.add(c);
        }

        if (doInsert) {
            insert lstContacts;
        }

        return lstContacts;
    }

    public static List<Contact> createContacts(String lastName, Integer numberOfRecords, Boolean doInsert) {
        List<Contact> lstContacts = createContacts(numberOfRecords, false);

        Integer i=0;
        for (Contact c : lstContacts) {
            if (numberOfRecords > 1) {
                c.LastName = lastName + String.valueOf(i);
            }
            else {
                c.LastName = lastName;
            }

            i++;
        }

        if (doInsert) {
            insert lstContacts;
        }

        return lstContacts;
    }

    public static List<Account> createAccounts(Integer numberOfRecords, Boolean doInsert) {
        List<Account> lstAccounts = new List<Account>();

        for (Integer i=0; i<numberOfRecords; i++) {
            Account a = new Account();
            lstAccounts.add(a);
        }

        if (doInsert) {
            insert lstAccounts;
        }

        return lstAccounts;
    }

    public static List<Account> createAccounts(String name, Integer numberOfRecords, Boolean doInsert) {
        List<Account> lstAccounts = createAccounts(numberOfRecords, false);

        Integer i=0;
        for (Account a : lstAccounts) {
            if (numberOfRecords > 1) {
                a.Name = name + String.valueOf(i);
            }
            else {
                a.Name = name;
            }

            i++;
        }

        if (doInsert) {
            insert lstAccounts;
        }

        return lstAccounts;
    }
}
