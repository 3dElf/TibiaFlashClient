package tibia.appearances
{
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   import tibia.§appearances:ns_appearance_internal§.m_Type;
   
   public class EffectInstance extends AppearanceInstance
   {
       
      public function EffectInstance(param1:int, param2:AppearanceType)
      {
         super(param1,param2);
         phase = AppearanceInstance.PHASE_ASYNCHRONOUS;
      }
      
      override public function animate(param1:Number) : Boolean
      {
         super.animate(param1);
         return m_Phase < m_Type.phases;
      }
   }
}
