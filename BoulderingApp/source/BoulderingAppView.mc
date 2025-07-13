import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
import Toybox.System;
import Toybox.Lang;
import Toybox.Sensor;

class BoulderingAppView extends WatchUi.View {

    private var _session as Session?;

    function initialize() {
        View.initialize();
        // SENSOR_PULSE_OXIMETRY = oxygen saturation
        //    https://www.garmin.com/en-US/garmin-technology/health-science/pulse-ox/
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE/*, Sensor.SENSOR_PULSE_OXIMETRY, Sensor.SENSOR_TEMPERATURE*/]);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout  (default app template) ...
        //View.onUpdate(dc);

        // ... but call custom logic to draw custom stuff
        // Set background color
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(dc.getWidth() / 2, 0, Graphics.FONT_XTINY, "M:" + System.getSystemStats().usedMemory, Graphics.TEXT_JUSTIFY_CENTER);

        if (Toybox has :ActivityRecording) {
            // Draw the instructions
            if (!isSessionRecording()) {
                dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_MEDIUM, "Press Menu to\nStart Recording", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            } else {
                var x = dc.getWidth() / 2;
                var y = dc.getFontHeight(Graphics.FONT_XTINY);
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
                dc.drawText(x, y, Graphics.FONT_MEDIUM, "Recording...", Graphics.TEXT_JUSTIFY_CENTER);
                y += dc.getFontHeight(Graphics.FONT_MEDIUM);
                dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
                dc.drawText(x, y, Graphics.FONT_MEDIUM, "Press Menu again\nto Stop and Save\nthe Recording", Graphics.TEXT_JUSTIFY_CENTER);
            }
        } else {
            // tell the user this sample doesn't work
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
            dc.drawText(dc.getWidth() / 2, dc.getWidth() / 2, Graphics.FONT_MEDIUM, "This product doesn't\nhave FIT Support", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    // ---
    // Custom functionality for this app
    // 

    //! Stop the recording if necessary
    public function stopRecording() as Void {
        var session = _session;
        if ((Toybox has :ActivityRecording) && isSessionRecording() && (session != null)) {
            session.stop();
            session.save();
            _session = null;
            WatchUi.requestUpdate();
        }
    }

    //! Start recording a session
    public function startRecording() as Void {
        _session = ActivityRecording.createSession({:name=>"Walk", :sport=>Activity.SPORT_WALKING});
        _session.start();
        WatchUi.requestUpdate();
    }

    //! Get whether a session is currently recording
    //! @return true if there is a session currently recording, false otherwise
    public function isSessionRecording() as Boolean {
        if (_session != null) {
            return _session.isRecording();
        }
        return false;
    }
}
