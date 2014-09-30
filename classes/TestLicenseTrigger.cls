@isTest
public class TestLicenseTrigger {
    public static License__c createOneLicnese()
    {
        License__c testLicense = new License__c();
        testLicense.Application_Received_Date__c = Date.newInstance(2014, 8, 30);
        testLicense.Effective_Date__c = Date.newInstance(2014, 9, 1);
        //RecordType testRecordType = createRecordType();
        //insert testRecordType;
        Id rtId = [select Id, name from RecordType where name='Pet Permit' and SObjectType='License__c'].Id;
        testLicense.RecordTypeId = rtId;
        testLicense.Comments__c = 'forSearching';
        return testLicense;
    }
    
    private static RecordType createRecordType()
    {
        RecordType testRecordType = new RecordType();
        testRecordType.Name = 'Pet Permit';
        return testRecordType;
    }

    private static License_type__c createLicenseType()
    {
        License_Type__c testLicenseType = new License_Type__c();
        testLicenseType.Name = 'Pet Permit';
        testLicenseType.Rejection_refund_amount__c = 3000.00;
        testLicenseType.Code__c = 'testCode12';
        testLicenseType.Application_Fee__c = 200.00;
        testLicenseType.Type_of_service__c = 'Personal';
        testLicenseType.Is_Renewable__c = false;
        testLicenseType.Authority__c = createAuthority().Id;
        
        return testLicenseType;
    }
     
    private static Authority__c createAuthority()
    {
        Authority__c testAuthority = new Authority__c();
        testAuthority.Name = 'testAuthority';
        testAuthority.Code__c = 'testCode12';
        testAuthority.Website__c = 'www.test.com';
        testAuthority.Phone__c = '1231231233';
        testAuthority.Begin_Date__c = Date.newInstance(2014,9,14);
        testAuthority.Fax__c = '1231231233';
        testAuthority.Email__c = 'test@email.com';
        testAuthority.Location_Address_1__c = '1234 test dr';
        testAuthority.Location_Address_2__c = '4321 test dr';
        testAuthority.Location_City__c = 'Gotham';
        testAuthority.Location_ZIP_Code__c = '75222';
        
        return testAuthority;
    }
    
    static testmethod void TestUpdateAuthorityAndLicenseType()
    {
        Test.startTest();
        License_Type__c testLicenseType = createLicenseType();
        License__c testLicense = createOneLicnese();
        map<Id,License__c> licMap = new map<Id,License__c>();
        licMap.put(testLicense.Id, testLicense);
        list<License__c> licList = new list<License__c>();
        licList.add(testLicense);
        
        insert testLicenseType;
        insert testLicense;
        testLicense.Status__c = 'Active';
        update testLicense;
        Test.stopTest();
     
        
        LicenseHelper.CreateLicenseHistory(licList, licMap, true, true , true);        
        LicenseHelper.isRecursiveCreateLicenseHistory = true;
        LicenseHelper.updateAuthorityAndLicenseTypeOnLicense(licList);
        
        /*list<License__c> resultLicense = [SELECT Id, Authority__c, License_type__c from License__c where Comments__c = 'forSearching'];
        list<License_Type__c> resultLicenseType = [SELECT Id, Authority__c from License_Type__c where Name = 'testType'];
        for(License__c lics:resultLicense)
        {
            for(License_Type__c licType:resultLicenseType)
            {
                System.assertEquals(lics.Authority__c, licType.Authority__c);
                //System.assertEquals(lics.License_type__c, licType.Id);
            }
        }*/
        
        
    }
    
}