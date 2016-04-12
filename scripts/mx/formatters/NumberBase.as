package mx.formatters
{

    public class NumberBase extends Object
    {
        public var thousandsSeparatorTo:String;
        public var decimalSeparatorTo:String;
        public var isValid:Boolean = false;
        public var thousandsSeparatorFrom:String;
        public var decimalSeparatorFrom:String;
        static const VERSION:String = "3.6.0.21751";

        public function NumberBase(param1:String = ".", param2:String = ",", param3:String = ".", param4:String = ",")
        {
            this.decimalSeparatorFrom = param1;
            this.thousandsSeparatorFrom = param2;
            this.decimalSeparatorTo = param3;
            this.thousandsSeparatorTo = param4;
            isValid = true;
            return;
        }// end function

        public function formatThousands(param1:String) : String
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_2:* = Number(param1);
            var _loc_3:* = _loc_2 < 0;
            var _loc_4:* = Math.abs(_loc_2).toString();
            _loc_4.toLowerCase();
            var _loc_5:* = _loc_4.indexOf("e");
            if (_loc_4.indexOf("e") != -1)
            {
                _loc_4 = expandExponents(_loc_4);
            }
            var _loc_6:* = _loc_4.split(_loc_4.indexOf(decimalSeparatorTo) != -1 ? (decimalSeparatorTo) : ("."));
            var _loc_7:* = String(_loc_6[0]).length;
            if (String(_loc_6[0]).length > 3)
            {
                _loc_8 = int(Math.floor(_loc_7 / 3));
                if (_loc_7 % 3 == 0)
                {
                    _loc_8 = _loc_8 - 1;
                }
                _loc_9 = _loc_7;
                _loc_10 = _loc_9 - 3;
                _loc_11 = [];
                _loc_12 = 0;
                while (_loc_12 <= _loc_8)
                {
                    
                    _loc_11[_loc_12] = _loc_6[0].slice(_loc_10, _loc_9);
                    _loc_10 = int(Math.max(_loc_10 - 3, 0));
                    _loc_9 = int(Math.max(_loc_9 - 3, 1));
                    _loc_12++;
                }
                _loc_11.reverse();
                _loc_6[0] = _loc_11.join(thousandsSeparatorTo);
            }
            _loc_4 = _loc_6.join(decimalSeparatorTo);
            if (_loc_3)
            {
                _loc_4 = "-" + _loc_4;
            }
            return _loc_4.toString();
        }// end function

        public function formatDecimal(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            return _loc_2.join(decimalSeparatorTo);
        }// end function

        public function parseNumberString(param1:String) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_2:* = param1.split(decimalSeparatorFrom);
            if (_loc_2.length > 2)
            {
                return null;
            }
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            var _loc_7:* = false;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.charAt(_loc_4);
                _loc_4++;
                if (_loc_5 >= "0" && _loc_5 <= "9" || _loc_5 == decimalSeparatorFrom)
                {
                    _loc_8 = param1.charAt(_loc_4 - 2);
                    if (_loc_8 == "-" || param1.charAt(0) == "-")
                    {
                        _loc_7 = true;
                    }
                    _loc_6 = "";
                    _loc_9 = _loc_4 - 1;
                    while (_loc_9 < _loc_3)
                    {
                        
                        _loc_5 = param1.charAt(--_loc_4);
                        _loc_4++;
                        if (_loc_5 >= "0" && _loc_5 <= "9")
                        {
                            _loc_6 = _loc_6 + _loc_5;
                        }
                        else if (_loc_5 == decimalSeparatorFrom)
                        {
                            _loc_6 = _loc_6 + ".";
                        }
                        else if (_loc_5 != thousandsSeparatorFrom || _loc_4 >= _loc_3)
                        {
                            break;
                        }
                        _loc_9++;
                    }
                }
            }
            if (_loc_6 != null && param1 != "")
            {
                _loc_10 = Number(_loc_6);
                if (_loc_10 == 0)
                {
                    return "0";
                }
            }
            if (_loc_6)
            {
                if (_loc_6.charAt((_loc_6.length - 1)) == ".")
                {
                    if (_loc_6.length >= 2)
                    {
                        _loc_6 = _loc_6.substring(0, (_loc_6.length - 1));
                    }
                    else if (_loc_6.length == 1)
                    {
                        _loc_6 = "";
                        _loc_7 = false;
                    }
                }
            }
            return _loc_7 ? ("-" + _loc_6) : (_loc_6);
        }// end function

        public function formatPrecision(param1:String, param2:int) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param2 == -1)
            {
                return param1;
            }
            var _loc_3:* = param1.split(decimalSeparatorTo);
            _loc_3[0] = _loc_3[0].length == 0 ? ("0") : (_loc_3[0]);
            if (param2 > 0)
            {
                _loc_4 = _loc_3[1] ? (String(_loc_3[1])) : ("");
                _loc_5 = _loc_4 + "000000000000000000000000000000000";
                param1 = _loc_3[0] + decimalSeparatorTo + _loc_5.substr(0, param2);
            }
            else
            {
                param1 = String(_loc_3[0]);
            }
            return param1.toString();
        }// end function

        public function expandExponents(param1:String) : String
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_2:* = /^([+-])?(\d+).?(\d*)[eE]([-+]?\d+)$/;
            var _loc_3:* = _loc_2.exec(param1);
            var _loc_4:* = _loc_3[1];
            var _loc_5:* = _loc_3[2];
            var _loc_6:* = _loc_3[3];
            var _loc_7:* = int(_loc_3[4]);
            if (!int(_loc_3[4]))
            {
                return (_loc_4 ? (_loc_4) : ("")) + (_loc_5 ? (_loc_5) : ("0")) + (_loc_6 ? ("." + _loc_6) : (""));
            }
            var _loc_8:* = _loc_5 + _loc_6;
            var _loc_9:* = _loc_7 < 0;
            if (_loc_7 < 0)
            {
                _loc_10 = -1 * (_loc_5.length + _loc_7) + 1;
                return (_loc_4 ? (_loc_4) : ("")) + "0." + new Array(_loc_10).join("0") + _loc_8;
            }
            else
            {
                _loc_11 = _loc_7 + _loc_5.length;
                if (_loc_11 >= _loc_8.length)
                {
                    return (_loc_4 ? (_loc_4) : ("")) + _loc_8 + new Array(_loc_11 - _loc_8.length + 1).join("0");
                }
                else
                {
                }
                return (_loc_4 ? (_loc_4) : ("")) + _loc_8.substr(0, _loc_11) + "." + _loc_8.substr(_loc_11);
            }
        }// end function

        public function formatRounding(param1:String, param2:String) : String
        {
            var _loc_3:* = Number(param1);
            if (param2 != NumberBaseRoundType.NONE)
            {
                if (param2 == NumberBaseRoundType.UP)
                {
                    _loc_3 = Math.ceil(_loc_3);
                }
                else if (param2 == NumberBaseRoundType.DOWN)
                {
                    _loc_3 = Math.floor(_loc_3);
                }
                else if (param2 == NumberBaseRoundType.NEAREST)
                {
                    _loc_3 = Math.round(_loc_3);
                }
                else
                {
                    isValid = false;
                    return "";
                }
            }
            return _loc_3.toString();
        }// end function

        public function formatNegative(param1:String, param2:Boolean) : String
        {
            if (param2)
            {
                if (param1.charAt(0) != "-")
                {
                    param1 = "-" + param1;
                }
            }
            else if (!param2)
            {
                if (param1.charAt(0) == "-")
                {
                    param1 = param1.substr(1, (param1.length - 1));
                }
                param1 = "(" + param1 + ")";
            }
            else
            {
                isValid = false;
                return "";
            }
            return param1;
        }// end function

        public function formatRoundingWithPrecision(param1:String, param2:String, param3:int) : String
        {
            var _loc_4:* = Number(param1);
            if (param2 == NumberBaseRoundType.NONE)
            {
                if (param3 == -1)
                {
                    return _loc_4.toString();
                }
            }
            else
            {
                if (param3 < 0)
                {
                    param3 = 0;
                }
                _loc_4 = _loc_4 * Math.pow(10, param3);
                _loc_4 = Number(_loc_4.toString());
                if (param2 == NumberBaseRoundType.UP)
                {
                    _loc_4 = Math.ceil(_loc_4);
                }
                else if (param2 == NumberBaseRoundType.DOWN)
                {
                    _loc_4 = Math.floor(_loc_4);
                }
                else if (param2 == NumberBaseRoundType.NEAREST)
                {
                    _loc_4 = Math.round(_loc_4);
                }
                else
                {
                    isValid = false;
                    return "";
                }
                _loc_4 = _loc_4 / Math.pow(10, param3);
            }
            return _loc_4.toString();
        }// end function

    }
}
