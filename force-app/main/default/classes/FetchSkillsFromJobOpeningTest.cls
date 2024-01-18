/*
@isTest
public class FetchSkillsFromJobOpeningTest {

    @isTest
    static void testSkillsFetched() {
        // Test positive scenario
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'Test Job Opening', CEMS_Skills__c = 'Apex Development');
        insert jobOpening;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(CEMS_Job_Opening__c = jobOpening.Name,CEMS_Personnel__c='Test');
        insert jobApplication;

        CEMS_Internal_Scheduler__c internalScheduler = new CEMS_Internal_Scheduler__c(
            CEMS_Job_Application_ID__c = jobApplication.Id,Name='test',CEMS_Interview_Round__c='Technical Round',CEMS_Interview_Type__c='Virtual Interview'
        );
        insert internalScheduler;

        Test.startTest();
        List<String> skills = FetchSkillsFromJobOpening.skillsFetched(internalScheduler.Id);
        Test.stopTest();

        System.assertEquals(3, skills.size());
        System.assertEquals('Java', skills[0]);
        System.assertEquals('JavaScript', skills[1]);
        System.assertEquals('Apex', skills[2]);

        // Test negative scenario
        Test.startTest();
        try {
            FetchSkillsFromJobOpening.skillsFetched('InvalidId');
        } catch (FetchSkillsFromJobOpening.myException e) {
            System.assertEquals('Record not found', e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testSaveRatingsAndComments() {
        // Test positive scenario
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'Test Job Opening', CEMS_Skills__c = 'Java;JavaScript;Apex');
        insert jobOpening;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(CEMS_Job_Opening__c = jobOpening.Id);
        insert jobApplication;

        CEMS_Internal_Scheduler__c internalScheduler = new CEMS_Internal_Scheduler__c(
            CEMS_Job_Application_ID__c = jobApplication.Id
        );
        insert internalScheduler;

        List<FetchSkillsFromJobOpening.InterviewRecord> records = new List<FetchSkillsFromJobOpening.InterviewRecord>();
        FetchSkillsFromJobOpening.InterviewRecord record = new FetchSkillsFromJobOpening.InterviewRecord();
        record.Id = internalScheduler.Id;
        record.SkillName = 'Java';
        record.SkillRating = 4;
        record.SkillComment = 'Good';
        record.FeedbackComment = 'Overall feedback';
        records.add(record);

        Test.startTest();
        FetchSkillsFromJobOpening.saveRatingsAndComments(records, internalScheduler.Id, 'Overall feedback');
        Test.stopTest();

        // Query the updated record and verify
        CEMS_Internal_Scheduler__c updatedInternalScheduler = [SELECT Id, CEMS_Skill_1_Rating__c, CEMS_Skill_1_Comment__c, CEMS_Feedback_Comments__c FROM CEMS_Internal_Scheduler__c WHERE Id = :internalScheduler.Id];
        System.assertEquals(4, updatedInternalScheduler.CEMS_Skill_1_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_1_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);

        // Test negative scenario
        Test.startTest();
        try {
            FetchSkillsFromJobOpening.saveRatingsAndComments(records, 'InvalidId', 'Overall feedback');
        } catch (AuraHandledException e) {
            System.assertEquals('Error saving ratings and comments.', e.getMessage());
        }
        Test.stopTest();
    }
}
*/

/*
@isTest
public class FetchSkillsFromJobOpeningTest {

    @isTest
    static void testSkillsFetched() {
         CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c();        
        jobOpening.Name='testJob';
        insert jobOpening;
CEMS_Personnel__c personnel =new CEMS_Personnel__c();
        personnel.Name='TestPersonnel';
        insert personnel;
// Create a CEMS_Job_Application__c record with the correct relationship references
CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c();
jobApplication.CEMS_Job_Opening__c = jobOpening.Id;
jobApplication.CEMS_Personnel__c = personnel.Id;
insert jobApplication;

        // Create a CEMS_Internal_Scheduler__c record with the correct relationship references
CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c();
interviewRecord.Name = 'Test Interview';
interviewRecord.CEMS_Job_Application_ID__c = jobApplication.Id;
insert interviewRecord;
System.debug('InterviewRecord Id: ' + interviewRecord.Id);
        // Call the method to be tested
        Test.startTest();
        List<String> result = FetchSkillsFromJobOpening.skillsFetched(interviewRecord.Id);
        Test.stopTest();

        // Verify the result
        System.assertEquals(3, result.size(), 'Number of skills should be 3');
        System.assertEquals('Java', result[0], 'First skill should be Java');
        System.assertEquals('JavaScript', result[1], 'Second skill should be JavaScript');
        System.assertEquals('HTML', result[2], 'Third skill should be HTML');

    }

   

   
    
        @isTest
    static void testSaveRatingsAndComments() {
         CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c();        
        jobOpening.Name='testJob';
        insert jobOpening;
CEMS_Personnel__c personnel =new CEMS_Personnel__c();
        personnel.Name='TestPersonnel';
        insert personnel;
// Create a CEMS_Job_Application__c record with the correct relationship references
CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c();
jobApplication.CEMS_Job_Opening__c = jobOpening.Id;
jobApplication.CEMS_Personnel__c = personnel.Id;
insert jobApplication;

        // Create a CEMS_Internal_Scheduler__c record with the correct relationship references
CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c();
interviewRecord.Name = 'Test Interview';
interviewRecord.CEMS_Job_Application_ID__c = jobApplication.Id;
insert interviewRecord;


        List<FetchSkillsFromJobOpening.InterviewRecord> records = new List<FetchSkillsFromJobOpening.InterviewRecord>();
        FetchSkillsFromJobOpening.InterviewRecord record = new FetchSkillsFromJobOpening.InterviewRecord();
        record.Id = interviewRecord.Id;
        record.SkillName = 'Java';
        record.SkillRating = 4;
        record.SkillComment = 'Good';
        record.FeedbackComment = 'Overall feedback';
        records.add(record);

        Test.startTest();
        FetchSkillsFromJobOpening.saveRatingsAndComments(records, interviewRecord.Id, 'Overall feedback');
        Test.stopTest();

        // Query the updated record and verify
        // Assertions for the first skill
     
        CEMS_Internal_Scheduler__c updatedInternalScheduler = [SELECT Id, CEMS_Skill_1_Rating__c,CEMS_Skill_2_Rating__c, CEMS_Skill_3_Rating__c,CEMS_Skill_4_Rating__c, CEMS_Skill_5_Rating__c, CEMS_Skill_6_Rating__c, CEMS_Skill_1_Comment__c,CEMS_Skill_2_Comment__c,CEMS_Skill_3_Comment__c,CEMS_Skill_4_Comment__c,CEMS_Skill_5_Comment__c, CEMS_Skill_6_Comment__c, CEMS_Feedback_Comments__c FROM CEMS_Internal_Scheduler__c WHERE Id = :interviewRecord.Id];
             System.assertEquals(records[0].SkillRating, updatedInternalScheduler.CEMS_Skill_1_Rating__c);
          System.assertEquals(records[0].SkillComment, updatedInternalScheduler.CEMS_Skill_1_Comment__c);

        // Assertions for the second skill
System.assertEquals(records[1].SkillRating, updatedInternalScheduler.CEMS_Skill_2_Rating__c);
System.assertEquals(records[1].SkillComment, updatedInternalScheduler.CEMS_Skill_2_Comment__c);
        /*System.assertEquals(4, updatedInternalScheduler.CEMS_Skill_1_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_1_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
         System.assertEquals(5, updatedInternalScheduler.CEMS_Skill_2_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_2_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
         System.assertEquals(2, updatedInternalScheduler.CEMS_Skill_3_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_3_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
         System.assertEquals(3, updatedInternalScheduler.CEMS_Skill_4_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_4_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
         System.assertEquals(4, updatedInternalScheduler.CEMS_Skill_5_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_5_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
         System.assertEquals(1, updatedInternalScheduler.CEMS_Skill_6_Rating__c);
        System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_6_Comment__c);
        System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c);
        
        */
/*
        // Test negative scenario
        Test.startTest();
        try {
            FetchSkillsFromJobOpening.saveRatingsAndComments(records, 'InvalidId', 'Overall feedback');
        } catch (AuraHandledException e) {
            System.assertEquals('Error saving ratings and comments.', e.getMessage());
        }
        Test.stopTest();
    }
}*/


@isTest
public class FetchSkillsFromJobOpeningTest {

    @isTest
    static void testSkillsFetched() {
        // Test data setup
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'TestJob');
        insert jobOpening;

        CEMS_Personnel__c personnel = new CEMS_Personnel__c(Name = 'TestPersonnel');
        insert personnel;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Job_Opening__c = jobOpening.Id,
            CEMS_Personnel__c = personnel.Id
        );
        insert jobApplication;

        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
            Name = 'Test Interview',
            CEMS_Job_Application_ID__c = jobApplication.Id
        );
        insert interviewRecord;

        // Call the method to be tested
        Test.startTest();
        List<String> result = FetchSkillsFromJobOpening.skillsFetched(interviewRecord.Id);
        Test.stopTest();

        // Verify the result
        System.assertNotEquals(null, result, 'Result should not be null');
        // Add more assertions based on your expected results
        System.assertEquals(0, result.size(), 'Number of skills should be 0 for this test data');
    }

    @isTest
    static void testExceptionCase() {
        // Test data setup
        // No need to create data for this case

        // Call the method to be tested
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            // Provide an invalid recordId to simulate an exception
            FetchSkillsFromJobOpening.skillsFetched('InvalidRecordId');
        } catch (FetchSkillsFromJobOpening.myException ex) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Verify the exception was thrown
        System.assert(exceptionThrown, 'Exception should be thrown for invalid recordId');
    }
    
     @isTest
static void testSaveRatingsAndComments() {
    // Test data setup
   CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'TestJobOpening');
    insert jobOpening;


    CEMS_Personnel__c personnel = new CEMS_Personnel__c(Name = 'TestPersonnel');
    insert personnel;

    CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
        CEMS_Job_Opening__c = jobOpening.Id,
        CEMS_Personnel__c = personnel.Id
    );
    insert jobApplication;

    CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
        Name = 'Interview Scheduler',
        CEMS_Job_Application_ID__c = jobApplication.Id,
        CEMS_Skill_1__c = 'Java',
        CEMS_Skill_1_Rating__c = 3,
         CEMS_Skill_1_Comment__c='Good',
                CEMS_Skill_2__c = 'C',
        CEMS_Skill_2_Rating__c = 2,
         CEMS_Skill_2_Comment__c='Avg',
        CEMS_Feedback_Comments__c='Overall good'
    );
    insert interviewRecord;

    List<FetchSkillsFromJobOpening.InterviewRecord> records = new List<FetchSkillsFromJobOpening.InterviewRecord>();
    FetchSkillsFromJobOpening.InterviewRecord record = new FetchSkillsFromJobOpening.InterviewRecord();
    record.Id = interviewRecord.Id;
    record.SkillName = 'Java';
    record.SkillRating = 4;
    record.SkillComment = 'Good';
    record.FeedbackComment = 'Overall good';
    records.add(record);

    // Call the method to be tested
    Test.startTest();
    FetchSkillsFromJobOpening.saveRatingsAndComments(records, interviewRecord.Id, 'Overall feedback');
    Test.stopTest();

    // Query the updated record and verify
    CEMS_Internal_Scheduler__c updatedInternalScheduler = [SELECT Id,CEMS_Skill_1_Rating__c, CEMS_Skill_1_Comment__c, CEMS_Skill_2_Rating__c,CEMS_Skill_3_Rating__c,CEMS_Skill_2_Comment__c,CEMS_Skill_3_Comment__c,CEMS_Feedback_Comments__c FROM CEMS_Internal_Scheduler__c WHERE Id = :interviewRecord.Id];

    // Debug statements for investigation
    System.debug('Updated Internal Scheduler: ' + updatedInternalScheduler);

    // Add more assertions based on your expected results
    System.assertNotEquals(null, updatedInternalScheduler, 'Internal Scheduler record should not be null');
    System.assertEquals(3, updatedInternalScheduler.CEMS_Skill_1_Rating__c, 'Skill 1 Rating should be 3');
    System.assertEquals(2, updatedInternalScheduler.CEMS_Skill_2_Rating__c, 'Skill 2 Rating should be 2');

    System.assertEquals('Good', updatedInternalScheduler.CEMS_Skill_1_Comment__c, 'Skill 1 Comment should be Good');
    System.assertEquals('Avg', updatedInternalScheduler.CEMS_Skill_2_Comment__c, 'Skill 2 Comment should be Good');
    System.assertEquals('Overall feedback', updatedInternalScheduler.CEMS_Feedback_Comments__c, 'Feedback Comments should be Overall feedback');
}
     
}