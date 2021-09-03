global class EmailController implements Schedulable {

    global void execute(SchedulableContext ctx) {
        String email = 'roducihuqut@vintomaper.com';

        List<Log__c> errorsList =  [SELECT Id, Name, Line_number__c, Message__c, Level__c, Source_Class__c, User_Id__c, Type__c  
                                    FROM Log__c WHERE Level__c = 'severe' OR Level__c =  'exception'];
        
        List<Messaging.SingleEmailMessage> messageList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setSenderDisplayName('Datamasking Errors Bot');
        message.setToAddresses(new List<String> { email });
        String htmlBody = '';
        
        htmlBody = '<table border="1"><tr style="background: LightGray"><th>Name</th><th>Class</th><th>Exception</th><th>Level</th></tr>';
        
        for(Log__c errorIndex : errorsList){
            
            String idError = errorIndex.Id;
            String nameError = errorIndex.Name; 
            String levelError = errorIndex.Level__c; 
            String exceptionError = errorIndex.Message__c;
            String classError = errorIndex.Source_Class__c;
            
            htmlBody += '<tr><td><a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+idError+'">' + nameError + '</a></td><td>' + classError + '</td><td>' + exceptionError + '</td><td>' + levelError + '</td></tr>';
            
        }
        
        htmlBody += '</table>';
        
        message.setHtmlBody(htmlBody);
        
        message.setSubject('Datamasking Errors');
        messageList.add(message);
        Messaging.sendEmail(messageList);
    }

}