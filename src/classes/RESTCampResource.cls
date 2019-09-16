/**
 * Created by user on 10-Sep-19.
 */
@RestResource(urlMapping='/TestAccount/*')
global with sharing class RESTCampResource {

    @HttpGet
    global static Account doGetAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response; 
        String sId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name FROM Account WHERE Id=:sId];
        return result;
    }
}

/* 	0012v00002VrxAJAAZ  */