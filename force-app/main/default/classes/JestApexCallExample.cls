public with sharing class JestApexCallExample
{
        //Make sure in a real life scenario to actually use proper error handling here and ideally a selector class
	@AuraEnabled
	public static List<Case> getKewlCases(String subject){
		return [SELECT Id, Subject FROM Case WHERE Subject = :subject];
	}
}