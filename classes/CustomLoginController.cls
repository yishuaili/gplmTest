/*********************************************************************************
Name         : CustomLoginController
Created By   : Shiva Shankar Nalluri
Modified BY  : 
Company Name : NTT Data
Project      : NTT i3, Bangalore
Created Date : 30 Sept 2014
Modified Date: 
Usages       : Controller for VisualForce Page: CustomLogin
*********************************************************************************/
public class CustomLoginController {
 
	public String username{get; set;}
	public String password {get; set;}
	public static final string startUrl=null;
	public string errormsg{get;set;}
	public pageReference doLogin()
	{  
	    Pagereference redirectPage = Site.login(username,password,startUrl); 
        if (redirectPage != null)
            return redirectPage;
        else
        {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Login unsuccessful. Please try again later.'));
          return null;
        }
	}
	
	public pagereference setPassword()
	{
		if(!Utility.isEmpty(username) && !Utility.isEmpty(password))
		{
			list<User> lstUser=[select id from user where Username=:username limit 1];
			if(!Utility.isEmpty(lstUser))
				System.setPassword(lstUser[0].id,password);
			else
				errormsg='username does not exist.';	
		}
		else
		{
			errormsg='Please eneter username and password.';
		}
		return null;
				 
	}
}