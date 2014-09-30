/*******************************************************************************
Name         : LicenseHelper 
Created By   : Shiva Shankar Nalluri
Company Name : NTT Data
Project      : NTT i3
Created Date : 23 Sept 2014
Usages       : LicenseHelper handler class for LicenseTrigger.
** SL.No  Date        Modified By      Description
** 1      09/23/2014  Shiva Shankar N  Created CreateLicenseHistory method to insert License History Records whenever license status is approved.
*******************************************************************************/
public class LicenseHelper
{
	//Variable Declaration
	//boolean variable to stop recursive fire.
    public static boolean isRecursiveCreateLicenseHistory=false;
    
    public static void CreateLicenseHistory(List<License__c> newLicenses,Map<Id,License__c> oldLicensesMap,Boolean isAfter ,Boolean isInsert, Boolean isUpdate)
    {
        List<License_History__c> licenseHistObjList = new List<License_History__c>(); 
        for(License__c lns : newLicenses)
        {
                //When record will be created for the License__c object and populating status on the comments field for License_History__c
                if(isInsert)
                {
                	License_History__c lh = new License_History__c();
                	lh.License__c = lns.Id;
                	lh.Comments__c='Changed to '+lns.Status__c;
                	lh.Status__c=lns.Status__c;
                	licenseHistObjList.add(lh);
                }
                //When record will be updated for the License__c object and updating comments from old status to new status
                else if(isUpdate && !isRecursiveCreateLicenseHistory && lns.Status__c!=oldLicensesMap.get(lns.Id).Status__c)
                {
                	License_History__c lh = new License_History__c();
                	lh.License__c = lns.Id;
                	lh.Comments__c='Changed From '+oldLicensesMap.get(lns.Id).Status__c+' to '+lns.Status__c;
                	lh.Status__c=lns.Status__c;
                	licenseHistObjList.add(lh);
                	isRecursiveCreateLicenseHistory=true;
                }
        }
        if(!Utility.isEmpty(licenseHistObjList))
            insert licenseHistObjList;
    }
    
   	/*********************************************************************************
	Method Name  : updateAuthorityAndLicenseTypeOnLicense
	Created By   : Sukumar R
	Created Date : 09/23/2014
	Project      : NTT i3, Bangalore
	Usages       : Update Authority and License Type field on License object based on
				   the record type selection on License
	
	*********************************************************************************/

	public static void updateAuthorityAndLicenseTypeOnLicense(List<License__c> licList)
	{		
		set<Id> recTypeIdSet = new set<Id>();    // Set to hold the Id's of RecordType which will be used for querying.
		set<String> recTypeNameSet = new set<String>();   // Set to hold the Names of RecordTypes which will be used for querying.
		//Iterating over the list of License records passes via trigger and adding the RecordType id's to the set
		for(License__c lic : licList)
		{
			recTypeIdSet.add(lic.RecordTypeId);
		}
		list<RecordType> recTypeList = SOQLUtilityClass.RecordTypeQueryResults(recTypeIdSet);
		if(recTypeList.size() > 0)
		{
			//Iterating over the list of RecordType records and adding the RecordType names to the set
			for(RecordType recType : recTypeList)
			{
				recTypeNameSet.add(recType.Name);
			}
		}
		
		
		list<License_type__c> licenseTypeList = SOQLUtilityClass.licenseTypeQueryResults(recTypeNameSet);
		if(licenseTypeList.size() > 0)
		{
			//Iterating over the list of License and License Type records and updating the License records with Authority and License type values
			for(License__c lics : licList)
			{
				for(License_type__c licType : licenseTypeList)
				{
					lics.Authority__c = licType.Authority__c;
					lics.License_type__c = licType.Id;
				}
			}
		}		
	}
}