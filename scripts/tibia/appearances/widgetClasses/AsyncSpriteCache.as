package tibia.appearances.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;

    public class AsyncSpriteCache extends Object implements ISpriteProvider
    {
        private var m_AsyncCompressedSpriteProvider:AsyncCompressedSpriteProvider = null;
        private var m_TempSpriteInformation:CachedSpriteInformation;
        public var m_PagedBitmapCache:PagedBitmapCache = null;
        private var m_CacheBitmap:BitmapData = null;
        private static const ENVIRONMENTAL_EFFECTS:Array = [];
        public static const FRAME_GROUP_WALKING:uint = 1;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const MINIMUM_SPEED_FRAME_DURATION:int = 720;
        static const NUM_EFFECTS:int = 200;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        public static const PHASE_AUTOMATIC:int = -1;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const APPEARANCE_MISSILE:uint = 3;
        static const FIELD_HEIGHT:int = 24;
        public static const COMPRESSED_IMAGES_CACHE_MEMORY:uint = 3.53894e+007;
        static const UNDERGROUND_LAYER:int = 2;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        public static const PHASE_RANDOM:int = 254;
        private static const MAXIMUM_SPEED_FRAME_DURATION:int = 280;
        static const APPEARANCE_OUTFIT:uint = 1;
        static const FIELD_CACHESIZE:int = 32;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        public static const SPRITE_CACHE_PAGE_DIMENSION:uint = 512;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        public static const SPRITE_CACHE_PAGE_COUNT:uint = 25;
        static const GROUND_LAYER:int = 7;
        static const APPEARANCE_OBJECT:uint = 0;
        public static const ANIMATION_DELAY_BEFORE_RESET:int = 1000;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        public static const ANIMATION_ASYNCHRON:int = 0;
        public static const PHASE_ASYNCHRONOUS:int = 255;
        static const NUM_FIELDS:int = 2016;
        private static const MIN_SPEED_DELAY:int = 550;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const APPEARANCE_EFFECT:uint = 2;
        public static const FRAME_GROUP_DEFAULT:uint = 0;
        private static const MAX_SPEED_DELAY:int = 100;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        public static const FRAME_GROUP_IDLE:uint = 0;
        public static const ANIMATION_SYNCHRON:int = 1;

        public function AsyncSpriteCache(param1:AsyncCompressedSpriteProvider, param2:Dictionary)
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_7:* = 0;
            this.m_TempSpriteInformation = new CachedSpriteInformation();
            if (param1 == null)
            {
                throw new ArgumentError("AsyncSpriteCache.AsyncSpriteCache: a_AsyncCompressedSpriteProvider must not be null");
            }
            if (param2 == null)
            {
                throw new ArgumentError("AsyncSpriteCache.AsyncSpriteCache: m_CachedSpriteInformations must not be null");
            }
            this.m_AsyncCompressedSpriteProvider = param1;
            _loc_3 = Math.ceil(Math.sqrt(SPRITE_CACHE_PAGE_COUNT));
            _loc_4 = Math.ceil(SPRITE_CACHE_PAGE_COUNT / _loc_3);
            this.m_CacheBitmap = new BitmapData(_loc_3 * SPRITE_CACHE_PAGE_DIMENSION, _loc_4 * SPRITE_CACHE_PAGE_DIMENSION, true, 0);
            var _loc_5:* = new Vector.<BitmapPart>(_loc_3 * _loc_4, true);
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = 0;
                while (_loc_7 < _loc_3)
                {
                    
                    _loc_5[_loc_6 * _loc_3 + _loc_7] = new BitmapPart(this.m_CacheBitmap, new Rectangle(_loc_7 * SPRITE_CACHE_PAGE_DIMENSION, _loc_6 * SPRITE_CACHE_PAGE_DIMENSION, SPRITE_CACHE_PAGE_DIMENSION, SPRITE_CACHE_PAGE_DIMENSION));
                    _loc_7 = _loc_7 + 1;
                }
                _loc_6 = _loc_6 + 1;
            }
            this.m_CacheBitmap.lock();
            this.m_PagedBitmapCache = new PagedBitmapCache(_loc_5);
            return;
        }// end function

        private function cacheSprite(param1:CachedSpriteInformation) : Boolean
        {
            var _loc_2:* = false;
            if (param1.cacheMiss)
            {
                this.m_TempSpriteInformation = this.m_AsyncCompressedSpriteProvider.getSprite(param1.spriteID, this.m_TempSpriteInformation);
                if (this.m_TempSpriteInformation.cacheMiss == false)
                {
                    _loc_2 = this.m_PagedBitmapCache.put(param1.spriteID, this.m_TempSpriteInformation);
                    this.m_PagedBitmapCache.get(param1.spriteID, param1);
                    param1.cacheMiss = false;
                    return _loc_2;
                }
            }
            return false;
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
            var _loc_5:* = this.m_PagedBitmapCache.get(param1, _loc_4);
            if (this.m_PagedBitmapCache.get(param1, _loc_4) == null)
            {
                _loc_4.cacheMiss = true;
            }
            else
            {
                _loc_4.cacheMiss = false;
            }
            if (_loc_4.cacheMiss == true)
            {
                this.cacheSprite(_loc_4);
                if (_loc_4.cacheMiss == false)
                {
                    if (param3 != null)
                    {
                        this.cacheSpritesForAppearanceType(param3, true);
                    }
                }
            }
            return _loc_4;
        }// end function

        public function get cachedBitmaps() : uint
        {
            return this.m_PagedBitmapCache.cachedBitmaps;
        }// end function

        public function get fillFactor() : Number
        {
            return this.m_PagedBitmapCache.fillFactor;
        }// end function

        public function get currentBitmapCache() : BitmapPart
        {
            return this.m_PagedBitmapCache.currentBufferCachePage;
        }// end function

        public function get invalidBitmapCache() : BitmapPart
        {
            return this.m_PagedBitmapCache.invalidCachePage;
        }// end function

        private function cacheSpritesForAppearanceType(param1:AppearanceType, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (param1 == null)
            {
                return;
            }
            for each (_loc_3 in param1.FrameGroups)
            {
                
                _loc_4 = _loc_3.cachedSpriteInformations.length;
                _loc_5 = 0;
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_7 = _loc_3.cachedSpriteInformations[_loc_6];
                    if (this.cacheSprite(_loc_7))
                    {
                        _loc_5 = _loc_5 + 1;
                    }
                    _loc_6 = _loc_6 + 1;
                }
            }
            return;
        }// end function

    }
}
