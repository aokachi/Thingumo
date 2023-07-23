document.addEventListener('DOMContentLoaded', function(){
  let modalButton = document.getElementById('modal-button');
  let modal = document.getElementById('modal');
  let modalInner = document.getElementById('modal-inner');
  let modalForm = document.getElementById('modal-form');
  let disagreeButton = document.getElementById('disagree-button');
  let agreeButton = document.getElementById('agree-button');
  let returnButton = document.getElementById('return-button');
  let modalNotes = document.getElementById('modal-notes');
  
  modal.style.display = 'none';
  
  modalButton.addEventListener('click', function(){
    modal.style.display = 'flex';
    modalInner.style.display = 'block';
    modalForm.style.display = 'none';
    modalNotes.style.display = 'block';
  });
  
  disagreeButton.addEventListener('click', function(){
    modal.style.display = 'none';
    modalInner.style.display = 'none';
    modalForm.style.display = 'none';
    modalNotes.style.display = 'none';
  });
  
  agreeButton.addEventListener('click', function(){
    modalNotes.style.display = 'none';
    modalForm.style.display = 'block';
  });
  
  returnButton.addEventListener('click', function(){
    modalForm.style.display = 'none';
    modalNotes.style.display = 'block';
  });
});
