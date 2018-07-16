using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

class TheGoodPlaceView extends WatchUi.WatchFace {

	var mountainBitmap = null;
	var sunBitmap = null;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	mountainBitmap = loadResource(Rez.Drawables.MountainIcon);
        sunBitmap = loadResource(Rez.Drawables.SunIcon);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var hour = clockTime.hour % 12;
        if (hour == 0) {
        	hour = 12;
        }
        var timeString = Lang.format("$1$:$2$", [hour, clockTime.min]);
        
        // clear background , check if this is even necessary 
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        // draw background color 
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        dc.fillCircle(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2);
        // draw sun 
        dc.drawBitmap(0, 0, sunBitmap);
        // mask for the time 
        var degreeOffset = (60 - clockTime.min) * 6; // every minute = 6 degrees around circle
        var startDegree = 90;
        var endDegree = startDegree + degreeOffset;
        if (endDegree > 360) {
        	endDegree = endDegree - 360; 
        }
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
        dc.setPenWidth(dc.getWidth());
        // draw mask
        dc.drawArc(dc.getWidth() / 2, dc.getHeight() / 2, dc.getWidth() / 2, 0, startDegree, endDegree); 
        // draw mountain
        dc.drawBitmap(dc.getWidth() / 4, dc.getHeight() / 4, mountainBitmap);
        // draw hour
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SYSTEM_LARGE, timeString, Graphics.TEXT_JUSTIFY_CENTER); 
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
