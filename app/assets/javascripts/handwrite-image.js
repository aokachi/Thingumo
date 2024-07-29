window.onload = function() {
  // キャンバスの初期化
  var canvas = new fabric.Canvas('handwrite-image-canvas');

  // キャンバスのリサイズ関数
  function resizeCanvas() {
    var wrapper = document.querySelector('.canvas-wrapper');
    canvas.setWidth(wrapper.clientWidth);
    canvas.setHeight(wrapper.clientHeight);
    canvas.renderAll();
  }

  // ウィンドウリサイズイベントにリサイズ関数をバインド
  window.addEventListener('resize', resizeCanvas);

  // 初期リサイズ
  resizeCanvas();

  // 最初は描画モードを無効にする
  canvas.isDrawingMode = false;

  var colorPalette = document.querySelectorAll('.color-box');
  // 線の太さの調整テキストボックスとボタン
  var lineWidthInput = document.getElementById('line-width-input');
  var increaseLineWidthButton = document.getElementById('increase-line-width');
  var decreaseLineWidthButton = document.getElementById('decrease-line-width');
  // 消しゴムのサイズの調整テキストボックスとボタン
  var eraserWidthInput = document.getElementById('eraser-width-input');
  var increaseEraserWidthButton = document.getElementById('increase-eraser-width');
  var decreaseEraserWidthButton = document.getElementById('decrease-eraser-width');
  var clearButton = document.getElementById('clear-canvas-tool');

  // モーダルを表示する関数
  function showModal() {
    var modal = document.getElementById('handwrite-image-modal');
    modal.style.display = "block";

    // 背後の要素のpointer-eventsをnoneに設定
    var elementsToDisable = document.querySelectorAll('.form-control, .upload-zone, .new-question-select, .btn3, .btn4');
    elementsToDisable.forEach(function(el) {
      el.style.pointerEvents = 'none';
    });

    // キャンバスサイズを動的に調整
    setTimeout(function() {
      var wrapper = document.querySelector('.canvas-wrapper');
      var wrapperWidth = wrapper.clientWidth;
      var wrapperHeight = wrapper.clientHeight;

      canvas.setWidth(wrapperWidth);
      canvas.setHeight(wrapperHeight);
      canvas.calcOffset();
    }, 0);

    // 初期表示時にペンツールを有効にする
    canvas.isDrawingMode = true;
  }

  // モーダルを閉じる関数
  function closeModal() {
    var modal = document.getElementById('handwrite-image-modal');
    modal.style.display = "none";

    // 背後の要素のpointer-eventsを元に戻す
    var elementsToDisable = document.querySelectorAll('.form-control, .upload-zone, .new-question-select, .btn3, .btn4');
    elementsToDisable.forEach(function(el) {
      el.style.pointerEvents = 'auto';
    });
  }

  // モーダルの表示・非表示のイベントリスナー
  var openBtn = document.getElementById('handwrite-image-button');
  openBtn.addEventListener('click', showModal);

  var closeBtn = document.getElementById('handwrite-image-modal-close');
  closeBtn.addEventListener('click', closeModal);

  // 色の選択機能
  colorPalette.forEach(function(colorBox) {
    colorBox.addEventListener('click', function() {
      canvas.freeDrawingBrush.color = colorBox.style.backgroundColor;
    });
  });

  // "color-box"のボタンに対するスタイル
  document.querySelectorAll('.color-box').forEach(function(btn) {
    btn.addEventListener('mousedown', function() {
      this.style.transform = 'scale(0.95)';
      this.style.boxShadow = 'inset 0 3px 5px rgba(0, 0, 0, 0.125)';
    });
    btn.addEventListener('mouseup', function() {
      this.style.transform = '';
      this.style.boxShadow = '';
    });
  });

  // 線の太さをテキストボックスの値に基づいて設定する関数
  function setLineWidth() {
    var lineWidth = parseInt(lineWidthInput.value, 10);
    canvas.freeDrawingBrush.width = lineWidth;
  }

  // 線の太さを増やすボタンのイベントハンドラ
  increaseLineWidthButton.addEventListener('click', function() {
    lineWidthInput.value = parseInt(lineWidthInput.value, 10) + 1;
    setLineWidth();
  });

  // 線の太さを減らすボタンのイベントハンドラ
  decreaseLineWidthButton.addEventListener('click', function() {
    lineWidthInput.value = Math.max(parseInt(lineWidthInput.value, 10) - 1, 1);
    setLineWidth();
  });

  // テキストボックスの値が変更されたときのイベントハンドラ
  lineWidthInput.addEventListener('change', setLineWidth);

  // 消しゴムの太さをテキストボックスの値に基づいて設定する関数
  function setEraserWidth() {
    var eraserWidth = parseInt(document.getElementById('eraser-width-input').value, 10);
    canvas.freeDrawingBrush.width = eraserWidth;
  }

  // 消しゴムの太さを増やすボタンのイベントハンドラ
  increaseEraserWidthButton.addEventListener('click', function() {
    eraserWidthInput.value = parseInt(eraserWidthInput.value, 10) + 1;
    setEraserWidth();
  });

  // 消しゴムの太さを減らすボタンのイベントハンドラ
  decreaseEraserWidthButton.addEventListener('click', function() {
    eraserWidthInput.value = Math.max(parseInt(eraserWidthInput.value, 10) - 1, 1);
    setEraserWidth();
  });

  // テキストボックスの値が変更されたときのイベントハンドラ
  eraserWidthInput.addEventListener('change', setEraserWidth);

  // ペンツールへ切り替え
  document.getElementById('pen-tool').addEventListener('click', function() {
    canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
    canvas.isDrawingMode = true;
  });

  // 範囲選択ツールへ切り替え
  document.getElementById('select-move-tool').addEventListener('click', function() {
    canvas.isDrawingMode = false;
    canvas.selection = true;
  });

  // 消しゴムツールの設定
  document.getElementById('eraser-tool').addEventListener('click', function() {
    canvas.freeDrawingBrush = new fabric.EraserBrush(canvas);
    canvas.isDrawingMode = true;
    // その他の必要な設定（例：消しゴムの幅設定）
    canvas.freeDrawingBrush.width = parseInt(document.getElementById('eraser-width-input').value, 10);
  });

  // クリア機能
  clearButton.addEventListener('click', function() {
    canvas.clear();
  });

  // 送信ボタンの機能
  document.getElementById('handwrite-image-modal-send').addEventListener('click', function() {
    var canvas = document.getElementById('handwrite-image-canvas');
    canvas.toBlob(function(blob) {
      var newFile = new File([blob], "canvas-image.png", {type: "image/png", lastModified: new Date().getTime()});
      var container = new DataTransfer();
      container.items.add(newFile);

      var fileInput = document.getElementById('question_image');
      fileInput.files = container.files;
      $('#question_image').trigger('change'); // 画像追加後にchangeイベントをトリガーする

      // closeModal() 関数を呼び出してモーダルを閉じる
      closeModal();
    }, 'image/png');
  });
};