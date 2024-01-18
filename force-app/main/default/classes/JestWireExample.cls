public with sharing class JestWireExample {
    @AuraEnabled(cacheable=true)
	public static List<Account> getAcctList(){
		return [SELECT Id, Name FROM Account WHERE Name = 'Matts Account'];
	}
}