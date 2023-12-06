window.onload = function() {
  var modal = document.getElementById('handwrite-image-modal');
  var btn = document.getElementById('handwrite-image-button');
  var span = document.getElementById('handwrite-image-modal-close');
  var sendBtn = document.getElementById('handwrite-image-modal-send');
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
  var undoButton = document.getElementById('undo-button');
  var redoButton = document.getElementById('redo-button');
  var clearButton = document.getElementById('clear-canvas');

  // モーダルを表示するイベントリスナー
  // "canvas-container"と子要素を"canvas-wrapper"のサイズに合わせて設定する
  btn.addEventListener('click', function() {
    modal.style.display = "block";
    setTimeout(function() {
      var wrapper = document.querySelector('.canvas-wrapper');
      var wrapperWidth = wrapper.clientWidth;
      var wrapperHeight = wrapper.clientHeight;

      canvas.setWidth(wrapperWidth);
      canvas.setHeight(wrapperHeight);
      canvas.calcOffset();
    }, 0);
  });

  // モーダルを閉じるイベントリスナー
  span.addEventListener('click', function() {
    modal.style.display = "none";
  });

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
      canvas.freeDrawingBrush.width = parseInt(lineWidthInput.value, 10);
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