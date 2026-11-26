@isTest
private class AccountRatingTriggerTest {

    @isTest
    static void testAccountInsert() {

        Account acc = new Account(
            Name = 'Test Account',
            AnnualRevenue = 2000000
        );

        insert acc;

        Account result = [
            SELECT Rating FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Hot', result.Rating);
    }

    @isTest
    static void testAccountUpdate() {

        Account acc = new Account(
            Name = 'Test Account',
            AnnualRevenue = 2000000
        );

        insert acc;

        acc.AnnualRevenue = 500000;
        update acc;

        Account result = [
            SELECT Rating FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Warm', result.Rating);
    }
}