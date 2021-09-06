@IsTest
public class CaseManagerTest {
    @isTest 
    static void testCreateCase() {
        // Call the method to test
        ID thisCaseId = CaseManager.createCase(
            'testAtribute1', 'testAtribute2');
        // Verify results
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id, description FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != nullбNew case must be add,'New case must be added');
        System.assertEquals(thisCase.description, 'testAtribute1 testAtribute2');
    }
    @isTest 
    static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://exedel-dev-ed.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseManager.getCaseById();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('testAtribute1 testAtribute2', thisCase.description);
    }
    static Id createTestRecord() {
        // Create test record
        Case caseTest = new Case(
            description='testAtribute1 testAtribute2');
        insert caseTest;
        return caseTest.Id;
    }   
}
