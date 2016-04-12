package tibia.input.staticaction
{
    import tibia.minimap.*;
    import tibia.options.*;
    import tibia.sidebar.*;

    public class MiniMapMove extends StaticAction
    {
        protected var m_Direction:int = 0;
        public static const NORTH:int = 1;
        public static const DOWN:int = 5;
        public static const SOUTH:int = 3;
        public static const WEST:int = 2;
        public static const CENTER:int = 6;
        public static const UP:int = 4;
        public static const EAST:int = 0;

        public function MiniMapMove(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != EAST && param4 != NORTH && param4 != WEST && param4 != SOUTH && param4 != UP && param4 != DOWN && param4 != CENTER)
            {
                throw new ArgumentError("MiniMapMove.MiniMapMove: Invalid movement direction: " + param4 + ".");
            }
            this.m_Direction = param4;
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
                switch(this.m_Direction)
                {
                    case EAST:
                    {
                        _loc_4.translatePosition(1, 0, 0);
                        break;
                    }
                    case NORTH:
                    {
                        _loc_4.translatePosition(0, -1, 0);
                        break;
                    }
                    case WEST:
                    {
                        _loc_4.translatePosition(-1, 0, 0);
                        break;
                    }
                    case SOUTH:
                    {
                        _loc_4.translatePosition(0, 1, 0);
                        break;
                    }
                    case UP:
                    {
                        _loc_4.translatePosition(0, 0, -1);
                        break;
                    }
                    case DOWN:
                    {
                        _loc_4.translatePosition(0, 0, 1);
                        break;
                    }
                    case CENTER:
                    {
                        _loc_4.centerPosition();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
