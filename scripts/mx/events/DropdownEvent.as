package mx.events
{
    import flash.events.*;

    public class DropdownEvent extends Event
    {
        public var triggerEvent:Event;
        static const VERSION:String = "3.6.0.21751";
        public static const OPEN:String = "open";
        public static const CLOSE:String = "close";

        public function DropdownEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Event = null)
        {
            super(param1, param2, param3);
            this.triggerEvent = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new DropdownEvent(type, bubbles, cancelable, triggerEvent);
        }// end function

    }
}
