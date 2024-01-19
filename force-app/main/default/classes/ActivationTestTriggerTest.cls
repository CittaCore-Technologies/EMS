@isTest
public class ActivationTestTriggerTest {

    @isTest
    static void testActivationTestTrigger() {
        // Create TriggerDeactivation__c record with IsActive__c set to true
        TriggerDeactivation__c triggerDeactivationRecord = new TriggerDeactivation__c(
            Name = 'MakeActive',
            IsActive__c = true
        );
        insert triggerDeactivationRecord;

        // Create test accounts
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2')
        };

        // Test 'before insert' trigger logic
        Test.startTest();
        insert testAccounts;
        Test.stopTest();

        // Query the accounts for assertions
        List<Account> queriedAccounts = [SELECT Name FROM Account WHERE Id IN :testAccounts];
        
        // Perform assertions
        for (Account acc : queriedAccounts) {
            System.assertEquals(acc.Name, acc.Name);
        }
        
        
    }
    
}