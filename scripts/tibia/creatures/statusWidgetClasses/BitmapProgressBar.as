package tibia.creatures.statusWidgetClasses
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;
    import mx.styles.*;
    import mx.utils.*;
    import shared.skins.*;

    public class BitmapProgressBar extends UIComponent
    {
        protected var m_Direction:String = null;
        private var m_UncommittedTickValues:Boolean = false;
        private var m_StyleImageLimits:Object = null;
        protected var m_LabelFormat:String = "{1}";
        private var m_UncommittedMaxValue:Boolean = false;
        protected var m_MaxValue:Number = 100;
        protected var m_UILeftOrnament:BitmapGrid = null;
        private var m_UIConstructed:Boolean = false;
        private var m_BarLimits:Array = null;
        private var m_UncommittedLabelFormat:Boolean = false;
        private var m_StyleImageNames:Object = null;
        protected var m_TickValues:Array = null;
        protected var m_BarLabel:TextField = null;
        private var m_UncommittedLabelEnabled:Boolean = false;
        protected var m_LabelEnabled:Boolean = false;
        protected var m_UITick:BitmapGrid = null;
        private var m_UncommittedValue:Boolean = false;
        protected var m_UIRightOrnament:BitmapGrid = null;
        private var m_UncommittedDirection:Boolean = false;
        private var m_UncommittedMinValue:Boolean = false;
        protected var m_MinValue:Number = 0;
        protected var m_UIBackground:BitmapGrid = null;
        protected var m_UILabel:Bitmap = null;
        private var m_BarImages:Array = null;
        protected var m_Value:Number = 50;
        public static const DIRECTION_BOTTOM_TO_TOP:String = "bt";
        public static const DIRECTION_RIGHT_TO_LEFT:String = "rl";
        public static const DIRECTION_TOP_TO_BOTTOM:String = "tb";
        static var s_Matrix:Matrix = new Matrix();
        public static const DIRECTION_AUTO:String = "a";
        public static const DIRECTION_LEFT_TO_RIGHT:String = "lr";

        public function BitmapProgressBar()
        {
            this.m_UIBackground = new BitmapGrid(this, "background");
            this.m_UILeftOrnament = new BitmapGrid(this, "leftOrnament");
            this.m_UIRightOrnament = new BitmapGrid(this, "rightOrnament");
            this.m_UITick = new BitmapGrid(this, "tick");
            return;
        }// end function

        public function set direction(param1:String) : void
        {
            if (param1 != DIRECTION_LEFT_TO_RIGHT && param1 != DIRECTION_RIGHT_TO_LEFT)
            {
                param1 = DIRECTION_LEFT_TO_RIGHT;
            }
            if (this.m_Direction != param1)
            {
                this.m_Direction = param1;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get direction() : String
        {
            return this.m_Direction;
        }// end function

        private function cacheBarImages(param1:Boolean = false) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = getStyle("barImages");
            var _loc_3:* = getStyle("barLimits");
            var _loc_4:* = null;
            if (param1 || this.m_StyleImageNames != _loc_2 || this.m_StyleImageLimits != _loc_3)
            {
                this.m_StyleImageNames = _loc_2;
                this.m_StyleImageLimits = _loc_3;
                this.m_BarLimits = [];
                this.m_BarImages = [];
                _loc_5 = 0;
                _loc_6 = _loc_2 is Array ? (_loc_2.length) : (0);
                _loc_7 = _loc_3 is Array ? (_loc_3.length) : (0);
                if (_loc_6 > 0 && _loc_7 == _loc_6)
                {
                    _loc_5 = 0;
                    while (_loc_5 < _loc_6)
                    {
                        
                        this.m_BarLimits[_loc_5] = Number(_loc_3[_loc_5]);
                        var _loc_8:* = getStyle(_loc_2[_loc_5]) as Class;
                        _loc_4 = getStyle(_loc_2[_loc_5]) as Class;
                        this.m_BarImages[_loc_5] = _loc_8 != null ? (new _loc_4) : (null);
                        _loc_5++;
                    }
                }
                else if (_loc_6 == 0 && _loc_7 == _loc_6)
                {
                    this.m_BarLimits[0] = Number(_loc_3);
                    var _loc_8:* = getStyle(_loc_2) as Class;
                    _loc_4 = getStyle(_loc_2) as Class;
                    this.m_BarImages[0] = _loc_8 != null ? (new _loc_4) : (null);
                }
            }
            return;
        }// end function

        public function get labelFormat() : String
        {
            return this.m_LabelFormat;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = this.viewMetricsAndPadding;
            var _loc_5:* = _loc_4.left;
            var _loc_6:* = _loc_4.top;
            var _loc_7:* = 0;
            var _loc_8:* = param1 - _loc_5 - _loc_4.right;
            var _loc_9:* = 0;
            if (this.m_MaxValue > this.m_MinValue)
            {
                _loc_9 = this.m_Value / (this.m_MaxValue - this.m_MinValue);
                _loc_8 = Math.round(_loc_8 * _loc_9);
            }
            graphics.clear();
            this.m_UIBackground.drawGrid(graphics, 0, 0, param1, param2);
            _loc_5 = getStyle("leftOrnamentOffset");
            this.m_UILeftOrnament.drawGrid(graphics, _loc_5, 0, this.m_UILeftOrnament.measuredWidth, this.m_UILeftOrnament.measuredHeight);
            _loc_5 = param1 - this.m_UIRightOrnament.measuredWidth + getStyle("rightOrnamentOffset");
            this.m_UIRightOrnament.drawGrid(graphics, _loc_5, 0, this.m_UIRightOrnament.measuredWidth, this.m_UIRightOrnament.measuredHeight);
            this.cacheBarImages(this.m_BarLimits == null || this.m_BarImages == null);
            _loc_3 = this.m_BarLimits.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (_loc_9 >= this.m_BarLimits[_loc_3])
                {
                    break;
                }
                _loc_3 = _loc_3 - 1;
            }
            if (_loc_3 > -1 && this.m_BarImages[_loc_3] != null)
            {
                s_Matrix.tx = this.direction == DIRECTION_RIGHT_TO_LEFT ? (param1 - _loc_4.right - _loc_8) : (_loc_4.left);
                s_Matrix.ty = _loc_4.top;
                graphics.beginBitmapFill(this.m_BarImages[_loc_3].bitmapData, s_Matrix, true, false);
                graphics.drawRect(s_Matrix.tx, s_Matrix.ty, _loc_8, this.m_BarImages[_loc_3].height);
            }
            if (this.m_MaxValue > this.m_MinValue && this.m_TickValues != null)
            {
                _loc_7 = param2 - _loc_4.top - _loc_4.bottom;
                _loc_8 = param1 - _loc_4.left - _loc_4.right;
                _loc_6 = _loc_4.top + (_loc_7 - this.m_UITick.measuredHeight) / 2 + getStyle("tickOffset");
                _loc_3 = this.m_TickValues.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_5 = _loc_4.left + _loc_8 * this.m_TickValues[_loc_3] / (this.m_MaxValue - this.m_MinValue) - this.m_UITick.measuredWidth / 2;
                    this.m_UITick.drawGrid(graphics, _loc_5, _loc_6, this.m_UITick.measuredWidth, this.m_UITick.measuredHeight);
                    _loc_3 = _loc_3 - 1;
                }
            }
            graphics.endFill();
            this.cacheBarLabel();
            this.m_UILabel.visible = this.m_LabelEnabled;
            this.m_UILabel.x = this.direction == DIRECTION_RIGHT_TO_LEFT ? (param1 - _loc_4.right - this.m_UILabel.width) : (_loc_4.left);
            this.m_UILabel.y = _loc_4.top + (param2 - _loc_4.top - _loc_4.bottom - this.m_UILabel.height) / 2;
            return;
        }// end function

        public function set minValue(param1:Number) : void
        {
            param1 = Math.max(0, param1);
            if (this.m_MinValue != param1)
            {
                this.m_MinValue = param1;
                this.m_UncommittedMinValue = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILabel = new Bitmap();
                addChild(this.m_UILabel);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set labelFormat(param1:String) : void
        {
            if (this.m_LabelFormat != param1)
            {
                this.m_LabelFormat = param1;
                this.m_UncommittedLabelFormat = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get labelEnabled() : Boolean
        {
            return this.m_LabelEnabled;
        }// end function

        public function get tickValues() : Array
        {
            return this.m_TickValues;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = this.borderMetrics.clone();
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            return _loc_1;
        }// end function

        public function get minValue() : Number
        {
            return this.m_MinValue;
        }// end function

        override public function set styleName(param1:Object) : void
        {
            if (styleName != param1)
            {
                super.styleName = param1;
                this.m_UIBackground.invalidateStyle();
                this.m_UILeftOrnament.invalidateStyle();
                this.m_UIRightOrnament.invalidateStyle();
                this.m_UITick.invalidateStyle();
                this.m_BarImages = null;
                this.m_BarLimits = null;
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "barImages":
                case "barLimits":
                {
                    this.m_BarImages = null;
                    this.m_BarLimits = null;
                    invalidateDisplayList();
                    break;
                }
                case "fontColor":
                case "fontFamily":
                case "fontSize":
                case "fontStyle":
                case "fontWeight":
                {
                    this.m_BarLabel.defaultTextFormat = new TextFormat(getStyle("fontFamily"), getStyle("fontSize"), getStyle("fontColor"), getStyle("fontWeight") == "bold", getStyle("fontStyle") == "italic");
                    invalidateDisplayList();
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function set tickValues(param1:Array) : void
        {
            if (this.m_TickValues != param1)
            {
                this.m_TickValues = param1;
                this.m_UncommittedTickValues = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedMaxValue)
            {
                this.m_UncommittedMaxValue = false;
            }
            if (this.m_UncommittedMinValue)
            {
                this.m_UncommittedMinValue = false;
            }
            if (this.m_UncommittedValue)
            {
                this.m_UncommittedValue = false;
            }
            if (this.m_UncommittedLabelEnabled)
            {
                this.m_UncommittedLabelEnabled = false;
            }
            if (this.m_UncommittedLabelFormat)
            {
                this.m_UncommittedLabelFormat = false;
            }
            if (this.m_UncommittedTickValues)
            {
                this.m_UncommittedTickValues = false;
            }
            return;
        }// end function

        public function set maxValue(param1:Number) : void
        {
            param1 = Math.max(0, param1);
            if (this.m_MaxValue != param1)
            {
                this.m_MaxValue = param1;
                this.m_UncommittedMaxValue = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function cacheBarLabel() : void
        {
            if (this.m_BarLabel == null)
            {
                this.m_BarLabel = createInFontContext(TextField) as TextField;
                this.m_BarLabel.autoSize = TextFieldAutoSize.LEFT;
                this.m_BarLabel.defaultTextFormat = new TextFormat(getStyle("fontFamily"), getStyle("fontSize"), getStyle("fontColor"), getStyle("fontWeight") == "bold", getStyle("fontStyle") == "italic");
                this.m_BarLabel.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
            }
            this.m_BarLabel.text = StringUtil.substitute(this.m_LabelFormat, this.m_MinValue, this.m_Value, this.m_MaxValue);
            var _loc_1:* = this.m_UILabel.bitmapData;
            if (_loc_1 == null || _loc_1.width != this.m_BarLabel.width || _loc_1.height != this.m_BarLabel.height)
            {
                var _loc_2:* = new BitmapData(this.m_BarLabel.width, this.m_BarLabel.height, true, 0);
                this.m_UILabel.bitmapData = new BitmapData(this.m_BarLabel.width, this.m_BarLabel.height, true, 0);
                _loc_1 = _loc_2;
                _loc_1.lock();
            }
            else
            {
                _loc_1.lock();
                _loc_1.fillRect(new Rectangle(0, 0, this.m_BarLabel.width, this.m_BarLabel.height), 0);
            }
            _loc_1.draw(this.m_BarLabel);
            _loc_1.unlock();
            return;
        }// end function

        public function set labelEnabled(param1:Boolean) : void
        {
            if (this.m_LabelEnabled != param1)
            {
                this.m_LabelEnabled = param1;
                this.m_UncommittedLabelEnabled = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = this.m_UIBackground.measuredWidth;
            measuredWidth = this.m_UIBackground.measuredWidth;
            measuredMinWidth = _loc_1;
            var _loc_1:* = this.m_UIBackground.measuredHeight;
            measuredHeight = this.m_UIBackground.measuredHeight;
            measuredMinHeight = _loc_1;
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            param1 = Math.max(this.m_MinValue, Math.min(param1, this.m_MaxValue));
            if (this.m_Value != param1)
            {
                this.m_Value = param1;
                this.m_UncommittedValue = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get maxValue() : Number
        {
            return this.m_MaxValue;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            return this.m_UIBackground.borderMetrics;
        }// end function

        public function get value() : Number
        {
            return this.m_Value;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.barImages = null;
                this.barLimits = null;
                this.fontColor = 16777215;
                this.fontFamily = "Verdana";
                this.fontSize = 11;
                this.fontStyle = "normal";
                this.fontWeight = "bold";
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.leftOrnamentOffset = 0;
                this.rightOrnamentOffset = 0;
                this.tickOffset = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
