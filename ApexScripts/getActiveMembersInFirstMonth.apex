Set<Id> memberIds = new Set<Id>();
List<FieloPLT__Event__c> events = [Select Id, FieloPLT__Type__c, FieloPLT__Member__r.Id, CreatedDate From FieloPLT__Event__c Where FieloPLT__Type__c = 'Registration'];
System.debug(events.size());
for (FieloPLT__Event__c event:events) {
  memberIds.add(event.FieloPLT__Member__r.Id);
}
Map<Id, FieloPLT__Member__c> membersMap = new Map<Id, FieloPLT__Member__c>([SELECT Id,Name,
  (SELECT Id, FieloPRP__Date__c FROM FieloPRP__Invoices__r ORDER BY FieloPRP__Date__c DESC LIMIT 1),
  (SELECT Id, CreatedDate FROM FieloELR__CoursesStatus__r ORDER BY CreatedDate DESC LIMIT 1),
  (SELECT Id, FieloELR__SubmitDate__c FROM FieloELR__ModuleResponses__r WHERE FieloELR__SubmitDate__c != null ORDER BY FieloELR__SubmitDate__c DESC LIMIT 1)
  FROM FieloPLT__Member__c WHERE Id in :memberIds]);

Map<Id, FieloPLT__Member__c> updMembersMap = new Map<Id, FieloPLT__Member__c>();
for(FieloPLT__Event__c event:events) {
    if (!membersMap.get(event.FieloPLT__Member__r.Id).FieloPRP__Invoices__r.isEmpty()) {
      if (event.CreatedDate.date().daysBetween(membersMap.get(event.FieloPLT__Member__r.Id).FieloPRP__Invoices__r[0].FieloPRP__Date__c) <= 30) {
        if (!updMembersMap.containsKey(event.FieloPLT__Member__r.Id)) {
          updMembersMap.put(event.FieloPLT__Member__r.Id, new FieloPLT__Member__c(Id=event.FieloPLT__Member__r.Id,ActionInFirstMonth__c=true));
        }
      }
    }
    if (!membersMap.get(event.FieloPLT__Member__r.Id).FieloELR__CoursesStatus__r.isEmpty()) {
      if (event.CreatedDate.date().daysBetween(membersMap.get(event.FieloPLT__Member__r.Id).FieloELR__CoursesStatus__r[0].CreatedDate.date()) <= 30) {
        if (!updMembersMap.containsKey(event.FieloPLT__Member__r.Id)) {
          updMembersMap.put(event.FieloPLT__Member__r.Id, new FieloPLT__Member__c(Id=event.FieloPLT__Member__r.Id,ActionInFirstMonth__c=true));
        }
      }
    }
    if (!membersMap.get(event.FieloPLT__Member__r.Id).FieloELR__ModuleResponses__r.isEmpty()) {
      if (event.CreatedDate.date().daysBetween(membersMap.get(event.FieloPLT__Member__r.Id).FieloELR__ModuleResponses__r[0].FieloELR__SubmitDate__c.date()) <= 30) {
        if (!updMembersMap.containsKey(event.FieloPLT__Member__r.Id)) {
          updMembersMap.put(event.FieloPLT__Member__r.Id, new FieloPLT__Member__c(Id=event.FieloPLT__Member__r.Id,ActionInFirstMonth__c=true));
        }
      }
    }
}

update updMembersMap.values();
