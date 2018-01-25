List<FieloCMS__Page__c> pages = [SELECT id, name, fielocms__externalname__c FROM FieloCMS__Page__c];

for (fielocms__page__c page: pages) {
  page.fielocms__externalname__c = page.name.replaceAll(' ','').replaceAll('[^A-Za-z0-9]','') + 'Page';
}

update pages;
