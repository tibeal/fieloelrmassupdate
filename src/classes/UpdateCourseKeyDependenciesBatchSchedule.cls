global class UpdateCourseKeyDependenciesBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateCourseKeyDependenciesBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, '+
			'(SELECT FieloELR__Predecessor__c FROM FieloELR__PredecessorCourses__r WHERE FieloELR__Predecessor__r.FieloELR__Status__c = \'Active\' ORDER BY Id) ' +
			'FROM FieloELR__Course__c WHERE FieloELR__KeyDependencies__c like \'_______________,%\' OR FieloELR__KeyDependencies__c like \'_______________\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		FieloELRUPD_SObjectUnitOfWork uow = new FieloELRUPD_SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__Course__c.SObjectType});
		FieloELR__Course__c course;
		Set<Id> predecessors = new Set<Id>();
		for(sobject record: scope) {
			course = (FieloELR__Course__c) record;
			if (!course.FieloELR__PredecessorCourses__r.isEmpty()) {
				predecessors.clear();
				for (FieloELR__CourseDependency__c cd: course.FieloELR__PredecessorCourses__r) {
					predecessors.add(cd.FieloELR__Predecessor__c);
				}
				course.FieloELR__KeyDependencies__c = String.join(new List<Id>(predecessors), ',');
				uow.registerDirty(course);
			} else {
				course.FieloELR__KeyDependencies__c = '';
				uow.registerDirty(course);
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
		mail.setSubject('Apex Update Course Key Dependencies ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}