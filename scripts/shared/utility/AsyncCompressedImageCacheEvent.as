package shared.utility
{
    import flash.events.*;

    public class AsyncCompressedImageCacheEvent extends Event
    {
        private var m_ImageKey:Object = null;
        public static const UNCOMPRESS:String = "uncompress";

        public function AsyncCompressedImageCacheEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            super(param1, param2, param3);
            this.m_ImageKey = param4;
            return;
        }// end function

        public function get imageKey() : Object
        {
            return this.m_ImageKey;
        }// end function

    }
}
