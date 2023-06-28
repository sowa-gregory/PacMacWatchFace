import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;

module StepsProgress {
  const GHOST_SIZE = 24;
  const START_ANGLE = 18;
  const STEP_ANGE = 36;
  const GHOSTS = 10;
  const RADIUS = 88;
  const SCREEN_SIZE = 208;
  const SCREEN_SIZE_HALF = 104;

  function drawEmptyGhost(
    dc as Dc,
    x as Number,
    y as Number,
    s as Number
  ) as Void {
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.setPenWidth(2);
    y -= s * 0.1;
    dc.setClip(x - s / 2, y - s / 2, s, s / 2);
    dc.drawCircle(x, y, s / 2 - 1);
    dc.setClip(0, 0, 208, 208);
    dc.drawLine(x - s / 2, y, x - s / 2, y + s * 0.7);
    dc.drawLine(x + s / 2, y - 1, x + s / 2, y + s * 0.7);

    var step = s / 6.0;
    var xpos = x - s / 2;

    dc.drawLine(xpos, y + s * 0.7, xpos + step, y + s * 0.5);
    dc.drawLine(xpos + step, y + s * 0.5, xpos + 2 * step, y + s * 0.7);
    xpos += 2 * step;
    dc.drawLine(xpos, y + s * 0.7, xpos + step, y + s * 0.5);
    dc.drawLine(xpos + step, y + s * 0.5, xpos + 2 * step, y + s * 0.7);
    xpos += 2 * step;
    dc.drawLine(xpos, y + s * 0.7, xpos + step, y + s * 0.5);
    dc.drawLine(xpos + step, y + s * 0.5, x + s / 2, y + s * 0.7);

    dc.drawEllipse(x - s * 0.17, y, s / 8, s / 6);
    dc.drawEllipse(x + s * 0.17, y, s / 8, s / 6);
    dc.setPenWidth(1);
  }

  function drawGhost(
    dc as Dc,
    x as Number,
    y as Number,
    s as Number,
    col as Graphics.ColorValue
  ) as Void {
    dc.setColor(col, Graphics.COLOR_BLACK);
    y -= s * 0.1;
    dc.fillCircle(x, y, s / 2 - 1);
    dc.fillRectangle(x - s / 2, y, s, s * 0.7);
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    var step = s / 6.0;
    var xpos = x - s / 2;
    for (var i = 0; i < 3; i++) {
      dc.fillPolygon([
        [xpos, y + s * 0.7],
        [xpos + step, y + s * 0.5],
        [xpos + 2 * step, y + s * 0.7],
      ]);
      xpos += 2 * step;
    }
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    dc.fillEllipse(x - s * 0.12, y, s / 7.5, s / 5);
    dc.fillEllipse(x + s * 0.25, y, s / 7.5, s / 5);
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    var eyesize = s / 15.0;
    if (eyesize < 2) {
      eyesize = 2;
    }
    dc.fillEllipse(
      x - s * 0.12 + eyesize / 3,
      y + eyesize * 0.7,
      eyesize,
      eyesize
    );
    dc.fillEllipse(
      x + s * 0.25 + eyesize / 3,
      y + eyesize * 0.7,
      eyesize,
      eyesize
    );
  }

  function draw(dc as Dc) as Void {
    var PROGRESS_COLORS = [
      Graphics.COLOR_WHITE,
      Graphics.COLOR_PURPLE,
      Graphics.COLOR_RED,
      Graphics.COLOR_RED,
      Graphics.COLOR_YELLOW,
      Graphics.COLOR_YELLOW,
      Graphics.COLOR_DK_BLUE,
      Graphics.COLOR_DK_BLUE,
      Graphics.COLOR_BLUE,
      Graphics.COLOR_BLUE,
      Graphics.COLOR_GREEN,
    ];

    var steps = ActivityMonitor.getInfo().steps;
    var stepGoal = ActivityMonitor.getInfo().stepGoal;
    var progress = (steps * 100) / stepGoal;

    System.print("steps percent:");
    System.println(progress);

    var colIndex = progress / GHOSTS;
    if (colIndex > 10) {
      colIndex = 10;
    }
    var col = PROGRESS_COLORS[colIndex];
    var angle = START_ANGLE;
    var stepAngle = STEP_ANGE;

    for (var i = 0; i < GHOSTS; i++) {
      var x = (104 + RADIUS * Math.sin((angle * Math.PI) / 180)).toNumber();
      var y = (104 - RADIUS * Math.cos((angle * Math.PI) / 180)).toNumber();
      if (progress >= (i + 1) * GHOSTS) {
        drawGhost(dc, x, y, GHOST_SIZE, col);
      } else {
        drawEmptyGhost(dc, x, y, GHOST_SIZE - 2);
      }
      angle += stepAngle;
    }
  }
}
