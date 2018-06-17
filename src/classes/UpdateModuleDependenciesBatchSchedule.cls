global class UpdateModuleDependenciesBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateModuleDependenciesBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, FieloELR__Predecessor__c, FieloELR__Module__c FROM FieloELR__ModuleDependency__c WHERE FieloELR__ExternalKey__c = \'\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__ModuleDependency__c.SObjectType});
		FieloELR__ModuleDependency__c moduleDependency;
		for(sobject record: scope) {
			moduleDependency = (FieloELR__ModuleDependency__c) record;
			moduleDependency.FieloELR__ExternalKey__c = String.valueOf(moduleDependency.FieloELR__Predecessor__c) + String.valueOf(moduleDependency.FieloELR__Module__c);
			uow.registerDirty(moduleDependency);
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
		mail.setSubject('Apex Update Module Dependencies ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}