@IsTest
public class CaseManagerTest {
    @isTest 
    static void testCreateCase() {

        ID thisCaseId = CaseManager.createCase(
            'testAtribute1', 'testAtribute2');

        System.assert(thisCaseId != null, 'New case must be added');
        Case thisCase = [SELECT Id, description FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null, 'New case must be added');
        System.assertEquals(thisCase.description, 'New case must be added');
    }
    @isTest 
    static void testGetCaseById() {
        Id recordId = createTestRecord();
 
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://exedel-dev-ed.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Case thisCase = CaseManager.getCaseById();

        System.assert(thisCase != null);
        System.assertEquals('testAtribute1 testAtribute2', thisCase.description);
    }
    static Id createTestRecord() {

        Case caseTest = new Case(
            description='testAtribute1 testAtribute2');
        insert caseTest;
        return caseTest.Id;
    }   
}
