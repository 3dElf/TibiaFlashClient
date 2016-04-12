package tibia.controls.dynamicTabBarClasses
{
    import flash.events.*;

    public class TabBarEvent extends Event
    {
        public var index:int = 0;
        public var oldIndex:int = 0;
        public static const CLOSE:String = "tabClose";
        public static const SELECT:String = "tabSelect";
        public static const DROP:String = "tabDrop";

        public function TabBarEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:int = -1, param5:int = -1)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TabBarEvent(type, bubbles, cancelable, this.index, this.oldIndex);
        }// end function

    }
}
