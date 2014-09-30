/*******************************************************************************
Name         : LicenseTrigger 
Created By   : Shiva Shankar Nalluri
Company Name : NTT Data
Project      : NTT i3
Created Date : 23 Sept 2014
Usages       : 
*******************************************************************************/
trigger LicenseTrigger on License__c (before insert,after insert,before update,after update) 
{    
    try
    {    
        if(Trigger.isBefore && Trigger.isInsert)
        {  
        	// Calling the helper class method to perform the task
            LicenseHelper.updateAuthorityAndLicenseTypeOnLicense(trigger.new);
        }
        if(Trigger.isAfter && Trigger.isInsert)
        { 
            LicenseHelper.CreateLicenseHistory(trigger.New,null,trigger.isAfter,trigger.isInsert,trigger.isUpdate);  
        }
        if(Trigger.isBefore && Trigger.isUpdate)
        { 
    		//null
        }
        if(Trigger.isAfter && Trigger.isUpdate)
        { 
        	 LicenseHelper.CreateLicenseHistory(trigger.New, trigger.oldmap, trigger.isAfter,trigger.isInsert,trigger.isUpdate);            
        }
       
        
    }
    catch(Exception e)
    {
    	string bodyText;
        bodyText +='\n\n' +'CreateLicenseHistory has failed with the following error message at the Line Number:\t' + e.getLineNumber()
        + '\n' + e.getMessage() 
        + '\n of Type ' + e.getTypeName() 
        + '\n of Type ' + e.getCause()
        + '\n\nStacktrace: ' + e.getStacktraceString();
		//send exception email to group of users.
		//Utility.sendExceptionEmail(bodyText);
    }
}