package tibia.cursors
{
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import mx.core.*;
    import mx.managers.*;
    import mx.managers.dragClasses.*;

    public class DragCursorBase extends Object
    {
        public static const CURSOR_RESIZE_VERTICAL_NAME:String = "resizeVertical";
        public static const CURSOR_LOOK_NAME:String = "look";
        public static const CURSOR_RESIZE_HORIZONTAL_NAME:String = "resizeHorizontal";
        private static const CROSSHAIR_MOVE_CLASS:Class = DragCursorBase_CROSSHAIR_MOVE_CLASS;
        static const DRAG_TYPE_CHANNEL:String = "channel";
        private static const DEFAULT_MOVE_CLASS:Class = DragCursorBase_DEFAULT_MOVE_CLASS;
        static const DRAG_TYPE_ACTION:String = "action";
        public static const CURSOR_ATTACK_NAME:String = "attack";
        public static const CURSOR_TALK_NAME:String = "talk";
        private static const DEFAULT_REJECT_CLASS:Class = DragCursorBase_DEFAULT_REJECT_CLASS;
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const DRAG_TYPE_OBJECT:String = "object";
        public static const CURSOR_WALK_NAME:String = "walk";
        static const DRAG_OPACITY:Number = 0.75;
        public static const CURSOR_DEFAULT_REJECT_NAME:String = "defaultReject";
        public static const CURSOR_USE_NAME:String = "use";
        private static const CROSSHAIR_REJECT_CLASS:Class = DragCursorBase_CROSSHAIR_REJECT_CLASS;
        public static const CURSOR_CROSSHAIR_NAME:String = "crosshair";
        public static const CURSOR_DEFAULT_NAME:String = "default";
        static const DRAG_TYPE_SPELL:String = "spell";
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        public static const CURSOR_OPEN_NAME:String = "open";

        public function DragCursorBase()
        {
            return;
        }// end function

        private static function s_RegisterNative() : void
        {
            var _loc_1:* = null;
            _loc_1 = new MouseCursorData();
            _loc_1.data = new Vector.<BitmapData>;
            _loc_1.data[0] = Bitmap(new DEFAULT_MOVE_CLASS()).bitmapData;
            _loc_1.frameRate = 0;
            _loc_1.hotSpot = new Point(1, 0);
            Mouse.registerCursor("dragDefaultMove", _loc_1);
            _loc_1 = new MouseCursorData();
            _loc_1.data = new Vector.<BitmapData>;
            _loc_1.data[0] = Bitmap(new DEFAULT_REJECT_CLASS()).bitmapData;
            _loc_1.frameRate = 0;
            _loc_1.hotSpot = new Point(1, 0);
            Mouse.registerCursor("dragDefaultReject", _loc_1);
            _loc_1 = new MouseCursorData();
            _loc_1.data = new Vector.<BitmapData>;
            _loc_1.data[0] = Bitmap(new CROSSHAIR_MOVE_CLASS()).bitmapData;
            _loc_1.frameRate = 0;
            _loc_1.hotSpot = new Point(10, 9);
            Mouse.registerCursor("dragCrosshairMove", _loc_1);
            _loc_1 = new MouseCursorData();
            _loc_1.data = new Vector.<BitmapData>;
            _loc_1.data[0] = Bitmap(new CROSSHAIR_REJECT_CLASS()).bitmapData;
            _loc_1.frameRate = 0;
            _loc_1.hotSpot = new Point(10, 9);
            Mouse.registerCursor("dragCrosshairReject", _loc_1);
            return;
        }// end function

        public static function get CURSOR_NAME() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (DragManager.isDragging)
            {
                _loc_1 = mx_internal::dragProxy;
                _loc_2 = null;
                _loc_3 = _loc_1.dragSource != null && _loc_1.dragSource.hasFormat("dragType") ? (_loc_1.dragSource.dataForFormat("dragType") as String) : (null);
                switch(_loc_3)
                {
                    case DRAG_TYPE_OBJECT:
                    case DRAG_TYPE_ACTION:
                    {
                        _loc_2 = "Crosshair";
                        break;
                    }
                    default:
                    {
                        _loc_2 = "Default";
                        break;
                        break;
                    }
                }
                _loc_4 = null;
                switch(_loc_1.action)
                {
                    case DragManager.COPY:
                    case DragManager.LINK:
                    case DragManager.MOVE:
                    {
                        _loc_4 = "Move";
                        break;
                    }
                    case DragManager.NONE:
                    {
                        _loc_4 = "Reject";
                        break;
                    }
                    default:
                    {
                        _loc_4 = "Reject";
                        break;
                        break;
                    }
                }
                return "drag" + _loc_2 + _loc_4;
            }
            return "auto";
        }// end function

        s_RegisterNative();
    }
}
