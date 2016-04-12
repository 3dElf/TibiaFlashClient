package shared.utility
{
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class AsyncCompressedImageCache extends EventDispatcher
    {
        private var m_LoaderPool:HeapDictionaryWrapper = null;
        private const m_CompressedImages:Dictionary;
        private var m_MemoryUsed:uint = 0;
        private var m_MaxMemory:uint = 0;
        private var m_UncompressQueueAccessKey:int = 2.14748e+009;
        private var m_UncompressedImagesCollection:HeapDictionaryWrapper = null;
        private var m_UncompressQueue:HeapDictionaryWrapper = null;
        private var m_LoaderPoolKeysLoading:Dictionary = null;
        private var m_LoaderContext:LoaderContext = null;
        private var m_UncompressedImagesAccessKey:int = -2.14748e+009;
        private static const LOADER_POOL_SIZE:uint = 4;

        public function AsyncCompressedImageCache(param1:uint = 0)
        {
            var _loc_3:* = null;
            this.m_CompressedImages = new Dictionary();
            this.m_LoaderPool = new HeapDictionaryWrapper();
            this.m_LoaderPoolKeysLoading = new Dictionary();
            var _loc_2:* = 0;
            while (_loc_2 < LOADER_POOL_SIZE)
            {
                
                _loc_3 = new LoaderPoolEntry();
                _loc_3.m_Loader = new Loader();
                _loc_3.m_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onUncompressImageComplete);
                _loc_3.m_Loader.contentLoaderInfo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onUncompressImageError);
                _loc_3.m_Loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onUncompressImageError);
                _loc_3.m_Loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onUncompressImageError);
                this.m_LoaderPool.put(_loc_3.m_Loader, _loc_3, int.MIN_VALUE);
                _loc_2 = _loc_2 + 1;
            }
            this.m_MaxMemory = param1;
            this.m_UncompressedImagesCollection = new HeapDictionaryWrapper();
            this.m_UncompressQueue = new HeapDictionaryWrapper();
            this.m_LoaderContext = new LoaderContext();
            this.m_LoaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            return;
        }// end function

        private function onUncompressImageError(event:Event) : void
        {
            throw Error("AsyncCompressedImageCache.onGetBitmapDataError: Error while uncompressing image");
        }// end function

        private function removeUncompressedBitmap(param1:Object) : void
        {
            var _loc_2:* = null;
            if (this.m_UncompressedImagesCollection.contains(param1))
            {
                var _loc_3:* = this;
                _loc_3.m_UncompressedImagesAccessKey = this.m_UncompressedImagesAccessKey + 1;
                _loc_2 = this.m_UncompressedImagesCollection.get(param1, this.m_UncompressedImagesAccessKey++) as BitmapData;
                this.m_MemoryUsed = this.m_MemoryUsed - this.calculateUsedMemory(_loc_2);
                this.m_UncompressedImagesCollection.remove(param1);
                _loc_2.dispose();
                _loc_2 = null;
            }
            return;
        }// end function

        private function onUncompressImageComplete(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_2 = LoaderInfo(event.target);
            _loc_3 = this.m_LoaderPool.get(_loc_2.loader) as LoaderPoolEntry;
            _loc_4 = _loc_3.m_CompressedImageKey;
            _loc_3.m_Busy = false;
            this.m_LoaderPool.updateHeapPriority(_loc_3.m_Loader, int.MIN_VALUE);
            delete this.m_LoaderPoolKeysLoading[_loc_4];
            var _loc_5:* = (_loc_2.content as Bitmap).bitmapData;
            this.addUncompressedBitmap(_loc_4, _loc_5);
            _loc_3.m_CompressedImageKey = null;
            var _loc_6:* = new AsyncCompressedImageCacheEvent(AsyncCompressedImageCacheEvent.UNCOMPRESS, false, false, _loc_4);
            this.uncompressNextImage();
            dispatchEvent(_loc_6);
            return;
        }// end function

        public function get memoryUsed() : uint
        {
            return this.m_MemoryUsed;
        }// end function

        private function addUncompressRequestToQueue(param1:Object) : void
        {
            if (param1 in this.m_LoaderPoolKeysLoading || this.m_UncompressedImagesCollection.contains(param1))
            {
                return;
            }
            if (param1 in this.m_CompressedImages == false)
            {
                return;
            }
            if (this.m_UncompressQueue.contains(param1))
            {
                var _loc_2:* = this;
                _loc_2.m_UncompressQueueAccessKey = this.m_UncompressQueueAccessKey - 1;
                this.m_UncompressQueue.updateHeapPriority(param1, this.m_UncompressQueueAccessKey--);
            }
            else
            {
                var _loc_2:* = this;
                _loc_2.m_UncompressQueueAccessKey = this.m_UncompressQueueAccessKey - 1;
                this.m_UncompressQueue.put(param1, param1, this.m_UncompressQueueAccessKey--);
            }
            return;
        }// end function

        public function getUncompressedImage(param1:Object) : BitmapData
        {
            var _loc_2:* = null;
            if (this.m_UncompressedImagesCollection.contains(param1))
            {
                var _loc_3:* = this;
                _loc_3.m_UncompressedImagesAccessKey = this.m_UncompressedImagesAccessKey + 1;
                _loc_2 = this.m_UncompressedImagesCollection.get(param1, this.m_UncompressedImagesAccessKey++) as BitmapData;
                return _loc_2;
            }
            this.addUncompressRequestToQueue(param1);
            this.uncompressNextImage();
            return null;
        }// end function

        private function uncompressNextImage() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.m_UncompressQueue.length > 0)
            {
                _loc_1 = this.m_LoaderPool.peekMinItem() as LoaderPoolEntry;
                if (_loc_1 == null)
                {
                    throw new Error("AsyncCompressedImageCache.uncompressNextImage: Empty loader pool");
                }
                if (_loc_1.m_Busy == true)
                {
                    return;
                }
                _loc_2 = this.getAndRemoveNewestUncompressRequestFromQueue();
                if (_loc_2 != null)
                {
                    _loc_1.m_CompressedImageKey = _loc_2;
                    _loc_1.m_Busy = true;
                    _loc_1.m_Loader.loadBytes(this.m_CompressedImages[_loc_2], this.m_LoaderContext);
                    this.m_LoaderPoolKeysLoading[_loc_1.m_CompressedImageKey] = true;
                    this.m_LoaderPool.updateHeapPriority(_loc_1.m_Loader, int.MAX_VALUE);
                }
            }
            return;
        }// end function

        private function addUncompressedBitmap(param1:Object, param2:BitmapData) : void
        {
            var _loc_4:* = null;
            if (this.m_UncompressedImagesCollection.contains(param1))
            {
                this.m_UncompressedImagesCollection.remove(param1);
            }
            var _loc_3:* = this.calculateUsedMemory(param2);
            while (this.m_MemoryUsed + _loc_3 > this.m_MaxMemory)
            {
                
                _loc_4 = this.m_UncompressedImagesCollection.peekMinItemKey();
                if (_loc_4 != null)
                {
                    this.removeUncompressedBitmap(_loc_4);
                    continue;
                }
                break;
            }
            this.m_MemoryUsed = this.m_MemoryUsed + _loc_3;
            var _loc_5:* = this;
            _loc_5.m_UncompressedImagesAccessKey = this.m_UncompressedImagesAccessKey + 1;
            this.m_UncompressedImagesCollection.put(param1, param2.clone(), this.m_UncompressedImagesAccessKey++);
            return;
        }// end function

        public function clearCache() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.m_UncompressedImagesCollection.keys)
            {
                
                this.removeUncompressedBitmap(_loc_1);
            }
            return;
        }// end function

        public function addCompressedImage(param1:Object, param2:ByteArray) : void
        {
            if (param1 != null)
            {
                this.m_CompressedImages[param1] = param2;
                this.removeUncompressedBitmap(param1);
            }
            return;
        }// end function

        private function calculateUsedMemory(param1:BitmapData) : uint
        {
            return param1.width * param1.height * (param1.transparent ? (4) : (3));
        }// end function

        private function getAndRemoveNewestUncompressRequestFromQueue() : Object
        {
            var _loc_1:* = this.m_UncompressQueue.peekMinItemKey();
            if (_loc_1 != null)
            {
                this.m_UncompressQueue.remove(_loc_1);
                if (this.m_UncompressQueue.length == 0)
                {
                    this.m_UncompressQueueAccessKey = int.MAX_VALUE;
                }
                return _loc_1;
            }
            else
            {
                return null;
            }
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.system.*;

import flash.utils.*;

class LoaderPoolEntry extends Object
{
    public var m_Loader:Loader = null;
    public var m_CompressedImageKey:Object = null;
    public var m_Busy:Boolean = false;

    function LoaderPoolEntry()
    {
        return;
    }// end function

}

