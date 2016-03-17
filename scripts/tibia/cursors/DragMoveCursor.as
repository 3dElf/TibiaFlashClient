package tibia.cursors
{
   public class DragMoveCursor
   {
       
      public function DragMoveCursor()
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
