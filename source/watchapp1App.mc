using Toybox.Application;
using Toybox.WatchUi;
using Toybox.BluetoothLowEnergy;
class watchapp1App extends Application.AppBase {

    hidden var scanner;
    hidden var model;

    function initialize() {
        AppBase.initialize();
        model = new ResultsModel();
        scanner = new Scanner(model);
        model.add(new ScanResultMock("foo", 123));
        model.add(new ScanResultMock("bar", 44));
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        var view = new watchapp1View(model);
        return [ view, new KeyHandler(scanner, view) ];
    }

}
