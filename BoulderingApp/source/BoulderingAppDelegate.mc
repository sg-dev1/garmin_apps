import Toybox.Lang;
import Toybox.WatchUi;

class BoulderingAppDelegate extends WatchUi.BehaviorDelegate {

    private var _view as BoulderingAppView;

    function initialize(view as BoulderingAppView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    /* This does not work on Garmin Fenix 7 Pro (at least not in simulator), therefore the solution with onKeyPressed ...
       The BoulderingAppMenuDelegate example from the app template I currently do not need at all.
    function onMenu() as Boolean {
        System.println("Handling on menu");
        WatchUi.pushView(new Rez.Menus.MainMenu(), new BoulderingAppMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
    */

    function onKeyPressed(keyEvent as KeyEvent) as Boolean {
        System.println(keyEvent.getKey());

        if (WatchUi.KEY_UP == keyEvent.getKey())
        {
            System.println("Menu behavior triggered");
            if (Toybox has :ActivityRecording) {
                if (!_view.isSessionRecording()) {
                    System.println("Start recording");
                    _view.startRecording();
                } else {
                    System.println("Stop Recording");
                    _view.stopRecording();
                }
            }
            return true;
        }

        return false;
    }

}