package tibia.input.staticaction
{
    import tibia.options.*;
    import tibia.sidebar.*;

    public class ToggleSideBar extends StaticAction
    {
        private var m_Location:int = -1;

        public function ToggleSideBar(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != SideBarSet.LOCATION_A && param4 != SideBarSet.LOCATION_B && param4 != SideBarSet.LOCATION_C && param4 != SideBarSet.LOCATION_D)
            {
                throw new ArgumentError("ToggleSideBar.ToggleSideBar: Invalid location: " + param4);
            }
            this.m_Location = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            var _loc_5:* = _loc_3.getSideBar(this.m_Location);
            _loc_4 = _loc_3.getSideBar(this.m_Location);
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null)
            {
                _loc_4.visible = !_loc_4.visible;
            }
            return;
        }// end function

    }
}
