package shared.cryptography
{
    import __AS3__.vec.*;
    import flash.crypto.*;
    import flash.utils.*;

    public class Random extends Object
    {
        private var m_StateA:uint = 0;
        private var m_StateB:uint = 0;
        private var m_StateC:uint = 0;
        private var m_StateM:Vector.<uint>;
        private var m_Output:Vector.<uint>;
        private var m_OutputPosition:uint = 256;
        private static var s_PoolWritePosition:uint = 0;
        private static const POOL_SIZE:int = 1024;
        private static var s_PoolReadPosition:uint = 0;
        private static var s_PoolData:Vector.<uint> = new Vector.<uint>(POOL_SIZE, true);
        private static const STATE_SIZE:int = 256;

        public function Random()
        {
            this.m_Output = new Vector.<uint>(STATE_SIZE, true);
            this.m_StateM = new Vector.<uint>(STATE_SIZE, true);
            this.randomInit();
            return;
        }// end function

        private function randomInit() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = new Vector.<uint>(8, true);
            _loc_1 = 0;
            while (_loc_1 < 8)
            {
                
                _loc_3[_loc_1] = 2654435769;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                s_Mix(_loc_3);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < STATE_SIZE)
            {
                
                _loc_2 = 0;
                while (_loc_2 < 8)
                {
                    
                    _loc_3[_loc_2] = _loc_3[_loc_2] + s_PoolGetUnsignedInt();
                    _loc_2++;
                }
                s_Mix(_loc_3);
                _loc_2 = 0;
                while (_loc_2 < 8)
                {
                    
                    this.m_StateM[_loc_1 + _loc_2] = _loc_3[_loc_2];
                    _loc_2++;
                }
                _loc_1 = _loc_1 + 8;
            }
            _loc_1 = 0;
            while (_loc_1 < STATE_SIZE)
            {
                
                _loc_2 = 0;
                while (_loc_2 < 8)
                {
                    
                    _loc_3[_loc_2] = _loc_3[_loc_2] + this.m_StateM[_loc_1 + _loc_2];
                    _loc_2++;
                }
                s_Mix(_loc_3);
                _loc_2 = 0;
                while (_loc_2 < 8)
                {
                    
                    this.m_StateM[_loc_1 + _loc_2] = _loc_3[_loc_2];
                    _loc_2++;
                }
                _loc_1 = _loc_1 + 8;
            }
            this.randomUpdate();
            return;
        }// end function

        private function randomUpdate() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            (this.m_StateC + 1);
            this.m_StateB = this.m_StateB + this.m_StateC;
            var _loc_1:* = 0;
            while (_loc_1 < STATE_SIZE)
            {
                
                switch(_loc_1 % 4)
                {
                    case 0:
                    {
                        this.m_StateA = this.m_StateA ^ this.m_StateA << 13;
                        break;
                    }
                    case 1:
                    {
                        this.m_StateA = this.m_StateA ^ this.m_StateA >>> 6;
                        break;
                    }
                    case 2:
                    {
                        this.m_StateA = this.m_StateA ^ this.m_StateA << 2;
                        break;
                    }
                    case 3:
                    {
                        this.m_StateA = this.m_StateA ^ this.m_StateA >>> 16;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2 = this.m_StateM[_loc_1];
                this.m_StateA = this.m_StateM[(_loc_1 + 128) % STATE_SIZE] + this.m_StateA;
                this.m_StateM[_loc_1] = this.m_StateM[(_loc_2 >>> 2) % STATE_SIZE] + this.m_StateA + this.m_StateB;
                _loc_3 = this.m_StateM[_loc_1];
                this.m_Output[_loc_1] = this.m_StateM[(_loc_3 >>> 10) % STATE_SIZE] + _loc_2;
                this.m_StateB = this.m_Output[_loc_1];
                _loc_1++;
            }
            this.m_OutputPosition = 0;
            return;
        }// end function

        public function getUnsignedInt() : uint
        {
            if (this.m_OutputPosition >= STATE_SIZE)
            {
                this.randomUpdate();
            }
            var _loc_1:* = this;
            _loc_1.m_OutputPosition = this.m_OutputPosition + 1;
            return this.m_Output[this.m_OutputPosition++];
        }// end function

        public function getBytes(param1:ByteArray, param2:uint) : void
        {
            var _loc_6:* = 0;
            var _loc_3:* = param2 >>> 2;
            var _loc_4:* = param2 % 4;
            var _loc_5:* = _loc_3;
            while (_loc_5 > 0)
            {
                
                if (this.m_OutputPosition >= STATE_SIZE)
                {
                    this.randomUpdate();
                }
                var _loc_7:* = this;
                _loc_7.m_OutputPosition = this.m_OutputPosition + 1;
                param1.writeUnsignedInt(this.m_Output[this.m_OutputPosition++]);
                _loc_5 = _loc_5 - 1;
            }
            if (_loc_4 > 0)
            {
                if (this.m_OutputPosition >= STATE_SIZE)
                {
                    this.randomUpdate();
                }
                var _loc_7:* = this;
                _loc_7.m_OutputPosition = this.m_OutputPosition + 1;
                _loc_6 = this.m_Output[this.m_OutputPosition++];
                switch(_loc_4)
                {
                    case 3:
                    {
                        param1.writeByte(_loc_6 & 65535);
                        _loc_6 = _loc_6 >>> 8;
                    }
                    case 2:
                    {
                        param1.writeByte(_loc_6 & 65535);
                        _loc_6 = _loc_6 >>> 8;
                    }
                    case 1:
                    {
                        param1.writeByte(_loc_6 & 65535);
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private static function s_PoolGetUnsignedInt() : uint
        {
            return s_PoolData[s_PoolReadPosition++ % POOL_SIZE];
        }// end function

        private static function s_Mix(param1:Vector.<uint>) : void
        {
            param1[0] = param1[0] ^ param1[1] << 11;
            param1[3] = param1[3] + param1[0];
            param1[1] = param1[1] + param1[2];
            param1[1] = param1[1] ^ param1[2] >>> 2;
            param1[4] = param1[4] + param1[1];
            param1[2] = param1[2] + param1[3];
            param1[2] = param1[2] ^ param1[3] << 8;
            param1[5] = param1[5] + param1[2];
            param1[3] = param1[3] + param1[4];
            param1[3] = param1[3] ^ param1[4] >>> 16;
            param1[6] = param1[6] + param1[3];
            param1[4] = param1[4] + param1[5];
            param1[4] = param1[4] ^ param1[5] << 10;
            param1[7] = param1[7] + param1[4];
            param1[5] = param1[5] + param1[6];
            param1[5] = param1[5] ^ param1[6] >>> 4;
            param1[0] = param1[0] + param1[5];
            param1[6] = param1[6] + param1[7];
            param1[6] = param1[6] ^ param1[7] << 8;
            param1[1] = param1[1] + param1[6];
            param1[7] = param1[7] + param1[0];
            param1[7] = param1[7] ^ param1[0] >>> 9;
            param1[2] = param1[2] + param1[7];
            param1[0] = param1[0] + param1[1];
            return;
        }// end function

        public static function s_PoolPutUnsignedInt(param1:uint) : void
        {
            s_PoolData[s_PoolWritePosition++ % POOL_SIZE] = param1;
            return;
        }// end function

        private static function s_PoolInitialize() : void
        {
            var i:int;
            var Buffer:ByteArray;
            i;
            i = (i + 1);
            var _loc_2:* = i;
            s_PoolData[_loc_2] = new Date().time;
            i = (i + 1);
            var _loc_3:* = i;
            s_PoolData[_loc_3] = getTimer();
            try
            {
                while (i < POOL_SIZE)
                {
                    
                    Buffer = generateRandomBytes(1024);
                    while (i < POOL_SIZE && Buffer.bytesAvailable >= 4)
                    {
                        
                        i = (i + 1);
                        var _loc_4:* = i;
                        s_PoolData[i] = Buffer.readUnsignedInt();
                    }
                }
            }
            catch (e)
            {
                while (i < POOL_SIZE)
                {
                    
                    i = (i + 1);
                    var _loc_5:* = i;
                    s_PoolData[i] = uint(Math.random());
                }
            }
            return;
        }// end function

        s_PoolInitialize();
    }
}
