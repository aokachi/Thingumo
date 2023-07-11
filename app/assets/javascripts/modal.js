document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  let modal = document.getElementById('modal');
  let modalInner = document.getElementById('modal-inner');
  let modalNotes = document.getElementById('modal-notes');
  let modalForm = document.getElementById('modal-form');
  let disagreeButton = document.getElementsByClassName('disagree-button')[0];
  let agreeButton = document.getElementsByClassName('agree-button')[0];
  let cancelButton = document.getElementById('cancel-button');
  
  modalButton.addEventListener('click', function(){
    modal.style.display = 'block';
    modalNotes.style.display = 'block';
    modalForm.style.display = 'none';
  });
  
  disagreeButton.addEventListener('click', function(){
    modal.style.display = 'none';
  });
  
  agreeButton.addEventListener('click', function(){
    modalNotes.style.display = 'none';
    modalForm.style.display = 'block';
  });
  
  cancelButton.addEventListener('click', function(){
    modal.style.display = 'none';
  });
});
