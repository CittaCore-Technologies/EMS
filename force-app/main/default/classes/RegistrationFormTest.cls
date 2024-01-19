@isTest
public class RegistrationFormTest {

    @isTest
    static void testRegisterMethod() {
        // Create test data for the method parameters
        String firstName = 'TestFirst';
        String lastName = 'TestLast';
        String email = 'test@example.com';
        String city = 'TestCity';
        String street = 'TestStreet';
        String country = 'TestCountry';
        String postalCode = '12345';
        String phone = '1234567890';
        String highestDegree = 'PhD';
        String qualification = 'TestQualification';
        Integer cgpa = 4;
        String panCard = 'ABCPAN1234';
        String experience = '5 years';
        String previousCompany = 'TestCompany';
        String role = 'TestRole';

        List<RegistrationForm.AttachmentWrapper> attachments = new List<RegistrationForm.AttachmentWrapper>();
        RegistrationForm.AttachmentWrapper attachment = new RegistrationForm.AttachmentWrapper();
        attachment.fileName = 'TestFile.txt';
        attachment.fileContents = Blob.valueOf('Test file content');
        attachments.add(attachment);

        // Retrieve an existing RecordType Id for CEMS_Personnel__c
        Id recordTypeId = getExistingRecordTypeId('CEMS_Personnel__c');

        // Call the Register method
        Test.startTest();
        RegistrationForm.Register(firstName, lastName, email, city, street, country, postalCode, phone, highestDegree, qualification, cgpa, panCard, experience, previousCompany, role, attachments, recordTypeId);
        Test.stopTest();

        // Perform assertions
        // Example: Query the inserted personnel record and assert its values
        CEMS_Personnel__c insertedPersonnel = [SELECT Id, Name, CEMS_Email__c, CEMS_Contact_Number__c FROM CEMS_Personnel__c WHERE Name = :firstName LIMIT 1];
        System.assertEquals(firstName, insertedPersonnel.Name);
        System.assertEquals(email, insertedPersonnel.CEMS_Email__c);
        System.assertEquals(phone, insertedPersonnel.CEMS_Contact_Number__c);

        // Perform assertions
        // Example: Query the inserted content version and assert its values
        ContentVersion insertedContentVersion = [SELECT Id, Title, VersionData FROM ContentVersion WHERE FirstPublishLocationId = :insertedPersonnel.Id LIMIT 1];
        
        // Use a case-insensitive comparison for Blob data in test assertions
        System.assertEquals(true, Test.isRunningTest() ? 
            insertedContentVersion.Title.equalsIgnoreCase(attachment.fileName) : 
            insertedContentVersion.Title == attachment.fileName
        );
        
        System.assertEquals(true, Test.isRunningTest() ? 
            insertedContentVersion.VersionData.toString().equalsIgnoreCase(attachment.fileContents.toString()) : 
            insertedContentVersion.VersionData == attachment.fileContents
        );
    
    }

    private static Id getExistingRecordTypeId(String sObjectName) {
        // Query an existing RecordType Id for the specified SObject
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType = :sObjectName LIMIT 1];
        return rt.Id;
    }
    //////testGetJobApplications
    @isTest
    static void testGetJobApplications() {
        // Create test data
        // Create a CEMS_Job_Opening__c record
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(/* Populate fields as needed */);
        insert jobOpening;

        // Create a CEMS_Personnel__c record
        CEMS_Personnel__c personnel = new CEMS_Personnel__c(/* Populate fields as needed */);
        insert personnel;

        // Create a CEMS_Job_Application__c record with valid references
        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Job_Opening__c = jobOpening.Id,
            CEMS_Personnel__c = personnel.Id
            // Populate other fields as needed
        );
        insert jobApplication;

        Test.startTest();

        // Call the method
        List<CEMS_Job_Application__c> jobApplications = RegistrationForm.getjobApplications();

        // Add assertions
        System.assertNotEquals(null, jobApplications, 'Expected a non-null list of job applications');
        System.assertEquals(1, jobApplications.size(), 'Expected one job application in the list');

        CEMS_Job_Application__c retrievedJobApplication = jobApplications[0];

        // Add more assertions based on your specific requirements
        // For example:
        // System.assertEquals('John', retrievedJobApplication.CEMS_First_Name__c, 'Incorrect first name');

        Test.stopTest();
    }
    //////////getLeaverecords
     @isTest
    static void testGetLeaveRecords() {
        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'John Doe',
            CEMS_Work_Email__c = 'john.doe@example.com'
            // Add other required fields
        );
        insert employee;

        CEMS_Leave__c leaveRecord = new CEMS_Leave__c(
            Emp_Email__c = employee.CEMS_Work_Email__c,
            CEMS_Employee__c = employee.Id,
            CEMS_Leave_End_Date__c = Date.today()
            // Add other required fields
        );
        insert leaveRecord;

        Test.startTest();

        // Call the method
        List<CEMS_Leave__c> leaveRecords = RegistrationForm.getLeaveRecords(employee.CEMS_Work_Email__c);

        // Add assertions
        System.assertNotEquals(null, leaveRecords, 'Expected a non-null list of leave records');
        System.assertEquals(1, leaveRecords.size(), 'Expected one leave record in the list');

        CEMS_Leave__c retrievedLeaveRecord = leaveRecords[0];

        // Add more assertions based on your specific requirements
        // For example:
        // System.assertEquals('Sick Leave', retrievedLeaveRecord.CEMS_Type_Of_Leave__c, 'Incorrect type of leave');

        Test.stopTest();
    }
    /////getLeaverecords2
    @isTest
    static void testGetLeaveRecords2() {
        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'John Doe',
            CEMS_Work_Email__c = 'john.doe@example.com'
            // Add other required fields
        );
        insert employee;

        CEMS_Leave__c leaveRecord = new CEMS_Leave__c(
            Emp_Email__c = employee.CEMS_Work_Email__c,
            CEMS_Employee__c = employee.Id,
            CEMS_Leave_End_Date__c = Date.today()
            // Add other required fields
        );
        insert leaveRecord;

        Test.startTest();

        // Call the method
        List<CEMS_Leave__c> leaveRecords = RegistrationForm.getLeaveRecords2(employee.CEMS_Work_Email__c);

        // Add assertions
        System.assertNotEquals(null, leaveRecords, 'Expected a non-null list of leave records');
        System.assertEquals(1, leaveRecords.size(), 'Expected one leave record in the list');

        CEMS_Leave__c retrievedLeaveRecord = leaveRecords[0];

        // Add more assertions based on your specific requirements
        // For example:
        // System.assertEquals('Sick Leave', retrievedLeaveRecord.CEMS_Type_Of_Leave__c, 'Incorrect type of leave');

        Test.stopTest();
    }
    /////testRetrieveJobApplications
      @isTest
    static void testRetrieveJobApplications() {
        // Create test data
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(
            Name = 'Software Engineer'
            // Add other required fields for CEMS_Job_Opening__c
        );
        insert jobOpening;

        CEMS_Personnel__c personnel = new CEMS_Personnel__c(
            Name = 'John Doe'
            // Add other required fields for CEMS_Personnel__c
        );
        insert personnel;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Job_Opening__c = jobOpening.Id,
            CEMS_First_Name__c = 'John',
            CEMS_Last_Name__c = 'Doe',
            CEMS_Email__c = 'john.doe@example.com',
            CEMS_Personnel__c = personnel.Id
            // Add other required fields for CEMS_Job_Application__c
        );
        insert jobApplication;

        Test.startTest();

        // Call the method
        List<CEMS_Job_Application__c> jobApplications = RegistrationForm.retrieveJobApplications(jobOpening.Id);

        // Add assertions
        System.assertNotEquals(null, jobApplications, 'Expected a non-null list of job applications');
        System.assertEquals(1, jobApplications.size(), 'Expected one job application in the list');

        CEMS_Job_Application__c retrievedJobApplication = jobApplications[0];

        // Add more assertions based on your specific requirements
        // For example:
        // System.assertEquals('Software Engineer', retrievedJobApplication.CEMS_Job_Opening__r.Name, 'Incorrect job opening name');

        Test.stopTest();
    }
   ////////////////testBase64ToJson
    @isTest
    static void testBase64ToJson() {
        // Encode a sample JSON string to Base64
        String jsonString = '{"key": "value"}';
        Blob base64Data = Blob.valueOf(EncodingUtil.base64Encode(Blob.valueOf(jsonString)));

        Test.startTest();

        // Call the method
        Map<String, Object> result = RegistrationForm.base64ToJson(base64Data.toString());

        // Add assertions
        System.assertNotEquals(null, result, 'Expected a non-null result');
        System.assertEquals('value', result.get('key'), 'Incorrect value for key');

        Test.stopTest();
    }
    /////testVerifyLogin
     @isTest
    static void testVerifyLogin() {
        // Create a test user with the specified email
        String testEmail = 'test@example.com';
        
        // Replace 'YourRecordTypeId' with the actual Record Type Id for 'Employee'
        RecordType employeeRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'CEMS_Personnel__c' AND DeveloperName = 'Employee' LIMIT 1];
        System.assertNotEquals(null, employeeRecordType, 'Employee Record Type not found');

        CEMS_Personnel__c testUser = new CEMS_Personnel__c(
            Name = 'Test User',
            RecordTypeId = employeeRecordType.Id,
            CEMS_Work_Email__c = testEmail,
            CEMS_Personal_Email__c = testEmail
            // Add other required fields
        );
        insert testUser;

        Test.startTest();

        // Call the method
        RegistrationForm.verifyLogin(testEmail);

        Test.stopTest();

        // Perform assertions based on the expected behavior
        List<CEMS_Personnel__c> result = [SELECT Id FROM CEMS_Personnel__c WHERE CEMS_Personal_Email__c = :testEmail];
        System.assertEquals(1, result.size(), 'Expected one user to be retrieved');
    }
}