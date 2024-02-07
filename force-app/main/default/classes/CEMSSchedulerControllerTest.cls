@isTest
public class CEMSSchedulerControllerTest {

     @isTest
    static void testGetInterviewData2() {
        CEMS_Job_Opening__c jobopening = new CEMS_Job_Opening__c();
        jobopening.Name = 'TestJobOpening';
        insert jobopening;
        CEMS_Personnel__c personnel = new CEMS_Personnel__c();
        personnel.Name = 'TestPersonnel';
        personnel.CEMS_Position__c = jobopening.Id;
        insert personnel;

        CEMS_Interview_Panel__c interviewPanel = new CEMS_Interview_Panel__c();
        interviewPanel.Name = 'TestPanel';
        interviewPanel.CEMS_Interviewer_1__c = personnel.Id;
        interviewPanel.CEMS_Position_Name__c = jobopening.Id;
        insert interviewPanel;
          
          
       

        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c();
        interviewRecord.Name = 'Interview Scheduler';
        interviewRecord.CEMS_Interview_Round__c = 'Technical Round';
        interviewRecord.CEMS_Interview_Type__c  = 'In Person Interview';
        interviewRecord.CEMS_Interview_Start_Time__c = Datetime.now();
        interviewRecord.CEMS_Interview_End_Time__c = interviewRecord.CEMS_Interview_Start_Time__c.addMinutes(30);
        interviewRecord.CEMS_Interview_Panel__c = interviewPanel.Id;
        insert interviewRecord;                                                                                    

        // Call the method to be tested
        Test.startTest();
        List<CEMS_Internal_Scheduler__c> result = CEMSSchedulerController.getInterviewData2(personnel.CEMS_Work_Email__c);
        Test.stopTest();

        // Verify the result
        System.assertEquals(1, result.size(), 'Number of interview records should be 1');
        

    }
    
    @isTest
    static void testGetInterviewData() {
        CEMS_Job_Opening__c jobopening = new CEMS_Job_Opening__c();
        jobopening.Name = 'TestJobOpening';
        insert jobopening;
        CEMS_Personnel__c personnel = new CEMS_Personnel__c();
        personnel.Name = 'TestPersonnel';
        personnel.CEMS_Position__c = jobopening.Id;
        insert personnel;

        CEMS_Interview_Panel__c interviewPanel = new CEMS_Interview_Panel__c();
        interviewPanel.Name = 'TestPanel';
        interviewPanel.CEMS_Interviewer_1__c = personnel.Id;
        interviewPanel.CEMS_Position_Name__c = jobopening.Id;
        insert interviewPanel;
          
          
       

        CEMS_Internal_Scheduler__c interviewRecord = new CEMS_Internal_Scheduler__c();
        interviewRecord.Name = 'Interview Scheduler';
        interviewRecord.CEMS_Interview_Round__c = 'Technical Round';
        interviewRecord.CEMS_Interview_Type__c  = 'In Person Interview';
        interviewRecord.CEMS_Interview_Start_Time__c = Datetime.now();
        interviewRecord.CEMS_Interview_End_Time__c = interviewRecord.CEMS_Interview_Start_Time__c.addMinutes(30);
        interviewRecord.CEMS_Interview_Panel__c = interviewPanel.Id;
        insert interviewRecord;                                                                                    

        // Call the method to be tested
        Test.startTest();
        List<CEMS_Internal_Scheduler__c> result = CEMSSchedulerController.getInterviewData2(personnel.CEMS_Work_Email__c);
        Test.stopTest();

        // Verify the result
        System.assertEquals(1, result.size(), 'Number of interview records should be 1');
    }
    
    
}