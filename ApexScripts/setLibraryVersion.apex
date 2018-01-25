List<FieloPLT__Library__c> appsLibs = [SELECT Id, FieloPLT__Version__c FROM FieloPLT__Library__c WHERE Name in ('FieloELR','FieloPRP')];

for (FieloPLT__Library__c lib: appsLibs) {
    if (lib.FieloPLT__Version__c==null) {
        lib.FieloPLT__Version__c = 1.000;
    }
}

update appsLibs;
