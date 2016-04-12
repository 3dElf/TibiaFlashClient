package shared.utility
{
    import flash.external.*;
    import flash.system.*;

    public class BrowserHelper extends Object
    {
        public static const INTERNETEXPLORER:int = 3;
        public static const UNKNOWN:int = 0;
        private static const USERAGENT_REGEXP:Array = [null, /^Mozilla\/[0-9]+.[0-9]+ .* Chrome\/([0-9]+)\.([0-9]+)\.([0-9]+).*$/, /^Mozilla\/[0-9]+.[0-9]+ .* Firefox\/([0-9]+)\.([0-9]+)\.([0-9]+).*$/, /^Mozilla\/[0-9]+.[0-9]+ \(compatible; MSIE ([0-9]+)\.([0-9]+);.*$/, /^Mozilla\/[0-9]+.[0-9]+ .* Safari\/([0-9]+)\.([0-9]+)\.([0-9]+)$/, /^Opera\/([0-9]+)\.([0-9]+) .*$/];
        public static const SAFARI:int = 4;
        public static const OPERA:int = 5;
        public static const FIREFOX:int = 2;
        public static const CHROME:int = 1;

        public function BrowserHelper()
        {
            return;
        }// end function

        public static function s_GetBrowserID() : int
        {
            if (!ExternalInterface.available)
            {
                return UNKNOWN;
            }
            var _loc_1:* = ExternalInterface.call("function () { return navigator.userAgent; }") as String;
            if (_loc_1 == null)
            {
                return UNKNOWN;
            }
            if (_loc_1.indexOf("Chrome") > -1)
            {
                return CHROME;
            }
            if (_loc_1.indexOf("Firefox") > -1)
            {
                return FIREFOX;
            }
            if (_loc_1.indexOf("MSIE") > -1)
            {
                return INTERNETEXPLORER;
            }
            if (_loc_1.indexOf("Safari") > -1)
            {
                return SAFARI;
            }
            if (_loc_1.indexOf("Opera") > -1)
            {
                return OPERA;
            }
            return UNKNOWN;
        }// end function

        public static function s_CompareBrowserVersion(param1:int = 0, param2:int = 0, param3:int = 0) : int
        {
            var _loc_5:* = null;
            if (!ExternalInterface.available)
            {
                return -1;
            }
            var _loc_4:* = s_GetBrowserID();
            if (s_GetBrowserID() == UNKNOWN)
            {
                return -1;
            }
            _loc_5 = ExternalInterface.call("function () { return navigator.userAgent; }") as String;
            var _loc_6:* = USERAGENT_REGEXP[_loc_4].exec(_loc_5);
            if (USERAGENT_REGEXP[_loc_4].exec(_loc_5) == null)
            {
                return -1;
            }
            var _loc_7:* = parseInt(_loc_6[1] as String);
            var _loc_8:* = parseInt(_loc_6[2] as String);
            var _loc_9:* = _loc_6.length == 4 ? (parseInt(_loc_6[3] as String)) : (0);
            if (isNaN(_loc_7) || _loc_7 < param1)
            {
                return -1;
            }
            if (_loc_7 > param1)
            {
                return 1;
            }
            if (isNaN(_loc_8) || _loc_8 < param2)
            {
                return -1;
            }
            if (_loc_8 > param2)
            {
                return 1;
            }
            if (isNaN(_loc_9) || _loc_9 < param3)
            {
                return -1;
            }
            if (_loc_9 > param3)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function s_CompareFlashPlayerVersion(param1:String) : Boolean
        {
            var _loc_2:* = Capabilities.version;
            return _loc_2.indexOf(param1) > -1;
        }// end function

        public static function s_GetBrowserString() : String
        {
            var _loc_1:* = null;
            if (ExternalInterface.available)
            {
                _loc_1 = ExternalInterface.call("function () { return navigator.userAgent; }") as String;
            }
            return _loc_1;
        }// end function

    }
}
