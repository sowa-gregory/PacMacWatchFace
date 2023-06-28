import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;
import Toybox.Time;
using Toybox.Time.Gregorian;

module BinaryClock {
  var frame = 0;
  var animOffset as Array<Number> = [1, 3, 0, 2, 5, 1, 4, 3, 2, 0, 3, 5];
  var animRight as Array<Number> = [4, 5, 6, 0, 6, 5];
  var animLeft as Array<Number> = [1, 2, 3, 0, 3, 2];

  const CLOCK_Y = 90;
  const CLOCK_Y_OFFSET = 13;
  const ANIM_PHASES = 6;
  const PACMAN_SIZE = 5;
  const COL_X = [88, 100, 112, 125];

  function drawPacman(
    dc as Dc,
    x as Number,
    y as Number,
    radius as Number,
    frame as Number
  ) {
    var angles = [0, 225, 240, 260, 45, 60, 80];

    dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(x, y, radius);
    var angle = angles[frame % 7];
    dc.setClip(x - radius, y - radius, radius * 2 + 1, radius * 2 + 1);
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    if (angle != 0) {
      dc.fillPolygon([
        [x, y],
        [
          x + 3 * radius * Math.sin((angle * Math.PI) / 180),
          y + 3 * radius * Math.cos((angle * Math.PI) / 180),
        ],
        [
          x + 3 * radius * Math.sin(((180 - angle) * Math.PI) / 180),
          y + 3 * radius * Math.cos(((180 - angle) * Math.PI) / 180),
        ],
      ]);
    }
    dc.clearClip();
  }

  function drawDigitLowPower(
    dc as Dc,
    x as Number,
    bits as Number,
    val as Number
  ) {
    var y = CLOCK_Y;

    for (var i = 0; i < bits; i++) {
      if (val & (1 << i)) {
        drawPacman(dc, x, y, PACMAN_SIZE, 1);
      } else {
        drawPacman(dc, x, y, PACMAN_SIZE, 4);
      }
      y -= CLOCK_Y_OFFSET;
    }
  }

  function drawDigit(
    dc as Dc,
    x as Number,
    itemNum as Number, // number of bit - used for animation offset
    bits as Number,
    val as Number
  ) {
    var y = CLOCK_Y;

    for (var i = 0; i < bits; i++) {
      var phase = (frame + animOffset[itemNum]) % ANIM_PHASES;
      if (val & (1 << i)) {
        drawPacman(dc, x, y, PACMAN_SIZE, animLeft[phase]);
      } else {
        drawPacman(dc, x, y, PACMAN_SIZE, animRight[phase]);
      }
      y -= CLOCK_Y_OFFSET;
      itemNum++;
    }
  }

  function draw(dc as Dc, lowPower as Boolean) {
    var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    //System.println(Lang.format("time: $1$:$2$", [date.hour, date.min]));

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    dc.fillRectangle(
      COL_X[0] - PACMAN_SIZE,
      CLOCK_Y + PACMAN_SIZE - 4 * CLOCK_Y_OFFSET,
      COL_X[3] - COL_X[0] + 2 * PACMAN_SIZE,
      4 * CLOCK_Y_OFFSET
    );

    if (frame % 2 == 0 || lowPower) {
      dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
      dc.fillCircle(COL_X[1], CLOCK_Y - CLOCK_Y_OFFSET, 2);
      dc.fillCircle(COL_X[1], CLOCK_Y - 2 * CLOCK_Y_OFFSET, 2);
    }
    if (lowPower) {
      drawDigitLowPower(dc, COL_X[0], 4, date.hour % 13);
      drawDigitLowPower(dc, COL_X[2], 4, date.min / 10);
      drawDigitLowPower(dc, COL_X[3], 4, date.min % 10);
    } else {
      drawDigit(dc, COL_X[0], 0, 4, date.hour % 12);
      drawDigit(dc, COL_X[2], 4, 4, date.min / 10);
      drawDigit(dc, COL_X[3], 8, 4, date.min % 10);
      frame++;
    }
  }
}
