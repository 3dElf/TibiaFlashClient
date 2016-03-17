package tibia.cursors
{
   import flash.ui.MouseCursorData;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.ui.Mouse;
   
   public class DefaultCursor
   {
      
      public static const CURSOR_ID:int = -2;
      
      public static const CURSOR_NAME:String = "default";
      
      private static const CURSOR_CLASS:Class = DefaultCursor_CURSOR_CLASS;
      
      {
         s_RegisterNative();
      }
      
      public function DefaultCursor()
      {
         super();
      }
      
      private static function s_RegisterNative() : void
      {
         var _loc1_:MouseCursorData = new MouseCursorData();
         _loc1_.data = new Vector.<BitmapData>();
         _loc1_.data[0] = Bitmap(new CURSOR_CLASS()).bitmapData;
         _loc1_.frameRate = 0;
         _loc1_.hotSpot = new Point(1,0);
         Mouse.registerCursor(CURSOR_NAME,_loc1_);
      }
   }
}
