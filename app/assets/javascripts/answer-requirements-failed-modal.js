document.addEventListener('DOMContentLoaded', function(){
  let answerRequirementsFailedModal = document.getElementById('answer-requirements-failed-modal');
  let answerRequirementsFailedModalInner = document.getElementById('answer-requirements-failed-modal-inner');
  let answerRequirementsFailedModalReturnButton = document.getElementById('answer-requirements-failed-modal-return-button');
  let answerRequirementsFailedModalNotes = document.getElementById('answer-requirements-failed-modal-notes');
  
  answerRequirementsFailedModal.style.display = 'none';
  
  modalButton.addEventListener('click', function(){
    answerRequirementsFailedModal.style.display = 'flex';
    answerRequirementsFailedModalInner.style.display = 'block';
    answerRequirementsFailedModalNotes.style.display = 'block';
  });
  
  answerRequirementsFailedModalReturnButton.addEventListener('click', function(){
    answerRequirementsFailedModalNotes.style.display = 'block';
  });
});