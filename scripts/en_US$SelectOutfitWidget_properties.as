package
{
   import mx.resources.ResourceBundle;
   
   public class en_US$SelectOutfitWidget_properties extends ResourceBundle
   {
       
      public function en_US$SelectOutfitWidget_properties()
      {
         super("en_US","SelectOutfitWidget");
      }
      
      override protected function getContent() : Object
      {
         var _loc1_:Object = {
            "CHECK_OUTFIT_ADDON":"Addon {0}",
            "LABEL_COLOUR_SECONDARY":"Secondary",
            "LABEL_COLOUR_PRIMARY":"Primary",
            "LABEL_COLOUR_DETAIL":"Detail",
            "LABEL_COLOUR_HEAD":"Head",
            "TITLE":"Select Outfit",
            "LABEL_NO_MOUNT":"No Mount",
            "LABEL_NO_OUTFIT":"No Outfit"
         };
         return _loc1_;
      }
   }
}
