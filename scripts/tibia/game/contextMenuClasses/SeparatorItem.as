package tibia.game.contextMenuClasses
{
    import mx.core.*;
    import tibia.game.contextMenuClasses.*;

    public class SeparatorItem extends UIComponent implements IContextMenuItem
    {

        public function SeparatorItem()
        {
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = getStyle("separatorHeight");
            measuredMinHeight = _loc_1;
            measuredHeight = _loc_1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            graphics.clear();
            graphics.lineStyle(1, getStyle("separatorColor"), getStyle("separatorAlpha"));
            var _loc_3:* = param1 * (1 - getStyle("separatorWidth")) / 2;
            var _loc_4:* = param2 / 2;
            graphics.moveTo(_loc_3, _loc_4);
            graphics.lineTo(param1 - _loc_3, _loc_4);
            return;
        }// end function

    }
}
