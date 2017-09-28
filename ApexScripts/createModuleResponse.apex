Id memberId = 'a0H6A000001QZwcUAG';
Id courseId = 'a0i6A000001VP9YQAW';

FieloPLT__Member__c member =
  [Select Id, Name, FieloPLT__Program__c From FieloPLT__Member__c Where Id = :memberId];

FieloELR__Course__c course =
  [Select Id, Name, (Select Id From FieloELR__Modules__r Where IsActive__c = true) From FieloELR__Course__c Where Id = :courseId];

Map<Id,FieloELR__Module__c> modulesMap = new Map<Id,FieloELR__Question__c>(
  [Select Id, (Select Id From FieloELR__Questions__r) From FieloELR__Module__c Where Id in :course.FieloELR__Modules__r]
);

Map<Id,FieloELR__Question__c> questions = new Map<Id,FieloELR__Question__c>(
  [Select Id, (Select Id, Name, IsCorrect__c From FieloELR__AnswerOptions__r Where IsCorrect__c=true) From FieloELR__Question__c Where FieloELR__Module__c in :course.FieloELR__Modules__r]
);

CourseStatus__c cs = new CourseStatus__c(
  FieloELR__Course__c = course.Id,
  FieloELR__Member__c = member.Id
);

List<FieloELR__ModuleResponse__c> mrs = new List<FieloELR__ModuleResponse__c>();

for(FieloELR__Module__c module: modulesMap.values()) {
    mrs.add(
        new FieloELR__ModuleResponse__c(
            FieloELR__Module__c = module.Id,
            FieloELR__Member__c = member.Id
        )
    );
}
