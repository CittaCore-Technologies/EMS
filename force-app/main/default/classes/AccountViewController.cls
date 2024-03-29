public without sharing class AccountViewController {
    
    public class NoDataFoundException extends Exception {}
    
    static List<ContentVersion> cvList = new List<ContentVersion>();
    static List<ContentDocumentLink> cdList = new List<ContentDocumentLink>();
    
  @AuraEnabled(cacheable=true)
    public static List<Contact> getDataFromContact() {
        List<Contact> conList = new List<Contact>();

        
            conList = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 10];
        

        return conList;
    }
    @AuraEnabled(cacheable=true)
    public static List<CEMS_Job_Opening__c> getJobOpenings(){
    return [SELECT Id, Name, RecordTypeId,CEMS_Experience__c,CEMS_Job_Location__c, CEMS_Roles_and_Responsibilities__c, CEMS_Minimum_Pay__c, CEMS_Maximum_Pay__c, CEMS_Available_Vacancies__c, CEMS_Due_Date__c, CEMS_Skills__c, CEMS_Technology__c,CEMS_Approval_Status__c FROM CEMS_Job_Opening__c WHERE RecordType.Name = 'External Job Opening' AND CEMS_Approval_Status__c='Approved'];
    }



    @AuraEnabled(cacheable=true)
    public static List<CEMS_Job_Opening__c> getInternalJobOpenings(){
    return [SELECT Id, Name, RecordTypeId,CEMS_Experience__c, CEMS_Roles_and_Responsibilities__c, CEMS_Minimum_Pay__c, CEMS_Maximum_Pay__c, CEMS_Available_Vacancies__c, CEMS_Due_Date__c, CEMS_Skills__c, CEMS_Technology__c,CEMS_Approval_Status__c FROM CEMS_Job_Opening__c];
    }

    @AuraEnabled(cacheable = true)
    public static List<CEMS_Job_Opening__c> searchJobOpenings(string searchKey){
    searchKey = '%' + searchKey + '%';
    List<CEMS_Job_Opening__c> searched_Job = [SELECT Id, Name, CEMS_Technology__c,CEMS_Approval_Status__c FROM CEMS_Job_Opening__c  WHERE Name  LIKE :searchKey AND CEMS_Approval_Status__c= 'Approved'];
    if(searched_Job.isEmpty())  
    {
        throw new AuraHandledException('No Record Found..');
    }                
    return searched_Job;
    }
    @AuraEnabled(cacheable = true)
    public static List<string> getTechnologyOptions(){
    List<Schema.PicklistEntry> picklistValues = CEMS_Job_Opening__c.CEMS_Technology__c.getDescribe().getPicklistValues();
    List<string> technologyOptions = new List<string>();
            for (Schema.PicklistEntry picklistValue : picklistValues) {
        technologyOptions.add(picklistValue.getValue());
    }

    return technologyOptions;
    }

    @AuraEnabled(cacheable = true)
    public static List<String> getExperienceOptions(){
    List<Schema.PicklistEntry> pickListVal = CEMS_Job_Opening__c.CEMS_Experience__c.getDescribe().getPickListValues();

    List<String> experienceOptions = new List<String>();
    for(Schema.PickListEntry pickListValue : pickListVal){
        experienceOptions.add(pickListValue.getValue());
    }
    return experienceOptions;
    }
    @AuraEnabled(cacheable = true)
    public static List<String> getLocationOptions(){
    List<Schema.PicklistEntry> pickListVal = CEMS_Job_Opening__c.CEMS_Job_Location__c.getDescribe().getPickListValues();

    List<String> locationOptions = new List<String>();
    for(Schema.PickListEntry pickListValue : pickListVal){
        locationOptions.add(pickListValue.getValue());
    }
    return locationOptions;
    }

    // @AuraEnabled(cacheable = true)
    // public static List<CEMS_Employee_Award__c> GetEmployeeAwards(string email){
    // List<CEMS_Employee_Award__c> EmployeeAwards = [SELECT Id, Name,CEMS_Award__r.Name,CEMS_Award_Date__c,CEMS_Employee__c,CEMS_Award_URL__c,CEMS_Employee__r.Name FROM CEMS_Employee_Award__c WHERE CEMS_Employee__r.cems_work_email__c =:email];
    // if(EmployeeAwards.isEmpty())  
    // {
    //     throw new AuraHandledException('No Record Found..');
    // }                
    // return EmployeeAwards;
    // }   

    @AuraEnabled(cacheable = true)
    public static List<CEMS_Employee_Award__c> GetEmployeeAwards(String email) {
        List<CEMS_Employee_Award__c> EmployeeAwards;
        if (String.isNotBlank(email)) {
            EmployeeAwards = [SELECT Id, Name, CEMS_Award__r.Name, CEMS_Award_Date__c, 
                                    CEMS_Employee__c, CEMS_Award_URL__c, CEMS_Employee__r.Name 
                              FROM CEMS_Employee_Award__c 
                              WHERE CEMS_Employee__r.cems_work_email__c = :email];
        } else {
            EmployeeAwards = [SELECT Id, Name, CEMS_Award__r.Name, CEMS_Award_Date__c, 
                                    CEMS_Employee__c, CEMS_Award_URL__c, CEMS_Employee__r.Name 
                              FROM CEMS_Employee_Award__c];
        }
        if (EmployeeAwards.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }
        return EmployeeAwards;
    }
    @AuraEnabled(cacheable = true)
    public static List<CEMS_Performance__c> getPerformances(String email){
    List<CEMS_Performance__c> EmployeePerformance = [SELECT Id, Name,CEMS_Employee__r.Name, CEMS_Current_Discussion_Date__c, CEMS_Feedback__c, CEMS_Last_Discussion_Date__c, CEMS_Opportunities__c, CEMS_Performance_ID__c, CEMS_Performance_Outcome__c, CEMS_Promoted_Designation__c, CEMS_Weakness__c, CEMS_Threats__c, CEMS_Strength__c, CEMS_Rating_Value_4__c, CEMS_Rating_Value_3__c, CEMS_Rating_Value_2__c, CEMS_Rating_Value_1__c, CEMS_Career_Development_Focus_Areas__c, CEMS_Bonus__c, CEMS_Hike__c, CEMS_Employee__c, CEMS_Overall_Rating__c FROM CEMS_Performance__c WHERE CEMS_Employee__r.cems_work_email__c =:email ];
    if(EmployeePerformance.isEmpty())  
    {
        throw new AuraHandledException('No Record Found..');
    }                
    return EmployeePerformance;
    }  
    @AuraEnabled(cacheable = true)
    public static List<CEMS_Personnel__c> getEmployee(String email){
        // Check if the email parameter is null
    if (email == null) {
        return null;
    }
    List<CEMS_Personnel__c> Employee = [SELECT Id,Name,CEMS_Work_Email__c,CEMS_Work_Location__c,CEMS_Contact_Number__c, 
    CEMS_Employee_ID__c, CEMS_HR_Manager__r.Name,CEMS_Position__r.Name,CEMSAddress__City__s,CEMSAddress__CountryCode__s, 
    CEMSAddress__Street__s,CEMSAddress__StateCode__s, CEMS_Personal_Email__c,CEMS_Date_of_Birth__c
    FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c =:email LIMIT 1];//: email LIMIT 1
    // List<CEMS_User_Login__c> Login = [SELECT Id,Email_Address__c FROM CEMS_User_Login__c WHERE Email_Address__c =: email  LIMIT 1];
    system.debug('Employee'+Employee);
    if (employee.isEmpty() || employee[0].CEMS_Work_Email__c != email) {
        return null; // Return null if no records found or the email doesn't match
    }   
    return Employee;
    }

    @AuraEnabled(cacheable = true)
    public static List<CEMS_Personnel__c> getEmployee1(String email){
    List<CEMS_Personnel__c> Employee = [SELECT Id,Name,CEMS_Work_Email__c,CEMS_Work_Location__c,CEMS_Contact_Number__c, 
    CEMS_Employee_ID__c,CEMS_HR_Manager__r.Name,CEMS_Position__r.Name,CEMSAddress__City__s,CEMSAddress__CountryCode__s, 
    CEMSAddress__Street__s,CEMSAddress__StateCode__s, CEMS_Personal_Email__c,CEMS_Date_of_Birth__c
    FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c =:email LIMIT 1];//: email LIMIT 1
    // List<CEMS_User_Login__c> Login = [SELECT Id,Email_Address__c FROM CEMS_User_Login__c WHERE Email_Address__c =: email  LIMIT 1];
    system.debug('Employee'+Employee);
    System.debug('Email in getEmployee1: ' + email);

     // Check if the user is logged in
  
    if (employee.isEmpty() || employee[0].CEMS_Work_Email__c != email) {
        return null; // Return null if no records found or the email doesn't match
    }   
    System.debug('emp ' + Employee.size());
    return Employee;
    }




@AuraEnabled(cacheable = true)
public static List<CEMS_Employee_Project__c> GetEmployeeProjects(string email){
    // Check if the email parameter is null
    if (email == null) {
        return null;
    }
    List<CEMS_Employee_Project__c> EmployeeProjects = [SELECT Id, Name,CEMS_Projects__r.Name,CEMS_Employee__r.cems_work_email__c,CEMS_Employee_s_Project_Start_Date__c,CEMS_Employee_s_Project_End_Date__c,CEMS_Employee__r.Name FROM CEMS_Employee_Project__c where CEMS_Employee__r.cems_work_email__c=:email];
    if(EmployeeProjects.isEmpty())  
    {
        throw new AuraHandledException('No Record Found..');
    }                
    return EmployeeProjects;
}     
@AuraEnabled(cacheable = true)
public static List<Employee_Training__c> getEmployeeTrainings(string email) {
List<Employee_Training__c> employeeTrainings = [
            SELECT  Id, CEMS_Employee_Name__r.Name, CEMS_Learning_Name__r.CEMS_Learning_Name__c,RecordType.Name, CEMS_Due_Date__c, CEMS_Mandatory__c, CEMS_Specific__c, CEMS_Learning_Name__c, CEMS_Status__c, CEMS_Assessment_Link__c, CEMS_Assessment_Score__c, CEMS_Assessment_Status__c FROM Employee_Training__c
         WHERE  CEMS_Employee_Name__r.cems_work_email__c =:email AND RecordType.Name = 'Employee Learning' 
        ];

if (employeeTrainings.isEmpty()) {
    throw new AuraHandledException('No Record Found..');
}

return employeeTrainings;
}

@AuraEnabled
public static List<Employee_Training__c> getEmployeeTrainings1(String email) {
    List<Employee_Training__c> employeeTrainings1 = [
        SELECT Id, CEMS_Employee_Name__r.Name, CEMS_Learning_Name__r.CEMS_Learning_Name__c,
               CEMS_Certification_Name__r.CEMS_Certificate_Name__c, CEMS_Status__c, CEMS_Due_Date__c
        FROM Employee_Training__c
        WHERE CEMS_Employee_Name__r.cems_work_email__c != :email
    ];

    // Debug log to see the learnings
    System.debug('Total learnings retrieved: ' + employeeTrainings1.size());
    for (Employee_Training__c training : employeeTrainings1) {
        System.debug('Learning: ' + training.CEMS_Learning_Name__r.CEMS_Learning_Name__c);
    }

    return employeeTrainings1;
}





@AuraEnabled
    public static void uploadDocument(List<String> params,String emailid)
{
    for(String param:params)
    {
        fileJsonVO fj = fileJsonVO.parse(param);
        String fileName = fj.fileName;
        String base64 = fj.base64;
        createContentVersion(base64,fileName);
        
    }

    system.debug(cvList);
    if(cvList.size()>0)
        insert cvList;

    
    try{
        for(ContentVersion cv:cvList)
            createContentLink(cv.id,emailid);
    }
    catch(Exception e){
        throw new QueryException('error msg ' + emailId +' ' + cvList[0].id);
    }


    if(cdList.size()>0)
        insert cdList;

}
    public static void createContentVersion(String base64,String fileName)
{
    
    
    ContentVersion cv = new ContentVersion();
    cv.VersionData = EncodingUtil.base64Decode(base64);
    cv.Title = fileName;
    cv.PathOnClient = fileName;
    cvList.add(cv);

}
    
public static void createContentLink(String contentversionId,String emailId)
{
    try
    {
        ContentDocumentLink cdl = new ContentDocumentLink();
        
        ContentVersion cv = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersionId LIMIT 1];
        cdl.ContentDocumentId  = cv.ContentDocumentId;
        System.debug(cv.contentDocumentId);
        System.debug('CDL ' + cdl.ContentDocumentId);
        CEMS_Personnel__c[] employee = [SELECT Id,CEMS_Work_Email__c FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c = :emailId LIMIT 1];
        if (!employee.isEmpty()) 
        {
            cdl.LinkedEntityId = employee[0].Id;
        }
        else
        {
         //   System.debug('not valid user');
        }
        cdl.ShareType = 'V';
        cdList.add(cdl);
    }
    catch(Exception e){
        throw new QueryException('error ' + e.getMessage());
    }
} 

@AuraEnabled(cacheable=true)
public static List<CEMS_Job_Application__c> getJobApplications(){
    return [SELECT CEMS_First_Name__c, CEMS_Last_Name__c, CEMS_Email__c, CEMS_Email_Notification__c, CEMS_Job_Opening__c, CEMS_Pre_Screening_Exam_Link__c, CEMS_Screening_Exam_Score__c, CEMS_Skills__c, CEMS_Work_Experience__c, CEMS_Company_Name__c, CEMS_Role__c, CEMS_Worked_On__c, CEMS_Results__c, CEMS_Pre_Screening__c, CEMS_Referral__c, CEMS_Personnel__c, Notice_Period__c, Back_Ground_Verification__c, Offered_Position__c, Date_of_Joining__c, Budget_Allotted__c, CEMS_Interview_Result__c, Offered_salary__c, CEMS_Stage__c, CEMS_Status__c, Offered_Level__c, CEMS_Joining_Status__c, CEMS_Current_Position__c, CEMS_Type__c, CEMS_Expected_Salary__c, CEMS_Negotiated_Salary__c, CEMS_Hike_Percentage__c, CEMS_Basic_Pay__c, CEMS_Gratuity__c, CEMS_HRA__c, CEMS_Provident_Fund__c, CEMS_Company_Benefits_Plan__c, CEMS_Variable_Pay__c, CEMS_Health_Benefits__c, CEMS_Bonus__c, CEMS_Approval_Status__c, Id, Name, RecordTypeId FROM CEMS_Job_Application__c];
}

@AuraEnabled(cacheable=true)
public static List<String> getEducation(){
    List<Schema.PicklistEntry> picklistValues = CEMS_Personnel__c.CEMS_Required_Documents_to_Upload__c.getDescribe().getPicklistValues();
    
    List<String> educationOptions = new List<String>();
    for (Schema.PicklistEntry picklistValue : picklistValues) {
        educationOptions.add(picklistValue.getValue());
    }
    
    return educationOptions;

}
    /*
@AuraEnabled(cacheable = true)
public static List<CEMS_Personnel__c> getEmployees(String email) {
    List<CEMS_User_Login__c> loginRecords = [
        SELECT Email_Address__c
        FROM CEMS_User_Login__c
        WHERE Email_Address__c = :email
    ];
    
    if (loginRecords.isEmpty()) {
        throw new AuraHandledException('No Record Found..');
    }
    
    Set<String> employeeIds = new Set<String>();
    for (CEMS_User_Login__c loginRecord : loginRecords) {
        employeeIds.add(loginRecord.Email_Address__c);
        system.debug('loginRecords'+loginRecords);
    }
    
    List<CEMS_Personnel__c> emp = [SELECT Id,Name,CEMS_Work_Email__c,CEMS_Work_Location__c,CEMS_Contact_Number__c, 
        CEMS_Employee_ID__c, CEMS_HR_Manager__r.Name,CEMS_Position__r.Name,CEMSAddress__City__s,CEMSAddress__CountryCode__s, 
        CEMSAddress__Street__s,CEMSAddress__StateCode__s, CEMS_Personal_Email__c,CEMS_Date_of_Birth__c
      FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c = :email
            AND Id IN :employeeIds
        LIMIT 1
    ];

    if (emp.isEmpty()) {
        throw new AuraHandledException('No Record Found..');
    }
    system.debug('+++emp+++'+emp);

    return emp;
}
*/
    @AuraEnabled(cacheable = true)
public static List<CEMS_Personnel__c> getEmployees(String email) {
    List<CEMS_User_Login__c> loginRecords = [
        SELECT Email_Address__c
        FROM CEMS_User_Login__c
        WHERE Email_Address__c = :email
    ];
    
    if (loginRecords.isEmpty()) {
        throw new AuraHandledException('No Record Found..');
    }
    
    Set<String> emailAddresses = new Set<String>();
    for (CEMS_User_Login__c loginRecord : loginRecords) {
        emailAddresses.add(loginRecord.Email_Address__c);
        system.debug('loginRecords' + loginRecords);
    }
    
    List<CEMS_Personnel__c> emp = [SELECT Id, Name, CEMS_Work_Email__c, CEMS_Work_Location__c, CEMS_Contact_Number__c, 
        CEMS_Employee_ID__c, CEMS_HR_Manager__r.Name, CEMS_Position__r.Name, CEMSAddress__City__s, CEMSAddress__CountryCode__s, 
        CEMSAddress__Street__s, CEMSAddress__StateCode__s, CEMS_Personal_Email__c, CEMS_Date_of_Birth__c
      FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c IN :emailAddresses
        LIMIT 1
    ];

    if (emp.isEmpty()) {
        throw new AuraHandledException('No Record Found..');
    }
    system.debug('+++emp+++' + emp);

    return emp;
}

@AuraEnabled
 public static List<CEMS_Training__c> getAllCEMSTrainings() {
        List<CEMS_Training__c> cemsTrainings = [SELECT Id, Name, Category__c, Certificate_Level__c, CEMS_Certificate_Name__c, CreatedById,CEMS_Description__c, CEMS_Designated_Days__c, LastModifiedById, CEMS_Learning_Name__c,CEMS_Mandatory__c, OwnerId, RecordTypeId, CEMS_Registration_URL__c, CEMS_Resource_URl__c, Registered__c FROM CEMS_Training__c];
        
        // for (CEMS_Training__c cemsTraining : cemsTrainings) {
        //     System.debug('----------------');
        //     System.debug('ID: ' + cemsTraining.Id);
        //     System.debug('Name: ' + cemsTraining.Name);
        //     System.debug('Category: ' + cemsTraining.Category__c);
        //     System.debug('Certificate Level: ' + cemsTraining.Certificate_Level__c);
        //     System.debug('Certificate Name: ' + cemsTraining.CEMS_Certificate_Name__c);
        //     System.debug('Created By ID: ' + cemsTraining.CreatedById);
        //     System.debug('Description: ' + cemsTraining.CEMS_Description__c);
        //     System.debug('Designated Days: ' + cemsTraining.CEMS_Designated_Days__c);
        //     System.debug('Last Modified By ID: ' + cemsTraining.LastModifiedById);
        //     System.debug('Learning Name: ' + cemsTraining.CEMS_Learning_Name__c);
        //     System.debug('Mandatory: ' + cemsTraining.CEMS_Mandatory__c);
        //     System.debug('Owner ID: ' + cemsTraining.OwnerId);
        //     System.debug('Record Type ID: ' + cemsTraining.RecordTypeId);
        //     System.debug('Registration URL: ' + cemsTraining.CEMS_Registration_URL__c);
        //     System.debug('Resource URL: ' + cemsTraining.CEMS_Resource_URl__c);
        //     System.debug('Is Registered: ' + cemsTraining.Registered__c);
            
            
        // }
        
        return cemsTrainings;
    }

    
    
 @AuraEnabled(cacheable = true)
    public static String insertEmployeeTraining(String email, String trainingRecordId) {
        try {
            // Retrieve the Training record and its record type ID
            List<CEMS_Training__c> trainingRecords = [SELECT Id, Name, RecordTypeId, Registered__c FROM CEMS_Training__c WHERE Id = :trainingRecordId LIMIT 1];

            if (trainingRecords.isEmpty()) {
                return 'No employee training registered - Record not found for training Id: ' + trainingRecordId;
            }

            CEMS_Training__c trainingRecord = trainingRecords[0];
            System.debug('trainingRecord: ' + trainingRecord);

            Id trainingRecordTypeId = trainingRecord.RecordTypeId;
            System.debug('trainingRecordTypeId: ' + trainingRecordTypeId);

            if (trainingRecordTypeId != null && !trainingRecord.Registered__c) {
                // Retrieve the Personnel record based on the provided email
                List<CEMS_Personnel__c> personnelRecords = [SELECT Id, Name FROM CEMS_Personnel__c WHERE CEMS_Work_Email__c = :email LIMIT 1];

                if (personnelRecords.isEmpty()) {
                    return 'No employee found with email: ' + email;
                }

                CEMS_Personnel__c personnelRecord = personnelRecords[0];
                System.debug('personnelRecord: ' + personnelRecord);

                // Map to store Record Type Names and their corresponding Developer Names
                Map<String, String> recordTypeMap = new Map<String, String>();
                for (RecordType rt : [SELECT Id, Name, DeveloperName FROM RecordType WHERE SObjectType = 'Employee_Training__c']) {
                    recordTypeMap.put(rt.Name, rt.DeveloperName);
                }

                // Create the Employee Training records based on the Training object's record types
                List<Employee_Training__c> employeeTrainingList = new List<Employee_Training__c>();
                System.debug('employeeTrainingList: ' + employeeTrainingList);

                String recordTypeDeveloperName = recordTypeMap.get(trainingRecord.Name);
                if (recordTypeDeveloperName != null) {
                    Employee_Training__c employeeTraining = new Employee_Training__c();
                    employeeTraining.put(recordTypeDeveloperName, trainingRecord.Id);
                    employeeTraining.CEMS_Employee_Name__c = personnelRecord.Id;
                    // Set other field values based on the dynamic record type

                    employeeTrainingList.add(employeeTraining);
                    System.debug('employeeTraining: ' + employeeTraining);
                } else {
                    // Handle the case when the record type is not found
                    return 'No employee training registered - Record Type not found for training: ' + trainingRecord.Name;
                }

                insert employeeTrainingList;

                // Update the Registered__c field on the training record to indicate it's registered
                trainingRecord.Registered__c = true;
                update trainingRecord;

                return 'Employee training registered successfully';
            }

            return 'No employee training registered';
        } catch (Exception e) {
            // Handle any exceptions that occurred during the process
            String errorMessage = 'An error occurred while registering employee training: ' + e.getMessage();
            System.debug('errorMessage: ' + errorMessage);
            throw new AuraHandledException(errorMessage);
        }
    }

    @AuraEnabled
    public static List<CEMS_Job_Opening__c> getJobOpen(String userEmail) {
    List<CEMS_Job_Opening__c> jobOpenings = new List<CEMS_Job_Opening__c>();

    // Step 1: Query the personnel record based on the user's email
    List<CEMS_Personnel__c> personnelList = [SELECT Id, CEMS_Personal_Email__c, CEMS_Work_Email__c FROM CEMS_Personnel__c WHERE CEMS_Personal_Email__c = :userEmail OR CEMS_Work_Email__c = :userEmail LIMIT 1];
system.debug('personnelList'+personnelList);
    if (!personnelList.isEmpty()) {
        CEMS_Personnel__c personnel = personnelList[0];

        // Step 2: Check if the personnel record has both personal and work email fields
        if (personnel.CEMS_Personal_Email__c != null && personnel.CEMS_Work_Email__c != null) {
            // Step 3: If both personal and work email fields are present, fetch internal job openings
            jobOpenings = [SELECT Id, Name, RecordTypeId, CEMS_Experience__c, CEMS_Job_Location__c, 
                                  CEMS_Roles_and_Responsibilities__c, CEMS_Minimum_Pay__c, 
                                  CEMS_Maximum_Pay__c, CEMS_Available_Vacancies__c, CEMS_Due_Date__c, 
                                  CEMS_Skills__c, CEMS_Technology__c, CEMS_Approval_Status__c 
                           FROM CEMS_Job_Opening__c 
                           WHERE CEMS_Approval_Status__c='Approved' 
                           AND RecordTypeId='012H4000000VCPRIA4'];
            system.debug('jobOpenings11'+jobOpenings);
        } else {
            // Step 4: If either personal or work email field is missing, fetch external job openings
            jobOpenings = [SELECT Id, Name, RecordTypeId, CEMS_Experience__c, CEMS_Job_Location__c, 
                                  CEMS_Roles_and_Responsibilities__c, CEMS_Minimum_Pay__c, 
                                  CEMS_Maximum_Pay__c, CEMS_Available_Vacancies__c, CEMS_Due_Date__c, 
                                  CEMS_Skills__c, CEMS_Technology__c, CEMS_Approval_Status__c 
                           FROM CEMS_Job_Opening__c 
                           WHERE CEMS_Approval_Status__c='Approved' AND RecordTypeId='012H4000000VCPQIA4' ];
            system.debug('jobOpenings2'+jobOpenings);
        }
    }
    
    return jobOpenings;
}

}