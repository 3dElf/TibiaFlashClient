package tibia.sessiondump
{
    import flash.utils.*;
    import tibia.network.*;

    public class DummyMessageWriter extends Object implements IMessageWriter
    {
        private var m_DummyBuffer:ByteArray = null;
        static const CONNECTION_STATE_GAME:int = 4;
        static const ERR_INVALID_MESSAGE:int = 3;
        static const CONNECTION_STATE_PENDING:int = 3;
        static const HEADER_POS:int = 0;
        static const CONNECTION_STATE_DISCONNECTED:int = 0;
        static const CONNECTION_STATE_CONNECTING_STAGE1:int = 1;
        static const CONNECTION_STATE_CONNECTING_STAGE2:int = 2;
        static const ERR_INVALID_STATE:int = 4;
        public static const PROTOCOL_VERSION:int = 1101;
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

        public function DummyMessageWriter()
        {
            this.m_DummyBuffer = new ByteArray();
            return;
        }// end function

        public function finishMessage() : void
        {
            this.m_DummyBuffer.length = 0;
            this.m_DummyBuffer.position = 0;
            return;
        }// end function

        public function get outputPacketBuffer() : ByteArray
        {
            return this.m_DummyBuffer;
        }// end function

        public function createMessage() : ByteArray
        {
            this.m_DummyBuffer.length = 0;
            this.m_DummyBuffer.position = 0;
            return this.m_DummyBuffer;
        }// end function

    }
}
