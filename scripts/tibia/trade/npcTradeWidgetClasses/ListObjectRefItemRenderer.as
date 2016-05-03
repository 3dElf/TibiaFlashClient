package tibia.trade.npcTradeWidgetClasses
{
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.styles.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.trade.*;

    public class ListObjectRefItemRenderer extends UIComponent implements IListItemRenderer
    {
        protected var m_UIObject:SkinnedAppearanceRenderer = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIName:Label = null;
        protected var m_UIProperties:Label = null;
        private var m_UncommittedData:Boolean = false;
        protected var m_Data:TradeObjectRef = null;
        private static const BUNDLE:String = "NPCTradeWidget";

        public function ListObjectRefItemRenderer()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = getStyle("rendererPaddingLeft");
            var _loc_6:* = getStyle("rendererPaddingTop");
            var _loc_7:* = param1 - _loc_5 - getStyle("rendererPaddingRight");
            var _loc_8:* = param2 - _loc_6 - getStyle("rendererPaddingBottom");
            var _loc_9:* = getStyle("rendererHorizontalGap");
            _loc_3 = this.m_UIObject.getExplicitOrMeasuredWidth();
            _loc_4 = this.m_UIObject.getExplicitOrMeasuredHeight();
            this.m_UIObject.setActualSize(_loc_3, _loc_4);
            this.m_UIObject.move(_loc_5, _loc_6 + (_loc_8 - _loc_4) / 2);
            this.m_UIObject.visible = true;
            _loc_5 = _loc_5 + (_loc_3 + _loc_9);
            _loc_7 = _loc_7 - (_loc_3 + _loc_9);
            _loc_3 = this.m_UIProperties.getExplicitOrMeasuredWidth();
            _loc_4 = this.m_UIProperties.getExplicitOrMeasuredHeight();
            this.m_UIProperties.setActualSize(_loc_7, _loc_4);
            this.m_UIProperties.move(_loc_5, _loc_6 + _loc_8 - _loc_4);
            this.m_UIProperties.visible = true;
            _loc_8 = _loc_8 - _loc_4;
            _loc_3 = this.m_UIName.getExplicitOrMeasuredWidth();
            _loc_4 = this.m_UIName.getExplicitOrMeasuredHeight();
            this.m_UIName.setActualSize(_loc_7, _loc_8);
            this.m_UIName.move(_loc_5, _loc_6);
            this.m_UIName.visible = true;
            return;
        }// end function

        private function getObjectName() : String
        {
            if (this.m_Data != null)
            {
                return this.m_Data.name;
            }
            return null;
        }// end function

        private function getObjectProperties() : String
        {
            if (this.m_Data != null)
            {
                return resourceManager.getString(BUNDLE, "LBL_MONEY_AND_WEIGHT_FORMAT", [this.m_Data.price, (this.m_Data.weight / 100).toFixed(2)]);
            }
            return null;
        }// end function

        public function get data() : Object
        {
            return this.m_Data;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            super.measure();
            _loc_1 = getStyle("rendererPaddingLeft") + getStyle("rendererPaddingRight");
            _loc_2 = getStyle("rendererPaddingTop") + getStyle("rendererPaddingBottom");
            _loc_3 = Math.max(this.m_UIObject.getExplicitOrMeasuredWidth(), this.m_UIName.getExplicitOrMeasuredHeight() + this.m_UIProperties.getExplicitOrMeasuredHeight());
            _loc_4 = this.m_UIObject.getExplicitOrMeasuredHeight() + getStyle("rendererHorizontalGap") + Math.max(this.m_UIName.getExplicitOrMeasuredWidth(), this.m_UIProperties.getExplicitOrMeasuredWidth());
            measuredWidth = _loc_4 + _loc_1;
            measuredMinWidth = _loc_4 + _loc_1;
            measuredHeight = _loc_3 + _loc_2;
            measuredMinHeight = _loc_3 + _loc_2;
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIObject = new SkinnedAppearanceRenderer();
                this.m_UIObject.appearance = this.m_Data;
                this.m_UIObject.styleName = "npcTradeWidgetView";
                addChild(this.m_UIObject);
                this.m_UIName = new Label();
                this.m_UIName.percentHeight = 100;
                this.m_UIName.percentWidth = 100;
                this.m_UIName.text = this.getObjectName();
                addChild(this.m_UIName);
                this.m_UIProperties = new Label();
                this.m_UIProperties.percentHeight = NaN;
                this.m_UIProperties.percentWidth = 100;
                this.m_UIProperties.text = this.getObjectProperties();
                addChild(this.m_UIProperties);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this.m_Data = param1 as TradeObjectRef;
            this.m_UncommittedData = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            super.commitProperties();
            if (this.m_UncommittedData)
            {
                _loc_1 = this.m_Data != null && this.m_Data.amount > 0;
                this.m_UIObject.enabled = _loc_1;
                this.m_UIObject.appearance = this.m_Data;
                this.m_UIName.enabled = _loc_1;
                this.m_UIName.text = this.getObjectName();
                this.m_UIProperties.enabled = _loc_1;
                this.m_UIProperties.text = this.getObjectProperties();
                this.m_UncommittedData = false;
            }
            return;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.rendererHorizontalGap = 2;
                this.rendererVerticalGap = 0;
                this.rendererPaddingBottom = 2;
                this.rendererPaddingLeft = 2;
                this.rendererPaddingRight = 2;
                this.rendererPaddingTop = 2;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
