@isTest
private class EmailControllerTest {
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    @isTest 
    private static void testScheduledJob() {

        List<Log__c> logList = new List<Log__c>();
        for (Integer i = 0; i < 10; i++) {
            Log__c newLog = new Log__c(
                Level__c = 'severe',
                Source_Class__c = 'severe test Stack Trace' + i
            );
            logList.add(newLog);
        }
        insert logList;
        
        Map<Id, Log__c>  LogMap = new Map<Id, Log__c>(logList);
        List<Id> LogIdList = new List<Id>(LogMap.keySet());
        Test.startTest();

        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new EmailController());

        List<Task> taskFound = [SELECT Id
            FROM Task
            WHERE WhatId IN :LogIdList];
        System.assertEquals(0, taskFound.size(), 'Tasks exist before job has run');

        Test.stopTest();
        taskFound = [SELECT Id
            FROM Task
            WHERE WhatId IN :LogIdList];
        System.assertEquals(0,taskFound.size(),'Tasks were not created');
    }
}
