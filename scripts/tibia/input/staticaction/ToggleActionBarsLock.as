package tibia.input.staticaction
{
    import tibia.options.*;

    public class ToggleActionBarsLock extends StaticAction
    {

        public function ToggleActionBarsLock(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                _loc_2.generalActionBarsLock = !_loc_2.generalActionBarsLock;
            }
            return;
        }// end function

    }
}
