/*********************************************************************************
Name         : Utility
Created By   : Shiva Shankar N
Created Date : 09/22/2014
Project      : NTT i3, Bangalore
Usages       : 

*********************************************************************************/

public class Utility
{
    public static final String BLANK='';
    public static final String[] toAddresses=new String[]{'shivashankar.nalluri@nttdata.com,sukumar.rajashekaran@nttdata.com,nandini.konanur@nttdata.com,Sreenivas.Amirisetti@nttdata.com'};
    /**
    *   @author Shiva Shankar N
    *   @description - Checks the passed in input field for emptyness and return boolean value. *
    *   @param fldName - name of the field
    *   @param msg  - message to be displayed on UI  (can be select/enter)
    *   @param value -  value of input field
    */
    public static boolean isEmpty(String value){
        boolean flag=false;
        if(value==null||value.trim().equals(BLANK)){
            flag=true;      
        }
        return flag;
    }
    
    /**
    * @author Shiva Shankar N
    *  @description Check whether list is empty
    *  @param ex Exception which is printed in system log  
    *  @return Boolean True if String is empty or null else return false
    */
    public static boolean isEmpty(List<SObject> objList){       
        if(objList==null||objList.size()==0){
            return true;
        }else {
            return false;
        }
    }
    /**
    * @author Shiva Shankar N
    *  @description Check whether sObject is null
    *  @param ex Exception which is printed in system log  
    *  @return Boolean True if Sobject is null else return false
    */
    public static boolean isEmpty(SObject obj){         
        if(obj==null){
            return true;
        }else {
            return false;
        }
    }   
    
    /**
    * @author Shiva Shankar N
    *  @description Check whether list is empty
    *  @param ex Exception which is printed in system log  
    *  @return Boolean True if String is empty or null else return false
    */
    public static boolean isEmpty(List<object> objList){        
        if(objList==null||objList.size()==0){
            return true;
        }else {
            return false;
        }
    }

    /**
    * @author Shiva Shankar N
    * @description Check whether map is empty
    * @param map<String,Object> map to check whether is empty or not  
    * @return Boolean True if map is empty or null else return false
    */
    public static boolean isEmpty(Map<String,Object> objectMap){      
        if(objectMap==null||(objectMap !=null&&objectMap.size()==0)){
            return true;
        }else { 
            return false;
        }
    }
    
    /**
    * @author Shiva Shankar N 
    * @description Check whether Object is null
    * @param object to check whether it is null or not   
    * @return Boolean True if Object is null else return false
    */
    public static boolean isEmpty(Object obj){       
        if(obj==null){
            return true;
        }else {
            return false;
        }
    }  
    /**
    * @author Shiva Shankar N
    * @description to send exception email
    * @param string to send exception   
    */
    public static void sendExceptionEmail(String Str)
    {
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        mail.setSubject('Exception Email'+UserInfo.getUserName());
        mail.setSaveAsActivity(false);
        mail.setPlainTextBody('Exception Email to user.');
        mail.setHtmlBody(Str);
        mail.setUseSignature(true);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    
   
}