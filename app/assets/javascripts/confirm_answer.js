/* 正解選択用ボタン&モーダルウインドウ */
document.addEventListener('DOMContentLoaded', function() {
  const confirmBtn = document.getElementById('confirm-correct-answer-btn');
  const modal = document.getElementById('correct-answer-confirmation-modal');

  if (confirmBtn) {
    confirmBtn.addEventListener('click', function() {
      modal.style.display = 'block';
    });
  }
});
