package tibia.network
{
    import flash.events.*;
    import flash.utils.*;
    import tibia.network.*;

    public class NetworkMessageReader extends EventDispatcher implements IMessageReader
    {
        private var m_MessageBeginIndex:uint = 0;
        private var m_MessageType:uint = 0;
        private var m_InputBuffer:ByteArray = null;

        public function NetworkMessageReader(param1:ByteArray)
        {
            this.m_InputBuffer = param1;
            return;
        }// end function

        public function get messageType() : uint
        {
            if (this.m_MessageType == 0)
            {
                this.m_MessageBeginIndex = this.m_InputBuffer.position;
                this.m_MessageType = this.m_InputBuffer.readUnsignedByte();
            }
            return this.m_MessageType;
        }// end function

        public function get messageWasRead() : Boolean
        {
            return this.m_MessageType == 0 && this.m_InputBuffer.position != this.m_MessageBeginIndex;
        }// end function

        public function get inputBuffer() : ByteArray
        {
            return this.m_InputBuffer;
        }// end function

        public function finishMessage() : void
        {
            this.m_MessageType = 0;
            this.m_MessageBeginIndex = 0;
            return;
        }// end function

        public function dispose() : void
        {
            this.m_InputBuffer = null;
            return;
        }// end function

    }
}
