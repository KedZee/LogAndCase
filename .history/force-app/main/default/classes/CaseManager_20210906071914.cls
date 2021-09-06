@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        
        String caseId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Case result =  [SELECT Description
                        FROM Case
                        WHERE Id = :caseId];
        return result;
    }
    @HttpPost
    global static Id createCase(String attributes1, String attributes2) {
        Case thisCase = new Case(description= attributes1 +' '+ attributes2);
        insert thisCase;
        return thisCase.Id;
    }   
}
