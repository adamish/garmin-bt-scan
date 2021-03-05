using Toybox.WatchUi;
using Toybox.BluetoothLowEnergy;

class watchapp1View extends WatchUi.View {
    hidden var myText;
    hidden var model;
    hidden var current = 0;

    function initialize(model) {
        View.initialize();
        self.model = model;
        model.setListener(self);

        myText = new WatchUi.TextArea({
            :text=>"Scanner",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SMALL,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :width=>160,
            :height=>160
        });
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        myText.draw(dc);
    }

    function onHide() {
    }

    function next() {
       self.current = (self.current + 1) % self.model.size();
       update();
    }

    function previous() {
       if (self.model.size() > 0) {
           if (self.current > 0) {
              self.current--;
           } else {
              self.current = self.model.size() - 1;
           }
       }
       update();
    }

    function update() {
        if (self.model.isScanning()) {
            myText.setText("Scanning...");
        } else if (self.model.size() > 0) {
            var n = self.current + 1;
            myText.setText(n + " of " + self.model.size() + "\n" + describe(self.model.get(self.current)));
        } else {
            myText.setText("No results");
        }
        WatchUi.requestUpdate();
    }

    function describe(item) {
        var str = "";
        if (item.getDeviceName() != null) {
            str += item.getDeviceName();
        } else {
            str += "no name";
        }
        str += ",rssi=" + item.getRssi() + "," + BtDecoder.pretty(item.getRawData());
        return str;
    }

    function onModelChange() {
        update();
    }
}
