package build
{
   public class BuildConstants
   {
       
      public function BuildConstants()
      {
         super();
      }
      
      public static function get MINI_MAP_STORAGE_REFRESH_SECTORS() : Boolean
      {
         return true;
      }
      
      public static function get ENABLE_CHARACTER_CHANGE_DIALOG() : Boolean
      {
         return true;
      }
      
      public static function get MINI_MAP_STORAGE_SAVE_SECTORS() : Boolean
      {
         return true;
      }
      
      public static function get FOCUS_NOTIFIER_FULLY_TRANSPARENT() : Boolean
      {
         return false;
      }
      
      public static function get FOCUS_NOTIFIER_SHOW_HINT_LABEL() : Boolean
      {
         return true;
      }
      
      public static function get FOCUS_NOTIFIER_SHOW_ALWAYS() : Boolean
      {
         return false;
      }
   }
}
