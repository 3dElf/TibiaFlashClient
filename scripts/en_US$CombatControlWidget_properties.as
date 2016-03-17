package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$CombatControlWidget_properties extends ResourceBundle
   {
       
      public function en_US$CombatControlWidget_properties()
      {
         super("en_US","CombatControlWidget");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "TIP_SECURE":"Secure Mode",
            "TIP_MOUNT":"Mount",
            "TIP_CHASE":"Chase Opponent",
            "TIP_STOP":"Stop",
            "TIP_ATTACK_DEFENSIVE":"Defensive",
            "TIP_ATTACK_OFFENSIVE":"Offensive",
            "TIP_ATTACK_BALANCED":"Balanced",
            "TITLE":"Combat Controls"
         };
         return _loc1_;
      }
   }
}
