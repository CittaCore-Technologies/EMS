@isTest
private class EmployeeTrainingControllerTest {

    @isTest
    static void testInsertEmployeeTraining() {
        // Create a mock training record without setting the Name field
        CEMS_Training__c trainingRecord = new CEMS_Training__c();
        insert trainingRecord;

        // Create a mock personnel record
        CEMS_Personnel__c personnelRecord = new CEMS_Personnel__c(
            CEMS_Work_Email__c = 'test@example.com'
        );
        insert personnelRecord;

        // Set up the test data for RecordType
        RecordType rt = [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'Employee_Training__c' LIMIT 1];

        // Set up the test data for Employee_Training__c
        Employee_Training__c employeeTraining = new Employee_Training__c();
        employeeTraining.put(rt.DeveloperName, trainingRecord.Id);
        employeeTraining.CEMS_Employee_Name__c = personnelRecord.Id;
        // Set other field values based on the dynamic record type

        Test.startTest();
        // Call the method being tested
        AccountViewController.insertEmployeeTraining('test@example.com', trainingRecord.Id);
        Test.stopTest();

        // Verify that the training record is marked as registered
        CEMS_Training__c updatedTrainingRecord = [SELECT Id, Registered__c FROM CEMS_Training__c WHERE Id = :trainingRecord.Id LIMIT 1];
        System.assertEquals(true, updatedTrainingRecord.Registered__c, 'Training record should be marked as registered');

        // Add more assertions based on your specific requirements
    }
}