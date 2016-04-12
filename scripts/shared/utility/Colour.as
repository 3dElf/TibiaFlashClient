package shared.utility
{

    public class Colour extends Object
    {
        protected var m_Blue:uint = 0;
        protected var m_Green:uint = 0;
        protected var m_Red:uint = 0;
        protected var m_Alpha:uint = 0;
        private static const s_TempColor:Colour = new Colour(0, 0, 0);
        public static const HSI_SI_VALUES:int = 7;
        public static const HSI_H_STEPS:int = 19;

        public function Colour(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 255)
        {
            this.red = param1;
            this.green = param2;
            this.blue = param3;
            this.alpha = param4;
            return;
        }// end function

        public function set alphaFloat(param1:Number) : void
        {
            if (param1 < 0 || param1 > 1)
            {
                throw new ArgumentError("Colour.set alphaFloat: Invalid value: " + param1);
            }
            this.m_Alpha = param1 * 255;
            return;
        }// end function

        public function get green() : uint
        {
            return this.m_Green & 255;
        }// end function

        public function set blueFloat(param1:Number) : void
        {
            if (param1 < 0 || param1 > 1)
            {
                throw new ArgumentError("Colour.set blueFloat: Invalid value: " + param1);
            }
            this.m_Blue = param1 * 255;
            return;
        }// end function

        public function get eightBit() : uint
        {
            return this.red / 51 * 36 + this.green / 51 * 6 + this.blue / 51;
        }// end function

        public function set green(param1:uint) : void
        {
            if (param1 < 0 || param1 > 255)
            {
                throw new ArgumentError("Colour.set green: Invalid value: " + param1);
            }
            this.m_Green = param1;
            return;
        }// end function

        public function div(param1:int, param2:Boolean = true) : Colour
        {
            if (param1 == 0)
            {
                throw new ArgumentError("Colour.divide: Division by 0.");
            }
            var _loc_3:* = this.m_Red / param1;
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            if (_loc_3 > 255)
            {
                _loc_3 = 255;
            }
            var _loc_4:* = this.m_Green / param1;
            if (this.m_Green / param1 < 0)
            {
                _loc_4 = 0;
            }
            if (_loc_4 > 255)
            {
                _loc_4 = 255;
            }
            var _loc_5:* = this.m_Blue / param1;
            if (this.m_Blue / param1 < 0)
            {
                _loc_5 = 0;
            }
            if (_loc_5 > 255)
            {
                _loc_5 = 255;
            }
            var _loc_6:* = this.m_Alpha;
            if (param2)
            {
                _loc_6 = this.m_Alpha / param1;
                if (_loc_6 < 0)
                {
                    _loc_6 = 0;
                }
                if (_loc_6 > 255)
                {
                    _loc_6 = 255;
                }
            }
            return new Colour(_loc_3, _loc_4, _loc_5, _loc_6);
        }// end function

        public function get redFloat() : Number
        {
            return this.m_Red / 255;
        }// end function

        public function set brightness(param1:Number) : void
        {
            if (param1 < 0 || param1 > 1)
            {
                throw new ArgumentError("Colour.set alphaFloat: Invalid value: " + param1);
            }
            var _loc_2:* = param1 * 255;
            this.setChannels(_loc_2, _loc_2, _loc_2);
            return;
        }// end function

        public function get red() : uint
        {
            return this.m_Red & 255;
        }// end function

        public function setChannels(param1:uint, param2:uint, param3:uint, param4:uint = 255, param5:Boolean = false) : void
        {
            if (param5)
            {
                this.ARGB = param4 << 24 | param1 << 16 | param2 << 8 | param3;
            }
            else
            {
                this.ARGB = this.clipChannel(param4) << 24 | this.clipChannel(param1) << 16 | this.clipChannel(param2) << 8 | this.clipChannel(param3);
            }
            return;
        }// end function

        public function get ARGB() : uint
        {
            return this.m_Alpha << 24 | this.m_Red << 16 | this.m_Green << 8 | this.m_Blue;
        }// end function

        public function set alpha(param1:uint) : void
        {
            if (param1 < 0 || param1 > 255)
            {
                throw new ArgumentError("Colour.set alpha: Invalid value: " + param1);
            }
            this.m_Alpha = param1;
            return;
        }// end function

        public function set redFloat(param1:Number) : void
        {
            if (param1 < 0 || param1 > 1)
            {
                throw new ArgumentError("Colour.set redFloat: Invalid value: " + param1);
            }
            this.m_Red = param1 * 255;
            return;
        }// end function

        public function get greenFloat() : Number
        {
            return this.m_Green / 255;
        }// end function

        public function get blue() : uint
        {
            return this.m_Blue & 255;
        }// end function

        public function mul(param1:int, param2:Boolean = true) : Colour
        {
            var _loc_3:* = new Colour(0, 0, 0);
            _loc_3.ARGB = this.ARGB;
            _loc_3.mulToSelf(param1, param2);
            return _loc_3;
        }// end function

        public function get alpha() : uint
        {
            return this.m_Alpha & 255;
        }// end function

        public function get brightness() : Number
        {
            return (this.m_Red + this.m_Green + this.m_Blue) / (3 * 255);
        }// end function

        public function add(param1:Colour, param2:Boolean = true) : Colour
        {
            var _loc_3:* = new Colour(0, 0, 0);
            _loc_3.ARGB = this.ARGB;
            _loc_3.addToSelf(param1, param2);
            return _loc_3;
        }// end function

        public function mulToSelf(param1:int, param2:Boolean = true) : void
        {
            var _loc_3:* = this.m_Red * param1;
            var _loc_4:* = this.m_Green * param1;
            var _loc_5:* = this.m_Blue * param1;
            var _loc_6:* = this.m_Alpha;
            if (param2)
            {
                _loc_6 = this.m_Alpha * param1;
            }
            this.setChannels(_loc_3, _loc_4, _loc_5, _loc_6, true);
            return;
        }// end function

        public function get alphaFloat() : Number
        {
            return this.m_Alpha / 255;
        }// end function

        public function addToSelf(param1:Colour, param2:Boolean = true) : void
        {
            var _loc_3:* = this.m_Red + param1.m_Red;
            var _loc_4:* = this.m_Green + param1.m_Green;
            var _loc_5:* = this.m_Blue + param1.m_Blue;
            var _loc_6:* = this.m_Alpha;
            if (param2)
            {
                _loc_6 = this.m_Alpha + param1.m_Alpha;
            }
            this.setChannels(_loc_3, _loc_4, _loc_5, _loc_6, true);
            return;
        }// end function

        public function set red(param1:uint) : void
        {
            if (param1 < 0 || param1 > 255)
            {
                throw new ArgumentError("Colour.set red: Invalid value: " + param1);
            }
            this.m_Red = param1;
            return;
        }// end function

        protected function clipChannel(param1:int) : uint
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > 255)
            {
                param1 = 255;
            }
            return param1;
        }// end function

        public function get RGB() : uint
        {
            return this.m_Red << 16 | this.m_Green << 8 | this.m_Blue;
        }// end function

        public function divFloat(param1:Number, param2:Boolean = true) : Colour
        {
            if (param1 == 0)
            {
                throw new ArgumentError("Colour.divideFloat: Invalid colour.");
            }
            var _loc_3:* = int(this.m_Red / param1 + 0.5);
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            if (_loc_3 > 255)
            {
                _loc_3 = 255;
            }
            var _loc_4:* = int(this.m_Green / param1 + 0.5);
            if (int(this.m_Green / param1 + 0.5) < 0)
            {
                _loc_4 = 0;
            }
            if (_loc_4 > 255)
            {
                _loc_4 = 255;
            }
            var _loc_5:* = int(this.m_Blue / param1 + 0.5);
            if (int(this.m_Blue / param1 + 0.5) < 0)
            {
                _loc_5 = 0;
            }
            if (_loc_5 > 255)
            {
                _loc_5 = 255;
            }
            var _loc_6:* = this.m_Alpha;
            if (param2)
            {
                _loc_6 = int(this.m_Alpha / param1 + 0.5);
                if (_loc_6 < 0)
                {
                    _loc_6 = 0;
                }
                if (_loc_6 > 255)
                {
                    _loc_6 = 255;
                }
            }
            return new Colour(_loc_3, _loc_4, _loc_5, _loc_6);
        }// end function

        public function get blueFloat() : Number
        {
            return this.m_Blue / 255;
        }// end function

        public function set greenFloat(param1:Number) : void
        {
            if (param1 < 0 || param1 > 1)
            {
                throw new ArgumentError("Colour.set greenFloat: Invalid value: " + param1);
            }
            this.m_Green = param1 * 255;
            return;
        }// end function

        public function set blue(param1:uint) : void
        {
            if (param1 < 0 || param1 > 255)
            {
                throw new ArgumentError("Colour.set blue: Invalid value: " + param1);
            }
            this.m_Blue = param1;
            return;
        }// end function

        public function set HSI(param1:int) : void
        {
            var _loc_8:* = 0;
            if (param1 >= HSI_H_STEPS * HSI_SI_VALUES)
            {
                param1 = 0;
            }
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param1 % HSI_H_STEPS == 0)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 1 - param1 / HSI_H_STEPS / HSI_SI_VALUES;
            }
            else
            {
                _loc_2 = param1 % HSI_H_STEPS * (1 / 18);
                _loc_3 = 1;
                _loc_4 = 1;
                switch(int(param1 / HSI_H_STEPS))
                {
                    case 0:
                    {
                        _loc_3 = 0.25;
                        _loc_4 = 1;
                        break;
                    }
                    case 1:
                    {
                        _loc_3 = 0.25;
                        _loc_4 = 0.75;
                        break;
                    }
                    case 2:
                    {
                        _loc_3 = 0.5;
                        _loc_4 = 0.75;
                        break;
                    }
                    case 3:
                    {
                        _loc_3 = 0.667;
                        _loc_4 = 0.75;
                        break;
                    }
                    case 4:
                    {
                        _loc_3 = 1;
                        _loc_4 = 1;
                        break;
                    }
                    case 5:
                    {
                        _loc_3 = 1;
                        _loc_4 = 0.75;
                        break;
                    }
                    case 6:
                    {
                        _loc_3 = 1;
                        _loc_4 = 0.5;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (_loc_4 == 0)
            {
                this.setChannels(0, 0, 0);
            }
            if (_loc_3 == 0)
            {
                _loc_8 = int(_loc_4 * 255);
                this.setChannels(_loc_8, _loc_8, _loc_8);
            }
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (_loc_2 < 1 / 6)
            {
                _loc_5 = _loc_4;
                _loc_7 = _loc_4 * (1 - _loc_3);
                _loc_6 = _loc_7 + (_loc_4 - _loc_7) * 6 * _loc_2;
            }
            else if (_loc_2 < 2 / 6)
            {
                _loc_6 = _loc_4;
                _loc_7 = _loc_4 * (1 - _loc_3);
                _loc_5 = _loc_6 - (_loc_4 - _loc_7) * (6 * _loc_2 - 1);
            }
            else if (_loc_2 < 3 / 6)
            {
                _loc_6 = _loc_4;
                _loc_5 = _loc_4 * (1 - _loc_3);
                _loc_7 = _loc_5 + (_loc_4 - _loc_5) * (6 * _loc_2 - 2);
            }
            else if (_loc_2 < 4 / 6)
            {
                _loc_7 = _loc_4;
                _loc_5 = _loc_4 * (1 - _loc_3);
                _loc_6 = _loc_7 - (_loc_4 - _loc_5) * (6 * _loc_2 - 3);
            }
            else if (_loc_2 < 5 / 6)
            {
                _loc_7 = _loc_4;
                _loc_6 = _loc_4 * (1 - _loc_3);
                _loc_5 = _loc_6 + (_loc_4 - _loc_6) * (6 * _loc_2 - 4);
            }
            else
            {
                _loc_5 = _loc_4;
                _loc_6 = _loc_4 * (1 - _loc_3);
                _loc_7 = _loc_5 - (_loc_4 - _loc_6) * (6 * _loc_2 - 5);
            }
            this.setChannels(int(_loc_5 * 255), int(_loc_6 * 255), int(_loc_7 * 255));
            return;
        }// end function

        public function mulFloat(param1:Number, param2:Boolean = true) : Colour
        {
            var _loc_3:* = new Colour(0, 0, 0);
            _loc_3.ARGB = this.ARGB;
            _loc_3.mulFloatToSelf(param1, param2);
            return _loc_3;
        }// end function

        public function set ARGB(param1:uint) : void
        {
            this.m_Alpha = param1 >> 24 & 255;
            this.m_Red = param1 >> 16 & 255;
            this.m_Green = param1 >> 8 & 255;
            this.m_Blue = param1 & 255;
            return;
        }// end function

        public function toString() : String
        {
            return (this.m_Red << 24 | this.m_Green << 16 | this.m_Blue << 8 | this.m_Alpha).toString();
        }// end function

        public function set eightBit(param1:uint) : void
        {
            if (param1 < 0 || param1 >= 216)
            {
                this.setChannels(0, 0, 0);
            }
            var _loc_2:* = int(param1 / 36) % 6 * 51;
            var _loc_3:* = int(param1 / 6) % 6 * 51;
            var _loc_4:* = param1 % 6 * 51;
            this.setChannels(_loc_2, _loc_3, _loc_4);
            return;
        }// end function

        public function mulFloatToSelf(param1:Number, param2:Boolean = true) : void
        {
            var _loc_3:* = this.clipChannel(int(this.m_Red * param1 + 0.5));
            var _loc_4:* = this.clipChannel(int(this.m_Green * param1 + 0.5));
            var _loc_5:* = this.clipChannel(int(this.m_Blue * param1 + 0.5));
            var _loc_6:* = this.m_Alpha;
            if (param2)
            {
                _loc_6 = this.clipChannel(int(this.m_Alpha * param1 + 0.5));
            }
            this.setChannels(_loc_3, _loc_4, _loc_5, _loc_6);
            return;
        }// end function

        public static function s_ARGBFromEightBit(param1:uint) : uint
        {
            s_TempColor.eightBit = param1;
            return s_TempColor.ARGB;
        }// end function

        public static function s_EightBitFromARGB(param1:uint) : uint
        {
            s_TempColor.ARGB = param1;
            return s_TempColor.eightBit;
        }// end function

        public static function s_FromHSI(param1:int) : Colour
        {
            var _loc_2:* = new Colour(0, 0, 0);
            _loc_2.HSI = param1;
            return _loc_2;
        }// end function

        public static function s_RGBFromEightBit(param1:uint) : uint
        {
            s_TempColor.eightBit = param1;
            return s_TempColor.RGB;
        }// end function

        public static function s_FromARGB(param1:uint) : Colour
        {
            var _loc_2:* = param1 >> 24 & 255;
            var _loc_3:* = param1 >> 16 & 255;
            var _loc_4:* = param1 >> 8 & 255;
            var _loc_5:* = param1 & 255;
            return new Colour(_loc_3, _loc_4, _loc_5, _loc_2);
        }// end function

        public static function s_FromEightBit(param1:int) : Colour
        {
            var _loc_2:* = new Colour(0, 0, 0);
            _loc_2.eightBit = param1;
            return _loc_2;
        }// end function

        public static function s_ARGBFromHSI(param1:int) : uint
        {
            s_TempColor.HSI = param1;
            return s_TempColor.ARGB;
        }// end function

    }
}
