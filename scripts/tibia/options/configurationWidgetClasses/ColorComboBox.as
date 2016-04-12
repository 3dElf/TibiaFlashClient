package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.chat.*;

    public class ColorComboBox extends ComboBox
    {
        private var m_UIColorRenderer:ColorItemRenderer = null;
        private var m_UncommittedSelectedItem:Boolean = false;

        public function ColorComboBox()
        {
            var _loc_2:* = 0;
            var _loc_1:* = [];
            for each (_loc_2 in MessageMode.MESSAGE_MODE_COLOURS)
            {
                
                _loc_1.push(_loc_1.length);
            }
            dataProvider = _loc_1;
            itemRenderer = new ClassFactory(ColorItemRenderer);
            return;
        }// end function

        private function onMouseEvent(event:MouseEvent) : void
        {
            if (mx_internal::downArrowButton != null)
            {
                mx_internal::downArrowButton.dispatchEvent(event);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = borderMetrics;
            var _loc_4:* = param1 - _loc_3.left - _loc_3.right;
            if (mx_internal::downArrowButton != null)
            {
                _loc_4 = _loc_4 - mx_internal::downArrowButton.getExplicitOrMeasuredWidth();
            }
            var _loc_5:* = param2 - _loc_3.top - _loc_3.bottom;
            this.m_UIColorRenderer.data = selectedIndex;
            this.m_UIColorRenderer.move(_loc_3.left, _loc_3.top);
            this.m_UIColorRenderer.setActualSize(_loc_4, _loc_5);
            setChildIndex(this.m_UIColorRenderer, (numChildren - 1));
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIColorRenderer = new ColorItemRenderer();
            this.m_UIColorRenderer.setStyle("cornerRadius", 5);
            this.m_UIColorRenderer.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEvent);
            this.m_UIColorRenderer.addEventListener(MouseEvent.MOUSE_UP, this.onMouseEvent);
            this.m_UIColorRenderer.addEventListener(MouseEvent.ROLL_OUT, this.onMouseEvent);
            this.m_UIColorRenderer.addEventListener(MouseEvent.ROLL_OVER, this.onMouseEvent);
            addChild(this.m_UIColorRenderer);
            return;
        }// end function

    }
}
