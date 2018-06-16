global class UpdateCourseStatusBatchSchedule implements Database.Batchable<sObject> {
	
	String query;
	
	global UpdateCourseStatusBatchSchedule() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, FieloELR__Course__c, FieloELR__Member__c FROM FieloELR__CourseStatus__c WHERE FieloELR__ExternalKey__c = \'\'';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		FieloELRUPD_SObjectUnitOfWork uow = new FieloELRUPD_SObjectUnitOfWork(new List<Schema.SObjectType>{FieloELR__CourseStatus__c.SObjectType});
		FieloELR__CourseStatus__c courseStatus;
		for(sobject record: scope) {
			courseStatus = (FieloELR__CourseStatus__c) record;
			courseStatus.FieloELR__ExternalKey__c = String.valueOf(courseStatus.FieloELR__Course__c) + String.valueOf(courseStatus.FieloELR__Member__c);
			uow.registerDirty(courseStatus);
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
		mail.setSubject('Apex Update Course Status ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
}