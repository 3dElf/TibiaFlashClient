package tibia.sessiondump
{
    import flash.utils.*;
    import tibia.network.*;

    public class SessiondumpMessageReader extends Object implements IMessageReader
    {
        private var m_MessageBeginIndex:uint = 0;
        private var m_MessageEof:uint = 0;
        private var m_MessageType:uint = 0;
        private var m_InputBuffer:ByteArray = null;
        static const MESSAGELENGTH_SIZE:int = 2;
        static const MESSAGE_TYPE_CLIENT_MESSAGE:uint = 99;
        static const MESSAGE_TYPE_SERVER_MESSAGE:uint = 109;
        static const MESSAGE_MAGIC_BYTE_SIZE:uint = 1;

        public function SessiondumpMessageReader(param1:ByteArray)
        {
            this.m_InputBuffer = param1;
            return;
        }// end function

        public function get messageType() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.m_MessageType == 0)
            {
                _loc_1 = this.m_InputBuffer.readUnsignedByte();
                if (_loc_1 != MESSAGE_TYPE_SERVER_MESSAGE && _loc_1 != MESSAGE_TYPE_CLIENT_MESSAGE)
                {
                    throw new Error("SessiondumpMessageReader.messageType: Invalid magic byte: " + _loc_1);
                }
                _loc_2 = this.m_InputBuffer.readUnsignedShort();
                this.m_MessageEof = this.m_InputBuffer.position + _loc_2;
                this.m_MessageType = this.m_InputBuffer.readUnsignedByte();
                this.m_MessageBeginIndex = this.m_InputBuffer.position;
            }
            return this.m_MessageType;
        }// end function

        public function dispose() : void
        {
            this.m_InputBuffer = null;
            return;
        }// end function

        public function get inputBuffer() : ByteArray
        {
            return this.m_InputBuffer;
        }// end function

        public function finishMessage() : void
        {
            this.m_MessageType = 0;
            this.m_MessageBeginIndex = 0;
            this.m_InputBuffer.position = this.m_MessageEof;
            return;
        }// end function

        public function get messageWasRead() : Boolean
        {
            return this.m_MessageType == 0 && this.m_InputBuffer.position != this.m_MessageBeginIndex;
        }// end function

    }
}
