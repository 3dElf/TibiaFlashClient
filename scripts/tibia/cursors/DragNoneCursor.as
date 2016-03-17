package tibia.cursors
{
   public class DragNoneCursor
   {
       
      public function DragNoneCursor()
      {
         super();
      }
      
      public static function get CURSOR_ID() : int
      {
         return DragCursorBase.CURSOR_ID;
      }
      
      public static function get CURSOR_NAME() : String
      {
         return DragCursorBase.CURSOR_NAME;
      }
   }
}
