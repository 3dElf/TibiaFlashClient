package tibia.trade
{
    import mx.collections.*;
    import tibia.network.*;
    import tibia.sidebar.*;
    import tibia.trade.safeTradeWidgetClasses.*;

    public class SafeTradeWidget extends Widget
    {
        protected var m_OtherItems:IList = null;
        protected var m_OtherName:String = null;
        protected var m_OwnItems:IList = null;
        protected var m_OwnName:String = null;

        public function SafeTradeWidget()
        {
            return;
        }// end function

        public function set otherItems(param1:IList) : void
        {
            if (this.m_OtherItems != param1)
            {
                this.m_OtherItems = param1;
                if (m_ViewInstance is SafeTradeWidgetView)
                {
                    SafeTradeWidgetView(m_ViewInstance).otherItems = this.m_OtherItems;
                }
            }
            return;
        }// end function

        override public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (param1 || closable && !closed)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCREJECTTRADE();
                }
            }
            super.close(param1);
            return;
        }// end function

        public function set ownName(param1:String) : void
        {
            if (this.m_OwnName != param1)
            {
                this.m_OwnName = param1;
                if (m_ViewInstance is SafeTradeWidgetView)
                {
                    SafeTradeWidgetView(m_ViewInstance).ownName = this.m_OwnName;
                }
            }
            return;
        }// end function

        public function get otherItems() : IList
        {
            return this.m_OtherItems;
        }// end function

        public function get ownName() : String
        {
            return this.m_OwnName;
        }// end function

        public function set ownItems(param1:IList) : void
        {
            if (this.m_OwnItems != param1)
            {
                this.m_OwnItems = param1;
                if (m_ViewInstance is SafeTradeWidgetView)
                {
                    SafeTradeWidgetView(m_ViewInstance).ownItems = this.m_OwnItems;
                }
            }
            return;
        }// end function

        public function set otherName(param1:String) : void
        {
            if (this.m_OtherName != param1)
            {
                this.m_OtherName = param1;
                if (m_ViewInstance is SafeTradeWidgetView)
                {
                    SafeTradeWidgetView(m_ViewInstance).otherName = this.m_OtherName;
                }
            }
            return;
        }// end function

        public function get ownItems() : IList
        {
            return this.m_OwnItems;
        }// end function

        public function get otherName() : String
        {
            return this.m_OtherName;
        }// end function

    }
}
