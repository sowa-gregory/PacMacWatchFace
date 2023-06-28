import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Math;
import Toybox.ActivityMonitor;
import Toybox.Activity;
import Toybox.Weather;
import Toybox.Application;

module Weather {
  var rainBmp;
  var temperatureBmp;

  function loadRes() {
    rainBmp = Application.loadResource(Rez.Drawables.Rain);
    temperatureBmp = Application.loadResource(Rez.Drawables.Temp);
  }

  function draw(dc as Dc) {
    var temperature = Weather.getCurrentConditions().temperature;
    var prec = Weather.getCurrentConditions().precipitationChance;
    var precString = prec.toString()+"%";
    System.println(temperature);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
     dc.drawBitmap(40,109, temperatureBmp);
    if (temperature != null) {
      dc.drawText(
        55,
        103,
        Graphics.FONT_SYSTEM_TINY,
        temperature.toString() + "°",
        Graphics.TEXT_JUSTIFY_LEFT
      );
    }

    var width = dc.getTextWidthInPixels(precString, Graphics.FONT_SYSTEM_TINY);

    dc.drawBitmap(167-width-16,109, rainBmp);
    if (prec != null) {
      dc.drawText(
        167-width,
        103,
        Graphics.FONT_SYSTEM_TINY,
        precString,
        Graphics.TEXT_JUSTIFY_LEFT
      );
    }
  }
}
