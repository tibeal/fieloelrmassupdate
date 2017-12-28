// Read and Edit
var checkboxes=document.getElementsByTagName('input');
for(i=0;i<checkboxes.length;i++) {
  if (checkboxes[i].parentElement.className=="dataCell readonlyCol")
    checkboxes[i].checked='checked';
  if (checkboxes[i].parentElement.className=="dataCell displayedCol")
      checkboxes[i].checked='checked';
}
document.querySelector('[title="Save"]').click();

//Just Reada
var checkboxes=document.getElementsByTagName('input');
for(i=0;i<checkboxes.length;i++) {
  if (checkboxes[i].parentElement.className=="dataCell readonlyCol")
  checkboxes[i].checked='checked';
}
document.querySelector('[title="Save"]').click();
