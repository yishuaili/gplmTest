/*********************************************************************************
Name         : MyProfileUpdateController
Created By   : Shiva Shankar Nalluri
Modified BY  : 
Company Name : NTT Data
Project      : NTT i3, Bangalore
Created Date : 30 Sept 2014
Modified Date: 
Usages       : Controller for VisualForce Page: MyProfileUpdate
*********************************************************************************/
public with sharing class MyProfileUpdateController {
	
	ApexPages.StandardController controller;
	public Contact objContact{get;set;}
	
	public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Contact.FieldSets.My_Profile_View_Personal_Details_Set.getFields();
    }
    
	public List<Schema.FieldSetMember> getAddressFields() {
        return SObjectType.Contact.FieldSets.My_Profile_View_Address_Details_Set.getFields();
    }
    public boolean isEdit{get;set;}
    /**
    * @author Shiva Shankar
    * @description - Constructor for MyProfileUpdateController
    * @input param  - null
    * @return null
    */
	public MyProfileUpdateController()
    {
    	isEdit=true;
    	list<User> lstUser=[select id,contactId from User where id=:Userinfo.getUserId()]; 
    	if(!Utility.isEmpty(lstUser) && !Utility.isEmpty(lstUser[0].contactId))
    		objContact=[select Id,MobilePhone,Email,SSN__c,Name,LastName,FirstName,Birthdate,MailingStreet,MailingState,MailingPostalCode,MailingCountry,MailingCity,OtherStreet,OtherState,OtherPostalCode,OtherPhone,OtherCountry,OtherCity from Contact where id=:lstUser[0].contactId];
        else if(!Utility.isEmpty(ApexPages.currentPage().getParameters().get('id')))
        	objContact=[select Id,MobilePhone,Email,SSN__c,Name,LastName,FirstName,Birthdate,MailingStreet,MailingState,MailingPostalCode,MailingCountry,MailingCity,OtherStreet,OtherState,OtherPostalCode,OtherPhone,OtherCountry,OtherCity from Contact where id=:ApexPages.currentPage().getParameters().get('id')];
    }
    /**
    * @author Shiva Shankar
    * @description - to disable edit button & show save button
    * @input param  - null
    * @return null
    */
    public void isEditEnable()
    {
    	isEdit=false;
    }
    /**
    * @author Shiva Shankar
    * @description - to update contact details
    * @input param  - null
    * @return null
    */
    public void updateContactDetails()
    {
    	try{
    		update objContact;
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Your details updated successfully.'));
    	}
    	catch(Exception e)
    	{
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There was a error in processing your request. Please try again later.'));
    	}
    }
}