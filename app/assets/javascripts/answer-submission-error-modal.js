document.addEventListener('DOMContentLoaded', function(){
  let answerSubmissionErrorModal = document.getElementById('answer-submission-error-modal');
  let answerSubmissionErrorModalInner = document.getElementById('answer-submission-error-modal-inner');
  let answerSubmissionErrorModalReturnButton = document.getElementById('answer-submission-error-modal-return-button');
  let answerSubmissionErrorModalNotes = document.getElementById('answer-submission-error-modal-notes');
  
  answerSubmissionErrorModal.style.display = 'none';
  
  modalButton.addEventListener('click', function(){
    answerSubmissionErrorModal.style.display = 'flex';
    answerSubmissionErrorModalInner.style.display = 'block';
    answerSubmissionErrorModalNotes.style.display = 'block';
  });
  
  answerSubmissionErrorModalReturnButton.addEventListener('click', function(){
    answerSubmissionErrorModalNotes.style.display = 'block';
  });
});