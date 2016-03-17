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
            "TIP_SECURE":"Secure Mode: You are able to attack someone by targeting, regardless of your expert mode. You risk white, red and black skulls as well as a protection zone block.",
            "TIP_PVP_MODE_DOVE":"Dove Mode: You are only able to defend yourself against aggressors. You can\'t get a skull or a protection zone block.",
            "TIP_CHASE":"Chase Opponent",
            "TIP_STOP":"Stop",
            "TITLE":"Combat Controls",
            "TIP_PVP_MODE_YELLOW_HAND":"Yellow Hand Mode: You are able to attack any skulled player. You risk getting a yellow skull and a protection zone block.",
            "TIP_PVP_MODE_RED_FIST":"Red Fist Mode: You are able to attack and block anyone. You risk white, red and black skulls as well as a protection zone block.",
            "TIP_ATTACK_DEFENSIVE":"Defensive",
            "TIP_EXPERT_MODE":"Toggle expert PvP settings",
            "TIP_ATTACK_BALANCED":"Balanced",
            "TIP_PVP_MODE_WHITE_HAND":"White Hand Mode: You are able to defend yourself and your group against aggressors. You risk getting a yellow skull."
         };
         return _loc1_;
      }
   }
}
