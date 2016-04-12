package tibia.network
{
    import flash.events.*;

    public class MessageWriterEvent extends Event
    {
        protected var m_Message:String = null;
        protected var m_Data:Object = null;
        public static const FINISHED:String = "FINISHED";

        public function MessageWriterEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5 = null)
        {
            super(param1, param2, param3);
            this.m_Message = param4;
            this.m_Data = param5;
            return;
        }// end function

        public function get data()
        {
            return this.m_Data;
        }// end function

        public function set data(param1) : void
        {
            this.m_Data = param1;
            return;
        }// end function

        public function get message() : String
        {
            return this.m_Message;
        }// end function

        override public function clone() : Event
        {
            return new ConnectionEvent(type, bubbles, cancelable, this.message, this.data);
        }// end function

        public function set message(param1:String) : void
        {
            this.m_Message = param1;
            return;
        }// end function

    }
}
