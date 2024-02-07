@isTest
private class CEMS_LoginHandlerTest {

    @isTest
    static void testApplicantGenerateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c applicant = new CEMS_Personnel__c(
            Name = 'Test Applicant',
            CEMS_Email__c = 'testapplicant@example.com'
        );
        insert applicant;

        // Call the method
        CEMS_LoginHandler.applicantGenerateOtpHandler(applicant.Name, applicant.CEMS_Email__c);

        // Add assertions as needed
        // For example, check if a CEMS_User_Login__c record is created with the generated OTP
        List<CEMS_User_Login__c> userLogins = [SELECT Id, Applicant_Name__c, Email_Address__c, OTP__c, Is_Used__c FROM CEMS_User_Login__c];
        System.assertNotEquals(0, userLogins.size(), 'Expected a CEMS_User_Login__c record to be created');

        Test.stopTest();
    }
     @isTest
    static void testApplicantGenerateOtpHandler_Exception() {
        // Test data setup - No CEMS_Personnel__c record with the specified name and email
        // This is intentionally causing the CustomException to be thrown
        try {
            CEMS_LoginHandler.applicantGenerateOtpHandler('Nonexistent Applicant', 'nonexistent@example.com');
            // If the method doesn't throw an exception, fail the test
            System.assert(false, 'Expected CustomException but it did not occur.');
        } catch (CEMS_LoginHandler.CustomException e) {
            System.assertEquals('Cant find any record. Please register', e.getMessage(),
                'Unexpected error message for CustomException.');
            System.debug('Exception caught: ' + e.getMessage());

            // Expected behavior, do nothing
        }
    }
    
    @isTest
    static void testApplicantValidateOtpHandler_Exception() {
        // Test data setup - No CEMS_User_Login__c record with the specified name, email, and otp
        // This is intentionally causing the CustomException to be thrown
        try {
            CEMS_LoginHandler.applicantValidateOtpHandler('Nonexistent Applicant', 'nonexistent@example.com', '123456');
            // If the method doesn't throw an exception, fail the test
            System.assert(false, 'Expected CustomException but it did not occur.');
        } catch (CEMS_LoginHandler.CustomException e) {
            System.assertEquals('OTP Mismatch', e.getMessage(),
                'Unexpected error message for CustomException.');
            // Expected behavior, do nothing
        }
    }
    
    
    @isTest
    static void testEmployeeGenerateOtpHandler_Exception() {
        // Test data setup - No CEMS_Personnel__c record with the specified employeeId and emailId
        // This is intentionally causing the QueryException to be thrown
        try {
            CEMS_LoginHandler.employeeGenerateOtpHandler('NonexistentEmployeeID', 'nonexistent@example.com');
            // If the method doesn't throw an exception, fail the test
            System.assert(false, 'Expected QueryException but it did not occur.');
        } catch (QueryException e) {
            System.assertEquals('Employee Record Doesnt Exist', e.getMessage(),
                'Unexpected error message for QueryException.');
            // Expected behavior, do nothing
        }
    }
    
     @isTest
    static void testEmployeeValidateOtpHandler_Exception() {
        // Test data setup - No CEMS_User_Login__c record with the specified employeeId, emailId, and otp
        // This is intentionally causing the CustomException to be thrown
        try {
            CEMS_LoginHandler.employeeValidateOtpHandler('NonexistentEmployeeID', 'nonexistent@example.com', '123456');
            // If the method doesn't throw an exception, fail the test
            System.assert(false, 'Expected CustomException but it did not occur.');
        } catch (CEMS_LoginHandler.CustomException e) {
            System.assertEquals('OTP Mismatch', e.getMessage(),
                'Unexpected error message for CustomException.');
            // Expected behavior, do nothing
        }
    }

    @isTest
    static void testApplicantValidateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c applicant = new CEMS_Personnel__c(
        );
        insert applicant;

        CEMS_User_Login__c userLogin = new CEMS_User_Login__c(
            Personnel__c = applicant.Id,
            Applicant_Name__c = applicant.Name,
            Email_Address__c = applicant.CEMS_Email__c,
            OTP__c = '123456',
            Is_Used__c = false
        );
        insert userLogin;

        // Call the method
        CEMS_LoginHandler.applicantValidateOtpHandler(applicant.Name, applicant.CEMS_Email__c, userLogin.OTP__c);

        // Add assertions as needed
        // For example, check if the Is_Used__c field is updated to true
        userLogin = [SELECT Id, Is_Used__c FROM CEMS_User_Login__c WHERE Id = :userLogin.Id LIMIT 1];
        System.assertEquals(true, userLogin.Is_Used__c, 'Expected Is_Used__c to be updated to true');

        Test.stopTest();
    }

 @isTest
    static void testEmployeeGenerateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            CEMS_Work_Email__c = 'testemployee@example.com',
            CEMS_Employee_ID__c = 'EMP123'
        );
        insert employee;

        // Call the method
        CEMS_LoginHandler.employeeGenerateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c);

        // Add assertions as needed
        // For example, check if a CEMS_User_Login__c record is created with the generated OTP
        List<CEMS_User_Login__c> userLogins = [SELECT Id, Employee_Id__c, Email_Address__c, OTP__c, Is_Used__c FROM CEMS_User_Login__c];
        System.assertNotEquals(0, userLogins.size(), 'Expected a CEMS_User_Login__c record to be created');

        Test.stopTest();
    }

    @isTest
    static void testEmployeeValidateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            CEMS_Work_Email__c = 'testemployee@example.com',
            CEMS_Employee_ID__c = 'EMP123'
        );
        insert employee;

        CEMS_User_Login__c userLogin = new CEMS_User_Login__c(
            Personnel__c = employee.Id,
            Employee_Id__c = employee.CEMS_Employee_ID__c,
            Email_Address__c = employee.CEMS_Work_Email__c,
            OTP__c = '123456',
            Is_Used__c = false
        );
        insert userLogin;

        // Call the method
        CEMS_LoginHandler.employeeValidateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c, userLogin.OTP__c);

        // Add assertions as needed
        // For example, check if the Is_Used__c field is updated to true
        userLogin = [SELECT Id, Is_Used__c FROM CEMS_User_Login__c WHERE Id = :userLogin.Id LIMIT 1];
        System.assertEquals(true, userLogin.Is_Used__c, 'Expected Is_Used__c to be updated to true');

        Test.stopTest();
    }
}