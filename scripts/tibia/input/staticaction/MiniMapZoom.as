package tibia.input.staticaction
{
    import tibia.minimap.*;
    import tibia.options.*;
    import tibia.sidebar.*;

    public class MiniMapZoom extends StaticAction
    {
        protected var m_Delta:int = 0;

        public function MiniMapZoom(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            this.m_Delta = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
            var _loc_5:* = _loc_3.getWidgetByType(Widget.TYPE_MINIMAP) as MiniMapWidget;
            _loc_4 = _loc_3.getWidgetByType(Widget.TYPE_MINIMAP) as MiniMapWidget;
            if (_loc_2 != null && _loc_5 != null && _loc_5 != null)
            {
                _loc_4.zoom = _loc_4.zoom + this.m_Delta;
            }
            return;
        }// end function

    }
}
