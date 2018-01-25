List<FieloPLT__PageSettings__c> elrPS = [SELECT Id FROM FieloPLT__PageSettings__c WHERE FieloPLT__Library__r.Name = 'FieloELR'];

for (FieloPLT__PageSettings__c ps: elrPS) {
  ps.FieloPLT__IsCustom__c = false;
}

update elrPS;
