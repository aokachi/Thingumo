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

  // キャンバスの設定
  var canvas = new fabric.Canvas('handwrite-image-canvas');
  // 最初は描画モードを無効にする
  canvas.isDrawingMode = false;

  var colorPalette = document.querySelectorAll('.color-box');
  // 線の太さの調整テキストボックスとボタン
  var lineWidthInput = document.getElementById('line-width-input');
  var increaseLineWidthButton = document.getElementById('increase-line-width');
  var decreaseLineWidthButton = document.getElementById('decrease-line-width');

  var undoButton = document.getElementById('undo-button');
  var redoButton = document.getElementById('redo-button');
  var clearButton = document.getElementById('clear-canvas');

  // 色の選択機能
  colorPalette.forEach(function(colorBox) {
    colorBox.addEventListener('click', function() {
      canvas.freeDrawingBrush.color = colorBox.style.backgroundColor;
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


  // アンドゥ機能
  undoButton.addEventListener('click', function() {
    var history = canvas.historyUndo.pop();
    if(history) {
      canvas.loadFromJSON(history, canvas.renderAll.bind(canvas));
    }
  });

  // リドゥ機能
  redoButton.addEventListener('click', function() {
    var history = canvas.historyRedo.pop();
    if(history) {
      canvas.loadFromJSON(history, canvas.renderAll.bind(canvas));
    }
  });

  // クリア機能
  clearButton.addEventListener('click', function() {
    canvas.clear();
  });

  // 保存機能
  saveButton.addEventListener('click', function() {
    var dataURL = canvas.toDataURL({
      format: 'png',
      quality: 1.0
    });
    window.open(dataURL);
  });

  // ロード機能
  loadButton.addEventListener('click', function() {
    // ロード処理の実装
    // 例えばinput[type='file']を使ってローカルファイルを読み込むことができる
  });

  // 描画ツール選択機能（ペンツールと消しゴムツールのトグル）
  document.getElementById('drawing-tool-select').addEventListener('click', function() {
    canvas.isDrawingMode = !canvas.isDrawingMode;
  });

  // 消しゴムツールの設定
  document.getElementById('eraser-tool').addEventListener('click', function() {
    // 消しゴムモードへの切り替え
    if (canvas.isDrawingMode) {
      // 既存のブラシを一時的に保存し、消しゴムブラシに切り替える
      canvas.previousFreeDrawingBrush = canvas.freeDrawingBrush;
      canvas.freeDrawingBrush = new fabric.EraserBrush(canvas);
      canvas.freeDrawingBrush.width = parseInt(lineWidthAdjuster.value, 10);
    } else {
      // 描画モードが無効ならば、元のブラシに戻す
      canvas.freeDrawingBrush = canvas.previousFreeDrawingBrush;
    }
  });

  // 送信ボタンの機能
  sendBtn.addEventListener('click', function() {
    // 送信処理の実装
    var dataURL = canvas.toDataURL();
    // dataURLを送信するためのコードをここに実装
  });
};