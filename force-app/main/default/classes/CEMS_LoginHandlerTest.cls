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

        try {
            // Call the method
            CEMS_LoginHandler.applicantGenerateOtpHandler(applicant.Name, applicant.CEMS_Email__c);

            // Add assertions as needed
            // For example, check if a CEMS_User_Login__c record is created with the generated OTP
            List<CEMS_User_Login__c> userLogins = [SELECT Id, Applicant_Name__c, Email_Address__c, OTP__c, Is_Used__c FROM CEMS_User_Login__c];
            System.assertNotEquals(0, userLogins.size(), 'Employee Record Doesnt Exist');
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }
 @isTest
    static void testEmployeeGenerateOtpHandler_QueryException() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            CEMS_Work_Email__c = 'testemployee@example.com',
            CEMS_Employee_ID__c = 'EMP123'
        );
        insert employee;

        // Delete the employee record to simulate a scenario where the record doesn't exist
        delete employee;

        try {
            // Call the method
            CEMS_LoginHandler.employeeGenerateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c);

            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected QueryException but none was thrown.');
        } catch (QueryException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('Employee Record Doesn\'t Exist', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }
    @isTest
    static void testApplicantValidateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c applicant = new CEMS_Personnel__c(
            Name = 'Test Applicant',
            CEMS_Email__c = 'testapplicant@example.com'
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

        try {
            // Call the method
            CEMS_LoginHandler.applicantValidateOtpHandler(applicant.Name, applicant.CEMS_Email__c, userLogin.OTP__c);

            // Add assertions as needed
            // For example, check if the Is_Used__c field is updated to true
            userLogin = [SELECT Id, Is_Used__c FROM CEMS_User_Login__c WHERE Id = :userLogin.Id LIMIT 1];
            System.assertEquals(true, userLogin.Is_Used__c, 'Expected Is_Used__c to be updated to true');
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

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

        try {
            // Call the method
            CEMS_LoginHandler.employeeGenerateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c);

            // Add assertions as needed
            // For example, check if a CEMS_User_Login__c record is created with the generated OTP
            List<CEMS_User_Login__c> userLogins = [SELECT Id, Employee_Id__c, Email_Address__c, OTP__c, Is_Used__c FROM CEMS_User_Login__c];
            System.assertNotEquals(0, userLogins.size(), 'Expected a CEMS_User_Login__c record to be created');
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

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

        try {
            // Call the method
            CEMS_LoginHandler.employeeValidateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c, userLogin.OTP__c);

            // Add assertions as needed
            // For example, check if the Is_Used__c field is updated to true
            userLogin = [SELECT Id, Is_Used__c FROM CEMS_User_Login__c WHERE Id = :userLogin.Id LIMIT 1];
            System.assertEquals(true, userLogin.Is_Used__c, 'Expected Is_Used__c to be updated to true');
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @isTest
    static void testInvalidApplicantValidateOtpHandler() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c applicant = new CEMS_Personnel__c(
            Name = 'Test Applicant',
            CEMS_Email__c = 'testapplicant@example.com'
        );
        insert applicant;

        try {
            // Call the method
            CEMS_LoginHandler.applicantValidateOtpHandler('InvalidApplicantId', 'invalidemail@example.com', 'invalidOTP');
            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected CustomException but none was thrown.');
        } catch (CustomException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('OTP Mismatch', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }
    
     @isTest
    static void testApplicantValidateOtpHandler_CustomException() {
        Test.startTest();

        // Create test data
        CEMS_Personnel__c applicant = new CEMS_Personnel__c(
            Name = 'Test Applicant',
            CEMS_Email__c = 'testapplicant@example.com'
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

        try {
            // Call the method with an incorrect OTP
            CEMS_LoginHandler.applicantValidateOtpHandler(applicant.Name, applicant.CEMS_Email__c, 'invalidOTP');

            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected CustomException but none was thrown.');
        } catch (CustomException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('OTP Mismatch', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @isTest
    static void testEmployeeValidateOtpHandler_CustomException() {
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

        try {
            // Call the method with an incorrect OTP
            CEMS_LoginHandler.employeeValidateOtpHandler(employee.CEMS_Employee_ID__c, employee.CEMS_Work_Email__c, 'invalidOTP');

            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected CustomException but none was thrown.');
        } catch (CustomException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('OTP Mismatch', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }
    @isTest
    static void testApplicantGenerateOtpHandler_NoRecordFound() {
        Test.startTest();

        try {
            // Call the method with an applicant name and email that do not exist
            CEMS_LoginHandler.applicantGenerateOtpHandler('NonExistentApplicant', 'nonexistentemail@example.com');

            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected CustomException but none was thrown.');
        } catch (CEMS_LoginHandler.CustomException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('Can\'t find any record. Please register', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }

    @isTest
    static void testEmployeeGenerateOtpHandler_NoRecordFound() {
        Test.startTest();

        try {
            // Call the method with an employee ID and email that do not exist
            CEMS_LoginHandler.employeeGenerateOtpHandler('NonExistentEmployeeId', 'nonexistentemail@example.com');

            // If the above line does not throw an exception, fail the test
            System.assert(false, 'Expected CustomException but none was thrown.');
        } catch (CEMS_LoginHandler.CustomException e) {
            // Check if the expected exception message is thrown
            System.assertEquals('Can\'t find any record. Please register', e.getMessage(), 'Expected exception message does not match.');
        } catch (Exception e) {
            // Catch any other unexpected exceptions and fail the test
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }

        Test.stopTest();
    }
}