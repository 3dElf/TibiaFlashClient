package tibia.input.staticaction
{
    import tibia.actionbar.*;
    import tibia.options.*;

    public class ToggleActionBar extends StaticAction
    {
        private var m_Location:int = -1;

        public function ToggleActionBar(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != ActionBarSet.LOCATION_TOP && param4 != ActionBarSet.LOCATION_BOTTOM && param4 != ActionBarSet.LOCATION_LEFT && param4 != ActionBarSet.LOCATION_RIGHT)
            {
                throw new ArgumentError("ToggleActionBar.ToggleActionBar: Invalid location: " + param4);
            }
            this.m_Location = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getActionBarSet(_loc_2.generalInputSetID);
            _loc_3 = _loc_2.getActionBarSet(_loc_2.generalInputSetID);
            var _loc_5:* = _loc_3.getActionBar(this.m_Location);
            _loc_4 = _loc_3.getActionBar(this.m_Location);
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null)
            {
                _loc_4.visible = !_loc_4.visible;
            }
            return;
        }// end function

    }
}
