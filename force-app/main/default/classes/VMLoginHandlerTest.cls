@isTest
private class VMLoginHandlerTest {

    @isTest
    static void testEmployeeGenerateOtpHandler() {
        // Positive scenario: Employee record exists
        CEMS_Personnel__c testEmployee = new CEMS_Personnel__c(
            CEMS_Employee_ID__c = '12345',
            CEMS_Work_Email__c = 'test@example.com'
        );
        insert testEmployee;

        Test.startTest();
        VMLoginHandler.employeeGenerateOtpHandler(testEmployee.CEMS_Employee_ID__c, testEmployee.CEMS_Work_Email__c);

        // Query the OTP record after the method call
        List<CEMS_User_Login__c> otpUsers = [SELECT Id, OTP__c, Is_Used__c FROM CEMS_User_Login__c WHERE Personnel__c = :testEmployee.Id];
        

        // Assert the OTP record is created
        System.assertEquals(1, otpUsers.size(), 'One OTP record should be created.');

        CEMS_User_Login__c createdOtpUser = otpUsers[0];

        // Assert the OTP is generated and set correctly
        System.assertNotEquals(null, createdOtpUser.OTP__c, 'OTP should be generated.');
        System.assertEquals(false, createdOtpUser.Is_Used__c, 'Is_Used__c should be set to false.');

        // Negative scenario: Employee record does not exist
        
        try {
            VMLoginHandler.employeeGenerateOtpHandler('nonexistentID', 'nonexistent@example.com');
        } catch (QueryException e) {
            System.assertEquals('Employee Record Does Not Exist', e.getMessage(), 'Exception message should be as expected.');
        }
        Test.stopTest();
    }

    @isTest
    static void testEmployeeValidateOtpHandler() {
        // Positive scenario: Valid OTP
        CEMS_Personnel__c testEmployee = new CEMS_Personnel__c(
            CEMS_Employee_ID__c = '12345',
            CEMS_Work_Email__c = 'test@example.com'
        );
        insert testEmployee;

        CEMS_User_Login__c testUser = new CEMS_User_Login__c(
            Employee_Id__c = testEmployee.CEMS_Employee_ID__c,
            Email_Address__c = testEmployee.CEMS_Work_Email__c,
            OTP__c = '123456',
            Is_Used__c = false
        );
        insert testUser;

        Test.startTest();
        VMLoginHandler.employeeValidateOtpHandler(testEmployee.CEMS_Employee_ID__c, testEmployee.CEMS_Work_Email__c, '123456');

        // Query the OTP record after the method call
        List<CEMS_User_Login__c> updatedOtpUsers = [SELECT Id, Is_Used__c FROM CEMS_User_Login__c WHERE Id = :testUser.Id];
       

        // Assert the OTP record is updated
        System.assertEquals(1, updatedOtpUsers.size(), 'One OTP record should be updated.');

        CEMS_User_Login__c updatedOtpUser = updatedOtpUsers[0];

        // Assert Is_Used__c is set to true
        System.assertEquals(true, updatedOtpUser.Is_Used__c, 'Is_Used__c should be set to true.');

        // Negative scenario: Invalid OTP
     
        try {
            VMLoginHandler.employeeValidateOtpHandler(testEmployee.CEMS_Employee_ID__c, testEmployee.CEMS_Work_Email__c, 'wrongOTP');
        } catch (VMLoginHandler.CustomException e) {
            System.assertEquals('OTP Mismatch', e.getMessage(), 'Exception message should be as expected.');
        }
        Test.stopTest();
    }
}