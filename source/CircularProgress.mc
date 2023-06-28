import Toybox.Math;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class CircularProgress {
  private var mCirclePoints as Array<Array<Float> > = [];
  private var screenHalf;
  private var mColor;
  private var mPrevProgress; // previous value for which progress bar was generated

  const STEP = Math.PI / 8;
  const OFFSET = 5; // just a small offset to push point behind the screen

  function initialize(color as Graphics.ColorType) {
    mColor = color;
    mPrevProgress = -1;
    var settings = System.getDeviceSettings();
    screenHalf = settings.screenWidth / 2;

    for (var idx = 0; idx <= 15; idx++) {
      var angle = (idx + 1) * STEP;
      var pos = [
        Math.floor(screenHalf + (screenHalf + OFFSET) * Math.sin(angle)),
        Math.floor(screenHalf - (screenHalf + OFFSET) * Math.cos(angle)),
      ];
      mCirclePoints.add(pos);
    }

    if (Toybox.Graphics has :BufferedBitmap) {
      System.println("buffered bitmap on");
    } else {
      System.println("buffered bitmap off");
    }
  }

  function drawInternal(dc as Dc, progress as Number) {
    dc.setColor(mColor, Graphics.COLOR_TRANSPARENT);
    dc.clear();
    dc.setPenWidth(5);
    dc.drawCircle(screenHalf, screenHalf, screenHalf - 3);

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    dc.setPenWidth(1);

    if (progress < 360) {
      var anglerad = (progress * Math.PI) / 180;

      var arr = [[screenHalf, screenHalf]];
      var pos = [
        screenHalf + screenHalf * Math.sin(anglerad),
        screenHalf - screenHalf * Math.cos(anglerad),
      ];
      arr.add(pos);

      var start = Math.floor(anglerad / STEP).toNumber();

      for (var i = start; i < mCirclePoints.size(); i += 1) {
        arr.add(mCirclePoints[i]);
      }
      dc.fillPolygon(arr);
    }
  }

  function draw(dc as Dc, progress as Number) as Void {
    if (progress != mPrevProgress) {
      // }
      mPrevProgress = progress;
      // }
      drawInternal(dc, progress);
    }
    //dc.drawBitmap(0, 0, mOffBitmap);
  }
}
