package tibia.game
{
    import flash.events.*;

    public class ExtendedTooltipEvent extends Event
    {
        private var m_Tooltip:String = null;
        public static const HIDE:String = "extendedTooltipHide";
        public static const SHOW:String = "extendedTooltipShow";

        public function ExtendedTooltipEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:String = null)
        {
            super(param1, param2, param3);
            this.m_Tooltip = param4;
            return;
        }// end function

        public function get tooltip() : String
        {
            return this.m_Tooltip;
        }// end function

        override public function clone() : Event
        {
            return new GameEvent(type, bubbles, cancelable, this.m_Tooltip);
        }// end function

    }
}
