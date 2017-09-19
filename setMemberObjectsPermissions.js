​
// Fielo Member Site Object Permission
var objects = [
/* PLT & CMS */ 'Agreements','Categories','Components','Components Library','Layouts','Media','Members','Navigations','Pages','Posts','Programs','Rewards','Reward Items','Sections','Segments','Sites','Tags','Redemptions','Redemption Items','Transactions',
/* ELR */ 'Answers','Answer Options','Courses','Course Dependencies','Courses Status','Modules','Modules Dependencies','Modules Responses','Questions','Question Responses',
/* PRP */ 'Invoices','Invoice Items'
];
var readEditObjects = [
'Members',
'Answers',
'Courses Status',
'Modules Responses',
'Question Responses',
'Redemptions',
'Redemption Items',
'Transactions'
];
var readFlag;
var editFlag;
var createFlag;
[].forEach.call(objects, function(object) {
console.log(object);
var readFlag =
document.querySelector('[title="Read ' + object + '"]');
readFlag.checked = 'checked';
if (readEditObjects.indexOf(object) !== -1) {
editFlag =
document.querySelector('[title="Edit ' + object + '"]');
createFlag =
document.querySelector('[title="Create ' + object + '"]');
editFlag.checked = 'checked';
createFlag.checked = 'checked';
}
});
