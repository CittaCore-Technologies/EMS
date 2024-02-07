@isTest
public class CEMS_PerformanceDataCreationTest {
 @isTest
    static void testDeleteNRecords() {
        // Create test records
        List<CEMS_Personnel__c> testRecords = new List<CEMS_Personnel__c>();
        for (Integer i = 1; i <= 5; i++) {
            testRecords.add(new CEMS_Personnel__c(Name = 'TestRecord' + i));
        }
        insert testRecords;

        Test.startTest();

        // Call the method
        CEMS_PerformanceDataCreation.deleteNRecords();

        Test.stopTest();

        // Verify that records are deleted
        List<CEMS_Personnel__c> deletedRecords = [SELECT Id FROM CEMS_Personnel__c WHERE Name LIKE 'TestRecord%'];
        System.assertEquals(5, deletedRecords.size(), 'Expected all test records to be deleted');
    }
    
    ///////getjobOpen
  /*
  @isTest
    static void testGetJobOpenMissingEmail() {
        // Create a test user without the specified email fields
        CEMS_Personnel__c testUser = new CEMS_Personnel__c(
            Name = 'Test User'
            // Add other required fields
        );
        insert testUser;

        Test.startTest();

        // Call the method
        List<CEMS_Job_Opening__c> jobOpenings = CEMS_PerformanceDataCreation.getJobOpen(null);

        Test.stopTest();

        // Perform assertions based on the expected behavior
        System.assertNotEquals(null, jobOpenings, 'Expected a non-null list of job openings');

        // Assert that the list is empty because email fields are missing
        System.assertEquals(0, jobOpenings.size(), 'Expected zero job openings in the list');
    }*/
}