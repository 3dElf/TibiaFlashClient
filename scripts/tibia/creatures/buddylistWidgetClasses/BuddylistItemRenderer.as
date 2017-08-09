package tibia.creatures.buddylistWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.utility.*;
    import tibia.creatures.buddylistClasses.*;

    public class BuddylistItemRenderer extends UIComponent implements IListItemRenderer, IDataRenderer
    {
        protected var m_HaveTimer:Boolean = false;
        protected var m_UIName:FlexShape = null;
        protected var m_Buddy:Buddy = null;
        private var m_HaveTimerInvalid:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedBuddy:Boolean = false;
        protected var m_UIIcon:BuddyIconRenderer = null;
        static var s_NameCache:TextFieldCache = new TextFieldCache(192, TextFieldCache.DEFAULT_HEIGHT, 200, true);
        static var s_Trans:Matrix = new Matrix(1, 0, 0, 1);
        public static const HEIGHT_HINT:Number = 18;

        public function BuddylistItemRenderer()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_11:* = 0;
            var _loc_12:* = null;
            super.updateDisplayList(param1, param2);
            graphics.beginFill(65280, 0);
            graphics.drawRect(0, 0, param1, param2);
            graphics.endFill();
            var _loc_3:* = this.viewMetricsAndPadding;
            var _loc_4:* = getStyle("horizontalGap");
            var _loc_5:* = getStyle("verticalGap");
            var _loc_6:* = _loc_3.left;
            var _loc_7:* = _loc_3.top;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            param2 = param2 - (_loc_3.top + _loc_3.bottom);
            param1 = param1 - (_loc_3.left + _loc_3.right);
            _loc_9 = this.m_UIIcon.getExplicitOrMeasuredHeight();
            _loc_8 = this.m_UIIcon.getExplicitOrMeasuredWidth();
            this.m_UIIcon.ID = this.m_Buddy != null ? (this.m_Buddy.icon) : (BuddyIcon.DEFAULT_ICON);
            this.m_UIIcon.move(_loc_6, _loc_7 + (param2 - _loc_9) / 2);
            this.m_UIIcon.setActualSize(_loc_8, _loc_9);
            _loc_6 = _loc_6 + (_loc_8 + _loc_4);
            var _loc_10:* = this.m_UIName.graphics;
            _loc_10.clear();
            if (this.m_Buddy != null)
            {
                _loc_9 = s_NameCache.slotHeight;
                _loc_8 = param1 - _loc_8 - _loc_4;
                _loc_11 = 0;
                if (this.m_Buddy.highlight)
                {
                    _loc_11 = getStyle("highlightTextColor");
                }
                else if (this.m_Buddy.status == Buddy.STATUS_ONLINE)
                {
                    _loc_11 = getStyle("onlineTextColor");
                }
                else if (this.m_Buddy.status == Buddy.STATUS_OFFLINE)
                {
                    _loc_11 = getStyle("offlineTextColor");
                }
                else if (this.m_Buddy.status == Buddy.STATUS_PENDING)
                {
                    _loc_11 = getStyle("pendingTextColor");
                }
                _loc_12 = s_NameCache.getItem(this.m_Buddy.name + String(_loc_11), this.m_Buddy.name, _loc_11, _loc_8);
                if (_loc_12 != null)
                {
                    s_Trans.tx = -_loc_12.x;
                    s_Trans.ty = -_loc_12.y;
                    _loc_10.beginBitmapFill(s_NameCache, s_Trans, false, false);
                    _loc_10.drawRect(0, 0, _loc_12.width, _loc_12.height);
                    _loc_10.endFill();
                }
                this.m_UIName.x = _loc_6;
                this.m_UIName.y = _loc_7 + (param2 - _loc_9) / 2;
            }
            return;
        }// end function

        public function invalidateTimer() : void
        {
            this.m_HaveTimerInvalid = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            if (this.m_UncommittedBuddy)
            {
                toolTip = this.m_Buddy != null ? (this.m_Buddy.description) : (null);
                this.m_UncommittedBuddy = false;
            }
            if (this.m_HaveTimerInvalid)
            {
                _loc_1 = this.m_Buddy != null && this.m_Buddy.highlight;
                if (_loc_1 && !this.m_HaveTimer)
                {
                    Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onTimer);
                }
                if (!_loc_1 && this.m_HaveTimer)
                {
                    Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onTimer);
                }
                this.m_HaveTimer = _loc_1;
                this.m_HaveTimerInvalid = false;
            }
            super.commitProperties();
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIIcon = new BuddyIconRenderer();
                this.m_UIIcon.styleName = "noBackground";
                addChild(this.m_UIIcon);
                this.m_UIName = new FlexShape();
                addChild(this.m_UIName);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = NaN;
            super.measure();
            _loc_1 = this.viewMetricsAndPadding;
            var _loc_2:* = BuddyIconRenderer.ICON_WIDTH + getStyle("horizontalGap") + s_NameCache.slotWidth;
            _loc_3 = Math.max(BuddyIconRenderer.ICON_HEIGHT, s_NameCache.slotHeight);
            var _loc_4:* = _loc_1.left + _loc_2 + _loc_1.right;
            measuredWidth = _loc_1.left + _loc_2 + _loc_1.right;
            measuredMinWidth = _loc_4;
            var _loc_4:* = _loc_1.top + _loc_3 + _loc_1.bottom;
            measuredHeight = _loc_1.top + _loc_3 + _loc_1.bottom;
            measuredMinHeight = _loc_4;
            return;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            var _loc_2:* = false;
            if (event != null)
            {
                _loc_2 = this.m_Buddy != null && this.m_Buddy.highlight;
                if (!_loc_2)
                {
                    invalidateDisplayList();
                    this.invalidateTimer();
                }
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            if (this.m_Buddy != null)
            {
                this.m_Buddy.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onBuddyChange);
            }
            this.m_Buddy = param1 as Buddy;
            this.m_UncommittedBuddy = true;
            invalidateDisplayList();
            invalidateProperties();
            this.invalidateTimer();
            if (this.m_Buddy != null)
            {
                this.m_Buddy.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onBuddyChange);
            }
            return;
        }// end function

        protected function onBuddyChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "description":
                    {
                        toolTip = this.m_Buddy != null ? (this.m_Buddy.description) : (null);
                        break;
                    }
                    case "icon":
                    case "name":
                    {
                        invalidateDisplayList();
                        break;
                    }
                    case "highlight":
                    case "lastUpdate":
                    case "online":
                    {
                        invalidateDisplayList();
                        this.invalidateTimer();
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            return new EdgeMetrics(getStyle("paddingLeft"), getStyle("paddingTop"), getStyle("paddingRight"), getStyle("paddingBottom"));
        }// end function

        public function get data() : Object
        {
            return this.m_Buddy;
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
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.horizontalGap = 2;
                this.verticalGap = 2;
                this.highlightTextColor = 16316664;
                this.offlineTextColor = 16277600;
                this.onlineTextColor = 6355040;
                this.pendingTextColor = 16753920;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitialiseStyle();
    }
}
