package tibia.appearances
{

    public class EffectInstance extends AppearanceInstance
    {

        public function EffectInstance(param1:int, param2:AppearanceType)
        {
            super(param1, param2);
            phase = AppearanceAnimator.PHASE_ASYNCHRONOUS;
            return;
        }// end function

        public function setEndless() : void
        {
            if (m_Animators.hasOwnProperty(m_ActiveFrameGroup) && m_Animators[m_ActiveFrameGroup] != null)
            {
                m_Animators[m_ActiveFrameGroup].setEndless();
            }
            return;
        }// end function

        public function end() : void
        {
            if (m_Animators.hasOwnProperty(m_ActiveFrameGroup))
            {
                m_Animators[m_ActiveFrameGroup].finished = true;
            }
            return;
        }// end function

    }
}
