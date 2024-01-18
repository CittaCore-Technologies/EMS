public class TestDataFactory {

    // Method to set up a REST request with the given request URI and parameters
    @TestVisible
    public static RestRequest setupRestRequest(String requestURI, Map<String, String> params) {
        RestRequest req = new RestRequest();
        req.requestURI = requestURI;
        req.params.putAll(params);
        RestContext.request = req;
        return req;
    }

    // Method to set up a REST response
    @TestVisible
    public static RestResponse setupRestResponse() {
        RestResponse res = new RestResponse();
        RestContext.response = res;
        return res;
    }

    // Method to create test data for job openings
    @TestVisible
    public static void createTestData() {
        List<CEMS_job_opening__c> jobOpeningsData = new List<CEMS_job_opening__c>();
        for (Integer i = 0; i < 15; i++) {
            CEMS_job_opening__c jobOpening = new CEMS_job_opening__c(
                Name = 'Job Opening ' + i,
                CEMS_Roles_and_Responsibilities__c = 'Responsibilities for Job ' + i,
                CEMS_Skills__c = 'Configuration ',
                CEMS_Status__c = 'Open',
                CEMS_Technology__c = 'Azure',
                CEMS_Job_Location__c = 'Pune',
                CEMS_Available_Vacancies__c = 3,
                CEMS_Experience__c = '0-2 years'
            );
            jobOpeningsData.add(jobOpening);
        }
        insert jobOpeningsData;
    }

    // Method to create bulk test data for job openings
    @TestVisible
    public static void createBulkData() {
        List<CEMS_job_opening__c> jobOpenings = new List<CEMS_job_opening__c>();
        jobOpenings.add(new CEMS_job_opening__c(
            Name = 'Test Job 1',
            CEMS_Roles_and_Responsibilities__c = 'Test Roles and Responsibilities 1',
            CEMS_Technology__c = 'Azure',
            CEMS_Status__c = 'Open',
            CEMS_Job_Location__c = 'Pune',
            CEMS_Available_Vacancies__c = 5,
            CEMS_Experience__c = '1-2 years'
        ));
        jobOpenings.add(new CEMS_job_opening__c(
            Name = 'Test Job 2',
            CEMS_Roles_and_Responsibilities__c = 'Test Roles and Responsibilities 2',
            CEMS_Technology__c = 'Azure',
            CEMS_Status__c = 'Open',
            CEMS_Job_Location__c = 'Pune',
            CEMS_Available_Vacancies__c = 0,
            CEMS_Experience__c = '1-3 years'
        ));
        insert jobOpenings;
    }
    @TestVisible
     public static List<CEMS_Job_Opening__c> createApprovedJobOpenings(Integer numberOfRecords) {
        List<CEMS_Job_Opening__c> jobList = new List<CEMS_Job_Opening__c>();

        for (Integer i = 0; i < numberOfRecords; i++) {
            CEMS_Job_Opening__c job = new CEMS_Job_Opening__c(
                Name = 'Slesforce Developers ' + i,
                CEMS_Technology__c = 'Salesforce'
                //CEMS_Approval_Status__c = 'Approved'
                // Add other required fields as needed
            );
            jobList.add(job);
        }

        insert jobList;
        return jobList;
}
    // Create a test user
    @TestVisible
    public static User createTestUser(String email, String profileName) {
        Profile testProfile = [SELECT Id FROM Profile WHERE Name = :profileName LIMIT 1];

        // Append a timestamp to ensure a unique username
        String uniqueUsername = email + System.now().millisecond();

        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = email,
            Username = uniqueUsername,
            Alias = 'TUser',
            ProfileId = testProfile.Id,
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles'
        );

        insert testUser;

        return testUser;
    }

    // Create a test CEMS_Employee__c record
    public static CEMS_Personnel__c createTestEmployee(Id userId) {
        CEMS_Personnel__c testEmployee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            cems_work_email__c = 'testuser@example.com'
            // Add other required fields
        );

        insert testEmployee;

        return testEmployee;
    }

    // Create a test CEMS_Performance__c record
        @TestVisible

    public static CEMS_Performance__c createTestPerformance(Id employeeId) {
        CEMS_Performance__c testPerformance = new CEMS_Performance__c(
            // Populate fields as needed
            CEMS_Employee__c = employeeId
        );

        insert testPerformance;

        return testPerformance;
    }
    @TestVisible
 public static List<Employee_Training__c> createTestTrainings(Id employeeId) {
    List<Employee_Training__c> trainings = new List<Employee_Training__c>();

    // Create one or more Employee_Training__c records related to the employee
    for (Integer i = 0; i < 5; i++) {
                    System.debug('employeeId::::'+employeeId);

        trainings.add(new Employee_Training__c(
            CEMS_Employee_Name__c = employeeId,
           // CEMS_Learning_Name__c = 'Learning ' + i,
           // CEMS_Certification_Name__c = 'Certification ' + i,
            CEMS_Status__c = 'Completed',
            CEMS_Due_Date__c = Date.today().addDays(30)
        ));
    }

    insert trainings;
    return trainings;
}
    @TestVisible
 public static CEMS_Job_Opening__c createJobOpening(String jobName, String approvalStatus) {
        CEMS_Job_Opening__c jobOpening = new CEMS_Job_Opening__c(
            Name = jobName,
            CEMS_Approval_Status__c = approvalStatus
        );
        insert jobOpening;
        return jobOpening;
    }
    
     public static CEMS_Personnel__c createEmployee(String email) {
        CEMS_Personnel__c employee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            cems_work_email__c = email
        );
        insert employee;
        return employee;
    }

    public static CEMS_Award__c createAward() {
        CEMS_Award__c award = new CEMS_Award__c(
            Name = 'Test Award'
            // Add other required fields
        );
        insert award;
        return award;
    }

    public static CEMS_Employee_Award__c createEmployeeAward(String employeeId, String awardId) {
        CEMS_Employee_Award__c employeeAward = new CEMS_Employee_Award__c(
            CEMS_Award__c = awardId,
            CEMS_Employee__c = employeeId,
            CEMS_Award_Date__c = Date.today(),
            CEMS_Award_URL__c = 'https://example.com'
            // Add other required fields
        );
        insert employeeAward;
        return employeeAward;
    }
    
   /* public static CEMS_Personnel__c createTestEmployee(Id userId) {
        CEMS_Personnel__c testEmployee = new CEMS_Personnel__c(
            Name = 'Test Employee',
            cems_work_email__c = 'testemployee@example.com'
            // Add other required fields
        );

        insert testEmployee;
        return testEmployee;
    }*/


   
public static CEMS_Employee_Project__c createEmployeeProject(CEMS_personnel__c employee, CEMS_Projects__c project) {
    CEMS_Employee_Project__c employeeProject = new CEMS_Employee_Project__c();
    employeeProject.CEMS_Employee__c = employee.Id;
    employeeProject.CEMS_Projects__c = project.Id;
    employeeProject.CEMS_Employee_s_Project_Start_Date__c = Date.today();  // Replace with the actual start date
    employeeProject.CEMS_Employee_s_Project_End_Date__c = Date.today().addDays(10);  // Replace with the actual end date
    employeeProject.CEMS_Project_Role__c = 'Project Role';  // Replace with the actual role
    // Add any other required fields for CEMS_Employee_Project__c
    insert employeeProject;
    return employeeProject;
}
public static CEMS_Projects__c createTestProject() {
        CEMS_Projects__c project = new CEMS_Projects__c(
            // Set any required fields for CEMS_Projects__c
            Name = 'Test Project'
        );
        insert project;
        return project;
    }
}