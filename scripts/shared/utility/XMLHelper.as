package shared.utility
{

    public class XMLHelper extends Object
    {

        public function XMLHelper()
        {
            return;
        }// end function

        public static function s_UnmarshallInteger(param1:XML) : Number
        {
            if (param1.hasComplexContent())
            {
                throw new ArgumentError("XMLHelper.s_UnmarshallInteger(): Invalid element.");
            }
            var _loc_2:* = param1.text();
            var _loc_3:* = _loc_2.length();
            if (_loc_3 == 0)
            {
                return 0;
            }
            return parseInt(_loc_2[0].toString());
        }// end function

        public static function s_UnmarshallString(param1:XML) : String
        {
            if (param1.hasComplexContent())
            {
                throw new ArgumentError("XMLHelper.s_UnmarshallString(): Invalid element.");
            }
            var _loc_2:* = param1.text();
            var _loc_3:* = _loc_2.length();
            if (_loc_3 == 0)
            {
                return "";
            }
            return _loc_2[0].toString();
        }// end function

        public static function s_UnmarshallBoolean(param1:XML) : Boolean
        {
            var _loc_4:* = null;
            if (param1.hasComplexContent())
            {
                throw new ArgumentError("XMLHelper.s_UnmarshallDecimal(): Invalid element.");
            }
            var _loc_2:* = param1.text();
            var _loc_3:* = _loc_2.length();
            if (_loc_3 == 0)
            {
                return false;
            }
            _loc_4 = _loc_2[0].toString();
            return _loc_4 == "true" || parseInt(_loc_4) == 1;
        }// end function

        public static function s_UnmarshallDecimal(param1:XML) : Number
        {
            if (param1.hasComplexContent())
            {
                throw new ArgumentError("XMLHelper.s_UnmarshallDecimal(): Invalid element.");
            }
            var _loc_2:* = param1.text();
            var _loc_3:* = _loc_2.length();
            if (_loc_3 == 0)
            {
                return 0;
            }
            return Number(_loc_2[0].toString());
        }// end function

    }
}
