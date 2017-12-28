Id memberId = 'a0H6A000000GYSNUA4';
Id moduleId = 'a0m6A0000014V3EQAU';

FieloPLT__Member__c member =
  [Select Id, Name, FieloPLT__Program__c From FieloPLT__Member__c Where Id = :memberId];

FieloELR__Module__c module = [Select Id, FieloELR__Course__c, (Select Id From FieloELR__Questions__r) From FieloELR__Module__c Where Id = :moduleId];

Map<Id,FieloELR__Question__c> questionsMap = new Map<Id,FieloELR__Question__c>(
  [Select Id, (Select Id, Name, FieloELR__AnswerOptionText__c, FieloELR__MatchingText__c, FieloELR__IsCorrect__c From FieloELR__AnswerOptions__r Where IsCorrect__c=true) From FieloELR__Question__c Where FieloELR__Module__c = :moduleId]
);

CourseStatus__c cs = new CourseStatus__c(
  FieloELR__Course__c = module.FieloELR__Course__c,
  FieloELR__Member__c = member.Id
);

try{
  upsert cs;
}catch(Exception e){}

FieloELR__ModuleResponse__c mr = new FieloELR__ModuleResponse__c(
    FieloELR__Module__c = module.Id,
    FieloELR__Member__c = member.Id
);

try{
  upsert mr;
}catch(Exception e){
  System.debug(e);
}

List<FieloELR__QuestionResponse__c> qrs = new List<FieloELR__QuestionResponse__c>();
for(FieloELR__Question__c question: questionsMap.values()) {
    qrs.add(
        new FieloELR__QuestionResponse__c(
            FieloELR__ModuleResponse__c = mr.Id,
            FieloELR__Question__c = question.Id
        )
    );
}

try{
  upsert qrs;
}catch(Exception e){}

List<FieloELR__Answer__c> asws = new List<FieloELR__Answer__c>();
for (FieloELR__QuestionResponse__c qr: qrs) {
    for (FieloELR__AnswerOption__c ao: questionsMap.get(qr.FieloELR__Question__c).FieloELR__AnswerOptions__r) {
        asws.add(
            new FieloELR__Answer__c(
              FieloELR__QuestionResponse__c = qr.Id,
              FieloELR__AnswerOption__c = ao.Id,
              FieloELR__TextValue__c = ao.FieloELR__MatchingText__c
            )
        );
    }
}

try{
  upsert asws;
}catch(Exception e){}
