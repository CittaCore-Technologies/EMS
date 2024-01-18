@isTest(SeeAllData=false)
public class testUploadDocument {

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
    
    
}