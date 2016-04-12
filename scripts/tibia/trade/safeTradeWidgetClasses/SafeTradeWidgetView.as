package tibia.trade.safeTradeWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.appearances.*;
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.network.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class SafeTradeWidgetView extends WidgetView
    {
        private var m_UncommittedOtherItems:Boolean = false;
        private var m_UIStateTradeAccept:Button = null;
        private var m_UncommittedOwnItems:Boolean = false;
        protected var m_OwnItems:IList = null;
        protected var m_State:int = 0;
        private var m_UIOwnItems:Container = null;
        private var m_UncommittedOtherName:Boolean = false;
        private var m_UIOwnName:Label = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIOtherName:Label = null;
        private var m_UIStateTradeReject:Button = null;
        protected var m_OwnName:String = null;
        protected var m_OtherItems:IList = null;
        protected var m_OtherName:String = null;
        private var m_UIOtherItems:Container = null;
        private var m_UIStateWaitReject:Button = null;
        private var m_UncommittedOwnName:Boolean = false;
        private var m_UIFooter:ViewStack = null;
        private var m_UIStateAcceptReject:Button = null;
        private static const BUNDLE:String = "SafeTradeWidget";
        private static const STATE_WAIT:int = 0;
        private static const STATE_ACCEPT:int = 2;
        private static const STATE_TRADE:int = 1;

        public function SafeTradeWidgetView()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            return;
        }// end function

        function get otherItems() : IList
        {
            return this.m_OtherItems;
        }// end function

        private function buildItemSlots(param1:IList, param2:Container) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            _loc_3 = param2.numChildren - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_5 = param2.removeChildAt(_loc_3) as ContainerSlot;
                if (_loc_5 != null)
                {
                    _loc_5.removeEventListener(MouseEvent.CLICK, this.onItemClick);
                    _loc_5.removeEventListener(MouseEvent.RIGHT_CLICK, this.onItemClick);
                }
                _loc_3 = _loc_3 - 1;
            }
            if (param1 != null)
            {
                _loc_3 = 0;
                _loc_4 = param1.length;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_5 = new ContainerSlot();
                    _loc_5.appearance = param1.getItemAt(_loc_3) as AppearanceInstance;
                    _loc_5.styleName = getStyle("tradeItemSlotStyle");
                    _loc_5.addEventListener(MouseEvent.CLICK, this.onItemClick);
                    _loc_5.addEventListener(MouseEvent.RIGHT_CLICK, this.onItemClick);
                    param2.addChild(_loc_5);
                    _loc_3++;
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_1.setStyle("horizontalAlign", "left");
                _loc_1.setStyle("horizontalGap", 1);
                this.m_UIOwnName = new CustomLabel();
                this.m_UIOwnName.height = NaN;
                this.m_UIOwnName.text = this.m_OwnName;
                this.m_UIOwnName.width = 76;
                this.m_UIOwnName.setStyle("fontSize", 9);
                this.m_UIOwnName.setStyle("paddingTop", -2);
                this.m_UIOwnName.setStyle("paddingBottom", -2);
                _loc_1.addChild(this.m_UIOwnName);
                this.m_UIOtherName = new CustomLabel();
                this.m_UIOtherName.height = NaN;
                this.m_UIOtherName.text = this.m_OtherName;
                this.m_UIOtherName.width = 76;
                this.m_UIOtherName.setStyle("fontSize", 9);
                this.m_UIOtherName.setStyle("paddingTop", -2);
                this.m_UIOtherName.setStyle("paddingBottom", -2);
                _loc_1.addChild(this.m_UIOtherName);
                addChild(_loc_1);
                this.m_UIOwnItems = new CustomTile();
                CustomTile(this.m_UIOwnItems).columns = 2;
                this.m_UIOwnItems.percentHeight = 100;
                this.m_UIOwnItems.percentWidth = 50;
                this.m_UIOwnItems.styleName = getStyle("tradeItemListStyle");
                this.m_UIOwnItems.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIOwnItems.setStyle("borderColor", getStyle("separatorColor"));
                this.m_UIOwnItems.setStyle("borderSides", "right");
                this.m_UIOwnItems.setStyle("borderStyle", "solid");
                this.m_UIOtherItems = new CustomTile();
                CustomTile(this.m_UIOtherItems).columns = 2;
                this.m_UIOtherItems.percentHeight = 100;
                this.m_UIOtherItems.percentWidth = 50;
                this.m_UIOtherItems.styleName = getStyle("tradeItemListStyle");
                this.m_UIOtherItems.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIOtherItems.setStyle("borderColor", getStyle("separatorColor"));
                this.m_UIOtherItems.setStyle("borderSides", "left");
                this.m_UIOtherItems.setStyle("borderStyle", "solid");
                _loc_2 = new HBox();
                _loc_2.percentHeight = 100;
                _loc_2.percentWidth = 100;
                _loc_2.verticalScrollPolicy = ScrollPolicy.ON;
                _loc_2.addChild(this.m_UIOwnItems);
                _loc_2.addChild(this.m_UIOtherItems);
                _loc_2.setStyle("horizontalGap", -1);
                _loc_2.setStyle("borderColor", getStyle("separatorColor"));
                _loc_2.setStyle("borderSides", "top bottom");
                _loc_2.setStyle("borderStyle", "solid");
                addChild(_loc_2);
                _loc_3 = new HBox();
                _loc_3.percentHeight = 100;
                _loc_3.percentWidth = 100;
                _loc_3.setStyle("horizontalAlign", "right");
                _loc_3.setStyle("verticalAlign", "middle");
                _loc_4 = new Text();
                _loc_4.percentHeight = 100;
                _loc_4.percentWidth = 100;
                _loc_4.text = resourceManager.getString(BUNDLE, "FOOTER_WAIT_FOR_OFFER_TEXT");
                _loc_4.setStyle("fontSize", 9);
                _loc_4.setStyle("textAlign", "center");
                _loc_4.setStyle("paddingTop", -3);
                _loc_4.setStyle("paddingBottom", -3);
                _loc_3.addChild(_loc_4);
                this.m_UIStateWaitReject = new CustomButton();
                this.m_UIStateWaitReject.label = resourceManager.getString(BUNDLE, "FOOTER_CANCEL_LABEL");
                this.m_UIStateWaitReject.toolTip = resourceManager.getString(BUNDLE, "FOOTER_CANCEL_TOOLTIP");
                this.m_UIStateWaitReject.addEventListener(MouseEvent.CLICK, this.onReject);
                _loc_3.addChild(this.m_UIStateWaitReject);
                _loc_5 = new HBox();
                _loc_5.percentHeight = 100;
                _loc_5.percentWidth = 100;
                _loc_5.setStyle("horizontalAlign", "right");
                _loc_5.setStyle("verticalAlign", "middle");
                this.m_UIStateTradeAccept = new CustomButton();
                this.m_UIStateTradeAccept.label = resourceManager.getString(BUNDLE, "FOOTER_ACCEPT_LABEL");
                this.m_UIStateTradeAccept.toolTip = resourceManager.getString(BUNDLE, "FOOTER_ACCEPT_TOOLTIP");
                this.m_UIStateTradeAccept.addEventListener(MouseEvent.CLICK, this.onAccept);
                _loc_5.addChild(this.m_UIStateTradeAccept);
                this.m_UIStateTradeReject = new CustomButton();
                this.m_UIStateTradeReject.label = resourceManager.getString(BUNDLE, "FOOTER_REJECT_LABEL");
                this.m_UIStateTradeReject.toolTip = resourceManager.getString(BUNDLE, "FOOTER_REJECT_TOOLTIP");
                this.m_UIStateTradeReject.addEventListener(MouseEvent.CLICK, this.onReject);
                _loc_5.addChild(this.m_UIStateTradeReject);
                _loc_6 = new HBox();
                _loc_6.percentHeight = 100;
                _loc_6.percentWidth = 100;
                _loc_6.setStyle("horizontalAlign", "right");
                _loc_6.setStyle("verticalAlign", "middle");
                _loc_7 = new Text();
                _loc_7.percentHeight = 100;
                _loc_7.percentWidth = 100;
                _loc_7.text = resourceManager.getString(BUNDLE, "FOOTER_WAIT_FOR_ACCEPT_TEXT");
                _loc_7.setStyle("fontSize", 9);
                _loc_7.setStyle("textAlign", "center");
                _loc_7.setStyle("paddingTop", -3);
                _loc_7.setStyle("paddingBottom", -3);
                _loc_6.addChild(_loc_7);
                this.m_UIStateAcceptReject = new CustomButton();
                this.m_UIStateAcceptReject.label = resourceManager.getString(BUNDLE, "FOOTER_REJECT_LABEL");
                this.m_UIStateAcceptReject.toolTip = resourceManager.getString(BUNDLE, "FOOTER_REJECT_TOOLTIP");
                this.m_UIStateAcceptReject.addEventListener(MouseEvent.CLICK, this.onReject);
                _loc_6.addChild(this.m_UIStateAcceptReject);
                this.m_UIFooter = new ViewStack();
                this.m_UIFooter.minHeight = 24;
                this.m_UIFooter.minWidth = NaN;
                this.m_UIFooter.percentHeight = NaN;
                this.m_UIFooter.percentWidth = 100;
                this.m_UIFooter.selectedIndex = this.m_State;
                this.m_UIFooter.addChild(_loc_3);
                this.m_UIFooter.addChild(_loc_5);
                this.m_UIFooter.addChild(_loc_6);
                addChild(this.m_UIFooter);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onItemClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ContainerSlot;
            if (_loc_2 == null || _loc_2.parent == null)
            {
                return;
            }
            var _loc_3:* = -1;
            var _loc_4:* = _loc_2.parent.getChildIndex(_loc_2);
            if (_loc_2.parent == this.m_UIOwnItems)
            {
                _loc_3 = 0;
            }
            else if (_loc_2.parent == this.m_UIOtherItems)
            {
                _loc_3 = 1;
            }
            var _loc_5:* = Tibia.s_GetCommunication();
            if (Tibia.s_GetCommunication() != null && _loc_5.isGameRunning)
            {
                _loc_5.sendCINSPECTTRADE(_loc_3, _loc_4);
            }
            return;
        }// end function

        function set otherItems(param1:IList) : void
        {
            if (this.m_OtherItems != param1)
            {
                this.m_OtherItems = param1;
                this.m_UncommittedOtherItems = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get ownName() : String
        {
            return this.m_OwnName;
        }// end function

        function set ownItems(param1:IList) : void
        {
            if (this.m_OwnItems != param1)
            {
                this.m_OwnItems = param1;
                this.m_UncommittedOwnItems = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get otherName() : String
        {
            return this.m_OtherName;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            this.buildItemSlots(null, this.m_UIOtherItems);
            this.buildItemSlots(null, this.m_UIOwnItems);
            this.m_UIStateAcceptReject.removeEventListener(MouseEvent.CLICK, this.onReject);
            this.m_UIStateTradeAccept.removeEventListener(MouseEvent.CLICK, this.onAccept);
            this.m_UIStateTradeReject.removeEventListener(MouseEvent.CLICK, this.onReject);
            this.m_UIStateWaitReject.removeEventListener(MouseEvent.CLICK, this.onReject);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = false;
            if (this.m_UncommittedOwnName)
            {
                _loc_1 = true;
                this.m_UIOwnName.text = this.m_OwnName;
                this.m_UncommittedOwnName = false;
            }
            if (this.m_UncommittedOwnItems)
            {
                _loc_1 = true;
                this.buildItemSlots(this.m_OwnItems, this.m_UIOwnItems);
                this.m_UncommittedOwnItems = false;
            }
            if (this.m_UncommittedOtherName)
            {
                _loc_1 = true;
                this.m_UIOtherName.text = this.m_OtherName;
                this.m_UncommittedOtherName = false;
            }
            if (this.m_UncommittedOtherItems)
            {
                _loc_1 = true;
                this.buildItemSlots(this.m_OtherItems, this.m_UIOtherItems);
                this.m_UncommittedOtherItems = false;
            }
            if (_loc_1)
            {
                if (this.m_OwnName != null && this.m_OwnName.length > 0 && (this.m_OwnItems != null && this.m_OwnItems.length > 0) && (this.m_OtherName != null && this.m_OtherName.length > 0) && (this.m_OtherItems != null && this.m_OtherItems.length > 0))
                {
                    this.m_State = STATE_TRADE;
                }
                else
                {
                    this.m_State = STATE_WAIT;
                }
                this.m_UIFooter.selectedIndex = this.m_State;
            }
            return;
        }// end function

        protected function onAccept(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.m_State == STATE_TRADE)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCACCEPTTRADE();
                }
                this.m_State = STATE_ACCEPT;
                this.m_UIFooter.selectedIndex = this.m_State;
            }
            return;
        }// end function

        function get ownItems() : IList
        {
            return this.m_OwnItems;
        }// end function

        protected function onReject(event:MouseEvent) : void
        {
            if (widgetInstance != null)
            {
                widgetInstance.close();
            }
            return;
        }// end function

        function set ownName(param1:String) : void
        {
            if (this.m_OwnName != param1)
            {
                this.m_OwnName = param1;
                this.m_UncommittedOwnName = true;
                invalidateProperties();
            }
            return;
        }// end function

        function set otherName(param1:String) : void
        {
            if (this.m_OtherName != param1)
            {
                this.m_OtherName = param1;
                this.m_UncommittedOtherName = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}

import flash.events.*;

import mx.collections.*;

import mx.containers.*;

import mx.controls.*;

import mx.core.*;

import shared.controls.*;

import tibia.appearances.*;

import tibia.container.containerViewWidgetClasses.*;

import tibia.network.*;

import tibia.sidebar.sideBarWidgetClasses.*;

class CustomTile extends Tile
{
    protected var m_Columns:int = 1;

    function CustomTile()
    {
        return;
    }// end function

    override protected function measure() : void
    {
        var _loc_1:* = null;
        var _loc_2:* = 0;
        if (numChildren < 1)
        {
            var _loc_3:* = 0;
            measuredHeight = 0;
            measuredMinHeight = _loc_3;
            var _loc_3:* = 0;
            measuredWidth = 0;
            measuredMinWidth = _loc_3;
        }
        else
        {
            _loc_1 = viewMetricsAndPadding;
            _loc_2 = Math.ceil(numChildren / this.m_Columns);
            .mx_internal::findCellSize();
            measuredMinHeight = mx_internal::cellHeight;
            measuredHeight = _loc_1.top + _loc_2 * mx_internal::cellHeight + (_loc_2 - 1) * getStyle("verticalGap") + _loc_1.bottom;
            measuredMinWidth = mx_internal::cellWidth;
            measuredWidth = _loc_1.left + this.m_Columns * mx_internal::cellWidth + (this.m_Columns - 1) * getStyle("horizontalGap") + _loc_1.right;
        }
        return;
    }// end function

    override public function get width() : Number
    {
        return measuredWidth;
    }// end function

    public function set columns(param1:int) : void
    {
        if (param1 < 1)
        {
            param1 = 1;
        }
        if (this.m_Columns != param1)
        {
            this.m_Columns = param1;
            invalidateDisplayList();
            invalidateSize();
        }
        return;
    }// end function

    public function get columns() : int
    {
        return this.m_Columns;
    }// end function

    override public function get height() : Number
    {
        return measuredHeight;
    }// end function

}

