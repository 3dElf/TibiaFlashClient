package tibia.input.staticaction
{
    import tibia.input.*;
    import tibia.options.*;

    public class ToggleMappingMode extends StaticAction
    {

        public function ToggleMappingMode(param1:int, param2:String, param3:uint)
        {
            super(param1, param2, param3, false);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                if (_loc_2.generalInputSetMode == MappingSet.CHAT_MODE_OFF)
                {
                    _loc_2.generalInputSetMode = MappingSet.CHAT_MODE_ON;
                }
                else
                {
                    _loc_2.generalInputSetMode = MappingSet.CHAT_MODE_OFF;
                }
            }
            return;
        }// end function

    }
}
