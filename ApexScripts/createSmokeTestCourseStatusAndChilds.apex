Id memberId = [SELECT Id FROM FieloPLT__Member__c WHERE FieloPLT__Program__r.Name = 'Training Center' LIMIT 1].Id;

Id courseId = 'a0j6A000001tdLRQAY';

delete [Select Id From FieloELR__CourseStatus__c Where FieloELR__Course__c = :courseId AND FieloELR__Member__c = :memberId];

List<FieloELR__CourseStatus__c> courseStatus = new List<FieloELR__CourseStatus__c>();
List<FieloELR__QuestionResponse__c> questionResponses = new List<FieloELR__QuestionResponse__c>();
List<FieloELR__ModuleResponse__c> moduleResponses = new List<FieloELR__ModuleResponse__c>();
List<FieloELR__Module__c> modules = new List<FieloELR__Module__c>();

//Course Status
courseStatus.add(new FieloELR__CourseStatus__c(FieloELR__Course__c = courseId, FieloELR__Member__c = memberId));

insert courseStatus;

modules = [SELECT Id, Name, (SELECT Id FROM FieloELR__Questions__r) FROM FieloELR__Module__c WHERE FieloELR__Course__c = :courseId];

//Module Response
for (FieloELR__Module__c module: modules) {
    moduleResponses.add(new FieloELR__ModuleResponse__c(FieloELR__CourseStatus__c = courseStatus.get(0).Id, FieloELR__Module__c = module.Id, FieloELR__Member__c = memberId));
}

insert moduleResponses;

Map<Id, FieloELR__Module__c> modulesMap = new Map<Id, FieloELR__Module__c>(modules);

Map<Id, FieloELR__Question__c> questionMap = new Map<Id, FieloELR__Question__c>(
    [SELECT Id, Name, (SELECT Id, FieloELR__Question__c, FieloELR__IsCorrect__c, FieloELR__AnswerOptionText__c FROM FieloELR__AnswerOptions__r WHERE FieloELR__IsCorrect__c = true) FROM FieloELR__Question__c WHERE FieloELR__Module__r.Id in :modules]
);

for (FieloELR__ModuleResponse__c mr: moduleResponses) {
    for (FieloELR__Question__c q: modulesMap.get(mr.FieloELR__Module__c).FieloELR__Questions__r) {
        questionResponses.add(
            new FieloELR__QuestionResponse__c(
                FieloELR__Question__c = q.Id,
                FieloELR__ModuleResponse__c = mr.Id
            )
        );
        for (FieloELR__AnswerOption__c ao: questionMap.get(q.Id).FieloELR__AnswerOptions__r) {
            if (ao.FieloELR__Question__c == q.Id && ao.FieloELR__IsCorrect__c) {
                questionResponses.get(questionResponses.size()-1).FieloELR__TextValue__c = ao.FieloELR__AnswerOptionText__c;
                break;
            }
        }
    }
}

insert questionResponses;
