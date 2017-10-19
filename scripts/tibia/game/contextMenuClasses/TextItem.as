package tibia.game.contextMenuClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.game.contextMenuClasses.*;

    public class TextItem extends UIComponent implements IContextMenuItem
    {
        private var m_ExplicitIconWidth:Number = NaN;
        private var m_IconWidth:Number = NaN;
        private var m_UncommittedCaption:Boolean = false;
        private var m_UICaption:UITextField = null;
        private var m_MouseOver:Boolean = false;
        private var m_UncommittedIcon:Boolean = false;
        private var m_Icon:Object = null;
        private var m_Caption:String = null;
        private var m_MeasuredIconWidth:Number = NaN;
        private var m_UIIcon:UIComponent = null;

        public function TextItem()
        {
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addEventListener(MouseEvent.CLICK, this.onMouseClick);
            addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseOver);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOver);
            return;
        }// end function

        public function set explicitIconWidth(param1:Number) : void
        {
            if (this.m_ExplicitIconWidth != param1)
            {
                this.m_ExplicitIconWidth = param1;
                invalidateSize();
            }
            return;
        }// end function

        public function get explicitIconWidth() : Number
        {
            return this.m_ExplicitIconWidth;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedCaption)
            {
                this.m_UICaption.text = this.caption;
                this.m_UncommittedCaption = false;
            }
            if (this.m_UncommittedIcon)
            {
                if (this.m_UIIcon != null)
                {
                    removeChild(this.m_UIIcon);
                    this.m_UIIcon = null;
                }
                if (this.icon is UIComponent)
                {
                    this.m_UIIcon = UIComponent(this.icon);
                }
                else if (this.icon is DisplayObject)
                {
                    this.m_UIIcon = new ShapeWrapper();
                    this.m_UIIcon.addChild(DisplayObject(this.icon));
                }
                if (this.m_UIIcon != null)
                {
                    addChildAt(this.m_UIIcon, 0);
                }
                this.m_UncommittedIcon = false;
            }
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            removeEventListener(MouseEvent.CLICK, this.onMouseClick);
            removeEventListener(MouseEvent.RIGHT_CLICK, this.onMouseClick);
            removeEventListener(MouseEvent.ROLL_OUT, this.onMouseOver);
            removeEventListener(MouseEvent.ROLL_OVER, this.onMouseOver);
            return;
        }// end function

        public function set caption(param1:String) : void
        {
            if (param1 != this.m_Caption)
            {
                this.m_Caption = param1;
                this.m_UncommittedCaption = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get iconWidth() : Number
        {
            return this.m_IconWidth;
        }// end function

        public function set iconWidth(param1:Number) : void
        {
            if (this.explicitIconWidth != param1)
            {
                this.explicitIconWidth = param1;
                invalidateSize();
            }
            if (this.m_IconWidth != param1)
            {
                this.m_IconWidth = param1;
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

        public function set measuredIconWidth(param1:Number) : void
        {
            this.m_MeasuredIconWidth = param1;
            return;
        }// end function

        public function get viewMetrics() : EdgeMetrics
        {
            return new EdgeMetrics();
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UICaption = new UITextField();
            addChild(this.m_UICaption);
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = !isNaN(this.m_UICaption.explicitMinWidth) ? (this.m_UICaption.explicitMinWidth) : (this.m_UICaption.measuredMinWidth);
            var _loc_2:* = this.m_UICaption.getExplicitOrMeasuredWidth();
            var _loc_3:* = !isNaN(this.m_UICaption.explicitMinHeight) ? (this.m_UICaption.explicitMinHeight) : (this.m_UICaption.measuredMinHeight);
            var _loc_4:* = this.m_UICaption.getExplicitOrMeasuredHeight();
            if (this.m_UIIcon != null)
            {
                this.measuredIconWidth = this.m_UIIcon.getExplicitOrMeasuredWidth();
                _loc_1 = _loc_1 + (!isNaN(this.m_UIIcon.explicitMinWidth) ? (this.m_UIIcon.explicitMinWidth) : (this.m_UIIcon.measuredMinWidth));
                _loc_2 = _loc_2 + this.measuredIconWidth;
                _loc_3 = Math.max(_loc_3, !isNaN(this.m_UIIcon.explicitMinHeight) ? (this.m_UIIcon.explicitMinHeight) : (this.m_UIIcon.measuredMinHeight));
                _loc_4 = Math.max(_loc_4, this.m_UIIcon.getExplicitOrMeasuredHeight());
            }
            else
            {
                this.measuredIconWidth = 0;
            }
            var _loc_5:* = this.viewMetricsAndPadding;
            measuredMinWidth = _loc_5.left + _loc_1 + _loc_5.right;
            measuredWidth = _loc_5.left + _loc_2 + _loc_5.right;
            measuredMinHeight = _loc_5.top + _loc_3 + _loc_5.bottom;
            measuredHeight = _loc_5.top + _loc_4 + _loc_5.bottom;
            return;
        }// end function

        public function get caption() : String
        {
            return this.m_Caption;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = new ContextMenuEvent(ContextMenuEvent.MENU_ITEM_SELECT);
            _loc_2.mouseTarget = this;
            _loc_2.contextMenuOwner = owner;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get measuredIconWidth() : Number
        {
            return this.m_MeasuredIconWidth;
        }// end function

        public function set icon(param1) : void
        {
            if (param1 != this.m_Icon)
            {
                this.m_Icon = param1;
                this.m_UncommittedIcon = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            graphics.clear();
            if (this.m_MouseOver)
            {
                graphics.beginFill(getStyle("rollOverColor"), getStyle("rollOverAlpha"));
                graphics.drawRect(0, 0, param1, param2);
                graphics.endFill();
                this.m_UICaption.setColor(getStyle("textRollOverColor"));
            }
            else
            {
                this.m_UICaption.setColor(getStyle("textColor"));
            }
            var _loc_3:* = this.viewMetricsAndPadding;
            param1 = param1 - (_loc_3.left + _loc_3.right);
            param2 = param2 - (_loc_3.top + _loc_3.bottom);
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3.left;
            var _loc_6:* = 0;
            if (this.iconWidth > 0 && this.m_UIIcon != null)
            {
                _loc_6 = this.m_UIIcon.getExplicitOrMeasuredWidth();
                _loc_4 = this.m_UIIcon.getExplicitOrMeasuredHeight();
                this.m_UIIcon.move(_loc_5 + (this.iconWidth - _loc_6) / 2, _loc_3.top + (param2 - _loc_4) / 2);
                this.m_UIIcon.setActualSize(_loc_6, _loc_4);
            }
            if (this.iconWidth > 0)
            {
                _loc_6 = this.iconWidth + getStyle("horizontalGap");
                _loc_5 = _loc_5 + _loc_6;
                param1 = param1 - _loc_6;
            }
            _loc_4 = this.m_UICaption.getExplicitOrMeasuredHeight();
            this.m_UICaption.move(_loc_5, _loc_3.top + (param2 - _loc_4) / 2);
            this.m_UICaption.setActualSize(param1, _loc_4);
            return;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = this.viewMetrics.clone();
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            return _loc_1;
        }// end function

        public function get icon()
        {
            return this.m_Icon;
        }// end function

        private function onMouseOver(event:MouseEvent) : void
        {
            this.m_MouseOver = event.type == MouseEvent.ROLL_OVER;
            invalidateDisplayList();
            return;
        }// end function

    }
}
