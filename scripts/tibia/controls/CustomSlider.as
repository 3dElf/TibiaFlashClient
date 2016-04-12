package tibia.controls
{
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.sliderClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.skins.halo.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.input.*;

    public class CustomSlider extends Canvas
    {
        protected var m_UIIncrease:Button = null;
        protected var m_TrackClickEnabled:Boolean = true;
        protected var m_ButtonClickEnabled:Boolean = true;
        protected var m_UISlider:Slider = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIDecrease:Button = null;
        protected var m_TrackClickAmount:Number = 10;
        private static const SLIDER_STYLE_FILTER:Object = {borderColor:"borderColor", dataTipOffset:"dataTipOffset", dataTipPrecision:"dataTipPrecision", dataTipStyleName:"dataTipStyleName", fillAlphas:"fillAlphas", fillColors:"fillColors", invertThumbDirection:"invertThumbDirection", labelOffset:"labelOffset", labelStyleName:"labelStyleName", showTrackHighlight:"showTrackHighlight", slideDuration:"slideDuration", slideEasingFunction:"slideEasingFunction", thumbDisabledSkin:"thumbDisabledSkin", thumbDownSkin:"thumbDownSkin", thumbOffset:"thumbOffset", thumbOverSkin:"thumbOverSkin", thumbSkin:"thumbSkin", thumbUpSkin:"thumbUpSkin", tickColor:"tickColor", tickLength:"tickLength", tickOffset:"tickOffset", tickThickness:"tickThickness", trackColors:"trackColors", trackHighlightSkin:"trackHighlightSkin", trackMargin:"trackMargin", trackSkin:"trackSkin"};

        public function CustomSlider()
        {
            this.m_UISlider = new HSlider();
            this.m_UISlider.addEventListener(SliderEvent.CHANGE, this.onSliderEvent);
            this.m_UISlider.addEventListener(SliderEvent.THUMB_DRAG, this.onSliderEvent);
            this.m_UISlider.addEventListener(SliderEvent.THUMB_PRESS, this.onSliderEvent);
            this.m_UISlider.addEventListener(SliderEvent.THUMB_RELEASE, this.onSliderEvent);
            this.m_UIDecrease = new CustomButton();
            this.m_UIIncrease = new CustomButton();
            return;
        }// end function

        public function get tickInterval() : Number
        {
            return this.m_UISlider.tickInterval;
        }// end function

        public function get sliderThumbClass() : Class
        {
            return this.m_UISlider.sliderThumbClass;
        }// end function

        public function set tickInterval(param1:Number) : void
        {
            this.m_UISlider.tickInterval = param1;
            return;
        }// end function

        public function set labels(param1:Array) : void
        {
            this.m_UISlider.labels = param1;
            return;
        }// end function

        public function set sliderThumbClass(param1:Class) : void
        {
            this.m_UISlider.sliderThumbClass = param1;
            return;
        }// end function

        public function get minimum() : Number
        {
            return this.m_UISlider.minimum;
        }// end function

        public function get labels() : Array
        {
            return this.m_UISlider.labels;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIDecrease.styleName = getStyle("decreaseButtonStyle");
                this.m_UIDecrease.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonDown);
                this.m_UIDecrease.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                this.m_UIDecrease.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onButtonClick);
                addChild(this.m_UIDecrease);
                this.m_UISlider.allowTrackClick = false;
                this.m_UISlider.minHeight = NaN;
                this.m_UISlider.minWidth = 10;
                this.m_UISlider.sliderThumbClass = ;
                this.m_UISlider.styleName = new StyleProxy(this, SLIDER_STYLE_FILTER);
                this.m_UISlider.addEventListener(MouseEvent.CLICK, this.onTrackDown);
                addChild(this.m_UISlider);
                this.m_UIIncrease.styleName = getStyle("increaseButtonStyle");
                this.m_UIIncrease.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonDown);
                this.m_UIIncrease.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                this.m_UIIncrease.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onButtonClick);
                addChild(this.m_UIIncrease);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set minimum(param1:Number) : void
        {
            this.m_UISlider.minimum = param1;
            this.m_UIDecrease.enabled = this.value > param1;
            return;
        }// end function

        protected function onButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            if (this.m_ButtonClickEnabled)
            {
                _loc_2 = event.shiftKey ? (10) : (1);
                if (event.currentTarget == this.m_UIDecrease)
                {
                    this.value = this.value - this.m_UISlider.snapInterval * _loc_2;
                }
                else
                {
                    this.value = this.value + this.m_UISlider.snapInterval * _loc_2;
                }
                _loc_3 = new SliderEvent(SliderEvent.CHANGE);
                _loc_3.clickTarget = String(event.currentTarget);
                _loc_3.thumbIndex = 0;
                _loc_3.triggerEvent = new MouseEvent(MouseEvent.CLICK);
                _loc_3.value = this.value;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function get tickValues() : Array
        {
            return this.m_UISlider.tickValues;
        }// end function

        public function get maximum() : Number
        {
            return this.m_UISlider.maximum;
        }// end function

        public function get values() : Array
        {
            return this.m_UISlider.values;
        }// end function

        public function get allowTrackClick() : Boolean
        {
            return this.m_TrackClickEnabled;
        }// end function

        public function set showDataTip(param1:Boolean) : void
        {
            this.m_UISlider.showDataTip = param1;
            return;
        }// end function

        public function get snapInterval() : Number
        {
            return this.m_UISlider.snapInterval;
        }// end function

        public function set thumbCount(param1:int) : void
        {
            return;
        }// end function

        public function set liveDragging(param1:Boolean) : void
        {
            this.m_UISlider.liveDragging = param1;
            return;
        }// end function

        public function set tickValues(param1:Array) : void
        {
            this.m_UISlider.tickValues = param1;
            return;
        }// end function

        public function set dataTipFormatFunction(param1:Function) : void
        {
            this.m_UISlider.dataTipFormatFunction = param1;
            return;
        }// end function

        protected function onButtonDown(event:MouseEvent) : void
        {
            if (event is MouseRepeatEvent)
            {
                MouseRepeatEvent(event).repeatEnabled = true;
            }
            return;
        }// end function

        public function set values(param1:Array) : void
        {
            this.m_UISlider.values = param1;
            return;
        }// end function

        public function set maximum(param1:Number) : void
        {
            this.m_UISlider.maximum = param1;
            this.m_UIIncrease.enabled = this.value < param1;
            return;
        }// end function

        public function set allowTrackClick(param1:Boolean) : void
        {
            this.m_TrackClickEnabled = param1;
            return;
        }// end function

        public function set sliderDataTipClass(param1:Class) : void
        {
            this.m_UISlider.sliderDataTipClass = param1;
            return;
        }// end function

        public function get showDataTip() : Boolean
        {
            return this.m_UISlider.showDataTip;
        }// end function

        public function setThumbValueAt(param1:int, param2:Number) : void
        {
            return this.m_UISlider.setThumbValueAt(param1, param2);
        }// end function

        public function get thumbCount() : int
        {
            return this.m_UISlider.thumbCount;
        }// end function

        protected function onSliderEvent(event:SliderEvent) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event.clone());
                this.m_UIDecrease.enabled = this.value > this.minimum;
                this.m_UIIncrease.enabled = this.value < this.maximum;
            }
            return;
        }// end function

        public function get liveDragging() : Boolean
        {
            return this.m_UISlider.liveDragging;
        }// end function

        public function set snapInterval(param1:Number) : void
        {
            this.m_UISlider.snapInterval = param1;
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            this.m_UISlider.value = param1;
            this.m_UIDecrease.enabled = param1 > this.minimum;
            this.m_UIIncrease.enabled = param1 < this.maximum;
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = null;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            super.measure();
            _loc_1 = viewMetricsAndPadding;
            var _loc_2:* = getStyle("horizontalGap");
            var _loc_3:* = getStyle("verticalGap");
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            while (_loc_9 < numChildren)
            {
                
                _loc_10 = UIComponent(getChildAt(_loc_9));
                if (_loc_10 == null || !_loc_10.includeInLayout)
                {
                }
                else
                {
                    _loc_11 = _loc_10.getExplicitOrMeasuredHeight();
                    _loc_12 = _loc_10.getExplicitOrMeasuredWidth();
                    _loc_13 = !isNaN(_loc_10.explicitMinHeight) ? (_loc_10.explicitMinHeight) : (_loc_10.measuredMinHeight);
                    _loc_14 = !isNaN(_loc_10.explicitMinWidth) ? (_loc_10.explicitMinWidth) : (_loc_10.measuredMinWidth);
                    if (this.direction == SliderDirection.HORIZONTAL)
                    {
                        _loc_7 = _loc_7 + _loc_14;
                        _loc_6 = _loc_6 + _loc_12;
                        _loc_5 = Math.max(_loc_5, _loc_13);
                        _loc_4 = Math.max(_loc_4, _loc_11);
                    }
                    else
                    {
                        _loc_7 = Math.max(_loc_7, _loc_14);
                        _loc_6 = Math.max(_loc_7, _loc_12);
                        _loc_5 = _loc_5 + _loc_13;
                        _loc_4 = _loc_4 + _loc_11;
                    }
                    _loc_8++;
                }
                _loc_9++;
            }
            _loc_8 = Math.max(0, (_loc_8 - 1));
            if (this.direction == SliderDirection.HORIZONTAL)
            {
                _loc_7 = _loc_7 + _loc_8 * _loc_2;
                _loc_6 = _loc_6 + _loc_8 * _loc_2;
            }
            else
            {
                _loc_5 = _loc_5 + _loc_8 * _loc_3;
                _loc_4 = _loc_4 + _loc_8 * _loc_3;
            }
            measuredMinWidth = _loc_7 + _loc_1.left + _loc_1.right;
            measuredWidth = _loc_6 + _loc_1.left + _loc_1.right;
            measuredMinHeight = _loc_5 + _loc_1.top + _loc_1.bottom;
            measuredHeight = _loc_4 + _loc_1.top + _loc_1.bottom;
            return;
        }// end function

        public function get sliderDataTipClass() : Class
        {
            return this.m_UISlider.sliderDataTipClass;
        }// end function

        public function set trackClickAmount(param1:Number) : void
        {
            this.m_TrackClickAmount = param1;
            return;
        }// end function

        protected function onTrackDown(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = this.m_UISlider;
            if (this.m_TrackClickEnabled && event != null && event.target == _loc_5.mx_internal::getTrackHitArea())
            {
                _loc_2 = _loc_5.getThumbAt(0);
                _loc_3 = _loc_2.localToGlobal(new Point(0, 0)).x + _loc_2.width / _loc_2.scaleX / 2;
                if (event.stageX < _loc_3)
                {
                    this.value = this.value - this.m_TrackClickAmount;
                }
                else
                {
                    this.value = this.value + this.m_TrackClickAmount;
                }
                _loc_4 = new SliderEvent(SliderEvent.CHANGE);
                _loc_4.clickTarget = String(event.target);
                _loc_4.thumbIndex = 0;
                _loc_4.triggerEvent = new MouseEvent(MouseEvent.CLICK);
                _loc_4.value = this.value;
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

        public function get dataTipFormatFunction() : Function
        {
            return this.m_UISlider.dataTipFormatFunction;
        }// end function

        public function get value() : Number
        {
            return this.m_UISlider.value;
        }// end function

        public function getThumbAt(param1:int) : SliderThumb
        {
            return this.m_UISlider.getThumbAt(param1);
        }// end function

        public function set allowThumbOverlap(param1:Boolean) : void
        {
            this.m_UISlider.allowThumbOverlap = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = viewMetricsAndPadding;
            var _loc_4:* = getStyle("horizontalGap");
            var _loc_5:* = getStyle("verticalGap");
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (this.direction == SliderDirection.HORIZONTAL)
            {
                param2 = param2 - (_loc_3.top + _loc_3.bottom);
                _loc_6 = this.m_UIDecrease.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UIDecrease.getExplicitOrMeasuredWidth();
                this.m_UIDecrease.move(_loc_3.left, _loc_3.top + (param2 - _loc_6) / 2);
                this.m_UIDecrease.setActualSize(_loc_7, _loc_6);
                _loc_8 = _loc_3.left + _loc_7 + _loc_4;
                _loc_10 = param1 - _loc_8;
                _loc_6 = this.m_UIIncrease.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UIIncrease.getExplicitOrMeasuredWidth();
                this.m_UIIncrease.move(param1 - _loc_3.right - _loc_7, _loc_3.top + (param2 - _loc_6) / 2);
                this.m_UIIncrease.setActualSize(_loc_7, _loc_6);
                _loc_10 = _loc_10 - (_loc_3.right + _loc_7 + _loc_4);
                _loc_6 = this.m_UISlider.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UISlider.getExplicitOrMeasuredWidth();
                this.m_UISlider.move(_loc_8, _loc_3.top + (param2 - _loc_6) / 2);
                this.m_UISlider.setActualSize(_loc_10, _loc_6);
            }
            else
            {
                param1 = param1 - (_loc_3.left + _loc_3.right);
                _loc_6 = this.m_UIDecrease.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UIDecrease.getExplicitOrMeasuredWidth();
                this.m_UIDecrease.move(_loc_3.left + (param1 - _loc_7) / 2, _loc_3.top);
                this.m_UIDecrease.setActualSize(_loc_7, _loc_6);
                _loc_9 = _loc_3.top + _loc_6 + _loc_5;
                _loc_10 = param2 - _loc_9;
                _loc_6 = this.m_UIIncrease.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UIIncrease.getExplicitOrMeasuredWidth();
                this.m_UIIncrease.move(_loc_3.left + (param1 - _loc_7) / 2, param2 - _loc_3.bottom - _loc_6);
                this.m_UIIncrease.setActualSize(_loc_7, _loc_6);
                _loc_10 = _loc_10 - (_loc_3.bottom + _loc_6 + _loc_5);
                _loc_6 = this.m_UISlider.getExplicitOrMeasuredHeight();
                _loc_7 = this.m_UISlider.getExplicitOrMeasuredWidth();
                this.m_UISlider.move(_loc_3.left + (param1 - _loc_7) / 2, _loc_9);
                this.m_UISlider.setActualSize(_loc_7, _loc_10);
            }
            return;
        }// end function

        public function get allowThumbOverlap() : Boolean
        {
            return this.m_UISlider.allowThumbOverlap;
        }// end function

        public function set direction(param1:String) : void
        {
            return;
        }// end function

        public function get direction() : String
        {
            return this.m_UISlider.direction;
        }// end function

        private static function s_InitialiseStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.borderColor = 9542041;
                this.dataTipOffset = 16;
                this.dataTipPlacement = "top";
                this.dataTipPrecision = 2;
                this.labelOffset = -10;
                this.showTrackHighlight = false;
                this.slideDuration = 300;
                this.thumbDisabledSkin = null;
                this.thumbDownSkin = null;
                this.thumbOffset = 0;
                this.thumbOverSkin = null;
                this.thumbSkin = SliderThumbSkin;
                this.thumbUpSkin = null;
                this.tickColor = 7305079;
                this.tickLength = 3;
                this.tickOffset = -6;
                this.tickThickness = 1;
                this.trackColors = [15198183, 15198183];
                this.trackHighlightSkin = SliderHighlightSkin;
                this.trackSkin = SliderTrackSkin;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitialiseStyle();
    }
}
