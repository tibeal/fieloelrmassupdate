List<FieloCMS__Page__c> pages = [SELECT Id, Name, FieloCMS__Site__r.Name FROM FieloCMS__Page__c WHERE FieloCMS__ExternalName__c != null];

for (FieloCMS__Page__c page:pages){
  page.FieloCMS__ExternalName__c = page.FieloCMS__Site__r.Name.replaceAll('[^a-zA-Z0-9]', '') + '_' + page.Name.replaceAll('[^a-zA-Z0-9]', '');
}

update pages;
