@isTest
private class EmailTriggerHelperTest {

    @isTest
    static void testSendEmail() {
        // Create test data
        // Create a CEMS_Employee__c record first
        CEMS_Personnel__c personnel = new CEMS_Personnel__c(CEMS_Company_Name__c='Cittacore');
        insert personnel;
        
        // Now, create a CEMS_Leave__c record associated with the employee
        CEMS_Leave__c leaveWithEmail = new CEMS_Leave__c(
           // Emp_Email__c = personnel.CEMS_Work_Email__c,
            CEMS_Employee__c = personnel.Id,
            CEMS_Leave_End_Date__c = Date.today()
        );
        insert leaveWithEmail;

        // Create another CEMS_Leave__c record without an associated employee
        CEMS_Leave__c leaveWithNoEmail = new CEMS_Leave__c(
            CEMS_Employee__c = personnel.Id,
            CEMS_Leave_End_Date__c = Date.today()
        );
        insert leaveWithNoEmail;

        Test.startTest();
        
        // Call the static method using the class name
        EmailTriggerHelper.sendEmail(new List<CEMS_Leave__c>{ leaveWithNoEmail, leaveWithEmail });
        
        Test.stopTest();
        
        // Verify that emails would have been created correctly
        List<EmailMessage> sentEmails = [SELECT Id, RelatedToId, Subject FROM EmailMessage];
        
        // Log information for debugging
        System.debug('Sent Emails: ' + sentEmails);

        // Expecting only one email with CEMS_Employee__c not null
        System.assertEquals(1, sentEmails.size(), 'Expected one email to be created');
        System.assertEquals(leaveWithEmail.Id, sentEmails[0].RelatedToId, 'Incorrect RelatedToId');
        System.assertEquals('Welcome! Your Account Details', sentEmails[0].Subject, 'Incorrect Subject');
        // Add more assertions based on your specific requirements
    }
    
    @isTest
    static void testSendEmailCustom() {
        // Create test data
        // Create a CEMS_Employee__c record first
        CEMS_Personnel__c personnel = new CEMS_Personnel__c(CEMS_Company_Name__c='Cittacore');
        insert personnel;
        
        // Now, create a CEMS_Leave__c record associated with the employee
        CEMS_Leave__c leaveWithEmail = new CEMS_Leave__c(
          //  Emp_Email__c = personnel.CEMS_Work_Email__c,
            CEMS_Employee__c = personnel.Id,
            CEMS_Leave_End_Date__c = Date.today()
        );
        insert leaveWithEmail;

        // Create another CEMS_Leave__c record without an associated employee
        CEMS_Leave__c leaveWithNoEmail = new CEMS_Leave__c(
            CEMS_Employee__c = personnel.Id,
            CEMS_Leave_End_Date__c = Date.today()
        );
        insert leaveWithNoEmail;

        Test.startTest();

        // Call the static method using the class name
        EmailTriggerHelper.sendEmailCustom(new List<CEMS_Leave__c>{ leaveWithNoEmail, leaveWithEmail });

        Test.stopTest();

        // Verify that emails would have been created correctly
        List<EmailMessage> sentEmails = [SELECT Id, RelatedToId, Subject FROM EmailMessage];

        // Log information for debugging
        System.debug('Sent Emails: ' + sentEmails);

        // Expecting only one email with CEMS_Employee__c not null
        System.assertEquals(1, sentEmails.size(), 'Expected one email to be created');
        System.assertEquals(leaveWithEmail.Id, sentEmails[0].RelatedToId, 'Incorrect RelatedToId');
        System.assertEquals('Welcome! Your Account Details', sentEmails[0].Subject, 'Incorrect Subject');
        // Add more assertions based on your specific requirements
    }
}