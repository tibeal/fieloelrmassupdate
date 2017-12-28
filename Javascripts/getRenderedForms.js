[].forEach.call(document.querySelectorAll('.slds-form'), function(form) {
  console.log(form.getAttribute('id') + '     ' + [].join.call(form.classList, ' '));
});
