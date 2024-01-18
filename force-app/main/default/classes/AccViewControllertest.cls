@istest
public class AccViewControllertest {
 @isTest
    static void testInsertEmployeeTrainingSuccess() {
        // Create a test training record with a valid Record Type
        CEMS_Training__c testTrainingRecord = new CEMS_Training__c(Registered__c = false);
        insert testTrainingRecord;

        // Create a test personnel record
        CEMS_Personnel__c testPersonnelRecord = new CEMS_Personnel__c(CEMS_Work_Email__c = 'test@example.com');
        insert testPersonnelRecord;

        // Ensure that the Record Type exists in your Salesforce org
        RecordType testRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE SObjectType = 'Employee_Training__c' LIMIT 1];

        // Set up the map with the record type information
        Map<String, String> recordTypeMap = new Map<String, String>();
        recordTypeMap.put(testTrainingRecord.Name, testRecordType.DeveloperName);

        // Start the test
        Test.startTest();

        // Call the method to test
        String result = AccountViewController.insertEmployeeTraining(testPersonnelRecord.CEMS_Work_Email__c, testTrainingRecord.Id);

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('Employee training registered successfully', result, 'Unexpected result: ' + result);

        // Clean up test data
        delete testPersonnelRecord;
        delete testTrainingRecord;
    }

    @isTest
    static void testInsertEmployeeTrainingRecordTypeNotFound() {
        // Create a test training record without a valid Record Type
        CEMS_Training__c testTrainingRecord = new CEMS_Training__c(Registered__c = false);
        insert testTrainingRecord;

        // Create a test personnel record
        CEMS_Personnel__c testPersonnelRecord = new CEMS_Personnel__c(CEMS_Work_Email__c = 'test@example.com');
        insert testPersonnelRecord;

        // Start the test
        Test.startTest();

        // Call the method to test
        String result = AccountViewController.insertEmployeeTraining(testPersonnelRecord.CEMS_Work_Email__c, testTrainingRecord.Id);

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('No employee training registered - Record Type not found for training: ' + testTrainingRecord.Name, result, 'Unexpected result: ' + result);

        // Clean up test data
        delete testPersonnelRecord;
        delete testTrainingRecord;
    }

    @isTest
    static void testInsertEmployeeTrainingAlreadyRegistered() {
        // Create a test training record with a valid Record Type and already registered
        CEMS_Training__c testTrainingRecord = new CEMS_Training__c(Registered__c = true);
        insert testTrainingRecord;

        // Create a test personnel record
        CEMS_Personnel__c testPersonnelRecord = new CEMS_Personnel__c(CEMS_Work_Email__c = 'test@example.com');
        insert testPersonnelRecord;

        // Ensure that the Record Type exists in your Salesforce org
        RecordType testRecordType = [SELECT Id, DeveloperName FROM RecordType WHERE SObjectType = 'Employee_Training__c' LIMIT 1];

        // Set up the map with the record type information
        Map<String, String> recordTypeMap = new Map<String, String>();
        recordTypeMap.put(testTrainingRecord.Name, testRecordType.DeveloperName);

        // Start the test
        Test.startTest();

        // Call the method to test
        String result = AccountViewController.insertEmployeeTraining(testPersonnelRecord.CEMS_Work_Email__c, testTrainingRecord.Id);

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('No employee training registered', result, 'Unexpected result: ' + result);

        // Clean up test data
        delete testPersonnelRecord;
        delete testTrainingRecord;
    }
}