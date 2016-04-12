package mx.containers
{
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;

    public class FormHeading extends UIComponent
    {
        private var labelObj:Label;
        private var _label:String = "";
        static const VERSION:String = "3.6.0.21751";

        public function FormHeading()
        {
            return;
        }// end function

        private function getLabelWidth() : Number
        {
            var _loc_1:* = getStyle("labelWidth");
            if (_loc_1 == 0)
            {
                _loc_1 = NaN;
            }
            if (isNaN(_loc_1) && parent is Form)
            {
                _loc_1 = Form(parent).calculateLabelWidth();
            }
            if (isNaN(_loc_1))
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            createLabel();
            return;
        }// end function

        public function get label() : String
        {
            return _label;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            super.updateDisplayList(param1, param2);
            if (labelObj)
            {
                _loc_3 = getStyle("indicatorGap");
                _loc_4 = getStyle("paddingTop");
                _loc_5 = width;
                labelObj.move(getLabelWidth() + _loc_3, _loc_4);
                if (parent && parent is Form)
                {
                    _loc_6 = Form(parent).viewMetricsAndPadding;
                    _loc_5 = parent.width - (getLabelWidth() + _loc_3 + _loc_6.left + _loc_6.right);
                }
                labelObj.setActualSize(_loc_5, height);
            }
            return;
        }// end function

        public function set label(param1:String) : void
        {
            _label = param1;
            invalidateProperties();
            dispatchEvent(new Event("labelChanged"));
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = getStyle("paddingTop");
            if (labelObj)
            {
                if (isNaN(labelObj.measuredWidth))
                {
                    labelObj.validateSize();
                }
                _loc_1 = labelObj.measuredWidth;
                _loc_2 = _loc_2 + labelObj.measuredHeight;
            }
            _loc_1 = _loc_1 + (getLabelWidth() + getStyle("indicatorGap"));
            measuredMinWidth = _loc_1;
            measuredMinHeight = _loc_2;
            measuredWidth = _loc_1;
            measuredHeight = _loc_2;
            return;
        }// end function

        private function createLabel() : void
        {
            if (_label && _label.length > 0)
            {
                if (!labelObj)
                {
                    labelObj = new Label();
                    labelObj.styleName = this;
                    addChild(labelObj);
                }
                if (labelObj.text != _label)
                {
                    labelObj.text = _label;
                    labelObj.validateSize();
                    invalidateSize();
                    invalidateDisplayList();
                }
            }
            if ((_label == null || _label.length == 0) && labelObj)
            {
                removeChild(labelObj);
                labelObj = null;
                invalidateSize();
                invalidateDisplayList();
            }
            return;
        }// end function

    }
}
