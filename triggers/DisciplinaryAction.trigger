/*******************************************************************************
Name         : DisciplinaryAction 
Created By   : Shiva Shankar Nalluri
Company Name : NTT Data
Project      : NTT i3
Created Date : 26 Sept 2014
Usages       : 
*******************************************************************************/
trigger DisciplinaryAction on Disciplinary_Action__c (before insert,after insert,before update,after update) {
    try
    {
        if(Trigger.isBefore && Trigger.isInsert)
        {         
        }
        if(Trigger.isAfter && Trigger.isInsert)
        {
            DisciplinaryActionHelper.UpdateDisciplinaryActionChkBoxOnLicense(trigger.New,null,trigger.isAfter,trigger.isInsert,trigger.isUpdate);  
        }
        if(Trigger.isBefore && Trigger.isUpdate)
        { 
        }
        if(Trigger.isAfter && Trigger.isUpdate)
        { 
        }
       
        
    }
    catch(Exception e)
    {
        string bodyText;
        bodyText +='\n\n' +'DisciplinaryAction has failed with the following error message at the Line Number:\t' + e.getLineNumber()
        + '\n' + e.getMessage() 
        + '\n of Type ' + e.getTypeName() 
        + '\n of Type ' + e.getCause()
        + '\n\nStacktrace: ' + e.getStacktraceString();
        //send exception email to group of users.
        //Utility.sendExceptionEmail(bodyText);
    }
}