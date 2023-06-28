import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.WatchUi;

module StepsProgress {
  const GHOSTS = 10;

  var emptyGhost as Array<BitmapResource>?;
  var colorGhost as Array<BitmapResource>?;
  var ghostX as Array<Number> = [119, 165, 180, 162, 119, 64, 22, 4, 20, 64];
  var ghostY as Array<Number> = [6, 38, 90, 141, 173, 173, 141, 90, 38, 6];
  var emptyGhostImage as Array<Number> = [0, 0, 1, 2, 2, 5, 5, 4, 3, 3];
  var colorGhostImage as Array<Number> = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5];
  var ghostWidth;
  var ghostHeight;

  function loadRes() {
    emptyGhost = new Array<BitmapResource>[6];
    emptyGhost[0] = Application.loadResource(Rez.Drawables.GhostEmptyRightTop);
    emptyGhost[1] = Application.loadResource(Rez.Drawables.GhostEmptyRight);
    emptyGhost[2] = Application.loadResource(
      Rez.Drawables.GhostEmptyRightBottom
    );
    emptyGhost[3] = Application.loadResource(Rez.Drawables.GhostEmptyLeftTop);
    emptyGhost[4] = Application.loadResource(Rez.Drawables.GhostEmptyLeft);
    emptyGhost[5] = Application.loadResource(
      Rez.Drawables.GhostEmptyLeftBottom
    );
    ghostWidth = emptyGhost[0].getWidth();
    ghostHeight = emptyGhost[0].getHeight();

    colorGhost = new Array<BitmapResource>[6];
    colorGhost[0] = Application.loadResource(Rez.Drawables.GhostPink);
    colorGhost[1] = Application.loadResource(Rez.Drawables.GhostRed);
    colorGhost[2] = Application.loadResource(Rez.Drawables.GhostYellow);
    colorGhost[3] = Application.loadResource(Rez.Drawables.GhostCyan);
    colorGhost[4] = Application.loadResource(Rez.Drawables.GhostBlue);
    colorGhost[5] = Application.loadResource(Rez.Drawables.GhostGreen);
  }

  function draw(dc as Dc) as Void {
    var steps = ActivityMonitor.getInfo().steps;
    var stepGoal = ActivityMonitor.getInfo().stepGoal;
    var progress = (steps * 100) / stepGoal;

    var colIndex = progress / GHOSTS;
    if (colIndex > GHOSTS) {
      colIndex = GHOSTS;
    }
    var ghostImageCol = colorGhost[colorGhostImage[colIndex]];

    for (var i = 0; i < GHOSTS; i++) {
      if (progress >= (i + 1) * GHOSTS) {
        dc.drawBitmap(ghostX[i], ghostY[i], ghostImageCol);
      } else {
        dc.drawBitmap(ghostX[i], ghostY[i], emptyGhost[emptyGhostImage[i]]);
      }
    }
  }
}
