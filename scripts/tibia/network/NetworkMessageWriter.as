package tibia.network
{
    import flash.utils.*;
    import shared.cryptography.*;
    import tibia.network.*;

    public class NetworkMessageWriter extends Object implements IMessageWriter
    {
        private var m_XTEA:XTEA = null;
        private var m_MessageFinishedCallback:Function = null;
        private var m_MessageBuffer:ByteArray = null;
        private var m_OutputBuffer:ByteArray = null;
        private var m_SequenceNumber:uint = 0;
        static const CONNECTION_STATE_GAME:int = 4;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const HEADER_POS:int = 0;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const ERR_INVALID_STATE:int = 4;
        public static const PROTOCOL_VERSION:int = 1132;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const PAYLOADLENGTH_POS:int = 6;
        static const ERR_INVALID_SIZE:int = 1;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const PACKETLENGTH_POS:int = 0;
        static const ERR_CONNECTION_LOST:int = 6;
        static const PAYLOADDATA_POSITION:int = 8;
        static const PACKETLENGTH_SIZE:int = 2;
        static const HEADER_SIZE:int = 6;
        static const ERR_INTERNAL:int = 0;
        static const SEQUENCE_NUMBER_SIZE:int = 4;
        static const PAYLOAD_POS:int = 6;
        static const SEQUENCE_NUMBER_POS:int = 2;

        public function NetworkMessageWriter()
        {
            this.m_OutputBuffer = new ByteArray();
            this.m_MessageBuffer = new ByteArray();
            this.m_OutputBuffer.endian = Endian.LITTLE_ENDIAN;
            this.m_MessageBuffer.endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public function registerMessageFinishedCallback(param1:Function) : void
        {
            this.m_MessageFinishedCallback = param1;
            return;
        }// end function

        public function get outputPacketBuffer() : ByteArray
        {
            return this.m_OutputBuffer;
        }// end function

        public function createMessage() : ByteArray
        {
            this.m_MessageBuffer.length = 0;
            this.m_MessageBuffer.position = 0;
            this.m_OutputBuffer.length = 0;
            this.m_OutputBuffer.position = 0;
            return this.m_MessageBuffer;
        }// end function

        public function set xtea(param1:XTEA) : void
        {
            this.m_XTEA = param1;
            return;
        }// end function

        public function get xtea() : XTEA
        {
            return this.m_XTEA;
        }// end function

        public function finishMessage() : void
        {
            var _loc_1:* = this.m_MessageBuffer.position;
            this.m_OutputBuffer.length = 0;
            this.m_OutputBuffer.position = 0;
            var _loc_2:* = SEQUENCE_NUMBER_POS + SEQUENCE_NUMBER_SIZE;
            this.m_OutputBuffer.position = _loc_2;
            var _loc_3:* = this.m_MessageBuffer.position;
            if (this.m_XTEA != null)
            {
                this.m_OutputBuffer.writeShort(_loc_3);
            }
            this.m_OutputBuffer.writeBytes(this.m_MessageBuffer, 0, _loc_3);
            if (this.m_XTEA != null)
            {
                this.m_XTEA.encrypt(this.m_OutputBuffer, _loc_2, this.m_OutputBuffer.length - _loc_2);
                ;
            }
            this.m_OutputBuffer.position = SEQUENCE_NUMBER_POS;
            var _loc_4:* = this;
            _loc_4.m_SequenceNumber = this.m_SequenceNumber + 1;
            this.m_OutputBuffer.writeUnsignedInt(this.m_SequenceNumber++);
            this.m_OutputBuffer.position = PACKETLENGTH_POS;
            this.m_OutputBuffer.writeShort(this.m_OutputBuffer.length - PACKETLENGTH_SIZE);
            this.m_OutputBuffer.position = 0;
            if (this.m_MessageFinishedCallback != null)
            {
                this.m_MessageFinishedCallback();
            }
            return;
        }// end function

    }
}
