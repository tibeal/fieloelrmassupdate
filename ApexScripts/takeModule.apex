Id memberId = 'a0H6A000001QZwcUAG';
FieloPLT__Member__c member = [SELECT Id, FieloPLT__Program__c FROM FieloPLT__Member__c WHERE Id =: memberId];
FieloELR.ModuleService.ModuleWrapper moduleWrapper = FieloELR.ModuleService.takeModule(
    'a0o6A000000IqUzQAK',
    member.Id,
    new Set<String> {'Id', 'FieloELR__AttemptsAllowed__c'},
    new Set<String> {'FieloELR__QuestionText__c'},
    new Set<String> {'FieloELR__AnswerOptionText__c','FieloELR__MatchingText__c'}
);
system.debug(
  JSON.serializePretty(moduleWrapper)
);
