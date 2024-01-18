@isTest
private class BarChartControllerTest {

    @isTest
    static void testGetOpportunities() {
        // Create test records for CEMS_Job_Opening__c
        List<CEMS_Job_Opening__c> jobOpenings = new List<CEMS_Job_Opening__c>();
        for (Integer i = 0; i < 5; i++) {
            jobOpenings.add(new CEMS_Job_Opening__c(
                Name = 'Job Opening ' + i
                // Add other required fields here
            ));
        }
        insert jobOpenings;

        // Call the method to be tested
        Test.startTest();
        List<AggregateResult> result = BarChartController.getOpportunities();
        Test.stopTest();

        // Positive Assertions
        System.assertNotEquals(0, result.size(), 'Expected aggregate results to be retrieved');

        // Verify that the returned records contain the expected fields
        for (AggregateResult aggregateResult : result) {
            // Add assertions based on your specific fields
            System.assert(aggregateResult.get('Name') != null, 'Expected Name to be present in the result');
            System.assert(aggregateResult.get('maxJobOpeningId') != null, 'Expected maxJobOpeningId to be present in the result');
            // Add more assertions for other fields
        }
    }
}