package shared.utility
{
    import flash.geom.*;

    class BitmapCacheItem extends HeapItem
    {
        public var slot:int = -1;
        public var key:Object;
        public var rectangle:Rectangle;

        function BitmapCacheItem()
        {
            this.rectangle = new Rectangle(0, 0, 0, 0);
            return;
        }// end function

    }
}
