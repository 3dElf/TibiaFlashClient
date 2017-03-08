package tibia.network
{
    import flash.utils.*;
    import shared.cryptography.*;

    public class NetworkPacketReader extends Object
    {
        private var m_PacketLength:uint = 0;
        private var m_PacketBeginOffset:uint = 0;
        private var m_PacketReady:Boolean = false;
        private var m_PayloadEof:uint = 0;
        private var m_PayloadOffset:uint = 0;
        private var m_Blocksize:uint = 0;
        private var m_HeaderComplete:Boolean = false;
        private var m_PacketEof:uint = 0;
        private var m_PayloadLength:uint = 0;
        private var m_XTEA:XTEA = null;
        private var m_MessagesOffset:uint = 0;
        private var m_Checksum:uint = 0;
        private var m_InputBuffer:ByteArray = null;
        static const CONNECTION_STATE_GAME:int = 4;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const HEADER_POS:int = 0;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const ERR_INVALID_STATE:int = 4;
        public static const PROTOCOL_VERSION:int = 11100;
        static const PAYLOADLENGTH_SIZE:int = 2;
        static const PAYLOADLENGTH_POS:int = 6;
        static const ERR_INVALID_SIZE:int = 1;
        static const ERR_INVALID_CHECKSUM:int = 2;
        static const ERR_COULD_NOT_CONNECT:int = 5;
        static const PACKETLENGTH_POS:int = 0;
        static const ERR_CONNECTION_LOST:int = 6;
        static const PACKETLENGTH_SIZE:int = 2;
        static const HEADER_SIZE:int = 6;
        static const ERR_INTERNAL:int = 0;
        static const CHECKSUM_POS:int = 2;
        static const PAYLOAD_POS:int = 6;
        static const CHECKSUM_SIZE:int = 4;
        static const PAYLOADDATA_POSITION:int = 8;

        public function NetworkPacketReader(param1:ByteArray, param2:uint = 1)
        {
            this.m_InputBuffer = param1;
            this.m_Blocksize = param2;
            return;
        }// end function

        public function get isPacketReady() : Boolean
        {
            if (this.m_PacketReady == true)
            {
                return this.m_PacketReady;
            }
            if (this.m_PacketLength == 0)
            {
                if (this.bytesAvailable(PACKETLENGTH_SIZE + CHECKSUM_SIZE))
                {
                    this.m_PacketBeginOffset = this.m_InputBuffer.position;
                    this.m_PacketLength = this.m_InputBuffer.readUnsignedShort();
                    this.m_PacketEof = this.m_InputBuffer.position + this.m_PacketLength;
                    this.m_Checksum = this.m_InputBuffer.readUnsignedInt();
                    this.m_PayloadOffset = this.m_InputBuffer.position;
                }
            }
            if (this.m_PacketLength != 0 && this.m_Checksum != 0 && this.bytesAvailable(this.m_PacketLength - CHECKSUM_SIZE))
            {
                this.m_PacketReady = true;
                return true;
            }
            return false;
        }// end function

        public function set xtea(param1:XTEA) : void
        {
            this.m_XTEA = param1;
            return;
        }// end function

        public function get containsUnreadMessage() : Boolean
        {
            return this.m_InputBuffer.position < Math.min(this.m_InputBuffer.length, this.m_PayloadEof);
        }// end function

        public function get isValidPacket() : Boolean
        {
            var _loc_1:* = true;
            if (this.isPacketReady == false)
            {
                throw new Error("Packet can only be validated if it is complete");
            }
            var _loc_2:* = this.m_InputBuffer.position;
            var _loc_3:* = calculateAdler32Checksum(this.m_InputBuffer, this.m_PayloadOffset, this.m_PacketLength - CHECKSUM_SIZE);
            this.m_InputBuffer.position = _loc_2;
            _loc_1 = _loc_1 && _loc_3 == this.m_Checksum;
            if ((this.m_PacketLength - CHECKSUM_SIZE) % this.m_Blocksize != 0)
            {
                _loc_1 = false;
            }
            return _loc_1;
        }// end function

        private function bytesAvailable(param1:uint) : Boolean
        {
            return this.m_InputBuffer.bytesAvailable >= param1;
        }// end function

        public function dispose() : void
        {
            this.m_InputBuffer = null;
            this.m_XTEA = null;
            return;
        }// end function

        public function get xtea() : XTEA
        {
            return this.m_XTEA;
        }// end function

        public function preparePacket() : void
        {
            if (this.isPacketReady)
            {
                if (this.m_XTEA != null)
                {
                    this.m_XTEA.decrypt(this.m_InputBuffer, this.m_PayloadOffset, this.m_PacketLength - CHECKSUM_SIZE);
                }
                this.m_InputBuffer.position = this.m_PayloadOffset;
            }
            this.m_PayloadLength = this.m_InputBuffer.readUnsignedShort();
            this.m_PayloadEof = this.m_InputBuffer.position + this.m_PayloadLength;
            this.m_MessagesOffset = this.m_InputBuffer.position;
            return;
        }// end function

        public function finishPacket() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            if (this.m_InputBuffer.length > this.m_PacketEof)
            {
                _loc_1 = this.m_InputBuffer.length - this.m_PacketEof;
                _loc_2 = this.m_PacketEof;
                _loc_3 = 0;
                while (_loc_3 < _loc_1)
                {
                    
                    this.m_InputBuffer[++_loc_3] = this.m_InputBuffer[_loc_2++];
                }
            }
            this.m_InputBuffer.length = _loc_1;
            this.m_InputBuffer.position = 0;
            this.m_HeaderComplete = false;
            this.m_PacketLength = 0;
            this.m_Checksum = 0;
            this.m_PacketReady = false;
            this.m_PayloadOffset = 0;
            this.m_PacketBeginOffset = 0;
            this.m_PacketEof = 0;
            this.m_PayloadLength = 0;
            this.m_MessagesOffset = 0;
            this.m_PayloadEof = 0;
            return;
        }// end function

    }
}
