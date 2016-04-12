package tibia.premium
{
    import tibia.sidebar.*;

    public class PremiumWidget extends Widget
    {
        private var m_PremiumManager:PremiumManager = null;

        public function PremiumWidget()
        {
            this.m_PremiumManager = Tibia.s_GetPremiumManager();
            return;
        }// end function

        public function get premiumManager() : PremiumManager
        {
            return this.m_PremiumManager;
        }// end function

        override public function get closable() : Boolean
        {
            return this.m_PremiumManager != null && !this.m_PremiumManager.freePlayerLimitations;
        }// end function

        override public function get draggable() : Boolean
        {
            return this.m_PremiumManager != null && !this.m_PremiumManager.freePlayerLimitations;
        }// end function

    }
}
