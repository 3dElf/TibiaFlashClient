package shared.cryptography
{
    import flash.utils.*;

    public class RSAPublicKey extends Object
    {
        private var m_Exponent:BigInt;
        private var m_Modulus:BigInt;
        private var m_PRNG:Random;
        private static const PUBLIC_MODULUS:String = "1321277432058722840622950990822933849527763264961655079678763618" + "4334395343554449668205332383339435179772895415509701210392836078" + "6959821132214473291575712138800495033169914814069637740318278150" + "2907336840325241747827401343576296990629870233111328210165697754" + "88792221429527047321331896351555606801473202394175817";
        private static const PUBLIC_EXPONENT:uint = 65537;
        public static const BLOCKSIZE:uint = 128;

        public function RSAPublicKey()
        {
            this.m_Exponent = new BigInt(PUBLIC_EXPONENT);
            this.m_Modulus = BigInt.s_FromString(PUBLIC_MODULUS, 10);
            this.m_PRNG = new Random();
            return;
        }// end function

        public function encrypt(param1:ByteArray, param2:uint = 0, param3:uint = 2147483647) : uint
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
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
                
                _loc_6 = BigInt.s_FromByteArray(param1, _loc_5, BLOCKSIZE);
                _loc_7 = BigInt.s_ImplModExp(_loc_6, this.m_Exponent, this.m_Modulus);
                _loc_7.toByteArray(param1, _loc_5, BLOCKSIZE);
                _loc_5 = _loc_5 + BLOCKSIZE;
            }
            return param3;
        }// end function

    }
}
