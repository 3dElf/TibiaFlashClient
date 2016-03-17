package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$GeneralButtonsWidget_properties extends ResourceBundle
   {
       
      public function en_US$GeneralButtonsWidget_properties()
      {
         super("en_US","GeneralButtonsWidget");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "BTN_SPELLLIST":"Spell List",
            "BTN_OPTIONS":"Options",
            "BTN_CHANGE_CHARACTER":"Change Character",
            "BTN_CHARACTER_PROFILE":"Character Profile",
            "TITLE":"General Controls",
            "BTN_QUEST_LOG":"Quest Log",
            "BTN_LOGOUT_CHARACTER":"Logout Character"
         };
         return _loc1_;
      }
   }
}
