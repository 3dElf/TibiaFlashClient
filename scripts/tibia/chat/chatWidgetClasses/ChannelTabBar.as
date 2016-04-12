package tibia.chat.chatWidgetClasses
{
    import mx.collections.*;
    import mx.core.*;
    import tibia.chat.*;
    import tibia.controls.*;
    import tibia.controls.dynamicTabBarClasses.*;

    public class ChannelTabBar extends DynamicTabBar
    {
        private var m_UncomittedSelectedIndex:Boolean = false;
        private var m_UncomittedScrollPosition:Boolean = false;

        public function ChannelTabBar()
        {
            addEventListener(ChannelEvent.HIGHLIGHT, this.onChannelHighlight, false, EventPriority.DEFAULT_HANDLER, false);
            addEventListener(ChannelEvent.DEHIGHLIGHT, this.onChannelHighlight, false, EventPriority.DEFAULT_HANDLER, false);
            navItemFactory = new ClassFactory(ChannelTab);
            return;
        }// end function

        override protected function createNavItem(param1:Object) : DynamicTab
        {
            var _loc_2:* = ChannelTab(super.createNavItem(param1));
            _loc_2.channel = param1 as Channel;
            return _loc_2;
        }// end function

        private function updateNavItemHighlight(param1:ChannelTab) : void
        {
            if (param1 != null)
            {
                if (param1.highlight && getStyle("navItemHighlightStyle") !== undefined)
                {
                    param1.styleName = getStyle("navItemHighlightStyle");
                }
                else
                {
                    param1.styleName = getStyle("navItemStyle");
                }
            }
            return;
        }// end function

        override protected function createDropDownMenu() : IList
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = new ArrayCollection();
            var _loc_2:* = 0;
            var _loc_3:* = getDataProviderLength();
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = ChannelTab(getChildAt(_loc_2));
                _loc_5 = _loc_4.label;
                if (_loc_4.highlight)
                {
                    _loc_5 = _loc_5 + "*";
                }
                _loc_1.addItem({label:_loc_5});
                _loc_2++;
            }
            return _loc_1;
        }// end function

        override public function set selectedIndex(param1:int) : void
        {
            if (selectedIndex != param1)
            {
                super.selectedIndex = param1;
                this.m_UncomittedSelectedIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncomittedScrollPosition)
            {
                callLater(this.updateScrollButtonHighlights);
                this.m_UncomittedScrollPosition = false;
            }
            if (this.m_UncomittedSelectedIndex)
            {
                if (m_SelectedIndex > -1)
                {
                    _loc_1 = ChannelTab(getChildAt(m_SelectedIndex));
                    _loc_1.highlight = false;
                    this.updateNavItemHighlight(_loc_1);
                }
                callLater(this.updateScrollButtonHighlights);
                this.m_UncomittedSelectedIndex = false;
            }
            return;
        }// end function

        private function isHighlightInRange(param1:int, param2:int) : Boolean
        {
            while (param1 < param2)
            {
                
                if (ChannelTab(getChildAt(param1)).highlight)
                {
                    return true;
                }
                param1++;
            }
            return false;
        }// end function

        private function updateScrollButtonHighlights() : void
        {
            if (this.isHighlightInRange(0, getFirstVisibleIndex()) && getStyle("scrollLeftButtonHighlightStyle") !== undefined)
            {
                m_UILeftButton.styleName = getStyle("scrollLeftButtonHighlightStyle");
            }
            else
            {
                m_UILeftButton.styleName = getStyle("scrollLeftButtonStyle");
            }
            if (this.isHighlightInRange(getLastVisibleIndex(), getDataProviderLength()) && getStyle("scrollRightButtonHighlightStyle") !== undefined)
            {
                m_UIRightButton.styleName = getStyle("scrollRightButtonHighlightStyle");
            }
            else
            {
                m_UIRightButton.styleName = getStyle("scrollRightButtonStyle");
            }
            return;
        }// end function

        protected function onChannelHighlight(event:ChannelEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                _loc_2 = ChannelTab(event.target);
                _loc_3 = getChildIndex(_loc_2);
                switch(event.type)
                {
                    case ChannelEvent.DEHIGHLIGHT:
                    {
                        this.updateNavItemHighlight(_loc_2);
                        this.updateScrollButtonHighlights();
                        break;
                    }
                    case ChannelEvent.HIGHLIGHT:
                    {
                        if (m_SelectedIndex == _loc_3)
                        {
                            event.preventDefault();
                        }
                        else
                        {
                            this.updateNavItemHighlight(_loc_2);
                            this.updateScrollButtonHighlights();
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get selectedTab() : ChannelTab
        {
            if (selectedIndex > -1)
            {
                return getChildAt(m_SelectedIndex) as ChannelTab;
            }
            return null;
        }// end function

        override public function set scrollPosition(param1:int) : void
        {
            if (scrollPosition != param1)
            {
                super.scrollPosition = param1;
                this.m_UncomittedScrollPosition = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function destroyNavItem(param1:int) : DynamicTab
        {
            var _loc_2:* = ChannelTab(super.destroyNavItem(param1));
            _loc_2.channel = null;
            return _loc_2;
        }// end function

    }
}
