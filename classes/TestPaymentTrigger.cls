/*********************************************************************************
Class Name   : TestPaymentTrigger
Created By   : Sukumar R
Created Date : 09/23/2014
Project      : NTT i3, Bangalore
Usages       : Test class for the code coverage of the below components.
			   paymentTrigger, updateOnLicenseHelperClass

*********************************************************************************/
@isTest
public class TestPaymentTrigger 
{ 
	//Preparing test data for Authority object 
    public static Authority__c createAuthorityRecord()
    {
        Authority__c testAuthority = new Authority__c();
        testAuthority.Name = 'testAuthority';
        testAuthority.Code__c = 'testCode12';
        testAuthority.Website__c = 'www.test.com';
        testAuthority.Phone__c = '1231231233';
        testAuthority.Begin_Date__c = Date.today();
        testAuthority.Fax__c = '1231231233';
        testAuthority.Email__c = 'test@email.com';
        testAuthority.Location_Address_1__c = '1234 test dr';
        testAuthority.Location_Address_2__c = '4321 test dr';
        testAuthority.Location_City__c = 'Gotham';
        testAuthority.Location_ZIP_Code__c = '75222';
        testAuthority.Location_State__c = 'Florida';
        testAuthority.Location_Country__c = 'United States';
        insert testAuthority;
                
        return testAuthority;
    }
    
    //Preparing test data for License Type object
    public static License_type__c createLicenseTypeRecord()
    {
        License_Type__c testLicenseType = new License_Type__c();
        testLicenseType.Name = 'Pet Permit';
        testLicenseType.Rejection_refund_amount__c = 3000.00;
        testLicenseType.Code__c = 'testCode12';
        testLicenseType.Application_Fee__c = 200.00;
        testLicenseType.Type_of_service__c = 'Personal';
        testLicenseType.Is_Renewable__c = false;
        testLicenseType.Authority__c = createAuthorityRecord().Id;
        insert testLicenseType;
        
        return testLicenseType;
    }
    
    //Preparing test data for License object
    public static License__c createLicneseRecord()
    {
        License__c testLicense = new License__c();
        License_type__c testLicTyp = createLicenseTypeRecord();
        testLicense.Application_Received_Date__c = Date.today();
        testLicense.Effective_Date__c = Date.today();
        Id rtId = [select Id, name from RecordType where SObjectType='License__c' limit 1].Id;
        testLicense.RecordTypeId = rtId;
        testLicense.Comments__c = 'forSearching';
        testLicense.License_type__c = testlicTyp.Id;
        testLicense.Authority__c = testLicTyp.Authority__c ;
        insert testLicense;
        
        return testLicense;
    }
    
    //Preparing test data for Payment object
    public static Payment__c CreatePaymentRecord() 
    {
    	list<License__c> licenseList = new list<License__c>();
        Payment__c testPayment = new Payment__c();
        testPayment.Payment_For__c = 'Cash';
        testPayment.Payment_Type__c = 'Application';
        testPayment.License__c = createLicneseRecord().Id;        
        
        return testPayment; 
    }
    
    //Test method which gets executed for the code coverage
    public static testMethod void  TestpaymentTriggerHelperClassMethod()
    {
    	//initializing payment object for insert
    	Payment__c testPymt = CreatePaymentRecord(); 
    	//Adding the initialized payment object to the list 	
    	list<Payment__c> pymtList = new list<Payment__c>();
    	pymtList.add(testPymt);
    	
    	test.startTest();
    	
    	insert testPymt;
    	
    	test.stopTest();
    	
    	//Calling the helperclass methods 
    	paymentTriggerHelperClass.updateApplicationStatusOnLicense(pymtList);
    	paymentTriggerHelperClass.updateAuthorityLicenseTypeIds(pymtList);
    }
}