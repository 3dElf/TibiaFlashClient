package shared.cryptography
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class BigInt extends Object
    {
        private var m_Digits:Vector.<uint>;
        private var m_Positive:Boolean = true;

        public function BigInt(param1:uint = 0)
        {
            this.m_Digits = new Vector.<uint>;
            this.m_Digits[0] = param1;
            this.m_Positive = true;
            return;
        }// end function

        public function sub(param1:BigInt) : BigInt
        {
            var _loc_2:* = this.clone();
            s_ImplSub(_loc_2, param1, false);
            return _loc_2;
        }// end function

        public function mod(param1:BigInt) : BigInt
        {
            var _loc_2:* = new BigInt();
            s_ImplDiv(this, param1, null, _loc_2);
            return _loc_2;
        }// end function

        public function compareAbsolute(param1:BigInt) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_2:* = this.m_Digits.length;
            var _loc_3:* = param1.m_Digits.length;
            if (_loc_2 > _loc_3)
            {
                return 1;
            }
            if (_loc_2 < _loc_3)
            {
                return -1;
            }
            _loc_4 = _loc_2 - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_5 = this.m_Digits[_loc_4];
                _loc_6 = param1.m_Digits[_loc_4];
                if (_loc_5 > _loc_6)
                {
                    return 1;
                }
                if (_loc_5 < _loc_6)
                {
                    return -1;
                }
                _loc_4 = _loc_4 - 1;
            }
            return 0;
        }// end function

        public function mul(param1:BigInt) : BigInt
        {
            var _loc_2:* = this.clone();
            s_ImplMul(_loc_2, param1);
            return _loc_2;
        }// end function

        private function normalize() : void
        {
            var _loc_1:* = this.m_Digits.length;
            while (_loc_1 > 1 && this.m_Digits[(_loc_1 - 1)] == 0)
            {
                
                _loc_1 = _loc_1 - 1;
            }
            this.m_Digits.length = _loc_1;
            if (_loc_1 == 1 && this.m_Digits[0] == 0)
            {
                this.m_Positive = true;
            }
            return;
        }// end function

        public function div(param1:BigInt) : BigInt
        {
            var _loc_2:* = new BigInt();
            s_ImplDiv(this, param1, _loc_2, null);
            return _loc_2;
        }// end function

        public function get bitLength() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = this.m_Digits[(this.m_Digits.length - 1)];
            var _loc_3:* = 32;
            while (_loc_3 > 0)
            {
                
                if ((_loc_2 & 2147483648) != 0)
                {
                    _loc_1 = _loc_3;
                    break;
                }
                _loc_2 = _loc_2 << 1;
                _loc_3 = _loc_3 - 1;
            }
            _loc_1 = _loc_1 + ((this.m_Digits.length - 1) << 5);
            return _loc_1;
        }// end function

        private function testBit(param1:uint) : Boolean
        {
            var _loc_2:* = param1 >>> 5;
            if (_loc_2 < this.m_Digits.length)
            {
                return (this.m_Digits[_loc_2] & 1 << (param1 & 31)) != 0;
            }
            return false;
        }// end function

        public function clone() : BigInt
        {
            var _loc_1:* = new BigInt();
            _loc_1.assign(this);
            return _loc_1;
        }// end function

        public function add(param1:BigInt) : BigInt
        {
            var _loc_2:* = this.clone();
            s_ImplAdd(_loc_2, param1, false);
            return _loc_2;
        }// end function

        public function compare(param1:BigInt) : int
        {
            if (this.m_Positive && !param1.m_Positive)
            {
                return 1;
            }
            if (!this.m_Positive && param1.m_Positive)
            {
                return -1;
            }
            if (this.m_Positive)
            {
                return 1 * this.compareAbsolute(param1);
            }
            return -1 * this.compareAbsolute(param1);
        }// end function

        private function shiftLeft(param1:uint, param2:uint) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 > 31)
            {
                throw new Error("BigInteger.shiftLeft: Shift distance is invalid.");
            }
            if (param1 > 0)
            {
                _loc_3 = 32 - param1;
                _loc_4 = param2;
                _loc_5 = 0;
                _loc_6 = this.m_Digits.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_5 = this.m_Digits[_loc_7] >>> _loc_3;
                    this.m_Digits[_loc_7] = this.m_Digits[_loc_7] << param1 | _loc_4;
                    _loc_4 = _loc_5;
                    _loc_7++;
                }
                this.m_Digits[++_loc_6] = _loc_4;
                if (_loc_6 > 1 && this.m_Digits[(_loc_6 - 1)] == 0)
                {
                    var _loc_9:* = this.m_Digits;
                    var _loc_10:* = _loc_9.length - 1;
                    _loc_9.length = _loc_10;
                    _loc_6 = _loc_6 - 1;
                }
                if (_loc_6 == 1 && _loc_9[0] == 0)
                {
                    this.m_Positive = true;
                }
            }
            return;
        }// end function

        public function setZero() : void
        {
            this.m_Digits[0] = 0;
            this.m_Digits.length = 1;
            this.m_Positive = true;
            return;
        }// end function

        public function toString(param1:int) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (param1 != 2 && param1 != 10 && param1 != 16)
            {
                throw new Error("BigInt.toString: Invalid base.");
            }
            var _loc_2:* = this.clone();
            var _loc_3:* = new Vector.<String>;
            if (param1 == 2)
            {
                while (true)
                {
                    
                    _loc_4 = _loc_2.shiftRight(1, 0) >>> 31;
                    _loc_3.push(_loc_4.toString());
                    if (_loc_2.isZero)
                    {
                        break;
                    }
                }
            }
            else if (param1 == 10)
            {
                _loc_5 = new BigInt(10);
                _loc_6 = new BigInt();
                while (true)
                {
                    
                    s_ImplDiv(_loc_2, _loc_5, _loc_2, _loc_6);
                    _loc_3.push(_loc_6.m_Digits[0].toString());
                    if (_loc_2.isZero)
                    {
                        break;
                    }
                }
            }
            else if (param1 == 16)
            {
                while (true)
                {
                    
                    _loc_7 = _loc_2.shiftRight(4, 0) >>> 28;
                    _loc_3.push(_loc_7.toString(16));
                    if (_loc_2.isZero)
                    {
                        break;
                    }
                }
            }
            if (!_loc_2.m_Positive)
            {
                _loc_3.push("-");
            }
            return _loc_3.reverse().join("");
        }// end function

        private function shiftLeftFar(param1:uint, param2:uint) : void
        {
            var _loc_3:* = param1 >>> 5;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this.m_Digits.splice(0, 0, param2);
                param2 = 0;
                _loc_4 = _loc_4 + 1;
            }
            this.shiftLeft(param1 & 31, param2);
            return;
        }// end function

        public function assign(param1:BigInt) : void
        {
            if (param1 == this)
            {
                return;
            }
            var _loc_2:* = param1.m_Digits.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.m_Digits[_loc_3] = param1.m_Digits[_loc_3];
                _loc_3 = _loc_3 + 1;
            }
            this.m_Digits.length = _loc_2;
            this.m_Positive = param1.m_Positive;
            this.normalize();
            return;
        }// end function

        public function get isZero() : Boolean
        {
            return this.m_Digits.length == 1 && this.m_Digits[0] == 0;
        }// end function

        public function toByteArray(param1:ByteArray, param2:int = -1, param3:int = -1) : uint
        {
            if (!this.m_Positive)
            {
                throw new Error("BigInt.toByteArray: Cannot write negative numbers.");
            }
            if (param2 > -1)
            {
                param1.position = param2;
            }
            if (param3 < 0)
            {
                param3 = (this.bitLength + 7) / 8;
            }
            var _loc_4:* = param3 - 1;
            while (_loc_4 >= 0)
            {
                
                param1.writeByte(this.getByte(_loc_4));
                _loc_4 = _loc_4 - 1;
            }
            return param3;
        }// end function

        private function shiftRight(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 > 0)
            {
                _loc_3 = 32 - param1;
                _loc_4 = param2;
                _loc_5 = 0;
                _loc_6 = this.m_Digits.length;
                _loc_7 = _loc_6 - 1;
                while (_loc_7 >= 0)
                {
                    
                    _loc_5 = this.m_Digits[_loc_7] << _loc_3;
                    this.m_Digits[_loc_7] = this.m_Digits[_loc_7] >>> param1 | _loc_4;
                    _loc_4 = _loc_5;
                    _loc_7 = _loc_7 - 1;
                }
                if (_loc_6 > 1 && this.m_Digits[(_loc_6 - 1)] == 0)
                {
                    var _loc_8:* = this.m_Digits;
                    var _loc_9:* = _loc_8.length - 1;
                    _loc_8.length = _loc_9;
                    _loc_6 = _loc_6 - 1;
                }
                if (_loc_6 == 1 && _loc_8[0] == 0)
                {
                    this.m_Positive = true;
                }
                return _loc_4;
            }
            else
            {
                return 0;
            }
        }// end function

        private function reserve(param1:uint) : void
        {
            var _loc_2:* = (param1 + 31) / 32;
            while (this.m_Digits.length < _loc_2)
            {
                
                this.m_Digits.push(0);
            }
            return;
        }// end function

        private function getByte(param1:uint) : uint
        {
            var _loc_2:* = param1 >>> 2;
            if (_loc_2 < this.m_Digits.length)
            {
                return 255 & this.m_Digits[_loc_2] >>> ((param1 & 3) << 3);
            }
            return 4294967040;
        }// end function

        static function s_ImplSub(param1:BigInt, param2:BigInt, param3:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            if (param3 || param1.m_Positive == param2.m_Positive)
            {
                _loc_4 = param1;
                _loc_5 = param2;
                _loc_6 = false;
                if (!param3 && _loc_4.compareAbsolute(param2) < 0)
                {
                    _loc_4 = _loc_5.clone();
                    _loc_5 = param1;
                    _loc_6 = true;
                }
                _loc_7 = _loc_4.m_Digits.length;
                _loc_8 = _loc_5.m_Digits.length;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_11 = 0;
                while (_loc_9 > 0 || _loc_11 < _loc_8)
                {
                    
                    _loc_12 = _loc_11 < _loc_7 ? (_loc_4.m_Digits[_loc_11]) : (0);
                    _loc_13 = _loc_11 < _loc_8 ? (_loc_5.m_Digits[_loc_11]) : (0);
                    _loc_10 = _loc_12 - _loc_9;
                    _loc_9 = 0;
                    if (_loc_10 > _loc_12)
                    {
                        _loc_9 = _loc_9 + 1;
                    }
                    if (_loc_13 > _loc_10)
                    {
                        _loc_9 = _loc_9 + 1;
                    }
                    _loc_4.m_Digits[++_loc_11] = _loc_10 - _loc_13;
                }
                _loc_5.assign(_loc_4);
                if (_loc_6)
                {
                    _loc_5.m_Positive = !_loc_5.m_Positive;
                }
                _loc_5.normalize();
            }
            else
            {
                s_ImplAdd(param1, param2, true);
            }
            return;
        }// end function

        static function s_ImplDiv(param1:BigInt, param2:BigInt, param3:BigInt, param4:BigInt) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param2.isZero)
            {
                throw new Error("BigInt.s_ImplDiv: Dividsion by zero.");
            }
            _loc_5 = param2.clone();
            _loc_6 = param1.clone();
            var _loc_7:* = _loc_6.bitLength - _loc_5.bitLength;
            if (_loc_6.bitLength - _loc_5.bitLength > 0)
            {
                _loc_5.shiftLeftFar(_loc_7, 0);
            }
            var _loc_8:* = 0;
            if (param3 != null)
            {
                param3.setZero();
                param3.m_Positive = param1.m_Positive && param2.m_Positive || !param1.m_Positive && !param2.m_Positive;
            }
            while (_loc_7 >= 0)
            {
                
                _loc_8 = 0;
                if (_loc_5.compareAbsolute(_loc_6) <= 0)
                {
                    s_ImplSub(_loc_6, _loc_5, true);
                    _loc_8 = 1;
                }
                if (param3 != null)
                {
                    param3.shiftLeft(1, _loc_8);
                }
                _loc_5.shiftRight(1, 0);
                _loc_7 = _loc_7 - 1;
            }
            if (param4 != null)
            {
                param4.assign(_loc_6);
            }
            if (param3 != null)
            {
                param3.normalize();
            }
            return;
        }// end function

        static function s_ImplModExp(param1:BigInt, param2:BigInt, param3:BigInt) : BigInt
        {
            var _loc_4:* = param1.clone();
            var _loc_5:* = param1.clone();
            var _loc_6:* = param2.bitLength - 1;
            while (_loc_6 > 0)
            {
                
                s_ImplMul(_loc_4, _loc_4);
                s_ImplDiv(_loc_4, param3, null, _loc_4);
                if (param2.testBit((_loc_6 - 1)))
                {
                    s_ImplMul(_loc_5, _loc_4);
                    s_ImplDiv(_loc_5, param3, null, _loc_5);
                }
                _loc_6 = _loc_6 - 1;
            }
            return _loc_5;
        }// end function

        static function s_ImplMul(param1:BigInt, param2:BigInt) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_3:* = param1.m_Digits.length;
            var _loc_4:* = param2.m_Digits.length;
            var _loc_5:* = new BigInt;
            _loc_5.reserve(param1.bitLength + param2.bitLength);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = param2.m_Digits[_loc_6] >>> 16;
                _loc_8 = param2.m_Digits[_loc_6] & 65535;
                if (_loc_7 == 0 && _loc_8 == 0)
                {
                }
                else
                {
                    _loc_9 = 0;
                    _loc_10 = 0;
                    _loc_11 = 0;
                    _loc_12 = 0;
                    _loc_13 = 0;
                    _loc_14 = 0;
                    while (_loc_14 < _loc_3)
                    {
                        
                        _loc_15 = param1.m_Digits[_loc_14] >>> 16;
                        _loc_16 = param1.m_Digits[_loc_14] & 65535;
                        _loc_10 = _loc_7 * _loc_15;
                        _loc_11 = _loc_8 * _loc_16;
                        if (_loc_9 > uint.MAX_VALUE - _loc_11)
                        {
                            _loc_10 = _loc_10 + 1;
                        }
                        _loc_11 = _loc_11 + _loc_9;
                        _loc_12 = _loc_7 * _loc_16;
                        _loc_10 = _loc_10 + (_loc_12 >>> 16);
                        _loc_12 = _loc_12 << 16;
                        if (_loc_12 > uint.MAX_VALUE - _loc_11)
                        {
                            _loc_10 = _loc_10 + 1;
                        }
                        _loc_11 = _loc_11 + _loc_12;
                        _loc_13 = _loc_8 * _loc_15;
                        _loc_10 = _loc_10 + (_loc_13 >>> 16);
                        _loc_13 = _loc_13 << 16;
                        if (_loc_13 > uint.MAX_VALUE - _loc_11)
                        {
                            _loc_10 = _loc_10 + 1;
                        }
                        _loc_11 = _loc_11 + _loc_13;
                        if (_loc_5.m_Digits[_loc_6 + _loc_14] > uint.MAX_VALUE - _loc_11)
                        {
                            _loc_10 = _loc_10 + 1;
                        }
                        _loc_5.m_Digits[_loc_6 + _loc_14] = _loc_5.m_Digits[_loc_6 + _loc_14] + _loc_11;
                        _loc_9 = _loc_10;
                        _loc_14 = _loc_14 + 1;
                    }
                    _loc_5.m_Digits[_loc_6 + _loc_3] = _loc_9;
                }
                _loc_6 = _loc_6 + 1;
            }
            param1.assign(_loc_5);
            param1.m_Positive = param1.m_Positive && param2.m_Positive || !param1.m_Positive && !param2.m_Positive;
            return;
        }// end function

        public static function s_FromByteArray(param1:ByteArray, param2:int = -1, param3:int = 2147483647) : BigInt
        {
            var _loc_4:* = new BigInt;
            if (param2 > -1)
            {
                param1.position = param2;
            }
            var _loc_5:* = 0;
            while (param1.bytesAvailable > 0 && _loc_5++ < param3)
            {
                
                _loc_4.shiftLeft(8, param1.readUnsignedByte());
            }
            _loc_4.normalize();
            return _loc_4;
        }// end function

        static function s_ImplAdd(param1:BigInt, param2:BigInt, param3:Boolean) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (param3 || param1.m_Positive == param2.m_Positive)
            {
                _loc_4 = param1.m_Digits.length;
                _loc_5 = param2.m_Digits.length;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = 0;
                while (_loc_6 > 0 || _loc_8 < _loc_5)
                {
                    
                    _loc_9 = _loc_8 < _loc_4 ? (param1.m_Digits[_loc_8]) : (0);
                    _loc_10 = _loc_8 < _loc_5 ? (param2.m_Digits[_loc_8]) : (0);
                    _loc_7 = _loc_9 + _loc_6;
                    _loc_6 = 0;
                    if (_loc_7 < _loc_9)
                    {
                        _loc_6 = _loc_6 + 1;
                    }
                    if (_loc_10 > uint.MAX_VALUE - _loc_7)
                    {
                        _loc_6 = _loc_6 + 1;
                    }
                    param1.m_Digits[++_loc_8] = _loc_7 + _loc_10;
                }
            }
            else if (param1.compareAbsolute(param2) >= 0)
            {
                s_ImplSub(param1, param2, true);
            }
            else
            {
                _loc_11 = param2.clone();
                s_ImplSub(_loc_11, param1, true);
                param1.assign(_loc_11);
            }
            return;
        }// end function

        public static function s_FromString(param1:String, param2:uint) : BigInt
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            param1 = param1.toLowerCase();
            if (param2 != 2 && param2 != 10 && param2 != 16)
            {
                throw new Error("BigInt.s_FromString: Invalid base.");
            }
            var _loc_3:* = new BigInt;
            var _loc_4:* = 0;
            if (param1.length > 0)
            {
                if (param1.substr(_loc_4, 1) == "-")
                {
                    _loc_3.m_Positive = false;
                    _loc_4 = _loc_4 + 1;
                }
            }
            if (param2 == 2)
            {
                while (_loc_4 < param1.length)
                {
                    
                    _loc_5 = parseInt(param1.substr(_loc_4, 1), 2);
                    _loc_3.shiftLeft(1, _loc_5);
                    _loc_4 = _loc_4 + 1;
                }
            }
            else if (param2 == 10)
            {
                _loc_6 = new BigInt(10);
                while (_loc_4 < param1.length)
                {
                    
                    _loc_7 = parseInt(param1.substr(_loc_4, 1), 10);
                    s_ImplMul(_loc_3, _loc_6);
                    s_ImplAdd(_loc_3, new BigInt(_loc_7), false);
                    _loc_4 = _loc_4 + 1;
                }
            }
            else if (param2 == 16)
            {
                while (_loc_4 < param1.length)
                {
                    
                    _loc_8 = parseInt(param1.substr(_loc_4, 1), 16);
                    _loc_3.shiftLeft(4, _loc_8);
                    _loc_4 = _loc_4 + 1;
                }
            }
            _loc_3.normalize();
            return _loc_3;
        }// end function

    }
}
