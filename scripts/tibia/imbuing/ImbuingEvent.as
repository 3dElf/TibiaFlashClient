package tibia.imbuing
{
    import flash.events.*;

    public class ImbuingEvent extends Event
    {
        private var m_Message:String = null;
        private var m_Data:Object = null;
        public static const IMBUEMENT_SLOT_SELECTED:String = "imbuementSlotSelected";
        public static const IMBUEMENT_DATA_CHANGED:String = "imbuementDataChanged";

        public function ImbuingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        public function get data() : Object
        {
            return this.m_Data;
        }// end function

        public function set data(param1:Object) : void
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
            var _loc_1:* = new ImbuingEvent(type, bubbles, cancelable);
            _loc_1.m_Message = this.m_Message;
            _loc_1.m_Data = this.m_Data;
            return _loc_1;
        }// end function

        public function set message(param1:String) : void
        {
            this.m_Message = param1;
            return;
        }// end function

    }
}
