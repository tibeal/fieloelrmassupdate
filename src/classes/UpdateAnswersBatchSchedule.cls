global class UpdateAnswersBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateAnswersBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, FieloELR__AnswerOption__c, FieloELR__QuestionResponse__c FROM FieloELR__Answer__c WHERE FieloELR__ExternalKey__c = \'\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__Answer__c.SObjectType});
		FieloELR__Answer__c answer;
		for(sobject record: scope) {
			answer = (FieloELR__Answer__c) record;
			answer.FieloELR__ExternalKey__c = String.valueOf(answer.FieloELR__QuestionResponse__c) + String.valueOf(answer.FieloELR__AnswerOption__c);
			uow.registerDirty(answer);
		}
		uow.commitWork();
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
		mail.setSubject('Apex Update Answers ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}