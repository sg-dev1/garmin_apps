import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class BoulderingAppApp extends Application.AppBase {

    private var _boulderingAppView as BoulderingAppView?;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        _boulderingAppView = new BoulderingAppView();
        return [ _boulderingAppView, new BoulderingAppDelegate(_boulderingAppView) ];
    }

}

function getApp() as BoulderingAppApp {
    return Application.getApp() as BoulderingAppApp;
}