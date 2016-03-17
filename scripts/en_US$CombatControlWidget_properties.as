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
            "TIP_MOUNT":"Mount",
            "TIP_ATTACK_OFFENSIVE":"Offensive",
            "TIP_SECURE":"Secure Mode",
            "TIP_PVP_MODE_DOVE":"Dove mode. You can attack or block only characters that have been aggressive towards yourself.",
            "TIP_CHASE":"Chase Opponent",
            "TIP_STOP":"Stop",
            "TITLE":"Combat Controls",
            "TIP_PVP_MODE_YELLOW_HAND":"Yellow hand mode. You can attack or block all skulled characters, except party/guild members.",
            "TIP_PVP_MODE_RED_FIST":"Red fist mode. You can attack or block all characters, except party/guild members. Not available for black skulled characters.",
            "TIP_ATTACK_DEFENSIVE":"Defensive",
            "TIP_ATTACK_BALANCED":"Balanced",
            "TIP_PVP_MODE_WHITE_HAND":"White hand mode. You can attack or block only characters that have been aggressive towards yourself or your party/guild members."
         };
         return _loc1_;
      }
   }
}
