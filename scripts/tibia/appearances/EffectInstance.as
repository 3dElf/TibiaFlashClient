package tibia.appearances
{
   public class EffectInstance extends AppearanceInstance
   {
       
      public function EffectInstance(param1:int, param2:AppearanceType)
      {
         super(param1,param2);
         phase = AppearanceAnimator.PHASE_ASYNCHRONOUS;
      }
      
      public function end() : void
      {
         if(m_Animator != null)
         {
            m_Animator.finished = true;
         }
      }
   }
}
