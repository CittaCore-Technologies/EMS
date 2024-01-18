@isTest
public class InterviewPanelControllerTest {

    @isTest
    static void testGetInterviewPanels() {
        // Test data setup
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(Name = 'TestJobOpening');
        insert jobOpening;

        CEMS_Personnel__c interviewer1 = new CEMS_Personnel__c(Name = 'Interviewer1');
        insert interviewer1;

        CEMS_Personnel__c interviewer2 = new CEMS_Personnel__c(Name = 'Interviewer2');
        insert interviewer2;

        CEMS_Personnel__c interviewer3 = new CEMS_Personnel__c(Name = 'Interviewer3');
        insert interviewer3;

        CEMS_Interview_Panel__c interviewPanel = new CEMS_Interview_Panel__c(
            Name = 'TestPanel',
            CEMS_Interviewer_1__c = interviewer1.Id,
            CEMS_Interviewer_2__c = interviewer2.Id,
            CEMS_Interviewer_3__c = interviewer3.Id,
            CEMS_Position_Name__c = jobOpening.Id
        );
        insert interviewPanel;

        // Call the method to be tested
        Test.startTest();
        List<CEMS_Interview_Panel__c> result = InterviewPanelController.getInterviewPanels();
        Test.stopTest();

        // Verify the result
        System.assertEquals(1, result.size(), 'Number of interview panels should be 1');

        // Additional assertions based on your specific requirements
        // ...

        // Ensure the debug statements are covered
        // (optional, remove in production code)
        for (CEMS_Interview_Panel__c panel : result) {
            System.assertNotEquals(null, panel.Id);
            System.assertNotEquals(null, panel.Name);
            System.assertNotEquals(null, panel.CEMS_Interviewer_1__r.Name);
            System.assertNotEquals(null, panel.CEMS_Interviewer_2__r.Name);
            System.assertNotEquals(null, panel.CEMS_Interviewer_3__r.Name);
            System.assertNotEquals(null, panel.CEMS_Position_Name__r.Name);
        }
    }
}