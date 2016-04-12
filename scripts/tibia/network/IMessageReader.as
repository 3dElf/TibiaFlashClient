package tibia.network
{
    import flash.utils.*;

    public interface IMessageReader
    {

        public function IMessageReader();

        function get messageType() : uint;

        function finishMessage() : void;

        function get messageWasRead() : Boolean;

        function get inputBuffer() : ByteArray;

        function dispose() : void;

    }
}
