package tibia.options.configurationWidgetClasses
{
    import flash.events.*;

    public class OptionsEditorEvent extends Event
    {
        public static const VALUE_CHANGE:String = "valueChange";

        public function OptionsEditorEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new OptionsEditorEvent(type, bubbles, cancelable);
        }// end function

    }
}
