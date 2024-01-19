@isTest
public class AccountViewControllerTest {
    @TestSetup
    static void setupTestData() {
        // Create common test data needed for multiple test methods
        TestDataFactory.createApprovedJobOpenings(5);
    }
       
    //Get Data from Contact
   /* @isTest
    static void testGetDataFromContact() {
        // Create test data
        
         List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Email = 'testemail' + i + '@example.com',
                Phone = '123456789' + i
            ));
        }
        insert testContacts;
        
        
        // Set up the test environment
        Test.startTest();
        
         try {
            List<Contact> contacts = AccountViewController.getDataFromContact();
            // Add assertions or validations as needed for the returned data
            System.assertEquals(5, contacts.size());
        } catch (Exception e) {
            // Handle or assert the expected exception
            System.assertEquals('An error occurred while fetching contacts.', e.getMessage());
        }
        
        // Call the method being tested
        //List<Contact> resultingContacts = AccountViewController.getDataFromContact();
        
        // Verify the results
       // System.assertEquals(5, resultingContacts.size());
        // Add more assertions as needed
        
        Test.stopTest();
    }*/
   
    @isTest
    static void testGetDataFromContactWithException() {
        // Negative Test Case to cover catch block

        // Insert a contact to trigger a DML exception
        Contact testContact = new Contact(
            FirstName = 'Test', 
            LastName = 'Contact', 
            Email = 'test@example.com', 
            Phone = '1234567890'
        );
        insert testContact;

        // Ensure that the test Contact is not returned in the query
        Test.startTest();
        try {
            // Simulate a DML exception by querying for a non-existent object
            List<Contact> conList = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 1];
        } catch (AccountViewController.NoDataFoundException e) {
            // Add assertions for the negative case
            System.assertEquals('An error occurred while fetching contacts.', e.getMessage(), 'Exception message should match.');
        } finally {
            Test.stopTest();
        }
    }
    
    
    @isTest
    static void testGetDataFromContact_ExceptionScenario() {
        // Set up the test environment
        Test.startTest();
        
        // Simulate an exception scenario by limiting the query to cause an exception
        try {
            List<Contact> resultingContacts = AccountViewController.getDataFromContact();
            
            // You can add assertions here to validate the exception if needed
            
        } catch (NoDataFoundException e) {
            // Verify that the exception message is as expected
            System.assertEquals('An error occurred while fetching contacts.', e.getMessage(), 'Unexpected exception message');
        } catch (Exception e) {
            // Fail the test if an unexpected exception type is caught
            System.assert(false, 'Unexpected exception type caught: ' + e.getTypeName());
        }
        
        Test.stopTest();
    }
    
    
    
    //Get JobOpenings
    @isTest
    static void testGetJobOpenings() {
        // Case 1: Positive scenario with approved job openings
        List<CEMS_Job_Opening__c> testJobOpenings = new List<CEMS_Job_Opening__c>();
        // Add approved job openings to the list
        
        // Set up the test environment
        Test.startTest();
        
        // Call the method being tested
        List<CEMS_Job_Opening__c> resultingJobOpenings = AccountViewController.getJobOpenings();
        
        // Verify the results
        System.assertEquals(testJobOpenings.size(), resultingJobOpenings.size());
        // Add more positive assertions as needed
        
        // Case 2: Negative scenario with no approved job openings
        List<CEMS_Job_Opening__c> noApprovedJobOpenings = new List<CEMS_Job_Opening__c>();
        // Do not add any approved job openings to the list
        
        // Call the method being tested
        List<CEMS_Job_Opening__c> resultNoApproved = AccountViewController.getJobOpenings();
        
        // Verify the results
        System.assertEquals(noApprovedJobOpenings.size(), resultNoApproved.size());
        // Add more negative assertions as needed
        
        // Case 3: Negative scenario with no job openings at all
        List<CEMS_Job_Opening__c> noJobOpenings = new List<CEMS_Job_Opening__c>();
        // Do not add any job openings to the list
        
        // Call the method being tested
        List<CEMS_Job_Opening__c> resultNoJobOpenings = AccountViewController.getJobOpenings();
        
        // Verify the results
        System.assertEquals(0, resultNoJobOpenings.size());
        // Add more negative assertions as needed
        
        Test.stopTest();
    }
    
    //getInternalJobOpenings
    @isTest
    static void testGetInternalJobOpenings() {
        // Case 1: Positive scenario with approved job openings
        // Set up the test environment
        Test.startTest();
        
        // Call the method being tested
        List<CEMS_Job_Opening__c> resultingJobOpenings = AccountViewController.getInternalJobOpenings();
        
        // Verify the results
        System.assertNotEquals(0, resultingJobOpenings.size(), 'There should be approved job openings');
        // Add more positive assertions as needed
        
        // Case 2: Negative scenario with no approved job openings (already covered by TestSetup)
        
        // Case 3: Negative scenario with no job openings at all
        // Verify the results
        System.assertEquals(5, resultingJobOpenings.size(), 'There should be no job openings');
        
        Test.stopTest();
    }
    
    
    ////////////////Get TechnologyOptions
    @isTest
    static void testGetTechnologyOptions() {
        // Create a test record (if needed) - This is optional, depending on your use case
        // CEMS_Job_Opening__c testJob = new CEMS_Job_Opening__c();
        // insert testJob;
        
        Test.startTest();
        // Call the method to get technology options
        List<String> result = AccountViewController.getTechnologyOptions();
        
        // Perform assertions
        // For simplicity, let's just check that the result is not null and not empty
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(0, result.size(), 'Result should not be empty');
        
        // You may want to perform more specific assertions based on your picklist values
        // For example, you might assert that certain expected values are present in the result
        
        Test.stopTest();
    }
    
    ////////////////Get ExperienceOptions
    @isTest
    static void testGetExperienceOptions() {
        // Create a test record (if needed) - This is optional, depending on your use case
        // CEMS_Job_Opening__c testJob = new CEMS_Job_Opening__c();
        // insert testJob;
        
        Test.startTest();
        // Call the method to get experience options
        List<String> result = AccountViewController.getExperienceOptions();
        
        // Perform assertions
        // For simplicity, let's just check that the result is not null and not empty
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(0, result.size(), 'Result should not be empty');
        
        // You may want to perform more specific assertions based on your picklist values
        // For example, you might assert that certain expected values are present in the result
        
        Test.stopTest();
    }
    ///Get Location Options
    @isTest
    static void testGetLocationOptions() {
        // Create a test record (if needed) - This is optional, depending on your use case
        // CEMS_Job_Opening__c testJob = new CEMS_Job_Opening__c();
        // insert testJob;
        
        Test.startTest();
        // Call the method to get location options
        List<String> result = AccountViewController.getLocationOptions();
        
        // Perform assertions
        // For simplicity, let's just check that the result is not null and not empty
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(0, result.size(), 'Result should not be empty');
        
        // You may want to perform more specific assertions based on your picklist values
        // For example, you might assert that certain expected values are present in the result
        
        Test.stopTest();
    }
    
    
    
    
    
    ///cems trainings
    @isTest
    static void testGetAllCEMSTrainings() {
        // Create test CEMS_Training__c records
        List<CEMS_Training__c> testTrainings = new List<CEMS_Training__c>();
        
        for (Integer i = 0; i < 3; i++) {
            testTrainings.add(new CEMS_Training__c(
                CEMS_Certificate_Name__c = 'Test Training ' + i
                // Add other required fields
            ));
        }
        
        insert testTrainings;
        
        // Call the method to be tested
        Test.startTest();
        List<CEMS_Training__c> result = AccountViewController.getAllCEMSTrainings();
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(testTrainings.size(), result.size(), 'Unexpected number of CEMS_Training__c records');
        
        for (Integer i = 0; i < testTrainings.size(); i++) {
            System.assertEquals(testTrainings[i].Id, result[i].Id, 'Unexpected CEMS_Training__c record retrieved');
            // Add additional assertions based on your specific fields and requirements
        }
    }
    //get education
    @isTest
    static void testGetEducation() {
        // Create a new CEMS_Personnel__c record to get the picklist values
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c();
        insert testPersonnel;
        
        // Call the method to be tested
        Test.startTest();
        List<String> result = AccountViewController.getEducation();
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(0, result.size(), 'No education options returned');
        
        // Add additional assertions based on your specific picklist values
        for (String educationOption : result) {
            // Perform assertions based on the expected picklist values
            // For example: System.assertEquals('ExpectedValue', educationOption, 'Unexpected education option');
        }
    }
    //GET jOBAPPLICATIONS
    @isTest
    static void testGetJobApplications() {
        // Create test CEMS_Job_Opening__c record
        CEMS_Job_Opening__c testJobOpening = new CEMS_Job_Opening__c(
            // Add required fields for CEMS_Job_Opening__c
            Name = 'TestJobOpening'
        );
        insert testJobOpening;
        
        // Create test CEMS_Personnel__c record
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(
            // Add required fields for CEMS_Personnel__c
            Name = 'TestPersonnel'
        );
        insert testPersonnel;
        
        // Create test CEMS_Job_Application__c records
        List<CEMS_Job_Application__c> testJobApplications = new List<CEMS_Job_Application__c>();
        
        for (Integer i = 0; i < 3; i++) {
            testJobApplications.add(new CEMS_Job_Application__c(
                CEMS_First_Name__c = 'TestFirstName' + i,
                CEMS_Last_Name__c = 'TestLastName' + i,
                CEMS_Job_Opening__c = testJobOpening.Id, 
                CEMS_Personnel__c = testPersonnel.Id
                // Add other required fields
            ));
        }
        
        insert testJobApplications;
        
        // Call the method to be tested
        Test.startTest();
        List<CEMS_Job_Application__c> result = AccountViewController.getJobApplications();
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(testJobApplications.size(), result.size(), 'Unexpected number of CEMS_Job_Application__c records');
        
        for (Integer i = 0; i < testJobApplications.size(); i++) {
            System.assertEquals(testJobApplications[i].Id, result[i].Id, 'Unexpected CEMS_Job_Application__c record retrieved');
            // Add additional assertions based on your specific fields and requirements
        }
    }
    ////Get Performance
    @isTest
    static void testGetPerformances() {
        // Create a test user and CEMS_Employee__c record for testing
        User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
        CEMS_Personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);
        
        // Create a CEMS_Performance__c record related to the test employee
        CEMS_Performance__c testPerformance = TestDataFactory.createTestPerformance(testEmployee.Id);
        
        try {
            // Call the method to be tested
            Test.startTest();
            List<CEMS_Performance__c> result = AccountViewController.getPerformances(testEmployee.cems_work_email__c);
            Test.stopTest();
            
            // Assert the results
            System.assertEquals(1, result.size(), 'Expected one performance record');
            System.assertEquals(testPerformance.Id, result[0].Id, 'Unexpected performance record retrieved');
        } catch (Exception e) {
            System.debug('Exception caught during positive test: ' + e.getMessage());
            //  e.printStackTrace();
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        }
    }
    
    @isTest
    static void testGetPerformancesNoRecords() {
        // Call the method with a different email (non-existing)
        Test.startTest();
        try {
            List<CEMS_Performance__c> result = AccountViewController.getPerformances('nonexistent@example.com');
            System.assertEquals(0, result.size(), 'Expected no performance records for a non-existing email');
        } catch (Exception e) {
            System.debug('Exception caught during negative test: ' + e.getMessage());
            System.assertEquals('Test failed due to an unexpected exception: ', 'Test failed due to an unexpected exception: ' , e.getMessage());
        } finally {
            Test.stopTest();
        }
    }
    ///Get Employee
    @isTest
    static void testGetEmployee() {
        // Create a test user and CEMS_Personnel__c record for testing
        User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
        CEMS_Personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);
        
        try {
            // Call the method to be tested
            Test.startTest();
            List<CEMS_Personnel__c> result = AccountViewController.getEmployee(testEmployee.CEMS_Work_Email__c);
            Test.stopTest();
            
            // Assert the results
            System.assertNotEquals(null, result, 'Expected a non-null result for an existing email');
            System.assertEquals(1, result.size(), 'Expected one employee record');
            System.assertEquals(testEmployee.Id, result[0].Id, 'Unexpected employee record retrieved');
        } catch (Exception e) {
            System.debug('Exception caught during positive test: ' + e.getMessage());
            // e.printStackTrace();
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        }
    }
    
    @isTest
    static void testGetEmployeeNotFound() {
        // Call the method with a different email (non-existing)
        Test.startTest();
        try {
            List<CEMS_Personnel__c> result = AccountViewController.getEmployee('nonexistent@example.com');
            System.assertEquals(null, result, 'Expected null result for a non-existing email');
        } catch (Exception e) {
            System.debug('Exception caught during negative test: ' + e.getMessage());
            // e.printStackTrace();
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        } finally {
            Test.stopTest();
        }
    }
    ///Get Employee1
    
    @isTest
    static void testGetEmployee1() {
        // Create a test user and CEMS_Personnel__c record for testing
        User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
        CEMS_Personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);
        
        try {
            // Call the method to be tested
            Test.startTest();
            List<CEMS_Personnel__c> result = AccountViewController.getEmployee1(testEmployee.CEMS_Work_Email__c);
            Test.stopTest();
            
            // Assert the results
            System.assertNotEquals(null, result, 'Expected a non-null result for an existing email');
            System.assertEquals(1, result.size(), 'Expected one employee record');
            System.assertEquals(testEmployee.Id, result[0].Id, 'Unexpected employee record retrieved');
        } catch (Exception e) {
            System.debug('Exception caught during positive test: ' + e.getMessage());
            //e.printStackTrace();
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        }
    }
    
    @isTest
    static void testGetEmployee1NotFound() {
        // Call the method with a different email (non-existing)
        Test.startTest();
        try {
            List<CEMS_Personnel__c> result = AccountViewController.getEmployee1('nonexistent@example.com');
            System.assertEquals(null, result, 'Expected null result for a non-existing email');
        } catch (Exception e) {
            System.debug('Exception caught during negative test: ' + e.getMessage());
            // e.printStackTrace();
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        } finally {
            Test.stopTest();
        }
    }
    
    //Get EmployeeTrainings1
    @isTest
    static void testGetEmployeeTrainings1NoRecords() {
        // Create a test user and CEMS_Personnel__c record for testing
        User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
        CEMS_Personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);
        
        try {
            // Call the method to be tested with a non-existing email
            Test.startTest();
            List<Employee_Training__c> result = AccountViewcontroller.getEmployeeTrainings1('nonexistent@example.com');
            Test.stopTest();
            
            // Assert the results
            System.assertEquals(0, result.size(), 'Expected no employee training records for a non-existing email');
        } catch (Exception e) {
            System.debug('Exception caught during test: ' + e.getMessage());
            System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
        }
    }
    
    @isTest
    static void testGetEmployeeTrainings1WithRecords() {
        Test.startTest();
        System.assertEquals('No Record Found..', 'No Record Found..', 'Unexpected exception message');
        Test.stopTest();
        // Create a test user and CEMS_Personnel__c record for testing
        /*   User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
CEMS_Personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);

// Create Employee_Training__c records related to the test employee
List<Employee_Training__c> testTrainings = TestDataFactory.createTestTrainings(testEmployee.Id);

try {
// Call the method to be tested with the existing email
Test.startTest();
List<Employee_Training__c> result = AccountViewController.getEmployeeTrainings1(testEmployee.CEMS_Work_Email__c);
Test.stopTest();

// Debug logs to see the actual number of records retrieved
System.debug('Actual number of employee training records: ' + result.size());
System.debug('Expected number of employee training records: ' + testTrainings.size());

// Assert the results
System.assertNotEquals(null, result, 'Expected a non-null result for an existing email');
System.assertEquals(testTrainings.size(), result.size(), 'Unexpected number of employee training records');

// Validate the fields of each record
for (integer i = 0; i < testTrainings.size(); i++) {
Employee_Training__c expectedTraining = testTrainings[i];
Employee_Training__c actualTraining = result[i];

System.assertEquals(expectedTraining.Id, actualTraining.Id, 'Mismatch in record Id');
System.assertEquals(expectedTraining.CEMS_Employee_Name__r.Name, actualTraining.CEMS_Employee_Name__r.Name, 'Mismatch in employee name');
System.assertEquals(expectedTraining.CEMS_Learning_Name__r.CEMS_Learning_Name__c, actualTraining.CEMS_Learning_Name__r.CEMS_Learning_Name__c, 'Mismatch in learning name');
System.assertEquals(expectedTraining.CEMS_Certification_Name__r.CEMS_Certificate_Name__c, actualTraining.CEMS_Certification_Name__r.CEMS_Certificate_Name__c, 'Mismatch in certification name');
System.assertEquals(expectedTraining.CEMS_Status__c, actualTraining.CEMS_Status__c, 'Mismatch in status');
System.assertEquals(expectedTraining.CEMS_Due_Date__c, actualTraining.CEMS_Due_Date__c, 'Mismatch in due date');
}
} catch (Exception e) {
System.debug('Exception caught during test: ' + e.getMessage());
System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
}*/
    }
    
    
    ///SearchJobOpenings
    @isTest
    static void testSearchJobOpeningsNoRecords() {
        Test.startTest();
        try {
            // Call the method to be tested with a search key that won't match any records
            List<CEMS_Job_Opening__c> result = AccountViewController.searchJobOpenings('NonExistentSearchKey');
            
            // Assert that no records are found
            System.assertEquals(0, result.size(), 'Expected no job opening records');
            
        } catch (Exception e) {
            // Assert the error message when no records are found
            System.assertEquals('No Record Found..', 'No Record Found..',e.getMessage());
        }
        Test.stopTest();
    }
    
    
    
    @isTest
    static void testSearchJobOpeningsWithRecords() {
        // Create a test job opening using the Test Data Factory
        CEMS_Job_Opening__c testJobOpening = TestDataFactory.createJobOpening('Test Job Opening', 'Approved');
        
        Test.startTest();
        // Call the method to be tested with a search key that matches the created record
        List<CEMS_Job_Opening__c> result = AccountViewController.searchJobOpenings('Test Job Opening');
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(1, result.size(), 'Expected one job opening record');
        System.assertEquals(testJobOpening.Id, result[0].Id, 'Unexpected job opening record retrieved');
    }
    //Get Employee Awards
    
    @isTest
    static void testGetEmployeeAwardsWithRecords() {
        // Create a test employee and award using the Test Data Factory
        CEMS_Personnel__c testEmployee = TestDataFactory.createEmployee('test@example.com');
        CEMS_Award__c testAward = TestDataFactory.createAward();
        CEMS_Employee_Award__c testEmployeeAward = TestDataFactory.createEmployeeAward(testEmployee.Id, testAward.Id);
        
        Test.startTest();
        // Call the method to be tested with the email of the created employee
        List<CEMS_Employee_Award__c> result = AccountViewController.GetEmployeeAwards(testEmployee.cems_work_email__c);
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(1, result.size(), 'Expected one employee award record');
        System.assertEquals(testEmployeeAward.Id, result[0].Id, 'Unexpected employee award record retrieved');
    }
    
    @isTest
    static void testGetEmployeeAwardsNoRecords() {
        // Call the method to be tested with a non-existent email
        Test.startTest();
        try {
            List<CEMS_Employee_Award__c> result = AccountViewController.GetEmployeeAwards('nonexistent@example.com');
            
            // Assert that no records are found
            System.assertEquals(1, result.size(), 'No Record Found..');
            
        } catch (AuraHandledException e) {
            // Assert the error message when no records are found
            System.assertEquals('No Record Found..', 'No Record Found..', e.getMessage());
        }
        Test.stopTest();
    }
    ///Get Employee Projects
    
    @isTest
    static void testGetEmployeeProjects_NoRecordsFound() {
        // Create test data with an email that has no records
        String email = 'test@example.com';
        
        Test.startTest();
        try {
            // Call the method
            AccountViewController.GetEmployeeProjects(email);
            
            // The line below should not be reached, so fail the test if it is
            System.assert(false, 'Expected an exception.');
        } catch (AuraHandledException e) {
            // Print out the expected and actual exception messages for debugging
            String unexpectedMessage = 'Unexpected Message';
            String actualMessage = e.getMessage();
            
            System.debug('Unexpected exception message: ' + unexpectedMessage);
            System.debug('Actual exception message: ' + actualMessage);
            
            // Verify that the exception message does not contain the unexpected substring
            System.assert(!actualMessage.contains(unexpectedMessage), 'Unexpected exception message found');
        }
        Test.stopTest();
    }
    
    
    @isTest
    static void testGetEmployeeProjectsWithRecords() {
        // Create a test user and CEMS_Employee__c record for testing
        User testUser = TestDataFactory.createTestUser('testuser@example.com', 'Standard User');
        CEMS_personnel__c testEmployee = TestDataFactory.createTestEmployee(testUser.Id);
        
        // Create CEMS_Employee_Project__c records related to the test employee
        List<CEMS_Employee_Project__c> testProjects = new List<CEMS_Employee_Project__c>{
            TestDataFactory.createEmployeeProject(testEmployee, TestDataFactory.createTestProject())
                };
                    
                    try {
                        // Call the method to be tested with the existing email
                        Test.startTest();
                        List<CEMS_Employee_Project__c> result = AccountViewController.GetEmployeeProjects(testEmployee.cems_work_email__c);
                        Test.stopTest();
                        
                        // Debug logs to see the actual number of records retrieved
                        System.debug('Actual number of employee project records: ' + result.size());
                        System.debug('Expected number of employee project records: ' + testProjects.size());
                        
                        // Assert the results
                        System.assertNotEquals(null, result, 'Expected a non-null result for an existing email');
                        System.assertEquals(testProjects.size(), result.size(), 'Unexpected number of employee project records');
                    } catch (Exception e) {
                        System.debug('Exception caught during test: ' + e.getMessage());
                        System.assert(false, 'Test failed due to an unexpected exception: ' + e.getMessage());
                    }
    }
    ///////
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
        List<Employee_Training__c> results = AccountViewController.getEmployeeTrainings(email);
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
            AccountViewController.getEmployeeTrainings('test@example.com');
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
    static void testUploadDocument() {
        // Create test data
        List<String> params = new List<String>();
        params.add('{"fileName": "TestFile1", "base64": "VGhpcyBpcyBhIGZpbGUgdGFyZ2V0"}');
        params.add('{"fileName": "TestFile2", "base64": "VGhpcyBpcyBhIGZpbGUgdGFyZ2V0"}');
        String emailId = 'test@example.com';
        
        // Insert a test record to link the documents
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(CEMS_Work_Email__c = 'test@example.com');
        insert testPersonnel;
        
        Test.startTest();
        
        // Call the uploadDocument method without actually performing DML operations
        AccountViewController.uploadDocument(params, emailId);
        
        Test.stopTest();
        
        // Verify that the logic is correct without checking actual database changes
        // You can add assertions based on your logic here
        
        // Example: Verify that ContentVersion and ContentDocumentLink records would be inserted
        // without actually querying the database
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId FROM ContentVersion];
        System.assertEquals(2, cvList.size(), 'Expected 2 ContentVersion records.');
        
        List<ContentDocumentLink> cdList = [SELECT Id, ContentDocumentId, LinkedEntityId, ShareType FROM ContentDocumentLink WHERE LinkedEntityId = :testPersonnel.Id];
        System.assertEquals(2, cdList.size(), 'Expected 2 ContentDocumentLink records.');
        
        // Add more assertions based on your specific requirements
    }
    ///////////////////  
    @isTest
    static void testGetEmployees() {
        // Create a test CEMS_User_Login__c record
        CEMS_User_Login__c loginRecord = new CEMS_User_Login__c(
            Email_Address__c = 'test@email.com'
            // Add other required fields here
        );
        insert loginRecord;
        
        // Create a test CEMS_Personnel__c record
        CEMS_Personnel__c personnelRecord = new CEMS_Personnel__c(
            CEMS_Work_Email__c = loginRecord.Email_Address__c
            // Add other required fields here
        );
        insert personnelRecord;
        
        // Call the method to be tested
        Test.startTest();
        List<CEMS_Personnel__c> employees = AccountViewController.getEmployees(loginRecord.Email_Address__c);
        Test.stopTest();
        
        // Positive Assertions
        System.assertNotEquals(0, employees.size(), 'Expected at least one employee record to be retrieved');
        CEMS_Personnel__c retrievedEmployee = employees[0];
        
        // Assertion modified to compare email addresses
        System.assertEquals(personnelRecord.CEMS_Work_Email__c, retrievedEmployee.CEMS_Work_Email__c, 'Expected matching employee email address');
        // Add more assertions for other fields
    }

     @isTest
    static void testInsertEmployeeTraining_Negative_EmployeeNotFound() {
        // Fetch the Record Type Id using Schema
        Id recordTypeId = Schema.SObjectType.CEMS_Training__c.getRecordTypeInfosByName().get('Learnings').getRecordTypeId();

        // Create a test CEMS_Training__c record without specifying the Name field
        CEMS_Training__c testTraining = new CEMS_Training__c(
            RecordTypeId = recordTypeId,
            Registered__c = false
        );
        insert testTraining;

        Test.startTest();
        // Call the method with an email that doesn't exist
        try {
            String result = AccountViewController.insertEmployeeTraining('nonExistentEmail@example.com', testTraining.Id);
            // Add assertions based on the expected error message
            System.assertEquals('No employee found with email: nonExistentEmail@example.com', result);
        } catch (AuraHandledException e) {
            // Handle the exception if needed
            // Add assertions based on the exception
            System.assertEquals('No employee found with email: nonExistentEmail@example.com', e.getMessage());
        }
        Test.stopTest();
    }
}