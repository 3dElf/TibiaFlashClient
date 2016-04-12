package tibia.creatures
{
    import tibia.creatures.battlelistWidgetClasses.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BattlelistWidget extends Widget
    {
        protected var m_CreatureStorage:CreatureStorage = null;

        public function BattlelistWidget()
        {
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            this.creatureStorage = Tibia.s_GetCreatureStorage();
            if (this.creatureStorage != null)
            {
                this.creatureStorage.setAim(null);
            }
            var _loc_2:* = super.acquireViewInstance(param1) as BattlelistWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.creatureStorage = this.m_CreatureStorage;
            }
            return _loc_2;
        }// end function

        override public function releaseViewInstance() : void
        {
            options = null;
            if (this.creatureStorage != null)
            {
                this.creatureStorage.setAim(null);
                this.creatureStorage = null;
            }
            super.releaseViewInstance();
            return;
        }// end function

        public function set creatureStorage(param1:CreatureStorage) : void
        {
            if (this.m_CreatureStorage != param1)
            {
                this.m_CreatureStorage = param1;
                if (m_ViewInstance is BattlelistWidgetView)
                {
                    BattlelistWidgetView(m_ViewInstance).creatureStorage = this.m_CreatureStorage;
                }
            }
            return;
        }// end function

        public function get creatureStorage() : CreatureStorage
        {
            return this.m_CreatureStorage;
        }// end function

    }
}
