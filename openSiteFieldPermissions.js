​
// Open all Field Permissions
// Need permission allow popup
var customFieldSecurity;
[].some.call(document.querySelectorAll('.subSubHeader'), function(element, index, array) {
if (element.innerHTML === 'Custom Field-Level Security') {
customFieldSecurity = element;
return true;
} else {
return false;
}
});
var allObjectLabels = customFieldSecurity.closest('table').querySelectorAll('.labelCol');
var objects = [
/* PLT & CMS */ 'Agreement','Category','Component','Component Library','Layout','Media','Member','Navigation','Page','Post','Program','Reward','Reward Item','Section','Segment','Site','Tag',
/* ELR */ 'Answer','Answer Option','Course','Course Dependencie','Course Status','Module','Module Dependency','Module Response','Question','Question Response',
/* PRP */ 'Invoice','Invoice Item'
];
[].forEach.call(allObjectLabels, function(label) {
if (objects.indexOf(label.innerHTML) !== -1) {
window.open(label.nextSibling.querySelector('a').href);
}
});
