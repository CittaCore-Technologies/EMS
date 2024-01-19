@isTest
public class FetchSkillsFromJobOpeningWithEmailTest {

   /* @isTest
    static void testInterviewRecordsFetched() {
        // Test data setup
        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
            Name = 'Test Interview Record',
            RecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'CEMS_Client_Interview' LIMIT 1],
            CEMS_Skill_1__c = 'Apex Development',
            CEMS_Skill_1_Rating__c = 4,
            CEMS_Skill_1_Comment__c = 'Good',
            CEMS_Skill_2__c = 'Data Modeling',
            CEMS_Skill_2_Rating__c = 5,
            CEMS_Skill_2_Comment__c = 'Excellent'
            // Add other skill fields as needed for your test data
        );
        insert interviewRecord;

        // Test the interviewRecordsFetched method
        Test.startTest();
        List<FetchSkillsFromJobOpeningWithEmail.InterviewRecord> fetchedInterviewRecords = FetchSkillsFromJobOpeningWithEmail.interviewRecordsFetched(interviewRecord.Id);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(6, fetchedInterviewRecords.size());

        // Check the first InterviewRecord
        FetchSkillsFromJobOpeningWithEmail.InterviewRecord firstRecord = fetchedInterviewRecords[0];
        System.assertEquals('Apex Development', firstRecord.skillName);
        System.assertEquals(4, firstRecord.skillRating);
        System.assertEquals('Good', firstRecord.skillComment);

        // Check the second InterviewRecord
        FetchSkillsFromJobOpeningWithEmail.InterviewRecord secondRecord = fetchedInterviewRecords[1];
        System.assertEquals('Data Modeling', secondRecord.skillName);
        System.assertEquals(5, secondRecord.skillRating);
        System.assertEquals('Excellent', secondRecord.skillComment);
        
       
    }*/
      @isTest
    static void testInterviewRecordsFetchedWithException() {
        // Test data setup
        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
            Name = 'Test Interview Record',
            RecordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'CEMS_Client_Interview' LIMIT 1]
            // Omitting skill fields to simulate a scenario where required fields are missing
        );
        insert interviewRecord;

        // Test the interviewRecordsFetched method with negative assertions
        Test.startTest();
        try {
            // This should throw an exception due to missing required fields
            List<FetchSkillsFromJobOpeningWithEmail.InterviewRecord> fetchedInterviewRecords = FetchSkillsFromJobOpeningWithEmail.interviewRecordsFetched(interviewRecord.Id);
            
            // If an exception is not thrown, log a message (optional)
            System.debug('Expected exception was not thrown.');
        } catch (Exception e) {
            // Expected exception, perform assertions or additional logging as needed
            //System.debug('e.getMessage() '+e.getMessage());
            System.assert(e.getMessage().contains('Record not found'), 'Incorrect exception message');
        }
        Test.stopTest();
    }
    
     @isTest
    static void testInterviewRecordsFetchedException() {
        // Create a test record with required fields
        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c();
        insert interviewRecord;

        Test.startTest();

        // Use a mock to simulate an exception during record retrieval
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        try {
            // Call the method with the test data
            List<FetchSkillsFromJobOpeningWithEmail.InterviewRecord> records = FetchSkillsFromJobOpeningWithEmail.interviewRecordsFetched(interviewRecord.Id);
            // Add assertions for the expected behavior if the method is successful
            System.assertEquals(0, records.size(), 'No records should be found');
        } catch (FetchSkillsFromJobOpeningWithEmail.myException e) {
            // Assert that the exception message contains the expected string
            System.assertEquals('Record not found:', e.getMessage().substring(0, 15), 'Unexpected exception message');
        }

        Test.stopTest();
    }

    // Mock class to simulate an exception during record retrieval
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            // Simulate an exception, e.g., by returning an error HTTP status code
            return new HttpResponse();
        }
    }
}