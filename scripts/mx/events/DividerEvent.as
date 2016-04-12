package mx.events
{
    import flash.events.*;

    public class DividerEvent extends Event
    {
        public var delta:Number;
        public var dividerIndex:int;
        static const VERSION:String = "3.6.0.21751";
        public static const DIVIDER_RELEASE:String = "dividerRelease";
        public static const DIVIDER_DRAG:String = "dividerDrag";
        public static const DIVIDER_PRESS:String = "dividerPress";

        public function DividerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:Number = NaN)
        {
            super(param1, param2, param3);
            this.dividerIndex = param4;
            this.delta = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new DividerEvent(type, bubbles, cancelable, dividerIndex, delta);
        }// end function

    }
}
