package shared.utility
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;

    public class BinPackedBitmapCache extends Object
    {
        private var m_Full:Boolean = false;
        private var m_Dictionary:Dictionary = null;
        private var m_DynamicBinPacker:DynamicBinPacker = null;
        private var m_TempBitmapPart:BitmapPart;
        private var m_StoredKeys:Vector.<Object> = null;
        private var m_CacheBitmapPart:BitmapPart;

        public function BinPackedBitmapCache(param1:BitmapPart)
        {
            this.m_CacheBitmapPart = new BitmapPart();
            this.m_TempBitmapPart = new BitmapPart();
            this.m_CacheBitmapPart = param1;
            this.m_CacheBitmapPart.setBitmapPartTo(param1.bitmapData, param1.rectangle);
            this.m_DynamicBinPacker = new DynamicBinPacker(param1.rectangle);
            this.m_Dictionary = new Dictionary();
            this.m_StoredKeys = new Vector.<Object>;
            this.m_Full = false;
            return;
        }// end function

        public function get usedSpace() : uint
        {
            return this.m_DynamicBinPacker.usedSpace;
        }// end function

        public function clear() : void
        {
            this.m_CacheBitmapPart.bitmapData.fillRect(this.m_CacheBitmapPart.rectangle, 0);
            this.m_Dictionary = new Dictionary();
            this.m_StoredKeys = new Vector.<Object>;
            this.m_DynamicBinPacker.clear();
            this.m_Full = false;
            return;
        }// end function

        public function get count() : uint
        {
            return this.m_StoredKeys.length;
        }// end function

        public function get bitmapCache() : BitmapPart
        {
            return this.m_CacheBitmapPart;
        }// end function

        public function put(param1:Object, param2:BitmapPart) : Boolean
        {
            var _loc_3:* = this.m_DynamicBinPacker.insert(param2.rectangle);
            if (_loc_3 == null)
            {
                this.m_Full = true;
                return false;
            }
            this.m_CacheBitmapPart.bitmapData.copyPixels(param2.bitmapData, param2.rectangle, _loc_3.topLeft);
            this.m_Dictionary[param1] = _loc_3;
            this.m_StoredKeys.push(param1);
            return true;
        }// end function

        public function get(param1:Object, param2:BitmapPart = null) : BitmapPart
        {
            var _loc_3:* = this.m_Dictionary[param1] as Rectangle;
            if (_loc_3 != null)
            {
                if (param2 == null)
                {
                    this.m_TempBitmapPart.setBitmapPartTo(this.m_CacheBitmapPart.bitmapData, _loc_3);
                    return this.m_TempBitmapPart;
                }
                param2.setBitmapPartTo(this.m_CacheBitmapPart.bitmapData, _loc_3);
                return param2;
            }
            else
            {
                return null;
            }
        }// end function

        public function get full() : Boolean
        {
            return this.m_Full;
        }// end function

        public function contains(param1:Object) : Boolean
        {
            return param1 in this.m_Dictionary;
        }// end function

        public function get cachedBitmaps() : uint
        {
            return this.m_DynamicBinPacker.packedRectangles;
        }// end function

        public function get fillFactor() : Number
        {
            return this.m_DynamicBinPacker.fillFactor;
        }// end function

        public function get storedKeys() : Vector.<Object>
        {
            return this.m_StoredKeys;
        }// end function

        public function get availableSpace() : uint
        {
            return this.m_DynamicBinPacker.availableSpace;
        }// end function

    }
}
