package tibia.container
{
    import tibia.container.bodyContainerViewWigdetClasses.*;
    import tibia.creatures.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BodyContainerViewWidget extends Widget
    {
        protected var m_Player:Player = null;
        protected var m_BodyContainer:BodyContainerView = null;

        public function BodyContainerViewWidget()
        {
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            if (type == Widget.TYPE_BODY)
            {
                this.bodyContainer = Tibia.s_GetContainerStorage().getBodyContainerView();
                this.player = Tibia.s_GetPlayer();
            }
            var _loc_2:* = super.acquireViewInstance(param1);
            if (_loc_2 is BodyContainerViewWidgetView)
            {
                _loc_2.options = options;
                BodyContainerViewWidgetView(_loc_2).bodyContainer = this.m_BodyContainer;
                BodyContainerViewWidgetView(_loc_2).player = this.m_Player;
            }
            return _loc_2;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                this.m_Player = param1;
                if (m_ViewInstance is BodyContainerViewWidgetView)
                {
                    BodyContainerViewWidgetView(m_ViewInstance).player = this.m_Player;
                }
            }
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            this.bodyContainer = null;
            this.player = null;
            super.releaseViewInstance();
            return;
        }// end function

        public function set bodyContainer(param1:BodyContainerView) : void
        {
            if (this.m_BodyContainer != param1)
            {
                this.m_BodyContainer = param1;
                if (m_ViewInstance is BodyContainerViewWidgetView)
                {
                    BodyContainerViewWidgetView(m_ViewInstance).bodyContainer = this.m_BodyContainer;
                }
            }
            return;
        }// end function

        public function get bodyContainer() : BodyContainerView
        {
            return this.m_BodyContainer;
        }// end function

    }
}
