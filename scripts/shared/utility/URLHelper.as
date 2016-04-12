package shared.utility
{
    import flash.external.*;

    public class URLHelper extends Object
    {

        public function URLHelper()
        {
            return;
        }// end function

        public static function s_GetBrowserCurrentBaseUrl() : String
        {
            var _loc_1:* = String(ExternalInterface.call(" function(){ return window.location.protocol + \"//\" + window.location.hostname + window.location.pathname;}"));
            return _loc_1;
        }// end function

        public static function s_GetBrowserCurrentUrl() : String
        {
            var _loc_1:* = String(ExternalInterface.call(" function(){ return window.location.href.toString();}"));
            return _loc_1;
        }// end function

        public static function s_NoCache(param1:String) : String
        {
            var _loc_2:* = "0123456789abcdef";
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < 32)
            {
                
                _loc_3 = _loc_3 + _loc_2.charAt(int(Math.random() * _loc_2.length));
                _loc_4++;
            }
            if (param1.indexOf("?") > 0)
            {
                return param1 + "&nocache=" + _loc_3;
            }
            return param1 + "?nocache=" + _loc_3;
        }// end function

        public static function s_GetBasename(param1:String) : String
        {
            var _loc_2:* = param1;
            if (_loc_2.charAt((_loc_2.length - 1)) == "/")
            {
                _loc_2 = _loc_2.substr(0, (_loc_2.length - 1));
            }
            var _loc_3:* = _loc_2.lastIndexOf("/");
            if (_loc_3 < 0)
            {
                throw new ArgumentError("URLHelpher.s_GetBaseName: No path delimiter found.");
            }
            return _loc_2.substr((_loc_3 + 1));
        }// end function

        public static function s_GetBrowserCurrentQuerystring() : String
        {
            var _loc_1:* = String(ExternalInterface.call(" function(){ return window.location.search.toString();}"));
            if (_loc_1.charAt(0) == "?")
            {
                _loc_1 = _loc_1.substr(1);
            }
            return _loc_1;
        }// end function

        public static function s_GetPath(param1:String) : String
        {
            var _loc_2:* = param1.lastIndexOf("/");
            if (_loc_2 < 0)
            {
                throw new ArgumentError("URLHelpher.s_GetPath: No path delimiter found.");
            }
            return param1.substr(0, _loc_2);
        }// end function

    }
}
