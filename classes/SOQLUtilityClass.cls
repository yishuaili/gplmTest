/*********************************************************************************
Name         : updateOnLicenseHelperClass
Created By   : Sukumar R
Created Date : 09/23/2014
Project      : NTT i3, Bangalore
Usages       : 

*********************************************************************************/

public with sharing class SOQLUtilityClass 
{
	/*********************************************************************************
	Method Name  : licenseObjectQueryResults
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : Query on License object to retrive results based on Id's passed in the
				   set and return the result back to the calling methods
	
	*********************************************************************************/
	public static list<License__c> licenseObjectQueryResults(set<Id> licenseIds)
	{
		list<License__c> licenseList = [select Id, Application_Status__c, Authority__c, License_type__c from License__c where Id in : licenseIds];
		return licenseList;
	}
	
	/*********************************************************************************
	Method Name  : RecordTypeQueryResults
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : Query on RecordType object to retrive results based on Id's passed in the
				   set and return the result back to the calling methods
	
	*********************************************************************************/
	public static list<RecordType> RecordTypeQueryResults(set<Id> recTypeIds)
	{
		list<RecordType> recTypeList = [Select Id, Name from RecordType where Id in : recTypeIds];
		return recTypeList;
	}
	
	/*********************************************************************************
	Method Name  : licenseTypeQueryResults
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : Query on License Type object to retrive results based on Id's passed in the
				   set and return the result back to the calling methods
	
	*********************************************************************************/
	public static list<License_type__c> licenseTypeQueryResults(set<String> licTypeNames)
	{
		list<License_type__c> licenseTypeList = [Select Id, Name, Authority__c from License_type__c where Name in : licTypeNames];
		return licenseTypeList;
	}
}