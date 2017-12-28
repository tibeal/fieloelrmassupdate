​
// Site Public Object Permission
var objects = [
/* Salesforce */ 'Contacts','Documents',
/* PLT & CMS */ 'Agreements','Categories','Components','Components Library','Layouts','Media','Members','Navigations','Pages','Posts','Programs','Rewards','Reward Items','Sections','Segments','Sites','Tags',
/* ELR */ 'Answers','Answer Options','Courses','Course Dependencies','Courses Status','Modules','Modules Dependencies','Modules Responses','Questions','Question Responses',
/* PRP */ 'Invoices','Invoice Items'
];
var readEditObjects = [
'Members',
'Answers',
'Courses Status',
'Modules Responses',
'Question Responses'
];
var readFlag;
var editFlag;
var createFlag;
[].forEach.call(objects, function(object) {
  var readFlag =
  document.querySelector('[title="Read ' + object + '"]');
  if (readFlag) {
    readFlag.checked = 'checked';
  }
  if (readEditObjects.indexOf(object) !== -1) {
    editFlag =
    document.querySelector('[title="Edit ' + object + '"]');
    createFlag =
    document.querySelector('[title="Create ' + object + '"]');
    if (editFlag) {
      editFlag.checked = 'checked';
    }
    if (createFlag) {
      createFlag.checked = 'checked';
    }
  }
});
