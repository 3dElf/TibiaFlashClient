package tibia.appearances.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import loader.asset.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.game.*;

    public class AsyncCompressedSpriteProvider extends Object implements ISpriteProvider
    {
        private var m_TempSpriteInformation:CachedSpriteInformation = null;
        private var m_TempRectangle:Rectangle;
        private var m_SpriteAssetKeys:Dictionary = null;
        private var m_AssetProvider:IAssetProvider = null;
        private var m_SpritesInformation:SpritesInformation = null;
        private var m_AsyncCompressedImageCache:AsyncCompressedImageCache = null;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;

        public function AsyncCompressedSpriteProvider(param1:IAssetProvider, param2:SpritesInformation, param3:uint)
        {
            var _loc_5:* = null;
            this.m_TempRectangle = new Rectangle();
            if (param1 == null)
            {
                throw new ArgumentError("AsyncCompressedSpriteProvider.AsyncCompressedSpriteProvider: asset provider must not be null");
            }
            this.m_AssetProvider = param1;
            if (param2 == null)
            {
                throw new ArgumentError("AsyncCompressedSpriteProvider.AsyncCompressedSpriteProvider: sprites information must not be null");
            }
            this.m_SpritesInformation = param2;
            this.m_AsyncCompressedImageCache = new AsyncCompressedImageCache(param3);
            this.m_AsyncCompressedImageCache.addEventListener(AsyncCompressedImageCacheEvent.UNCOMPRESS, this.onAsyncCompressedImageCacheUncompressed);
            this.m_TempSpriteInformation = new CachedSpriteInformation();
            var _loc_4:* = this.m_AssetProvider.getSpriteAssets();
            this.m_SpriteAssetKeys = new Dictionary();
            for each (_loc_5 in _loc_4)
            {
                
                this.m_SpriteAssetKeys[_loc_5.firstSpriteID] = _loc_5.uniqueKey;
                if (_loc_5.loaded)
                {
                    this.m_AsyncCompressedImageCache.addCompressedImage(_loc_5.firstSpriteID, _loc_5.rawBytes);
                    this.m_AssetProvider.removeAsset(_loc_5);
                }
            }
            if (param1.loadingFinished == false)
            {
                this.m_AssetProvider.addEventListener(AssetProviderEvent.ASSET_LOADED, this.onAssetProviderAssetLoaded);
                this.m_AssetProvider.addEventListener(AssetProviderEvent.ALL_ASSETS_LOADED, this.onAssetProviderAllAssetsLoaded);
            }
            else
            {
                this.m_AssetProvider = null;
            }
            return;
        }// end function

        private function onAssetProviderAllAssetsLoaded(event:AssetProviderEvent) : void
        {
            this.m_AssetProvider.removeEventListener(AssetProviderEvent.ASSET_LOADED, this.onAssetProviderAssetLoaded);
            this.m_AssetProvider.removeEventListener(AssetProviderEvent.ALL_ASSETS_LOADED, this.onAssetProviderAllAssetsLoaded);
            this.m_AssetProvider = null;
            return;
        }// end function

        private function onAssetProviderAssetLoaded(event:AssetProviderEvent) : void
        {
            var _loc_2:* = event.asset as SpritesAsset;
            if (_loc_2 != null)
            {
                if (_loc_2.loaded && _loc_2.optional == false)
                {
                    this.m_AsyncCompressedImageCache.addCompressedImage(_loc_2.firstSpriteID, _loc_2.rawBytes);
                    this.m_AssetProvider.removeAsset(_loc_2);
                }
            }
            return;
        }// end function

        public function getSprite(param1:uint, param2:CachedSpriteInformation = null, param3:AppearanceType = null) : CachedSpriteInformation
        {
            var _loc_4:* = null;
            if (param2 != null)
            {
                _loc_4 = param2;
            }
            else
            {
                _loc_4 = this.m_TempSpriteInformation;
                _loc_4.reset();
            }
            var _loc_5:* = null;
            var _loc_6:* = this.m_SpritesInformation.getFirstSpriteID(param1);
            _loc_5 = this.m_AsyncCompressedImageCache.getUncompressedImage(_loc_6);
            if (_loc_5 == null)
            {
                if (this.m_AssetProvider != null)
                {
                    this.m_AssetProvider.pushAssetForwardInLoadingQueueByKey(this.m_SpriteAssetKeys[_loc_6]);
                }
                _loc_4.cacheMiss = true;
            }
            else
            {
                this.m_SpritesInformation.getSpriteRectangle(param1, _loc_5.width, this.m_TempRectangle);
                _loc_4.setCachedSpriteInformationTo(param1, _loc_5, this.m_TempRectangle, false);
            }
            return _loc_4;
        }// end function

        private function onAsyncCompressedImageCacheUncompressed(event:AsyncCompressedImageCacheEvent) : void
        {
            return;
        }// end function

    }
}
