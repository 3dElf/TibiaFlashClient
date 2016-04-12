package tibia.input.staticaction
{
    import tibia.options.*;
    import tibia.sidebar.*;

    public class ShowWidget extends StaticAction
    {
        private var m_Type:int = -1;

        public function ShowWidget(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != Widget.TYPE_BATTLELIST && param4 != Widget.TYPE_BODY && param4 != Widget.TYPE_BUDDYLIST && param4 != Widget.TYPE_COMBATCONTROL && param4 != Widget.TYPE_GENERALBUTTONS && param4 != Widget.TYPE_MINIMAP && param4 != Widget.TYPE_SPELLLIST)
            {
                throw ArgumentError("ShowWidget.ShowWidget: Invalid type: " + param4);
            }
            this.m_Type = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            if (_loc_2 != null && _loc_4 != null)
            {
                if (_loc_3.countWidgetType(this.m_Type, -1) > 0)
                {
                    _loc_3.hideWidgetType(this.m_Type, -1);
                }
                else
                {
                    _loc_3.showWidgetType(this.m_Type, -1, -1);
                }
            }
            return;
        }// end function

    }
}
