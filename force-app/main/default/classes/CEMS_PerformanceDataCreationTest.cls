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
         @isTest
    static void testGetJobOpen() {
        // Create a test user with the specified email
        String testEmail = 'test@example.com';
        CEMS_Personnel__c testUser = new CEMS_Personnel__c(
            Name = 'Test User',
            CEMS_Personal_Email__c = testEmail,
            CEMS_Work_Email__c = testEmail
            // Add other required fields
        );
        insert testUser;

        // Create an approved job opening
        CEMS_Job_Opening__c approvedJobOpening = new CEMS_Job_Opening__c(
            Name = 'Software Developer',
            // Add other required fields
            CEMS_Approval_Status__c = 'Approved'
        );
        insert approvedJobOpening;

        Test.startTest();

        // Call the method
        List<CEMS_Job_Opening__c> jobOpenings = CEMS_PerformanceDataCreation.getJobOpen(testEmail);

        Test.stopTest();

        // Perform assertions based on the expected behavior
        System.assertNotEquals(null, jobOpenings, 'Expected a non-null list of job openings');

        // Assert that the list contains the approved job opening
        System.assertEquals(1, jobOpenings.size(), 'Expected one job opening in the list');
        System.assertEquals('Software Developer', jobOpenings[0].Name, 'Incorrect job opening name');
    }
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
    }
}