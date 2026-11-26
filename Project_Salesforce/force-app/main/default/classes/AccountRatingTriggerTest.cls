@isTest
private class AccountRatingTriggerTest {

    @isTest
    static void testHotRating() {

        Account acc = new Account(
            Name = 'Hot Account',
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
    static void testWarmRating() {

        Account acc = new Account(
            Name = 'Warm Account',
            AnnualRevenue = 750000
        );

        insert acc;

        Account result = [
            SELECT Rating FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Warm', result.Rating);
    }

    @isTest
    static void testColdRating() {

        Account acc = new Account(
            Name = 'Cold Account',
            AnnualRevenue = 250000
        );

        insert acc;

        Account result = [
            SELECT Rating FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Cold', result.Rating);
    }

    @isTest
    static void testAccountUpdate() {

        Account acc = new Account(
            Name = 'Update Account',
            AnnualRevenue = 2000000
        );

        insert acc;

        acc.AnnualRevenue = 250000;
        update acc;

        Account result = [
            SELECT Rating FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals('Cold', result.Rating);
    }
}