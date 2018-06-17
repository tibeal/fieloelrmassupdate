global class UpdateModuleKeyDependenciesBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateModuleKeyDependenciesBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id,' +
			' (SELECT FieloELR__Predecessor__c FROM FieloELR__PredecessorModules__r WHERE FieloELR__Predecessor__r.FieloELR__IsActive__c = true ORDER BY Id) ' +
			'FROM FieloELR__Module__c ' +
			'WHERE FieloELR__KeyDependencies__c like \'_______________,%\' OR FieloELR__KeyDependencies__c like \'_______________\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		SObjectUnitOfWork uow = new SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__Module__c.SObjectType});
		FieloELR__Module__c module;
		Set<Id> predecessors = new Set<Id>();
		for(sobject record: scope) {
			module = (FieloELR__Module__c) record;
			if (!module.FieloELR__PredecessorModules__r.isEmpty()) {
				predecessors.clear();
				for (FieloELR__ModuleDependency__c md: module.FieloELR__PredecessorModules__r) {
					predecessors.add(md.FieloELR__Predecessor__c);
				}
				module.FieloELR__KeyDependencies__c = String.join(new List<Id>(predecessors), ',');
				uow.registerDirty(module);
			} else {
				module.FieloELR__KeyDependencies__c = '';
				uow.registerDirty(module);
			}
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
		mail.setSubject('Apex Update Module Key Dependencies ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}