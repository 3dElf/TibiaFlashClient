package shared.cryptography
{
    import flash.utils.*;

    public class XTEA extends Object
    {
        private var m_Key:Array = null;
        private var m_PRNG:Random = null;
        private static const ROUNDS:uint = 32;
        private static const DELTA:uint = 2.65444e+009;
        public static const BLOCKSIZE:uint = 8;

        public function XTEA()
        {
            this.m_PRNG = new Random();
            this.generateKey();
            return;
        }// end function

        public function writeKey(param1:ByteArray) : void
        {
            param1.writeUnsignedInt(this.m_Key[0]);
            param1.writeUnsignedInt(this.m_Key[1]);
            param1.writeUnsignedInt(this.m_Key[2]);
            param1.writeUnsignedInt(this.m_Key[3]);
            return;
        }// end function

        public function encrypt(param1:ByteArray, param2:uint = 0, param3:uint = 2147483647) : uint
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            param3 = Math.min(param3, param1.length - param2);
            param1.position = param2 + param3;
            var _loc_4:* = Math.floor((param3 + BLOCKSIZE - 1) / BLOCKSIZE) * BLOCKSIZE;
            if (Math.floor((param3 + BLOCKSIZE - 1) / BLOCKSIZE) * BLOCKSIZE > param3)
            {
                this.m_PRNG.getBytes(param1, _loc_4 - param3);
                param3 = _loc_4;
            }
            var _loc_5:* = param2;
            while (_loc_5 < param2 + param3)
            {
                
                param1.position = _loc_5;
                _loc_6 = param1.readUnsignedInt();
                _loc_7 = param1.readUnsignedInt();
                _loc_8 = 0;
                _loc_9 = ROUNDS;
                while (_loc_9 > 0)
                {
                    
                    _loc_6 = _loc_6 + ((_loc_7 << 4 ^ _loc_7 >>> 5) + _loc_7 ^ _loc_8 + this.m_Key[_loc_8 & 3]);
                    _loc_8 = _loc_8 + DELTA;
                    _loc_7 = _loc_7 + ((_loc_6 << 4 ^ _loc_6 >>> 5) + _loc_6 ^ _loc_8 + this.m_Key[_loc_8 >>> 11 & 3]);
                    _loc_9 = _loc_9 - 1;
                }
                param1.position = param1.position - BLOCKSIZE;
                param1.writeUnsignedInt(_loc_6);
                param1.writeUnsignedInt(_loc_7);
                _loc_5 = _loc_5 + BLOCKSIZE;
            }
            return param3;
        }// end function

        public function generateKey() : void
        {
            this.m_Key = [this.m_PRNG.getUnsignedInt(), this.m_PRNG.getUnsignedInt(), this.m_PRNG.getUnsignedInt(), this.m_PRNG.getUnsignedInt()];
            return;
        }// end function

        public function decrypt(param1:ByteArray, param2:uint = 0, param3:uint = 2147483647) : uint
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            param3 = Math.min(param3, param1.length - param2);
            param3 = param3 - param3 % BLOCKSIZE;
            var _loc_4:* = param2;
            while (_loc_4 < param2 + param3)
            {
                
                param1.position = _loc_4;
                _loc_5 = param1.readUnsignedInt();
                _loc_6 = param1.readUnsignedInt();
                _loc_7 = DELTA * ROUNDS;
                _loc_8 = ROUNDS;
                while (_loc_8 > 0)
                {
                    
                    _loc_6 = _loc_6 - ((_loc_5 << 4 ^ _loc_5 >>> 5) + _loc_5 ^ _loc_7 + this.m_Key[_loc_7 >>> 11 & 3]);
                    _loc_7 = _loc_7 - DELTA;
                    _loc_5 = _loc_5 - ((_loc_6 << 4 ^ _loc_6 >>> 5) + _loc_6 ^ _loc_7 + this.m_Key[_loc_7 & 3]);
                    _loc_8 = _loc_8 - 1;
                }
                param1.position = param1.position - BLOCKSIZE;
                param1.writeUnsignedInt(_loc_5);
                param1.writeUnsignedInt(_loc_6);
                _loc_4 = _loc_4 + BLOCKSIZE;
            }
            return param3;
        }// end function

    }
}
