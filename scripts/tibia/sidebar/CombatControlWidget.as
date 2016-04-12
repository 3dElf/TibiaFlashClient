package tibia.sidebar
{
    import tibia.creatures.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class CombatControlWidget extends Widget
    {
        protected var m_Player:Player = null;

        public function CombatControlWidget()
        {
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            this.player = Tibia.s_GetPlayer();
            var _loc_2:* = super.acquireViewInstance(param1) as CombatControlWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.options = m_Options;
                _loc_2.player = this.m_Player;
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
                if (m_ViewInstance is CombatControlWidgetView)
                {
                    CombatControlWidgetView(m_ViewInstance).player = this.m_Player;
                }
            }
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            options = null;
            this.player = null;
            super.releaseViewInstance();
            return;
        }// end function

    }
}
