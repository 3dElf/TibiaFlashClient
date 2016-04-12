package tibia.cursors
{
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;

    public class TalkCursor extends Object
    {
        public static const CURSOR_ATTACK_NAME:String = "attack";
        public static const CURSOR_RESIZE_VERTICAL_NAME:String = "resizeVertical";
        public static const CURSOR_LOOK_NAME:String = "look";
        public static const CURSOR_RESIZE_HORIZONTAL_NAME:String = "resizeHorizontal";
        public static const CURSOR_NAME:String = "talk";
        public static const CURSOR_TALK_NAME:String = "talk";
        public static const CURSOR_WALK_NAME:String = "walk";
        public static const CURSOR_DEFAULT_REJECT_NAME:String = "defaultReject";
        public static const CURSOR_USE_NAME:String = "use";
        private static const CURSOR_CLASS:Class = TalkCursor_CURSOR_CLASS;
        public static const CURSOR_CROSSHAIR_NAME:String = "crosshair";
        public static const CURSOR_DEFAULT_NAME:String = "default";
        public static const CURSOR_OPEN_NAME:String = "open";

        public function TalkCursor()
        {
            return;
        }// end function

        private static function s_RegisterNative() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = new MouseCursorData();
            var _loc_2:* = Bitmap(new CURSOR_CLASS()).bitmapData;
            _loc_1.data = new Vector.<BitmapData>;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.width / 32)
            {
                
                _loc_4 = new BitmapData(32, 32, true);
                _loc_5 = new Rectangle(_loc_3 * 32, 0, 32, 32);
                _loc_4.copyPixels(_loc_2, _loc_5, new Point(0, 0));
                _loc_1.data[_loc_3] = _loc_4;
                _loc_3++;
            }
            _loc_1.frameRate = 6;
            _loc_1.hotSpot = new Point(1, 0);
            Mouse.registerCursor(CURSOR_NAME, _loc_1);
            return;
        }// end function

        s_RegisterNative();
    }
}
