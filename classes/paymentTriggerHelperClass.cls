/*********************************************************************************
Class Name   : paymentTriggerHelperClass
Created By   : Sukumar R
Created Date : 09/23/2014
Project      : NTT i3, Bangalore
Usages       : Helper class for the trigger paymentTrigger

*********************************************************************************/

public with sharing class paymentTriggerHelperClass 
{
		
	/*********************************************************************************
	Method Name  : updateAuthorityLicenseTypeIds
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : This method would populate Authority and License Type fields based on License field
	
	**********************************************************************************/
	
	public static void updateAuthorityLicenseTypeIds(list<Payment__c> paymentList)
	{
		// Set to hold the Id's of license which will be used for querying
		set<Id> licenseIdSet = new set<Id>();
		//Iterating over the list of payment records and adding the license id's to the set
		for(Payment__c pymt : paymentList)
		{	
			pymt.Received_Date__c = Date.today();	
			licenseIdSet.add(pymt.License__c);
		}
		//calling the licenseObjectQueryResults method from SOQLUtilityClass and retreving the queried result into list
		list<License__c> licenseList = SOQLUtilityClass.licenseObjectQueryResults(licenseIdSet);
		if(licenseList.size() > 0)
		{
			//Iterating over the list of Payment and License records and updating the Payment records with Authority and License type values
			for(Payment__c pymt : paymentList)
			{
				for(License__c lnc : licenseList)
				{
					//check if the licence id matches with the payment record which needs to be updated with the queried result on license object
					//Allow to update Authority and License Type fields only if they are blank  or null (applicable for update scenario)
					system.debug(pymt.License__c + '   LIcense Ids   ' + lnc.Id);
					if(pymt.License__c == lnc.Id && pymt.Authority__c == null && pymt.License_Type__c == null)
					{
						pymt.Authority__c = lnc.Authority__c;
						pymt.License_Type__c = lnc.License_type__c;
					}
				}
			}
		}
	}
	
	/*********************************************************************************
	Method Name  : updateApplicationStatusOnLicense
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : This method would update the Application Status field on License
				   with Payment Received value
	
	**********************************************************************************/

	public static void updateApplicationStatusOnLicense(list<Payment__c> paymentList)
	{
		// Set to hold the Id's of license which will be used for querying
		set<Id> licenseIdSet = new set<Id>();
		//Iterating over the list of payment records and adding the license id's to the set
		for(Payment__c pymt : paymentList)
		{
			licenseIdSet.add(pymt.License__c);
		}		
		list<License__c> updateLicenseList = new list<License__c>();
		//calling the licenseObjectQueryResults method from SOQLUtilityClass and retreving the queried result into list
		list<License__c> licenseList = SOQLUtilityClass.licenseObjectQueryResults(licenseIdSet);
		//Iterating over the list of Licenses and updating the License records with Application Status field with Payment Received value
		if(licenseList.size() > 0)
		{
			for(License__c lic : licenseList)
			{
				if(lic.Application_Status__c != 'Payment Received')
				{
					lic.Application_Status__c = 'Payment Received';
					updateLicenseList.add(lic);
				}	
			}
		}
		if(updateLicenseList.size() > 0)
		{
			update updateLicenseList;
		}
	}
}