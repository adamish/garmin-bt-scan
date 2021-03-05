using Toybox.Timer;

class Scanner extends Toybox.BluetoothLowEnergy.BleDelegate {
    hidden var running;
    hidden var model;
    /**
     * All Bluetooth SIG defined UUIDs use a common base UUID, and more specifically the following one:
    0x0000xxxx-0000-1000-8000-00805F9B34FB

    https://www.oreilly.com/library/view/getting-started-with/9781491900550/ch04.html
    The UUID for any CCCD is always the standard 16-bit UUIDCCCD (0x2902).

    http://www.davidgyoungtech.com/2020/04/24/hacking-with-contact-tracing-beacons

    https://btprodspecificationrefs.blob.core.windows.net/assigned-values/16-bit%20UUID%20Numbers%20Document.pdf
    */

    var profile = {
        :uuid => BluetoothLowEnergy.stringToUuid("000018fe-1212-efde-1523-785feabcd123"),
        :characteristics => [ {
            :uuid => BluetoothLowEnergy.cccdUuid()} ]
        };
    function initialize(model) {
        BleDelegate.initialize();
        BluetoothLowEnergy.setDelegate(self);
        BluetoothLowEnergy.registerProfile(profile);
        running = false;
        self.model = model;
    }

    function onScanResults(scanResults) {
        System.println("Results received");
        var i = 0;
        for (var item = scanResults.next(); item != null; item = scanResults.next()) {
            model.add(item);
            i++;
        }
    }

    function onScanStateChange(scanState, status) {
    }

    function start() {
       System.println("start");
       model.reset();
       BluetoothLowEnergy.setScanState(BluetoothLowEnergy.SCAN_STATE_SCANNING);
       running = true;
       model.setScanning(true);
       var myTimer = new Timer.Timer();
       myTimer.start(method(:stop), 5000, false);
    }

    function stop() {
        System.println("stop");
        model.setScanning(false);
        BluetoothLowEnergy.setScanState(BluetoothLowEnergy.SCAN_STATE_OFF);
        running = false;
    }

    function isRunning() {
       return running;
    }
}