@isTest
public class ActivationTest_Test {

    @isTest
    static void testTriggerLogic() {
        // Create a TriggerDeactivation__c custom setting record
        TriggerDeactivation__c customSetting = new TriggerDeactivation__c(Name = 'MakeActive', IsActive__c = true);
        insert customSetting;

        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');

        // Ensure the trigger logic modifies the Account name
        Test.startTest();
        insert testAccount;
        Test.stopTest();

        // Retrieve the modified Account
        Account modifiedAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id];

        // Assert that the Account name has been modified as expected
        System.assertEquals('Test Account Modified', modifiedAccount.Name);
    }

    @isTest
    static void testTriggerWithDeactivation() {
        // Create a TriggerDeactivation__c custom setting record with IsActive__c set to false
        TriggerDeactivation__c customSetting = new TriggerDeactivation__c(Name = 'MakeActive', IsActive__c = false);
        insert customSetting;

        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');

        // Ensure the trigger does not modify the Account name when custom setting is inactive
        Test.startTest();
        insert testAccount;
        Test.stopTest();

        // Retrieve the original Account
        Account originalAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id];

        // Assert that the Account name has not been modified
        System.assertEquals('Test Account', originalAccount.Name);
    }
}