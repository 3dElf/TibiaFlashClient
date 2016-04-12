package tibia.premium.premiumWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.premium.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class PremiumWidgetView extends WidgetView
    {
        private var m_TriggerExpiryTime:int = 0;
        private var m_UICollapsedStyleName:Object;
        private var m_UIGrid:Grid = null;
        private var m_TriggerHighlight:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_LastTriggerTime:Number = 0;
        private static const BUNDLE:String = "PremiumWidget";

        public function PremiumWidgetView()
        {
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            verticalScrollPolicy = ScrollPolicy.OFF;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            Tibia.s_GetPremiumManager().addEventListener(PremiumEvent.TRIGGER, this.onPremiumTrigger);
            Tibia.s_GetPremiumManager().addEventListener(PremiumEvent.HIGHLIGHT, this.onPremiumHighlightToggle);
            Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            return;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            m_UICollapseButton.removeEventListener(MouseEvent.CLICK, this.onCollapseButtonClick);
            m_UIHeader.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onHeaderDoubleClick);
            Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER, this.onSecondaryTimer);
            Tibia.s_GetPremiumManager().removeEventListener(PremiumEvent.TRIGGER, this.onPremiumTrigger);
            Tibia.s_GetPremiumManager().removeEventListener(PremiumEvent.HIGHLIGHT, this.onPremiumHighlightToggle);
            return;
        }// end function

        public function stopTriggerHighlight() : void
        {
            this.m_TriggerHighlight = false;
            m_UICollapseButton.styleName = this.m_UICollapsedStyleName;
            return;
        }// end function

        protected function onPremiumTrigger(event:PremiumEvent) : void
        {
            this.updatePremiumBenefits(event.messages);
            if (event.highlight)
            {
                this.startTriggerHighlight(event.highlightExpiry);
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            m_UICollapseButton.selected = widgetCollapsed;
            m_UICloseButton.enabled = m_WidgetClosable;
            return;
        }// end function

        protected function onCollapseButtonClick(event:MouseEvent) : void
        {
            this.stopTriggerHighlight();
            invalidateProperties();
            return;
        }// end function

        protected function onHeaderDoubleClick(event:MouseEvent) : void
        {
            this.stopTriggerHighlight();
            invalidateProperties();
            return;
        }// end function

        protected function onPremiumHighlightToggle(event:PremiumEvent) : void
        {
            if (this.m_TriggerHighlight)
            {
                this.stopTriggerHighlight();
            }
            else
            {
                this.startTriggerHighlight(event.highlightExpiry);
            }
            return;
        }// end function

        private function updatePremiumBenefits(param1:Vector.<PremiumMessage>) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.m_UIGrid.removeAllChildren();
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new GridRow();
                _loc_4 = new GridItem();
                _loc_4.styleName = "premiumWidgetGridItem";
                if (_loc_2.icon != null)
                {
                    _loc_6 = new Bitmap(_loc_2.icon);
                    _loc_7 = new Image();
                    _loc_7.source = _loc_6;
                    _loc_4.addChild(_loc_7);
                }
                _loc_3.addChild(_loc_4);
                _loc_4 = new GridItem();
                _loc_4.styleName = "premiumWidgetGridItem";
                _loc_5 = new Text();
                _loc_5.htmlText = resourceManager.getString(BUNDLE, _loc_2.resourceText, [(m_WidgetInstance as PremiumWidget).premiumManager.premiumExpiryDays]);
                _loc_4.addChild(_loc_5);
                _loc_3.addChild(_loc_4);
                this.m_UIGrid.addChild(_loc_3);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                m_UICollapseButton.addEventListener(MouseEvent.CLICK, this.onCollapseButtonClick);
                this.m_UICollapsedStyleName = m_UICollapseButton.styleName;
                this.m_UIGrid = new Grid();
                this.m_UIGrid.percentWidth = 100;
                addChild(this.m_UIGrid);
                this.updatePremiumBenefits(Tibia.s_GetPremiumManager().premiumMessages);
                m_UIHeader.addEventListener(MouseEvent.DOUBLE_CLICK, this.onHeaderDoubleClick);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function startTriggerHighlight(param1:int) : void
        {
            this.m_LastTriggerTime = Tibia.s_GetTibiaTimer();
            this.m_TriggerExpiryTime = param1;
            if (widgetCollapsed && !this.m_TriggerHighlight)
            {
                this.m_UICollapsedStyleName = m_UICollapseButton.styleName;
                m_UICollapseButton.styleName = "expandButtonPremiumTriggered";
            }
            this.m_TriggerHighlight = true;
            return;
        }// end function

        protected function onSecondaryTimer(event:TimerEvent) : void
        {
            var _loc_2:* = Tibia.s_GetTibiaTimer();
            if (this.m_TriggerHighlight && this.m_LastTriggerTime + this.m_TriggerExpiryTime < _loc_2)
            {
                this.stopTriggerHighlight();
            }
            return;
        }// end function

    }
}
