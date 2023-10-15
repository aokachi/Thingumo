/* 正解選択用ボタン&モーダルウインドウ */
document.addEventListener('DOMContentLoaded', function() {
  const confirmBtn = document.getElementById('confirm-correct-answer-btn');
  const modal = document.getElementById('correct-answer-confirmation-modal');

  if (confirmBtn) {
    confirmBtn.addEventListener('click', function() {
      modal.style.display = 'flex';
    });
  }

  // "confirm-answer-btn"を押下した場合の処理
  const confirmAnswerBtn = document.getElementById('confirm-answer-btn');
  const modalContent = document.querySelector('.modal-content');
  const answerBtnContainer = document.querySelector('.answer-btn-container');
  const processingIndicator = document.getElementById('correct-answer-processing-indicator');

  if (confirmAnswerBtn) {
    confirmAnswerBtn.addEventListener('click', function() {
      // "modal-content"と"answer-btn-container"を非表示にする
      modalContent.style.display = 'none';
      answerBtnContainer.style.display = 'none';
      // "correct-answer-processing-indicator"を表示する
      processingIndicator.style.display = 'block';
      // 質問のIDを取得
      const postId = document.getElementById('current-post-id').value;
      // 選択された回答のIDを取得
      const answerId = this.getAttribute('data-answer-id');
      // 選択された回答を行ったユーザーのIDを取得
      const userId = this.getAttribute('data-user-id');
      
      // Ajaxリクエストを使ってサーバーサイドの処理を呼び出す
      $.ajax({
        url: '/answers/confirm',
        method: 'POST',
        data: {
          post_id: postId,
          answer_id: answerId,
          user_id: userId,
          // CSRFトークン
          authenticity_token: $('[name="csrf-token"]').attr('content')
        },
        success: function(response) {
          // モーダルを閉じる
          $("#correct-answer-confirmation-modal").modal('hide');
          // 5秒間だけメッセージを表示する
          setTimeout(function() {
            alert('正解として登録しました。10分間は、正解を変更することができます。');
          }, 5000);
        }
      });
    });
  }
});