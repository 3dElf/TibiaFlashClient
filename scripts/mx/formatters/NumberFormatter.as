package mx.formatters
{

    public class NumberFormatter extends Formatter
    {
        private var roundingOverride:String;
        private var thousandsSeparatorFromOverride:String;
        private var _useNegativeSign:Object;
        private var decimalSeparatorFromOverride:String;
        private var _decimalSeparatorTo:String;
        private var useThousandsSeparatorOverride:Object;
        private var _thousandsSeparatorTo:String;
        private var useNegativeSignOverride:Object;
        private var thousandsSeparatorToOverride:String;
        private var decimalSeparatorToOverride:String;
        private var precisionOverride:Object;
        private var _rounding:String;
        private var _useThousandsSeparator:Object;
        private var _thousandsSeparatorFrom:String;
        private var _decimalSeparatorFrom:String;
        private var _precision:Object;
        static const VERSION:String = "3.6.0.21751";

        public function NumberFormatter()
        {
            return;
        }// end function

        public function set precision(param1:Object) : void
        {
            precisionOverride = param1;
            _precision = param1 != null ? (int(param1)) : (resourceManager.getInt("formatters", "numberFormatterPrecision"));
            return;
        }// end function

        public function get useNegativeSign() : Object
        {
            return _useNegativeSign;
        }// end function

        override protected function resourcesChanged() : void
        {
            super.resourcesChanged();
            decimalSeparatorFrom = decimalSeparatorFromOverride;
            decimalSeparatorTo = decimalSeparatorToOverride;
            precision = precisionOverride;
            rounding = roundingOverride;
            thousandsSeparatorFrom = thousandsSeparatorFromOverride;
            thousandsSeparatorTo = thousandsSeparatorToOverride;
            useNegativeSign = useNegativeSignOverride;
            useThousandsSeparator = useThousandsSeparatorOverride;
            return;
        }// end function

        public function get rounding() : String
        {
            return _rounding;
        }// end function

        public function set thousandsSeparatorTo(param1:String) : void
        {
            thousandsSeparatorToOverride = param1;
            _thousandsSeparatorTo = param1 != null ? (param1) : (resourceManager.getString("SharedResources", "thousandsSeparatorTo"));
            return;
        }// end function

        public function get thousandsSeparatorFrom() : String
        {
            return _thousandsSeparatorFrom;
        }// end function

        public function set decimalSeparatorTo(param1:String) : void
        {
            decimalSeparatorToOverride = param1;
            _decimalSeparatorTo = param1 != null ? (param1) : (resourceManager.getString("SharedResources", "decimalSeparatorTo"));
            return;
        }// end function

        public function set useNegativeSign(param1:Object) : void
        {
            useNegativeSignOverride = param1;
            _useNegativeSign = param1 != null ? (Boolean(param1)) : (resourceManager.getBoolean("formatters", "useNegativeSign"));
            return;
        }// end function

        override public function format(param1:Object) : String
        {
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            if (error)
            {
                error = null;
            }
            if (useThousandsSeparator && (decimalSeparatorFrom == thousandsSeparatorFrom || decimalSeparatorTo == thousandsSeparatorTo))
            {
                error = defaultInvalidFormatError;
                return "";
            }
            if (decimalSeparatorTo == "" || !isNaN(Number(decimalSeparatorTo)))
            {
                error = defaultInvalidFormatError;
                return "";
            }
            var _loc_2:* = new NumberBase(decimalSeparatorFrom, thousandsSeparatorFrom, decimalSeparatorTo, thousandsSeparatorTo);
            if (param1 is String)
            {
                param1 = _loc_2.parseNumberString(String(param1));
            }
            if (param1 === null || isNaN(Number(param1)))
            {
                error = defaultInvalidValueError;
                return "";
            }
            var _loc_3:* = Number(param1) < 0;
            var _loc_4:* = param1.toString();
            _loc_4.toLowerCase();
            var _loc_5:* = _loc_4.indexOf("e");
            if (_loc_4.indexOf("e") != -1)
            {
                _loc_4 = _loc_2.expandExponents(_loc_4);
            }
            var _loc_6:* = _loc_4.split(".");
            var _loc_7:* = _loc_6[1] ? (String(_loc_6[1]).length) : (0);
            if (precision <= _loc_7)
            {
                if (rounding != NumberBaseRoundType.NONE)
                {
                    _loc_4 = _loc_2.formatRoundingWithPrecision(_loc_4, rounding, int(precision));
                }
            }
            var _loc_8:* = Number(_loc_4);
            if (Math.abs(_loc_8) >= 1)
            {
                _loc_6 = _loc_4.split(".");
                _loc_9 = useThousandsSeparator ? (_loc_2.formatThousands(String(_loc_6[0]))) : (String(_loc_6[0]));
                if (_loc_6[1] != null && _loc_6[1] != "")
                {
                    _loc_4 = _loc_9 + decimalSeparatorTo + _loc_6[1];
                }
                else
                {
                    _loc_4 = _loc_9;
                }
            }
            else if (Math.abs(_loc_8) > 0)
            {
                if (_loc_4.indexOf("e") != -1)
                {
                    Math.abs(_loc_8) = (Math.abs(_loc_8) + 1);
                    _loc_4 = (Math.abs(_loc_8)).toString();
                }
                _loc_4 = decimalSeparatorTo + _loc_4.substring((_loc_4.indexOf(".") + 1));
            }
            _loc_4 = _loc_2.formatPrecision(_loc_4, int(precision));
            if (Number(_loc_4) == 0)
            {
                _loc_3 = false;
            }
            if (_loc_3)
            {
                _loc_4 = _loc_2.formatNegative(_loc_4, useNegativeSign);
            }
            if (!_loc_2.isValid)
            {
                error = defaultInvalidFormatError;
                return "";
            }
            return _loc_4;
        }// end function

        public function get decimalSeparatorFrom() : String
        {
            return _decimalSeparatorFrom;
        }// end function

        public function set rounding(param1:String) : void
        {
            roundingOverride = param1;
            _rounding = param1 != null ? (param1) : (resourceManager.getString("formatters", "rounding"));
            return;
        }// end function

        public function get thousandsSeparatorTo() : String
        {
            return _thousandsSeparatorTo;
        }// end function

        public function get decimalSeparatorTo() : String
        {
            return _decimalSeparatorTo;
        }// end function

        public function set thousandsSeparatorFrom(param1:String) : void
        {
            thousandsSeparatorFromOverride = param1;
            _thousandsSeparatorFrom = param1 != null ? (param1) : (resourceManager.getString("SharedResources", "thousandsSeparatorFrom"));
            return;
        }// end function

        public function set useThousandsSeparator(param1:Object) : void
        {
            useThousandsSeparatorOverride = param1;
            _useThousandsSeparator = param1 != null ? (Boolean(param1)) : (resourceManager.getBoolean("formatters", "useThousandsSeparator"));
            return;
        }// end function

        public function get useThousandsSeparator() : Object
        {
            return _useThousandsSeparator;
        }// end function

        public function set decimalSeparatorFrom(param1:String) : void
        {
            decimalSeparatorFromOverride = param1;
            _decimalSeparatorFrom = param1 != null ? (param1) : (resourceManager.getString("SharedResources", "decimalSeparatorFrom"));
            return;
        }// end function

        public function get precision() : Object
        {
            return _precision;
        }// end function

    }
}
