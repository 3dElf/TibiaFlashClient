package tibia.sessiondump
{
    import flash.utils.*;

    public class SessiondumpPacketReader extends Object
    {
        private var m_PacketLength:uint = 0;
        private var m_PacketReady:Boolean = false;
        private var m_CurrentPacketID:uint = 0;
        private var m_PayloadOffset:uint = 0;
        private var m_PacketType:uint = 0;
        private var m_HeaderComplete:Boolean = false;
        private var m_PacketEof:uint = 0;
        private var m_SkipClientPackets:Boolean = true;
        private var m_InputBuffer:ByteArray = null;
        private var m_PacketTimestamp:uint = 0;
        public static const PACKET_TYPE_CLIENT_MESSAGE:uint = 2;
        static const PACKET_TIMESTAMP_SIZE:uint = 4;
        static const PACKETLENGTH_SIZE:int = 2;
        static const PACKET_MAGIC_BYTE_SIZE:uint = 1;
        static const PACKET_TYPE_SIZE:uint = 1;
        static const PACKET_MAGIC_BYTE:uint = 112;
        public static const PACKET_TYPE_SERVER_MESSAGE:uint = 1;

        public function SessiondumpPacketReader(param1:ByteArray)
        {
            this.m_InputBuffer = param1;
            return;
        }// end function

        public function set skipClientPackets(param1:Boolean) : void
        {
            this.m_SkipClientPackets = param1;
            return;
        }// end function

        public function get currentPacketID() : uint
        {
            return this.m_CurrentPacketID;
        }// end function

        public function dispose() : void
        {
            this.m_InputBuffer = null;
            return;
        }// end function

        public function get skipClientPackets() : Boolean
        {
            return this.m_SkipClientPackets;
        }// end function

        private function bytesAvailable(param1:uint) : Boolean
        {
            return this.m_InputBuffer.bytesAvailable >= param1;
        }// end function

        public function get packetTimestamp() : uint
        {
            return this.m_PacketTimestamp;
        }// end function

        public function get isPacketReady() : Boolean
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this.m_PacketReady == true)
            {
                return this.m_PacketReady;
            }
            do
            {
                
                _loc_1 = false;
                if (this.m_PacketLength == 0)
                {
                    if (this.bytesAvailable(PACKET_MAGIC_BYTE_SIZE + PACKETLENGTH_SIZE + PACKET_TYPE_SIZE + PACKET_TIMESTAMP_SIZE))
                    {
                        _loc_2 = this.m_InputBuffer.readUnsignedByte();
                        if (_loc_2 != PACKET_MAGIC_BYTE)
                        {
                            throw new Error("SessiondumpPacketReader.isPacketReady: Invalid magic byte");
                        }
                        this.m_PacketLength = this.m_InputBuffer.readUnsignedShort();
                        this.m_PacketEof = this.m_InputBuffer.position + this.m_PacketLength;
                        this.m_PacketType = this.m_InputBuffer.readUnsignedByte();
                        if (this.m_PacketType != PACKET_TYPE_SERVER_MESSAGE && this.m_PacketType != PACKET_TYPE_CLIENT_MESSAGE)
                        {
                            throw new Error("SessiondumpPacketReader.isPacketReady: invalid packet type: " + this.m_PacketType);
                        }
                        this.m_PacketTimestamp = this.m_InputBuffer.readUnsignedInt();
                        this.m_HeaderComplete = true;
                        if (this.m_SkipClientPackets && this.m_PacketType == PACKET_TYPE_CLIENT_MESSAGE)
                        {
                            this.m_InputBuffer.position = this.m_PacketEof;
                            this.finishPacket();
                            _loc_1 = true;
                        }
                    }
                }
                if (this.m_HeaderComplete && this.bytesAvailable(this.m_PacketLength - 5))
                {
                    this.m_PacketReady = true;
                    return true;
                }
            }while (_loc_1 == true)
            return false;
        }// end function

        public function get containsUnreadMessage() : Boolean
        {
            return this.m_InputBuffer.position < Math.min(this.m_InputBuffer.length, this.m_PacketEof);
        }// end function

        public function finishPacket() : void
        {
            this.m_HeaderComplete = false;
            this.m_PacketLength = 0;
            this.m_PacketReady = false;
            this.m_PayloadOffset = 0;
            this.m_PacketEof = 0;
            var _loc_1:* = this;
            var _loc_2:* = this.m_CurrentPacketID + 1;
            _loc_1.m_CurrentPacketID = _loc_2;
            return;
        }// end function

        public function get isClientPacket() : Boolean
        {
            return this.m_PacketType == PACKET_TYPE_CLIENT_MESSAGE;
        }// end function

    }
}
