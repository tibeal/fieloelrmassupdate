global class UpdateCourseDependenciesBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateCourseDependenciesBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, FieloELR__Course__c, FieloELR__Predecessor__c FROM FieloELR__CourseDependency__c WHERE FieloELR__ExternalKey__c = \'\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		FieloELRUPD_SObjectUnitOfWork uow = new FieloELRUPD_SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__CourseDependency__c.SObjectType});
		FieloELR__CourseDependency__c courseDependency;
		for(sobject record: scope) {
			courseDependency = (FieloELR__CourseDependency__c) record;
			courseDependency.FieloELR__ExternalKey__c = ((string)courseDependency.FieloELR__Course__c) + ((string)courseDependency.FieloELR__Predecessor__c);
			uow.registerDirty(courseDependency);
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
		mail.setSubject('Apex Update Course Dependencies ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}