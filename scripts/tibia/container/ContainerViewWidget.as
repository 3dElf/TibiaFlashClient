package tibia.container
{
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.network.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class ContainerViewWidget extends Widget
    {
        protected var m_Container:ContainerView = null;

        public function ContainerViewWidget()
        {
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            var _loc_2:* = super.acquireViewInstance(param1);
            if (_loc_2 is ContainerViewWidgetView)
            {
                _loc_2.options = options;
                ContainerViewWidgetView(_loc_2).container = this.m_Container;
            }
            return _loc_2;
        }// end function

        public function get container() : ContainerView
        {
            return this.m_Container;
        }// end function

        public function set container(param1:ContainerView) : void
        {
            if (this.m_Container != param1)
            {
                this.m_Container = param1;
                if (m_ViewInstance is ContainerViewWidgetView)
                {
                    ContainerViewWidgetView(m_ViewInstance).container = this.m_Container;
                }
            }
            return;
        }// end function

        override public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (param1 || closable && !closed)
            {
                if (this.m_Container != null)
                {
                    m_Closed = true;
                    if (m_ViewInstance != null)
                    {
                        m_ViewInstance.widgetClosed = m_Closed;
                    }
                    _loc_2 = Tibia.s_GetCommunication();
                    if (_loc_2 != null && _loc_2.isGameRunning)
                    {
                        _loc_2.sendCCLOSECONTAINER(this.m_Container.ID);
                    }
                }
                else
                {
                    super.close(param1);
                }
            }
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            this.container = null;
            super.releaseViewInstance();
            return;
        }// end function

    }
}
