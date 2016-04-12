package tibia.minimap.editMarkWidgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import shared.controls.*;
    import tibia.minimap.*;

    public class MarkIconRenderer extends IconRendererBase
    {

        public function MarkIconRenderer()
        {
            super(MiniMapStorage.MARK_ICON_SIZE, MiniMapStorage.MARK_ICON_SIZE, (MiniMapStorage.MARK_ICON_COUNT - 1));
            return;
        }// end function

        override protected function drawIcon(param1:Graphics) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 != null)
            {
                _loc_2 = new Rectangle();
                _loc_3 = MiniMapStorage.s_GetMarkIcon(ID, false, _loc_2);
                param1.clear();
                param1.beginBitmapFill(_loc_3, new Matrix(1, 0, 0, 1, -_loc_2.x, -_loc_2.y), false, false);
                param1.drawRect(0, 0, _loc_2.width, _loc_2.height);
                param1.endFill();
            }
            return;
        }// end function

    }
}
