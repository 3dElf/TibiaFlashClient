package tibia.creatures
{
    import flash.events.*;
    import mx.events.*;
    import tibia.creatures.buddylistWidgetClasses.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BuddylistWidget extends Widget
    {
        private var m_BuddySet:BuddySet = null;
        private var m_ShowOffline:Boolean = true;
        private var m_SortOrder:int = 0;
        public static const SORT_BY_ICON:int = 1;
        public static const SORT_BY_NAME:int = 0;
        public static const SORT_BY_STATUS:int = 2;

        public function BuddylistWidget()
        {
            return;
        }// end function

        public function set sortOrder(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 != SORT_BY_ICON && param1 != SORT_BY_NAME && param1 != SORT_BY_STATUS)
            {
                param1 = SORT_BY_NAME;
            }
            if (this.m_SortOrder != param1)
            {
                _loc_2 = this.m_SortOrder;
                this.m_SortOrder = param1;
                _loc_3 = new Event(Widget.EVENT_OPTIONS_CHANGE);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_SortOrder = _loc_2;
                }
                if (m_ViewInstance is BuddylistWidgetView)
                {
                    BuddylistWidgetView(m_ViewInstance).sortOrder = this.m_SortOrder;
                }
            }
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            options = null;
            super.releaseViewInstance();
            return;
        }// end function

        public function get buddySet() : BuddySet
        {
            return this.m_BuddySet;
        }// end function

        private function updateBuddySet() : void
        {
            if (m_Options != null)
            {
                this.buddySet = m_Options.getBuddySet(BuddySet.DEFAULT_SET);
            }
            return;
        }// end function

        public function get showOffline() : Boolean
        {
            return this.m_ShowOffline;
        }// end function

        override public function unmarshall(param1:XML, param2:int) : void
        {
            super.unmarshall(param1, param2);
            var _loc_3:* = null;
            var _loc_4:* = param1.@showOffline;
            _loc_3 = param1.@showOffline;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.showOffline = _loc_3[0].toString() == "true";
            }
            var _loc_4:* = param1.@sortOrder;
            _loc_3 = param1.@sortOrder;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.sortOrder = int(_loc_3[0].toString());
            }
            return;
        }// end function

        public function set showOffline(param1:Boolean) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (this.m_ShowOffline != param1)
            {
                _loc_2 = this.m_ShowOffline;
                this.m_ShowOffline = param1;
                _loc_3 = new Event(Widget.EVENT_OPTIONS_CHANGE);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_ShowOffline = _loc_2;
                }
                if (m_ViewInstance is BuddylistWidgetView)
                {
                    BuddylistWidgetView(m_ViewInstance).showOffline = this.m_ShowOffline;
                }
            }
            return;
        }// end function

        override protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            super.onOptionsChange(event);
            switch(event.property)
            {
                case "buddySet":
                case "*":
                {
                    this.updateBuddySet();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function get sortOrder() : int
        {
            return this.m_SortOrder;
        }// end function

        override public function marshall() : XML
        {
            var _loc_1:* = super.marshall();
            _loc_1.@showOffline = this.showOffline;
            _loc_1.@sortOrder = this.sortOrder;
            return _loc_1;
        }// end function

        override protected function commitOptions() : void
        {
            super.commitOptions();
            this.updateBuddySet();
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            var _loc_2:* = super.acquireViewInstance(param1) as BuddylistWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.buddySet = this.buddySet;
                _loc_2.showOffline = this.showOffline;
                _loc_2.sortOrder = this.sortOrder;
            }
            return _loc_2;
        }// end function

        public function set buddySet(param1:BuddySet) : void
        {
            if (this.m_BuddySet != param1)
            {
                this.m_BuddySet = param1;
                if (m_ViewInstance is BuddylistWidgetView)
                {
                    BuddylistWidgetView(m_ViewInstance).buddySet = this.m_BuddySet;
                }
            }
            return;
        }// end function

    }
}
