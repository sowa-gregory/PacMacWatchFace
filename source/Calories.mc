import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;
import Toybox.Activity;
import Toybox.Weather;
import Toybox.Application;

module Calories {
  var calBmp;
 
  function loadRes() {
    calBmp = Application.loadResource(Rez.Drawables.Calories);
  }

  function draw(dc as Dc) {
    var cals = ActivityMonitor.getInfo().calories;
    var calsString = cals.toString();
    var width = dc.getTextWidthInPixels(calsString, Graphics.FONT_SYSTEM_TINY);

    var startPos = 104-(width+16)/2;
     dc.drawBitmap(startPos,147, calBmp);
   
      dc.drawText(
        startPos+16,
        141,
        Graphics.FONT_SYSTEM_TINY,
        calsString,
        Graphics.TEXT_JUSTIFY_LEFT
      );
    
  }
}
