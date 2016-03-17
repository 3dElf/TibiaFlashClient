package tibia.cursors
{
   import flash.ui.MouseCursorData;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import flash.ui.Mouse;
   
   public class ResizeHorizontalCursor
   {
      
      public static const CURSOR_ID:int = -4;
      
      public static const CURSOR_NAME:String = "resizeHorizontal";
      
      private static const CURSOR_CLASS:Class = ResizeHorizontalCursor_CURSOR_CLASS;
      
      {
         s_RegisterNative();
      }
      
      public function ResizeHorizontalCursor()
      {
         super();
      }
      
      private static function s_RegisterNative() : void
      {
         var _loc1_:MouseCursorData = new MouseCursorData();
         _loc1_.data = new Vector.<BitmapData>();
         _loc1_.data[0] = Bitmap(new CURSOR_CLASS()).bitmapData;
         _loc1_.frameRate = 0;
         _loc1_.hotSpot = new Point(10,4.5);
         Mouse.registerCursor(CURSOR_NAME,_loc1_);
      }
   }
}
