/*********************************************************************************
Name         : paymentTrigger
Created By   : Sukumar R
Created Date : 09/23/2014
Project      : NTT i3, Bangalore
Usages       : 

*********************************************************************************/

trigger paymentTrigger on Payment__c (before insert, after insert) 
{	
	//Check whether it is before insert scenario or before update scenario
	if((trigger.isBefore && trigger.isInsert) || (trigger.isBefore && trigger.isUpdate))
	{		
		// Calling the helper class method to perform the task
		paymentTriggerHelperClass.updateAuthorityLicenseTypeIds(trigger.new);
	}
	//Check whether it is after insert scenario
	if(trigger.isAfter && trigger.isInsert)
	{	
		// Calling the helper class method to perform the task
		paymentTriggerHelperClass.updateApplicationStatusOnLicense(trigger.new);
	}
	
}