package tibia.ingameshop
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import shared.utility.*;

    public class DynamicImageManager extends Object
    {
        private var m_CachePrefix:String;
        private var m_BaseURL:String;
        private var m_Loaders:Dictionary;
        private var m_ImageReferences:Dictionary;
        private var m_CacheTime:int;
        public static const DEFAULT_CACHE_TIME:int = 3600;

        public function DynamicImageManager(param1:String, param2:String, param3:int)
        {
            this.m_BaseURL = param1;
            this.m_CachePrefix = param2;
            this.m_CacheTime = param3;
            this.m_ImageReferences = new Dictionary();
            this.m_Loaders = new Dictionary();
            return;
        }// end function

        private function fetchImageCache(param1:String) : DynamicImage
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_2 = this.getOrCreateCacheObject(param1);
            _loc_3 = new Date().time / 1000;
            var _loc_4:* = _loc_2 != null && _loc_2.data.fetchTime > _loc_3 - this.m_CacheTime;
            var _loc_5:* = _loc_2 != null && _loc_2.data.imageData as ByteArray != null && (_loc_2.data.imageData as ByteArray).length > 0;
            if (_loc_4 && _loc_5)
            {
                _loc_6 = new Loader();
                _loc_6.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
                _loc_6.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
                _loc_6.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
                this.m_Loaders[_loc_6] = param1;
                _loc_6.loadBytes(_loc_2.data.imageData as ByteArray);
                _loc_7 = this.getOrCreateImageReference(param1);
                _loc_7.fetchTime = _loc_2.data.fetchTime;
                _loc_7.state = DynamicImage.STATE_LOADING;
                return _loc_7;
            }
            return this.fetchImageRemote(param1);
        }// end function

        private function onLoadError(event:ErrorEvent) : void
        {
            var _loc_2:* = event.target as LoaderInfo;
            _loc_2.removeEventListener(Event.COMPLETE, this.onLoadComplete);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
            var _loc_3:* = _loc_2.loader;
            var _loc_4:* = this.m_Loaders[_loc_3] as String;
            delete this.m_Loaders[_loc_3];
            _loc_3.unload();
            event.preventDefault();
            var _loc_5:* = this.getOrCreateImageReference(_loc_4);
            _loc_5.bitmapData = DynamicImage.ICON_ERROR;
            delete this.m_ImageReferences[_loc_4];
            return;
        }// end function

        public function getImage(param1:String) : DynamicImage
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            if (param1 == null || param1.length == 0)
            {
                return null;
            }
            if (this.m_ImageReferences.hasOwnProperty(param1))
            {
                _loc_2 = this.m_ImageReferences[param1] as DynamicImage;
                _loc_3 = new Date().time / 1000;
                if (_loc_2.state == DynamicImage.STATE_READY && _loc_2.fetchTime < _loc_3 - this.m_CacheTime)
                {
                    this.fetchImageRemote(param1);
                    ;
                }
                return _loc_2;
            }
            else
            {
            }
            return this.fetchImageCache(param1);
        }// end function

        private function fetchImageRemote(param1:String) : DynamicImage
        {
            var _loc_2:* = new Loader();
            _loc_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            _loc_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            _loc_2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
            this.m_Loaders[_loc_2] = param1;
            var _loc_3:* = new URLRequest(this.m_BaseURL + param1);
            _loc_2.load(_loc_3);
            var _loc_4:* = this.getOrCreateImageReference(param1);
            _loc_4.fetchTime = new Date().time / 1000;
            _loc_4.state = DynamicImage.STATE_LOADING;
            return _loc_4;
        }// end function

        private function getOrCreateImageReference(param1:String) : DynamicImage
        {
            var _loc_2:* = null;
            if (this.m_ImageReferences.hasOwnProperty(param1))
            {
                _loc_2 = this.m_ImageReferences[param1] as DynamicImage;
            }
            else
            {
                _loc_2 = new DynamicImage();
                this.m_ImageReferences[param1] = _loc_2;
            }
            return _loc_2;
        }// end function

        private function getOrCreateCacheObject(param1:String) : SharedObject
        {
            var CacheObject:SharedObject;
            var a_Identifier:* = param1;
            try
            {
                CacheObject;
                if (!BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                {
                    CacheObject = SharedObject.getLocal(this.m_CachePrefix + a_Identifier.replace("/", "_"), "/");
                }
                return CacheObject;
            }
            catch (_Error:Error)
            {
            }
            return null;
        }// end function

        private function onLoadComplete(event:Event) : void
        {
            var ImageIdentifier:String;
            var Data:Bitmap;
            var ErrorImgReference:DynamicImage;
            var a_Event:* = event;
            var _LoaderInfo:* = a_Event.target as LoaderInfo;
            _LoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadComplete);
            _LoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            _LoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
            var _Loader:* = _LoaderInfo.loader;
            ImageIdentifier = this.m_Loaders[_Loader];
            delete this.m_Loaders[_Loader];
            try
            {
                Data = _Loader.content as Bitmap;
            }
            catch (_Error:SecurityError)
            {
                ErrorImgReference = getOrCreateImageReference(ImageIdentifier);
                ErrorImgReference.bitmapData = DynamicImage.ICON_ERROR;
                delete m_ImageReferences[ImageIdentifier];
                return;
            }
            _Loader.unload();
            var CacheObject:* = this.getOrCreateCacheObject(ImageIdentifier);
            if (CacheObject != null)
            {
                CacheObject.data.fetchTime = new Date().time / 1000;
                CacheObject.data.imageData = new ByteArray();
                Data.bitmapData.encode(Data.bitmapData.rect, new PNGEncoderOptions(), CacheObject.data.imageData);
            }
            var ImgReference:* = this.getOrCreateImageReference(ImageIdentifier);
            ImgReference.state = DynamicImage.STATE_READY;
            ImgReference.bitmapData = Data.bitmapData;
            return;
        }// end function

    }
}
