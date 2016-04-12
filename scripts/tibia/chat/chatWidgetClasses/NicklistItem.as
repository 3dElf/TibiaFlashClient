package tibia.chat.chatWidgetClasses
{
    import flash.events.*;
    import mx.events.*;

    public class NicklistItem extends EventDispatcher
    {
        private var m_Name:String = null;
        private var m_State:uint = 0;
        public static const STATE_SUBSCRIBER:uint = 2;
        public static const STATE_PENDING:uint = 3;
        public static const STATE_UNKNOWN:uint = 0;
        public static const STATE_INVITED:uint = 1;

        public function NicklistItem(param1:String)
        {
            this.m_Name = param1;
            return;
        }// end function

        public function get state() : uint
        {
            return this.m_State;
        }// end function

        public function set state(param1:uint) : void
        {
            if (param1 != STATE_UNKNOWN && param1 != STATE_INVITED && param1 != STATE_SUBSCRIBER && param1 != STATE_PENDING)
            {
                throw new ArgumentError("NicklistItem.state (set): Invalid state " + param1);
            }
            this.m_State = param1;
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            _loc_2.property = "state";
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

    }
}
