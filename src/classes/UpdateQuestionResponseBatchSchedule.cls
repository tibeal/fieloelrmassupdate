global class UpdateQuestionResponseBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateQuestionResponseBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, FieloELR__Question__c, FieloELR__ModuleResponse__c FROM FieloELR__QuestionResponse__c WHERE FieloELR__ExternalKey__c = \'\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__QuestionResponse__c.SObjectType});
		FieloELR__QuestionResponse__c questionResponse;
		for(sobject record: scope) {
			questionResponse = (FieloELR__QuestionResponse__c) record;
			questionResponse.FieloELR__ExternalKey__c = String.valueOf(questionResponse.FieloELR__Question__c) + String.valueOf(questionResponse.FieloELR__ModuleResponse__c);
			uow.registerDirty(questionResponse);
		}
		FieloELR.CourseService.enableAdminPermission(true);
		uow.commitWork();
		FieloELR.CourseService.enableAdminPermission(false);
	}
	
	global void finish(Database.BatchableContext BC){
		// Get the ID of the AsyncApexJob representing this batch job
		// from Database.BatchableContext.
		// Query the AsyncApexJob object to retrieve the current job's information.
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
			TotalJobItems, CreatedBy.Email
			FROM AsyncApexJob WHERE Id =
			:BC.getJobId()];
		// Send an email to the Apex job's submitter notifying of job completion.
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {a.CreatedBy.Email};
		mail.setToAddresses(toAddresses);
		mail.setSubject('Apex Update Question Responses ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}