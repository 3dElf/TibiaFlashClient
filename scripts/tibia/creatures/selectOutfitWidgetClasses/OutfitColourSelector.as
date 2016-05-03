package tibia.creatures.selectOutfitWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import shared.utility.*;

    public class OutfitColourSelector extends UIComponent
    {
        protected var m_HSI:int = 0;
        private var m_UncommittedHSI:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIColourRenderer:Vector.<ColourRenderer>;
        private static const BUNDLE:String = "SelectOutfitWidget";

        public function OutfitColourSelector()
        {
            this.m_UIColourRenderer = new Vector.<ColourRenderer>(Colour.HSI_H_STEPS * Colour.HSI_SI_VALUES, true);
            return;
        }// end function

        protected function onColourRendererClick(event:MouseEvent) : void
        {
            if (event != null)
            {
                this.HSI = ColourRenderer(event.currentTarget).data;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:* = NaN;
            var _loc_4:* = NaN;
            super.measure();
            var _loc_1:* = this.viewMetricsAndPadding;
            _loc_2 = getStyle("pickerSize");
            var _loc_3:* = getStyle("horizontalGap");
            _loc_4 = getStyle("verticalGap");
            var _loc_5:* = _loc_1.left + Colour.HSI_H_STEPS * (_loc_2 + _loc_3) - _loc_3 + _loc_1.right;
            measuredWidth = _loc_1.left + Colour.HSI_H_STEPS * (_loc_2 + _loc_3) - _loc_3 + _loc_1.right;
            measuredMinWidth = _loc_5;
            var _loc_5:* = _loc_1.top + Colour.HSI_SI_VALUES * (_loc_2 + _loc_4) - _loc_4 + _loc_1.bottom;
            measuredHeight = _loc_1.top + Colour.HSI_SI_VALUES * (_loc_2 + _loc_4) - _loc_4 + _loc_1.bottom;
            measuredMinHeight = _loc_5;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            super.commitProperties();
            if (this.m_UncommittedHSI)
            {
                _loc_1 = 0;
                _loc_2 = this.m_UIColourRenderer.length;
                while (_loc_1 < _loc_2)
                {
                    
                    if (this.m_UIColourRenderer[_loc_1] != null)
                    {
                        this.m_UIColourRenderer[_loc_1].selected = this.m_HSI == this.m_UIColourRenderer[_loc_1].data;
                    }
                    _loc_1++;
                }
                this.m_UncommittedHSI = false;
            }
            return;
        }// end function

        private function set _71838HSI(param1:int) : void
        {
            if (this.m_HSI != param1)
            {
                this.m_HSI = param1;
                this.m_UncommittedHSI = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = this.viewMetricsAndPadding;
            var _loc_4:* = getStyle("pickerSize");
            var _loc_5:* = getStyle("horizontalGap");
            var _loc_6:* = getStyle("verticalGap");
            var _loc_7:* = 0;
            var _loc_8:* = this.m_UIColourRenderer.length;
            var _loc_9:* = _loc_3.left;
            var _loc_10:* = _loc_3.top - _loc_4 - _loc_6;
            while (_loc_7 < _loc_8)
            {
                
                if (this.m_UIColourRenderer[_loc_7] != null)
                {
                    if (_loc_7 % Colour.HSI_H_STEPS == 0)
                    {
                        _loc_9 = _loc_3.left;
                        _loc_10 = _loc_10 + (_loc_4 + _loc_6);
                    }
                    this.m_UIColourRenderer[_loc_7].move(_loc_9, _loc_10);
                    this.m_UIColourRenderer[_loc_7].setActualSize(_loc_4, _loc_4);
                    _loc_9 = _loc_9 + (_loc_4 + _loc_5);
                }
                _loc_7++;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = 0;
                while (_loc_1 < Colour.HSI_SI_VALUES)
                {
                    
                    _loc_2 = 0;
                    while (_loc_2 < Colour.HSI_H_STEPS)
                    {
                        
                        _loc_3 = _loc_1 * Colour.HSI_H_STEPS + _loc_2;
                        this.m_UIColourRenderer[_loc_3] = new ColourRenderer();
                        this.m_UIColourRenderer[_loc_3].ARGB = Colour.s_ARGBFromHSI(_loc_3);
                        this.m_UIColourRenderer[_loc_3].data = _loc_3;
                        this.m_UIColourRenderer[_loc_3].selected = this.m_HSI == _loc_3;
                        this.m_UIColourRenderer[_loc_3].styleName = this;
                        this.m_UIColourRenderer[_loc_3].addEventListener(MouseEvent.CLICK, this.onColourRendererClick);
                        addChild(this.m_UIColourRenderer[_loc_3]);
                        _loc_2++;
                    }
                    _loc_1++;
                }
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set HSI(param1:int) : void
        {
            var _loc_2:* = this.HSI;
            if (_loc_2 !== param1)
            {
                this._71838HSI = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "HSI", _loc_2, param1));
            }
            return;
        }// end function

        public function get HSI() : int
        {
            return this.m_HSI;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = new EdgeMetrics();
            _loc_1.bottom = getStyle("paddingBottom");
            _loc_1.left = getStyle("paddingLeft");
            _loc_1.right = getStyle("paddingRight");
            _loc_1.top = getStyle("paddingTop");
            return _loc_1;
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
                this.pickerSize = 12;
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
