package tibia.appearances
{
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   import tibia.§appearances:ns_appearance_internal§.m_Type;
   
   public class EffectInstance extends AppearanceInstance
   {
       
      private var m_LoopEffect:Boolean = false;
      
      public function EffectInstance(param1:int, param2:AppearanceType)
      {
         super(param1,param2);
         phase = AppearanceInstance.PHASE_ASYNCHRONOUS;
      }
      
      override public function animate(param1:Number) : Boolean
      {
         super.animate(param1);
         return Boolean(this.m_LoopEffect) || m_Phase < m_Type.phases;
      }
      
      public function get loopEffect() : Boolean
      {
         return this.m_LoopEffect;
      }
      
      public function set loopEffect(param1:Boolean) : void
      {
         this.m_LoopEffect = param1;
      }
      
      public function end() : void
      {
         this.m_LoopEffect = false;
         m_Phase = m_Type.phases - 1;
      }
   }
}
