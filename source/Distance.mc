import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;
import Toybox.Activity;
import Toybox.Weather;
import Toybox.Application;
import Toybox.WatchUi;

module Distance {
  var distBmp;

  function loadRes() {
    distBmp = WatchUi.loadResource(Rez.Drawables.Distance);
  }

  function draw(dc as Dc) {
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    var dist = ActivityMonitor.getInfo().distance / 100;
    var distString = dist.toString();
    var width = dc.getTextWidthInPixels(distString, Graphics.FONT_SYSTEM_TINY);

    var startPos = 104 - (width + 16) / 2;
    dc.drawBitmap(startPos, 128, distBmp);

    dc.drawText(
      startPos + 16,
      122,
      Graphics.FONT_SYSTEM_TINY,
      distString,
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
