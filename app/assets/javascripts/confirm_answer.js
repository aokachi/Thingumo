/* 正解選択用ボタン&モーダルウインドウ */
document.addEventListener('DOMContentLoaded', function() {
  const confirmBtn = document.getElementById('confirm-correct-answer-btn');
  const modal = document.getElementById('correct-answer-confirmation-modal');

  if (confirmBtn) {
    confirmBtn.addEventListener('click', function() {
      modal.style.display = 'flex';
    });
    
    // モーダルの外側をクリックした場合にモーダルを閉じる処理
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = 'none';
      }
    }
  }

  // "confirm-answer-btn"を押下した場合
  const confirmAnswerBtn = document.getElementById('confirm-answer-btn');
  if (confirmAnswerBtn) {
    confirmAnswerBtn.addEventListener('click', function() {
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
