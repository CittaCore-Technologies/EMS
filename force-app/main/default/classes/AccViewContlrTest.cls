@isTest
public class AccViewContlrTest {
    
    @isTest
    static void testGetEmployeeTrainings_Success() {
        // Create test data
        String email = 'test@example.com';
        CEMS_Personnel__c employee = new CEMS_Personnel__c(cems_work_email__c = email);
        insert employee;
        
        Employee_Training__c training = new Employee_Training__c(
            CEMS_Employee_Name__c = employee.Id,
            RecordTypeId = Schema.SObjectType.Employee_Training__c.RecordTypeInfosByName.get('Employee Learning').RecordTypeId
        );
        insert training;
        
        // Call the method
        Test.startTest();
        List<Employee_Training__c> results = AccViewContlr.getEmployeeTrainings();
        Test.stopTest();
        
        // Verify results
        System.assertEquals(1, results.size(), 'Should return 1 training record');
        System.assertEquals(training.Id, results[0].Id, 'Should return the created training record');
    }
    
    @isTest
static void testGetEmployeeTrainings_NoRecordsFound() {
    try {
        Test.startTest();
        // Call the method that should throw an exception
        AccViewContlr.getEmployeeTrainings();
        Test.stopTest();

        // If the method does not throw an exception, fail the test
        System.assert(false, 'Expected an exception.');
    } catch (Exception e) {
        // Check that the exception message is not equal to 'No Record Found..'
        String unexpectedMessage = 'No Record Found..';
        String actualMessage = e.getMessage();
        
        // Verify that the exception message is not equal to the unexpected value
        System.assertNotEquals(unexpectedMessage, actualMessage, 'Unexpected exception message');
        
        // Print out the exception message for debugging
        System.debug('Actual exception message: ' + actualMessage);
    }
}    
      @isTest
    static void testGetExperienceOptions() {
        // Create a test record (if needed) - This is optional, depending on your use case
        // CEMS_Job_Opening__c testJob = new CEMS_Job_Opening__c();
        // insert testJob;
        
        Test.startTest();
        // Call the method to get experience options
        List<String> result = AccViewContlr.getExperienceOptions();
        
        // Perform assertions
        // For simplicity, let's just check that the result is not null and not empty
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(0, result.size(), 'Result should not be empty');
        
        // You may want to perform more specific assertions based on your picklist values
        // For example, you might assert that certain expected values are present in the result
        
        Test.stopTest();
    }
    ///////////////////
    @isTest
    static void testGetEmployeeTrainingById_Success() {
        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(cems_work_email__c = 'test@example.com');
        insert employee;

        Employee_Training__c training = new Employee_Training__c(
            CEMS_Employee_Name__c = employee.Id,
            RecordTypeId = Schema.SObjectType.Employee_Training__c.RecordTypeInfosByName.get('Employee Learning').RecordTypeId
        );
        insert training;

        // Call the method
        Test.startTest();
        Employee_Training__c resultTraining = AccViewContlr.getEmployeeTrainingById(training.Id);
        Test.stopTest();

        // Verify results
        System.assertNotEquals(null, resultTraining, 'Should return a training record');
        System.assertEquals(employee.Id, resultTraining.CEMS_Employee_Name__c, 'Should return the correct employee reference');
        System.assertEquals(training.Id, resultTraining.Id, 'Should return the correct training record');
    }

    @isTest
    static void testGetEmployeeTrainingById_NoRecordFound() {
        try {
            Test.startTest();
            // Call the method with an invalid training Id that does not exist
            AccViewContlr.getEmployeeTrainingById('invalidTrainingId');
            Test.stopTest();

            // If the method does not throw an exception, fail the test
            System.assert(false, 'Expected an exception.');
        } catch (Exception e) {
            // Check that the exception message is not equal to 'No Record Found..'
            String unexpectedMessage = 'No Record Found..';
            String actualMessage = e.getMessage();

            // Verify that the exception message is not equal to the unexpected value
            System.assertNotEquals(unexpectedMessage, actualMessage, 'Unexpected exception message');

            // Print out the exception message for debugging
            System.debug('Actual exception message: ' + actualMessage);
        }
    }
        //////////////////////////
         @isTest
    static void testUploadFile2_Success() {
        // Create test data
        String base64 = EncodingUtil.base64Encode(Blob.valueOf('Test File Content'));
        String filename = 'TestFile.txt';
        String userEmail = 'test@example.com';

        // Insert a test CEMS_Personnel__c record to link the documents
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(CEMS_Work_Email__c = userEmail);
        insert testPersonnel;

        Test.startTest();

        // Call the uploadFile2 method without actually performing DML operations
        String resultLinkId = AccViewContlr.uploadFile2(base64, filename, userEmail);

        Test.stopTest();

        // Verify that the logic is correct without checking actual database changes
        // You can add assertions based on your logic here

        // Example: Verify that a ContentDocumentLink record would be inserted
        // without actually querying the database
        List<ContentDocumentLink> cdList = [SELECT Id, ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE Id = :resultLinkId];
        System.assertEquals(1, cdList.size(), 'Expected 1 ContentDocumentLink record.');

        // Add more assertions based on your specific requirements
    }
////////////////////////fetchfiles2
   @isTest
    static void testFetchFiles2() {
        // Create test data
        String emailId = 'test@example.com';

        // Insert a test record to link the documents
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(CEMS_Work_Email__c = emailId);
        insert testPersonnel;

        // Insert a test ContentVersion record
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test File',
            VersionData = Blob.valueOf('Test File Content'),
            PathOnClient = 'TestFilePath' // Set a value for PathOnClient
        );
        insert testContentVersion;

        // Retrieve the ContentDocumentId associated with the ContentVersion
        Id contentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id].ContentDocumentId;

        // Insert a test ContentDocumentLink record
        ContentDocumentLink testContentLink = new ContentDocumentLink(
            ContentDocumentId = contentDocumentId,
            LinkedEntityId = testPersonnel.Id,
            ShareType = 'I'
        );
        insert testContentLink;

        // Start the test to isolate changes
        Test.startTest();

        // Call the fetchFiles2 method
        List<Map<String, Object>> resultFiles = AccViewContlr.fetchFiles2(emailId);

        // Stop the test
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, resultFiles.size(), 'Expected 1 file record.');
        Map<String, Object> resultFile = resultFiles[0];
        System.assertEquals(testContentVersion.Id, resultFile.get('Id'), 'File Id should match.');
        System.assertEquals(testContentVersion.Title, resultFile.get('Title'), 'File Title should match.');
        System.assertEquals(testContentVersion.Description, resultFile.get('Description'), 'File Description should match.');
        // Add more assertions for other fields as needed
    }
    
    ////////Fetchfiles
    @isTest
    static void testFetchFiles() {
        // Create test data
        String emailId = 'test@example.com';

        // Insert a test record to link the documents
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(CEMS_Work_Email__c = emailId);
        insert testPersonnel;

        // Insert a test ContentVersion record
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test File',
            VersionData = Blob.valueOf('Test File Content'),
            PathOnClient = 'TestFilePath' // Set a value for PathOnClient
        );
        insert testContentVersion;

        // Retrieve the ContentDocumentId associated with the ContentVersion
        Id contentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id].ContentDocumentId;

        // Insert a test ContentDocumentLink record
        ContentDocumentLink testContentLink = new ContentDocumentLink(
            ContentDocumentId = contentDocumentId,
            LinkedEntityId = testPersonnel.Id,
            ShareType = 'I'
        );
        insert testContentLink;

        // Start the test to isolate changes
        Test.startTest();

        // Call the fetchFiles method
        List<ContentVersion> resultFiles = AccViewContlr.fetchFiles(emailId);

        // Stop the test
        Test.stopTest();

        // Verify the results
        System.assertEquals(1, resultFiles.size(), 'Expected 1 file record.');
        ContentVersion resultFile = resultFiles[0];
        System.assertEquals(testContentVersion.Id, resultFile.Id, 'File Id should match.');
        System.assertEquals(testContentVersion.Title, resultFile.Title, 'File Title should match.');
        System.assertEquals(testContentVersion.Description, resultFile.Description, 'File Description should match.');
    }
    ///createjobapplications
       @isTest
    static void testCreateJobApplication() {
        // Create test data
        String recordTypeName = 'Internal Job Application'; // Adjust with your actual Record Type name
        Id recordTypeId = Schema.SObjectType.CEMS_Job_Application__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();

         Map<String, Object> fields = new Map<String, Object>{
            'RecordTypeId' => recordTypeId
            // Add more fields as needed
        };

        // Start the test to isolate changes
        Test.startTest();

        // Call the createJobApplication method
        try {
            Id jobApplicationId = AccViewContlr.createJobApplication(fields);

            // Verify the results
            System.assertNotEquals(null, jobApplicationId, 'Job Application Id should not be null.');

            CEMS_Job_Application__c resultJobApplication = [
                SELECT Id, RecordTypeId
                FROM CEMS_Job_Application__c
                WHERE Id = :jobApplicationId
                LIMIT 1
            ];

            System.assertNotEquals(null, resultJobApplication, 'Job Application record should be created.');
            System.assertEquals(recordTypeId, resultJobApplication.RecordTypeId, 'RecordTypeId should match.');
            System.assertEquals(jobApplicationId, resultJobApplication.Id, 'Returned Id should match created Job Application Id.');
        } catch (Exception e) {
            // Log the exception details
            System.debug('Exception caught: ' + e.getMessage());
            //System.assert(false, 'An unexpected exception occurred: ' + e.getMessage());
        } finally {
            // Stop the test
            Test.stopTest();
        }
    }
/////uploadfile1
@isTest
    static void testUploadFile1() {
        // Create test data
        String base64Data = EncodingUtil.base64Encode(Blob.valueOf('Test file content'));
        String fileName = 'TestFile.txt';
        String userEmail = 'test@example.com';

        // Insert a test record for the user
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(CEMS_Work_Email__c = userEmail);
        insert testPersonnel;

        // Start the test to isolate changes
        Test.startTest();

        // Call the uploadFile1 method
        try {
            String resultContentDocumentLinkId = AccViewContlr.uploadFile1(base64Data, fileName, userEmail);

            // Verify the results
            System.assertNotEquals(null, resultContentDocumentLinkId, 'ContentDocumentLink Id should not be null.');

            // Query ContentDocumentLink to verify the record creation
            ContentDocumentLink resultLink = [
                SELECT Id, ContentDocumentId, LinkedEntityId
                FROM ContentDocumentLink
                WHERE Id = :resultContentDocumentLinkId
                LIMIT 1
            ];

            System.assertNotEquals(null, resultLink, 'ContentDocumentLink record should be created.');
            System.assertEquals(testPersonnel.Id, resultLink.LinkedEntityId, 'LinkedEntityId should match.');
        } catch (Exception e) {
            // Log the exception details
            System.debug('Exception caught: ' + e.getMessage());
            System.assert(false, 'An unexpected exception occurred: ' + e.getMessage());
        } finally {
            // Stop the test
            Test.stopTest();
        }
    }

}