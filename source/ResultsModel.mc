class ResultsModel {
    hidden var data;
    hidden var scanning;
    hidden var listener;

    function initialize() {
        self.data = new [0];
    }

    function reset() {
        self.data = new [0];
    }

    function size() {
        return self.data.size();
    }

    function get(i) {
        return data[i];
    }

    function add(result) {
       var contains = false;
       for (var i = 0; i < data.size(); i++) {
          if (data[i].isSameDevice(result)) {
              contains = true;
              break;
          }
       }
       if (!contains) {
           self.data.add(result);
       }
    }

    function setListener(listener) {
        self.listener = listener;
    }

    function setScanning(scanning) {
        self.scanning = scanning;
        self.listener.onModelChange();
    }
    function isScanning() {
        return self.scanning;
    }
}

class ScanResultMock {
    hidden var deviceName;
    hidden var rssi;
    function initialize(deviceName, rssi) {
        self.deviceName = deviceName;
        self.rssi = rssi;
    }
    function isSameDevice(other) {
       return false;
    }
    function getRssi() {
       return rssi;
    }
    function getDeviceName() {
       return deviceName;
    }
    function getRawData() {
        return [2, 1, 26, 2, 8, 0, 3, 3, 97, 254, 16, 255, 3, 0, 0, 96, 39, 0, 0, 8, 124, 217, 92, 171, 208, 245, 50];
    }
}
