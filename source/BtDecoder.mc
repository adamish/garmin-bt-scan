class BtDecoder {
    static function detail(item) {
        System.println("name " + item.getDeviceName());
        System.println("rssi " + item.getRssi());
        System.println("appearance " + item.getAppearance());
        decode(item.getRawData());
        var serviceUuids = item.getServiceUuids();
        for (var serviceUuid = serviceUuids.next(); serviceUuid != null; serviceUuid = serviceUuids.next()) {
            System.println("service " + serviceUuid + " data " +
            item.getServiceData(serviceUuid));
        }
    }

    /**
    https://stackoverflow.com/questions/62102854/ble-advertising-rawdata-how-to-decode
    */
   static function decode(data) {
        var n = data.size();
        var i = 0;
        while (i < n) {
            var size = data[i];
            var type = data[i + 1];
            var content = data.slice(i + 2, i + size + 1);
            System.println("size " + size);
            System.println("type " + toType(type));
            System.println("content " + content);

            i = i + size + 1;
        }
    }

   static function pretty(data) {
        var n = data.size();
        var i = 0;
        var str = "";
        while (i < n) {
            var size = data[i];
            if (size < 0) {
               break;
            }
            var type = data[i + 1];
            var content = data.slice(i + 2, i + size + 1);
            str = str + type.format("%02X");
            str = str + ":";
            for (var k = 0; k < content.size(); k++) {
               str = str + content[k].format("%02X");
            }
            i = i + size + 1;
            str = str + ", ";
        }
        return str;
    }

    /**
    https://www.bluetooth.com/specifications/assigned-numbers/generic-access-profile/
    */
    function toType(type) {
        switch (type) {
            case 0x01:
            return "flags";
            case 0x02:
            return "incomplete list 16";
            case 0x03:
            return "complete list 16";
            case 0x04:
            return "incomplete list 32";
            case 0x05:
            return "complete list 32";
            case 0x06:
            return "incomplete list 128";
            case 0x07:
            return "complete list 128";
            case 0x08:
            return "short name";
            case 0x09:
            return "complete name";
            case 0x0A:
            return "tx power";
            case 0x0D:
            return "class";
            case 0x0E:
            return "Simple Pairing Hash C";
            case 0x0F:
               return "Simple Pairing Randomizer R";
            case 0x10:
            return "device ID";
            case 0x16:
            return "service data";
            default:
            return "?? " + type;
        }
    }
}