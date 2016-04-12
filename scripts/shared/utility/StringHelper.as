package shared.utility
{
    import flash.utils.*;

    public class StringHelper extends Object
    {
        public static const STRING_SERIALISATION_CHARSET:String = "iso-8859-1";

        public function StringHelper()
        {
            return;
        }// end function

        public static function s_WriteToByteArray(param1:ByteArray, param2:String, param3:int = 2147483647) : void
        {
            if (param2.length > param3)
            {
                throw new Error("StringHelper.s_WriteToByteArray: Invalid string: \"" + param2 + "\".");
            }
            var _loc_4:* = param2.length;
            if (param2.length > 65535)
            {
                param1.writeShort(65535);
                param1.writeInt(_loc_4);
            }
            else
            {
                param1.writeShort(_loc_4);
            }
            param1.writeMultiByte(param2, STRING_SERIALISATION_CHARSET);
            return;
        }// end function

        public static function s_StripTags(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/<[^>]*>/g, "");
            }
            return param1;
        }// end function

        public static function s_MillisecondsToTimeString(param1:uint, param2:Boolean = true) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = param1 / 1000;
            _loc_4 = _loc_3 / 60;
            var _loc_5:* = _loc_4 / 60;
            var _loc_6:* = "";
            _loc_6 = _loc_5 + ":" + s_PadWithChars(String(_loc_4 % 60), "00") + ":" + s_PadWithChars(String(_loc_3 % 60), "00");
            if (param2)
            {
                _loc_6 = _loc_6 + ("." + s_PadWithChars(String(param1 % 1000), "000"));
            }
            return _loc_6;
        }// end function

        public static function s_StripNewline(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/(\r\n|\n\r|\r)/g, "");
            }
            return param1;
        }// end function

        public static function s_TrimFront(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/^\s+/, "");
            }
            return param1;
        }// end function

        public static function s_RemoveHilight(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/[{}]/g, "");
            }
            return param1;
        }// end function

        public static function s_EqualsIgnoreCase(param1:String, param2:String) : Boolean
        {
            if (param1 == null || param2 == null)
            {
                return param1 == param2;
            }
            return param1.toUpperCase() == param2.toUpperCase();
        }// end function

        public static function s_Trim(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/(^\s+|\s+$)/g, "");
            }
            return param1;
        }// end function

        public static function s_HilightToHTML(param1:String, param2:uint) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1 != null)
            {
                _loc_3 = "";
                _loc_4 = /\{[^}]+\}(?:\s+\{[^}]+\})*/g;
                _loc_5 = 0;
                _loc_6 = null;
                do
                {
                    
                    _loc_7 = (_loc_6[0] as String).replace(/[{}]/g, "");
                    _loc_3 = _loc_3 + (param1.substring(_loc_5, _loc_6.index) + "<font color=\"#" + (param2 & 16777215).toString(16) + "\">" + "<a href=\"event:" + _loc_7 + "\">" + _loc_7 + "</a>" + "</font>");
                    _loc_5 = _loc_6.index + (_loc_6[0] as String).length;
                    var _loc_8:* = _loc_4.exec(param1);
                    _loc_6 = _loc_4.exec(param1);
                }while (_loc_8 != null)
                return _loc_3 + param1.substring(_loc_5);
            }
            else
            {
                return null;
            }
        }// end function

        public static function s_PadWithChars(param1:String, param2:String) : String
        {
            if (param1.length < param2.length)
            {
                param1 = param2.substring(0, param2.length - param1.length) + param1;
            }
            return param1;
        }// end function

        public static function s_ReadPositiveInt(param1:String, param2:int = -1, param3:int = -1) : int
        {
            var _loc_4:* = 0;
            if (param1 != null && param1.match(/^[0-9]+$/) != null)
            {
                _loc_4 = int(param1);
                if ((param2 == -1 || _loc_4 >= param2) && (param3 == -1 || _loc_4 <= param3))
                {
                    return _loc_4;
                }
            }
            return -1;
        }// end function

        public static function s_TrimBack(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/\s+$/, "");
            }
            return param1;
        }// end function

        public static function s_IsWhitsepace(param1:String) : Boolean
        {
            return param1.match(/^\s+$/) != null;
        }// end function

        public static function s_ReadLongStringFromByteArray(param1:ByteArray, param2:int = 2147483647) : String
        {
            if (param1.bytesAvailable < 2)
            {
                throw new Error("StringHelper.s_ReadLongStringFromByteArray: Not enough data(1).");
            }
            var _loc_3:* = param1.readUnsignedShort();
            if (param1.bytesAvailable < _loc_3)
            {
                throw new Error("StringHelper.s_ReadLongStringFromByteArray: Not enough data(2).");
            }
            var _loc_4:* = param1.readMultiByte(_loc_3, STRING_SERIALISATION_CHARSET);
            return _loc_4.substr(0, param2);
        }// end function

        public static function s_HTMLSpecialChars(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&apos;");
            }
            return param1;
        }// end function

        public static function s_ReadShortStringFromByteArray(param1:ByteArray, param2:uint = 255) : String
        {
            if (param1.bytesAvailable < 1)
            {
                throw new Error("StringHelper.s_ReadShortStringFromByteArray: Not enough data(1).");
            }
            var _loc_3:* = param1.readUnsignedByte();
            if (param1.bytesAvailable < _loc_3)
            {
                throw new Error("StringHelper.s_ReadShortStringFromByteArray: Not enough data(2).");
            }
            var _loc_4:* = param1.readMultiByte(_loc_3, STRING_SERIALISATION_CHARSET);
            return _loc_4.substr(0, param2);
        }// end function

        public static function s_CleanNewline(param1:String) : String
        {
            if (param1 != null)
            {
                param1 = param1.replace(/(\r\n|\n\r|\r)/g, "\n");
            }
            return param1;
        }// end function

        public static function s_Capitalise(param1:String) : String
        {
            var a_String:* = param1;
            var ToUpperCase:* = function () : String
            {
                return String(arguments[0]).toUpperCase();
            }// end function
            ;
            return a_String.replace(/\b(.)/g, ToUpperCase);
        }// end function

    }
}
