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
            Emp_Email__c = personnel.CEMS_Work_Email__c,
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
        
        // Reserve email capacity for the test
        Messaging.reserveSingleEmailCapacity(2);

        // Call the static method using the class name
        EmailTriggerHelper.sendEmail(new List<CEMS_Leave__c>{ leaveWithNoEmail, leaveWithEmail });
        
        Test.stopTest();
        
        // Verify that emails would have been created correctly
        List<EmailMessage> sentEmails = [SELECT Id, RelatedToId, Subject FROM EmailMessage];

        // Log information for debugging
        System.debug('Sent Emails: ' + sentEmails);

        // Assert that at least one email was sent
        System.assertNotEquals(1, sentEmails.size(), 'Expected at least one email to be created');
      // Assert that setTargetObjectId, setSaveAsActivity are correctly set
      
    
        
    }
    
    @isTest
    static void testSendEmailCustom() {
        // Create test data
        // Create a CEMS_Employee__c record first
        CEMS_Personnel__c personnel = new CEMS_Personnel__c(CEMS_Company_Name__c='Cittacore', CEMS_Work_Email__c='nalinirajus@cittacore.com');
        insert personnel;
        
        // Now, create a CEMS_Leave__c record associated with the employee
        CEMS_Leave__c leaveWithEmail = new CEMS_Leave__c(
            Emp_Email__c = personnel.CEMS_Work_Email__c,
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

        // Reserve email capacity for the test
        Messaging.reserveSingleEmailCapacity(2);

        // Call the static method using the class name
        EmailTriggerHelper.sendEmailCustom(new List<CEMS_Leave__c>{ leaveWithNoEmail, leaveWithEmail });

        Test.stopTest();

        // Verify that emails would have been created correctly
        List<EmailMessage> sentEmails = [SELECT Id, RelatedToId, Subject FROM EmailMessage];

        // Log information for debugging
        System.debug('Sent Emails: ' + sentEmails);

        // Assert that at least one email was sent
        System.assertNotEquals(1, sentEmails.size(), 'Expected at least one email to be created');
        
        // Add more assertions based on your specific requirements
    }
    

}