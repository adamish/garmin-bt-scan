using Toybox.WatchUi;
using Toybox.System;

class KeyHandler extends WatchUi.BehaviorDelegate {
    hidden var scanner;
    hidden var view;

    function initialize(scanner, view) {
       BehaviorDelegate.initialize();
       self.scanner = scanner;
       self.view = view;
    }

    function onKey(keyEvent) {
        var key = keyEvent.getKey();
        System.println(key);
        if (key == KEY_ENTER) {
            if (scanner.isRunning()) {
                System.println("Stop");
                scanner.stop();
            } else {
                System.println("Start");
                scanner.start();
            }
        } else if (key == KEY_UP) {
            System.println("Up");
            view.previous();
        } else if (key == KEY_DOWN) {
            System.println("Down");
            view.previous();
        }
        return false;
    }

}