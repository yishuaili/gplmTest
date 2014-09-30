/*******************************************************************************
Name         : DisciplinaryActionHelper
Created By   : Shiva Shankar Nalluri
Company Name : NTT Data
Project      : NTT i3
Created Date : 26 Sept 2014
Usages       : DisciplinaryActionHelper handler class for DisciplinaryAction .
** SL.No  Date        Modified By      Description
** 1      09/26/2014  Shiva Shankar N  Created UpdateDisciplinaryActionChkBoxOnLicense method to update  Disciplinary_Action__c--check box on (License__c) whenever Disciplinary_Action__c is created for corresponding license record..
*******************************************************************************/
public class DisciplinaryActionHelper
{
	public static void UpdateDisciplinaryActionChkBoxOnLicense(List<Disciplinary_Action__c > newDisciplinaryActions,Map<Id,Disciplinary_Action__c > oldLicensesMap,Boolean isAfter ,Boolean isInsert, Boolean isUpdate)
	{
		set<Id> setLicenseId= new set<Id>();
		list<License__c> lstLicenseToUpdate = new List<License__c>();
		for(Disciplinary_Action__c daObj : newDisciplinaryActions)
        {
        	if(!Utility.isEmpty(daObj.License__c) && daObj.License__r.Disciplinary_Action__c==false)
        		setLicenseId.add(daObj.License__c);
        }
        if(!Utility.isEmpty(setLicenseId))
        {
        	lstLicenseToUpdate=[select id,Disciplinary_Action__c from License__c where id In:setLicenseId];
        	if(!Utility.isEmpty(lstLicenseToUpdate))
        	{
        		for(License__c objLicense:lstLicenseToUpdate)
        		{
        			objLicense.Disciplinary_Action__c=true;
        		}
        		
        		update lstLicenseToUpdate;
        	}
        }
	}
}