window.onload = function() {
  var modal = document.getElementById('handwrite-image-modal');
  var btn = document.getElementById('handwrite-image-button');
  var span = document.getElementById('handwrite-image-modal-close');
  var sendBtn = document.getElementById('handwrite-image-modal-send');

  // モーダルを表示するイベントリスナー
  btn.addEventListener('click', function() {
    modal.style.display = "block";
    canvas.setWidth(modal.clientWidth * 0.9);
    canvas.setHeight(modal.clientHeight * 0.9);
    canvas.calcOffset();
  });

  // モーダルを閉じるイベントリスナー
  span.addEventListener('click', function() {
    modal.style.display = "none";
  });

  // モーダル外のクリックでモーダルを閉じるイベントリスナー
  window.addEventListener('click', function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  });

  // キャンバスの設定
  var canvas = new fabric.Canvas('handwrite-image-canvas');
  canvas.isDrawingMode = true;
  canvas.freeDrawingBrush.width = 5;
  canvas.freeDrawingBrush.color = "black";

  // 送信ボタンの機能（ここに必要なコードを追加）
  sendBtn.addEventListener('click', function() {
    // 送信処理の実装
    // 例: canvas.toDataURL() を使用してキャンバスのデータを取得し、送信するなど
  });
}