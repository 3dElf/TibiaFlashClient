package tibia.sessiondump
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;

    public class SessiondumpReader extends EventDispatcher
    {
        private var m_HeaderLength:uint = 0;
        private var m_MessageReader:SessiondumpMessageReader = null;
        private var m_HeaderRead:Boolean = false;
        private var m_InputBuffer:ByteArray = null;
        private var m_PacketReader:SessiondumpPacketReader = null;
        private static const HEADER_MAGIC_BYTES_SIZE:uint = 3;
        private static const HEADER_HEADER_LENGTH_SIZE:uint = 2;

        public function SessiondumpReader(param1:ByteArray)
        {
            this.m_InputBuffer = param1;
            return;
        }// end function

        public function get isPacketReady() : Boolean
        {
            if (this.m_HeaderRead == false)
            {
                this.readSessiondumpHeader();
            }
            return this.m_HeaderRead && this.m_PacketReader != null && this.m_PacketReader.isPacketReady;
        }// end function

        private function readSessiondumpHeader() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_InputBuffer == null)
            {
                return;
            }
            if (this.m_HeaderRead == false)
            {
                if (this.m_HeaderLength == 0)
                {
                    if (this.m_InputBuffer.bytesAvailable >= HEADER_MAGIC_BYTES_SIZE + HEADER_HEADER_LENGTH_SIZE)
                    {
                        _loc_1 = new Vector.<uint>;
                        _loc_2 = 0;
                        while (_loc_2 < 3)
                        {
                            
                            _loc_1.push(this.m_InputBuffer.readUnsignedByte());
                            _loc_2 = _loc_2 + 1;
                        }
                        if (_loc_1[0] != 100 || _loc_1[1] != 109 || _loc_1[2] != 112)
                        {
                            throw new Error("SessiondumpReader.readSessiondumpHeader: Invalid magic bytes");
                        }
                        this.m_HeaderLength = this.m_InputBuffer.readUnsignedShort();
                    }
                }
                if (this.m_HeaderLength > 0 && this.m_InputBuffer.bytesAvailable >= this.m_HeaderLength)
                {
                    this.m_InputBuffer.position = this.m_InputBuffer.position + this.m_HeaderLength;
                    this.m_PacketReader = new SessiondumpPacketReader(this.m_InputBuffer);
                    this.m_MessageReader = new SessiondumpMessageReader(this.m_InputBuffer);
                    this.m_HeaderRead = true;
                    _loc_3 = new SessiondumpEvent(SessiondumpEvent.HEADER_READ);
                    dispatchEvent(_loc_3);
                }
            }
            return;
        }// end function

        public function get messageReader() : SessiondumpMessageReader
        {
            return this.m_MessageReader;
        }// end function

        public function get headerRead() : Boolean
        {
            return this.m_HeaderRead;
        }// end function

        public function get packetReader() : SessiondumpPacketReader
        {
            return this.m_PacketReader;
        }// end function

        public function get inputBuffer() : ByteArray
        {
            return this.m_InputBuffer;
        }// end function

        public function dispose() : void
        {
            this.m_InputBuffer = null;
            return;
        }// end function

    }
}
