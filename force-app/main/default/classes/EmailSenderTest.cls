@isTest
private class EmailSenderTest {
 @isTest
    static void testSendOfferLetterEmail() {
        // Create test data
        CEMS_Personnel__c personnelRecord = new CEMS_Personnel__c(
            // Provide required field values
            // ...
        );
        insert personnelRecord;
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(
            CEMS_Job_Location__c = 'Mumbai'
            // Add other required fields...
        );
        insert jobOpening;

        CEMS_Job_Application__c jobApplication = new CEMS_Job_Application__c(
            CEMS_Email__c = 'test@example.com',
            Offered_Position__c = 'Sales Cloud Consultant',
            CEMS_Last_Name__c = 'Doe',
            Date_of_Joining__c = Date.today(),
            Offered_salary__c = 80000.00,
            CEMS_Personnel__c = personnelRecord.Id,
            CEMS_Job_Opening__c = jobOpening.Id // Assign the Id of a CEMS_Job_Opening__c record
        );
        insert jobApplication;

         // Call the method within System.runAs to isolate the test execution
        Test.startTest();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            EmailSender.sendOfferLetterEmail([SELECT Id FROM CEMS_Job_Application__c LIMIT 1].Id);
        }
        Test.stopTest();

        // Query sent emails using @seeAllData
        List<EmailMessage> sentEmails = [SELECT Subject FROM EmailMessage];
        
        // Check if any emails were sent
        System.assertEquals(1, sentEmails.size(), 'Expected one email to be sent');

        // Check the subject of the sent email
        System.assertEquals('Offer Letter for Software Engineer role at CittaCore Technologies','Offer Letter for Software Engineer role at CittaCore Technologies', sentEmails[0].Subject);
    
    }

    @isTest
    static void testGenerateOfferLetter() {
        // Call the generateOfferLetter method and check its output
        String offerLetter = EmailSender.generateOfferLetter('Software Engineer', 'Doe', Date.today(), 80000.00);

        // Add your assertions here based on the expected content of the generated offer letter
        // For example, you can check if certain phrases or values are present in the offer letter

        // Example assertion for checking if the offer letter contains the position name
        System.assert(offerLetter.contains('Congratulations! You have been selected for the Software Engineer position at CittaCore Technologies'));
    }
}