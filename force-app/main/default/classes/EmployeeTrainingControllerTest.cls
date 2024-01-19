@isTest
private class EmployeeTrainingControllerTest {

    @isTest
    static void testInsertEmployeeTraining() {
        // Fetch the Record Type Id using Schema
        Id recordTypeId = Schema.SObjectType.CEMS_Training__c.getRecordTypeInfosByName().get('Learnings').getRecordTypeId();
        system.debug('recordTypeId'+recordTypeId);
        // Create a test CEMS_Training__c record without specifying the Name field
        CEMS_Training__c testTraining = new CEMS_Training__c(
            RecordTypeId = recordTypeId,
            Registered__c = false
        );
        insert testTraining;

        // Create a test CEMS_Personnel__c record
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(
            Name = 'Test Personnel',
            CEMS_Work_Email__c = 'nalinirajus@cittacore.com'
        );
        insert testPersonnel;

        Test.startTest();
        // Call the method with test data
        String result = AccountViewController.insertEmployeeTraining('nalinirajus@cittacore.com', testTraining.Id);
        system.debug(result);
        Test.stopTest();

        // Retrieve the updated CEMS_Training__c record after the DML operations
        CEMS_Training__c updatedTraining = [SELECT Id, Registered__c FROM CEMS_Training__c WHERE Id = :testTraining.Id LIMIT 1];
        System.debug('updatedTraining: ' + updatedTraining);

        // Add assertions based on the expected results
        System.assertEquals('Employee training registered successfully', result);
        System.assertEquals(true, updatedTraining.Registered__c);
    }
    
     @isTest
    static void testInsertEmployeeTraining_Negative_TrainingNotFound() {
        Test.startTest();
        // Call the method with a non-existent training record ID
        try {
            String result = AccountViewController.insertEmployeeTraining('test@example.com', 'nonExistentId');
            // Add assertions based on the expected error message
            System.assertEquals('No employee training registered - Record not found for training Id: nonExistentId', result);
        } catch (AuraHandledException e) {
            // Handle the exception if needed
            // Add assertions based on the exception
            System.assertEquals('No employee training registered - Record not found for training Id: nonExistentId', e.getMessage());
        }
        Test.stopTest();
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
    
    @isTest
    static void testInsertEmployeeTraining_Negative_RecordTypeNotFound() {
        // Fetch the Record Type Id using Schema
        Id recordTypeId = Schema.SObjectType.CEMS_Training__c.getRecordTypeInfosByName().get('Learnings').getRecordTypeId();

        // Create a test CEMS_Training__c record without specifying the Name field
        CEMS_Training__c testTraining = new CEMS_Training__c(
            RecordTypeId = recordTypeId,
            Registered__c = false
        );
        insert testTraining;

        // Create a test CEMS_Personnel__c record
        CEMS_Personnel__c testPersonnel = new CEMS_Personnel__c(
            Name = 'Test Personnel',
            CEMS_Work_Email__c = 'test@example.com'
        );
        insert testPersonnel;

        Test.startTest();
        // Call the method with a training record that has a non-existent record type
        try {
            String result = AccountViewController.insertEmployeeTraining('test@example.com', testTraining.Id);
            // Add assertions based on the expected error message
            System.assertEquals('No employee training registered - Record Type not found for training: ' + testTraining.Name, result);
        } catch (AuraHandledException e) {
            // Handle the exception if needed
            // Add assertions based on the exception
            System.assertEquals('No employee training registered - Record Type not found for training: ' + testTraining.Name, e.getMessage());
        }
        Test.stopTest();
    }


}