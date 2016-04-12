package tibia.ingameshop
{
    import flash.display.*;
    import flash.events.*;

    public class DynamicImage extends EventDispatcher
    {
        private var m_BitmapData:BitmapData;
        private var m_FetchTime:Number = 0;
        private var m_State:int = 1;
        public static const ICON_ERROR:BitmapData = Bitmap(new ICON_ERROR_CLASS()).bitmapData;
        public static const STATE_LOADING:int = 0;
        private static const ICON_LOADING_CLASS:Class = DynamicImage_ICON_LOADING_CLASS;
        public static const STATE_READY:int = 1;
        public static const ICON_LOADING:BitmapData = Bitmap(new ICON_LOADING_CLASS()).bitmapData;
        private static const ICON_ERROR_CLASS:Class = DynamicImage_ICON_ERROR_CLASS;

        public function DynamicImage()
        {
            this.m_BitmapData = ICON_LOADING;
            return;
        }// end function

        public function set state(param1:int) : void
        {
            var _loc_2:* = null;
            if (this.m_State != param1)
            {
                this.m_State = param1;
                _loc_2 = new IngameShopEvent(IngameShopEvent.IMAGE_CHANGED);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get fetchTime() : Number
        {
            return this.m_FetchTime;
        }// end function

        public function set fetchTime(param1:Number) : void
        {
            this.m_FetchTime = param1;
            return;
        }// end function

        public function get state() : int
        {
            return this.m_State;
        }// end function

        public function set bitmapData(param1:BitmapData) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_BitmapData)
            {
                this.m_BitmapData = param1;
                this.m_State = STATE_READY;
                _loc_2 = new IngameShopEvent(IngameShopEvent.IMAGE_CHANGED);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get bitmapData() : BitmapData
        {
            return this.m_BitmapData;
        }// end function

    }
}
