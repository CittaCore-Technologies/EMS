@isTest
public class FetchSkillsFromJobOpeningTest {

     @isTest
    static void testSkillsFetched() {
        // Test data setup
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'Test Job Opening', CEMS_Skills__c = 'Apex Development;Apex Development;Apex Development');
        insert jobOpening;

        // Create a CEMS_Personnel__c record (replace with actual field values)
        CEMS_Personnel__c personnelRecord = new CEMS_Personnel__c(Name = 'Test Personnel Record');
        insert personnelRecord;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Job_Opening__c = jobOpening.Id,
            CEMS_Personnel__c = personnelRecord.Id  // Assign the CEMS_Personnel__c reference
        );
        insert jobApplication;

        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
            Name = 'Test Interview Record',
            CEMS_Job_Application_ID__c = jobApplication.Id,
            CEMS_Skill_1__c = 'Apex Development',
            CEMS_Skill_2__c = 'Apex Development',
            CEMS_Skill_3__c = 'Apex Development'
        );
        insert interviewRecord;

        // Test the skillsFetched method
        Test.startTest();
        List<String> fetchedSkills = FetchSkillsFromJobOpening.skillsFetched(interviewRecord.Id);
        Test.stopTest();

        // Perform assertions
        System.assertEquals(3, fetchedSkills.size());
        System.assert(fetchedSkills.contains('Apex Development'));
        System.assert(fetchedSkills.contains('Apex Development'));
        System.assert(fetchedSkills.contains('Apex Development'));
    }

    @isTest
    static void testSaveRatingsAndComments() {
        // Test data setup
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'Test Job Opening', CEMS_Skills__c = 'Apex Development;Apex Development;Apex Development');
        insert jobOpening;

        // Create a CEMS_Personnel__c record (replace with actual field values)
        CEMS_Personnel__c personnelRecord = new CEMS_Personnel__c(Name = 'Test Personnel Record');
        insert personnelRecord;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Job_Opening__c = jobOpening.Id,
            CEMS_Personnel__c = personnelRecord.Id  // Assign the CEMS_Personnel__c reference
        );
        insert jobApplication;

        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c(
            Name = 'Test Interview Record',
            CEMS_Job_Application_ID__c = jobApplication.Id,
            CEMS_Skill_1__c = 'Apex Development',
            CEMS_Skill_2__c = 'Apex Development',
            CEMS_Skill_3__c = 'Apex Development'
        );
        insert interviewRecord;

        FetchSkillsFromJobOpening.InterviewRecord testRecord = new FetchSkillsFromJobOpening.InterviewRecord();
        testRecord.Id = interviewRecord.Id;
        testRecord.SkillName = 'Apex Development';
        testRecord.SkillRating = 4;
        testRecord.SkillComment = 'Test Comment';
        testRecord.FeedbackComment = 'Test Feedback';

        // Test the saveRatingsAndComments method
        Test.startTest();
        FetchSkillsFromJobOpening.saveRatingsAndComments(new List<FetchSkillsFromJobOpening.InterviewRecord>{ testRecord }, interviewRecord.Id, 'Test Feedback Comment');
        Test.stopTest();

        // Query the updated record for assertions
        CEMS_Internal_Scheduler__c updatedRecord = [SELECT Id, CEMS_Skill_1_Rating__c, CEMS_Skill_1_comment__c, CEMS_Feedback_Comments__c FROM CEMS_Internal_Scheduler__c WHERE Id = :interviewRecord.Id LIMIT 1];

        // Perform assertions
        System.assertEquals(4, updatedRecord.CEMS_Skill_1_Rating__c);
        System.assertEquals('Test Comment', updatedRecord.CEMS_Skill_1_comment__c);
        System.assertEquals('Test Feedback Comment', updatedRecord.CEMS_Feedback_Comments__c);
    }
}