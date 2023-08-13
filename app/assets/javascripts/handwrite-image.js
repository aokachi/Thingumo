import { fabric } from 'fabric';

window.onload = function() {
  var modal = document.getElementById('handwrite-image-modal');
  var btn = document.getElementById('handwrite-image-button');
  var span = document.getElementById('handwrite-image-modal-close');

  btn.onclick = function() {
    modal.style.display = "block";
  }

  span.onclick = function() {
    modal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }

  var canvas = new fabric.Canvas('handwrite-image-canvas');
  canvas.isDrawingMode = true;
  canvas.freeDrawingBrush.width = 5;
  canvas.freeDrawingBrush.color = "black";

  btn.onclick = function() {
    modal.style.display = "block";
    canvas.setWidth(modal.clientWidth * 0.9);
    canvas.setHeight(modal.clientHeight * 0.9);
    canvas.calcOffset();
  }

}
