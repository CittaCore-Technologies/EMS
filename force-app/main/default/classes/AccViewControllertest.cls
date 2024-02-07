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
    static void testInsertEmployeeTrainingRecordNotFound() {
        // Start the test
        Test.startTest();

        // Call the method to test with a non-existing training record
        String result = AccountViewController.insertEmployeeTraining('test@example.com', 'invalidTrainingId');

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('No employee training registered - Record not found for training Id: invalidTrainingId', result, 'Unexpected result: ' + result);
    }

    @isTest
    static void testInsertEmployeeTrainingNoEmployeeFound() {
        // Create a test training record with a valid Record Type
        CEMS_Training__c testTrainingRecord = new CEMS_Training__c(Registered__c = false);
        insert testTrainingRecord;

        // Start the test
        Test.startTest();

        // Call the method to test with a non-existing employee
        String result = AccountViewController.insertEmployeeTraining('nonexisting@example.com', testTrainingRecord.Id);

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('No employee found with email: nonexisting@example.com', result, 'Unexpected result: ' + result);

        // Clean up test data
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

    @isTest
    static void testInsertEmployeeTrainingException() {
        // Start the test
        Test.startTest();

        // Call the method to test with an exception
        String result = AccountViewController.insertEmployeeTraining('test@example.com', null);

        // End the test
        Test.stopTest();

        // Assertions
        System.assertEquals('An error occurred while registering employee training: Argument cannot be null', result, 'Unexpected result: ' + result);
    }
}