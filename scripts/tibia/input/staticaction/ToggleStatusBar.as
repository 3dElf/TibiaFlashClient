package tibia.input.staticaction
{
    import tibia.creatures.*;

    public class ToggleStatusBar extends StaticAction
    {
        private var m_PreviousStyle:int = -1;

        public function ToggleStatusBar(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetStatusWidget();
            if (_loc_2 != null)
            {
                _loc_2.visible = !_loc_2.visible;
            }
            return;
        }// end function

    }
}
