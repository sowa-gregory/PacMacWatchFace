import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Math;

class PacManView extends WatchUi.WatchFace {
  var lowPower = false;
  function initialize() {
    WatchFace.initialize();

    System.println("init test");
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
    Weather.loadRes();
    Calories.loadRes();
    Distance.loadRes();
    StepsProgress.loadRes();
  }

  function timerCallback() as Void {
    WatchUi.requestUpdate();
  }
  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    // animTimer.start(method(:timerCallback), 100, true);
  }

  var px = 0;
  function onUpdate(dc as Dc) as Void {
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

    dc.clear();

    StepsProgress.draw(dc);
    BinaryClock.draw(dc, lowPower);
    Weather.draw(dc);
    Calories.draw(dc);
    Distance.draw(dc);

    dc.setPenWidth(3);
    dc.drawCircle(104, 104, 68);

    dc.setPenWidth(1);
    px++;
    // drawWatchInfo(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {
    lowPower=false;
  }

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {
    lowPower=true;
    WatchUi.requestUpdate();
  }

  /*
  function onPartialUpdate(dc) {
    BinaryClock.draw(dc);
  }
  */
}
