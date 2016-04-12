package tibia.network
{
    import flash.utils.*;

    public interface IMessageWriter
    {

        public function IMessageWriter();

        function get outputPacketBuffer() : ByteArray;

        function createMessage() : ByteArray;

        function finishMessage() : void;

    }
}
