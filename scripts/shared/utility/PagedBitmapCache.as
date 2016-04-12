package shared.utility
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class PagedBitmapCache extends Object
    {
        private var m_UncomittedFillFactor:Boolean = true;
        private var m_CurrentBufferCachePage:CachePage = null;
        private var m_CurrentAccessKey:uint = 0;
        private var m_PagesCount:uint = 0;
        private var m_FilledPagesCount:uint = 0;
        private var m_CurrentInvalidCachePage:CachePage = null;
        private var m_KeyToCachePageInformation:Dictionary = null;
        private var m_FillFactor:Number = 0;
        private var m_CachePages:Vector.<CachePage> = null;
        private var m_CachedBitmaps:uint = 0;

        public function PagedBitmapCache(param1:Vector.<BitmapPart>)
        {
            var _loc_3:* = null;
            if (param1 == null || param1.length < 2)
            {
                throw new ArgumentError("PagedBitmapCache.PagedBitmapCache: cache pages vector must not be null and contain at least two pages");
            }
            this.m_CachePages = new Vector.<CachePage>(param1.length, true);
            this.m_KeyToCachePageInformation = new Dictionary();
            this.m_PagesCount = this.m_CachePages.length;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_PagesCount)
            {
                
                _loc_3 = new CachePage();
                _loc_3.m_BitmapCache = new BinPackedBitmapCache(param1[_loc_2]);
                this.m_CachePages[_loc_2] = _loc_3;
                _loc_2 = _loc_2 + 1;
            }
            this.m_CurrentBufferCachePage = this.m_CachePages[0];
            this.m_CurrentInvalidCachePage = null;
            return;
        }// end function

        public function get invalidCachePage() : BitmapPart
        {
            if (this.m_CurrentInvalidCachePage != null)
            {
                return this.m_CurrentInvalidCachePage.m_BitmapCache.bitmapCache;
            }
            return null;
        }// end function

        private function calculateUsedSpace() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (this.m_UncomittedFillFactor == true)
            {
                this.m_UncomittedFillFactor = false;
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                while (_loc_4 < this.m_PagesCount)
                {
                    
                    _loc_5 = this.m_CachePages[_loc_4];
                    if (_loc_5 != this.m_CurrentInvalidCachePage)
                    {
                        _loc_1 = _loc_1 + _loc_5.m_BitmapCache.availableSpace;
                        _loc_2 = _loc_2 + _loc_5.m_BitmapCache.usedSpace;
                        _loc_3 = _loc_3 + _loc_5.m_BitmapCache.cachedBitmaps;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                this.m_FillFactor = _loc_2 / _loc_1;
                this.m_CachedBitmaps = _loc_3;
            }
            return;
        }// end function

        public function put(param1:Object, param2:BitmapPart) : Boolean
        {
            var _loc_3:* = false;
            var _loc_4:* = 0;
            while (_loc_3 == false && _loc_4 < this.m_PagesCount)
            {
                
                if (this.m_CurrentBufferCachePage.m_BitmapCache.put(param1, param2) == true)
                {
                    this.m_KeyToCachePageInformation[param1] = this.m_CurrentBufferCachePage;
                    var _loc_5:* = this;
                    _loc_5.m_CurrentAccessKey = this.m_CurrentAccessKey + 1;
                    this.m_CurrentBufferCachePage.m_LastAccessKey = this.m_CurrentAccessKey + 1;
                    _loc_3 = true;
                    this.onBitmapAdded(param1);
                    continue;
                }
                _loc_4 = _loc_4 + 1;
                this.setNewBufferCachePage();
            }
            return _loc_3;
        }// end function

        private function getMinValidCachePage() : CachePage
        {
            var _loc_3:* = null;
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_PagesCount)
            {
                
                _loc_3 = this.m_CachePages[_loc_2];
                if (_loc_3.m_Valid && (_loc_1 == null || _loc_3.m_LastAccessKey < _loc_1.m_LastAccessKey))
                {
                    _loc_1 = _loc_3;
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        protected function onBitmapRemoved(param1:Object) : void
        {
            this.m_UncomittedFillFactor = true;
            return;
        }// end function

        private function setNewBufferCachePage() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this.m_CurrentBufferCachePage.m_BitmapCache.full)
            {
                if (this.m_FilledPagesCount >= this.m_PagesCount - 2)
                {
                    if (this.m_CurrentInvalidCachePage != null)
                    {
                        _loc_1 = this.m_CurrentInvalidCachePage.m_BitmapCache.storedKeys;
                        _loc_2 = _loc_1.length;
                        while (_loc_3 < _loc_2)
                        {
                            
                            _loc_5 = _loc_1[_loc_3] as Object;
                            _loc_6 = this.m_KeyToCachePageInformation[_loc_5] as CachePage;
                            if (_loc_6 != null && _loc_6 == this.m_CurrentInvalidCachePage)
                            {
                                delete this.m_KeyToCachePageInformation[_loc_5];
                                this.onBitmapRemoved(_loc_5);
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                        this.m_CurrentInvalidCachePage.m_BitmapCache.clear();
                        _loc_4 = this.getMinValidCachePage();
                        this.markCachePageAsInvalid(_loc_4);
                        this.m_CurrentInvalidCachePage.m_LastAccessKey = uint.MIN_VALUE;
                        this.m_CurrentInvalidCachePage.m_Valid = true;
                        this.m_CurrentBufferCachePage = this.m_CurrentInvalidCachePage;
                        this.m_CurrentInvalidCachePage = _loc_4;
                    }
                    else
                    {
                        this.m_CurrentBufferCachePage = this.getMinValidCachePage();
                        this.m_CurrentBufferCachePage.m_LastAccessKey = int.MAX_VALUE;
                        this.m_CurrentInvalidCachePage = this.getMinValidCachePage();
                        this.markCachePageAsInvalid(this.m_CurrentInvalidCachePage);
                    }
                }
                else
                {
                    this.m_CurrentBufferCachePage = this.getMinValidCachePage();
                    var _loc_7:* = this;
                    var _loc_8:* = this.m_FilledPagesCount + 1;
                    _loc_7.m_FilledPagesCount = _loc_8;
                }
                if (this.m_CurrentInvalidCachePage != null && this.m_CurrentBufferCachePage == this.m_CurrentInvalidCachePage)
                {
                    throw new Error("PagedBitmapCache.setNewCachePageIndices: Current buffer cache page can\'t be the same as the current invalid cache page.");
                }
            }
            return;
        }// end function

        public function get(param1:Object, param2:BitmapPart = null) : BitmapPart
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_3:* = this.m_KeyToCachePageInformation[param1] as CachePage;
            if (_loc_3 !== null)
            {
                _loc_4 = _loc_3.m_BitmapCache.get(param1, param2);
                if (this.m_CurrentInvalidCachePage != null && _loc_3 == this.m_CurrentInvalidCachePage)
                {
                    _loc_5 = this.m_CurrentBufferCachePage.m_BitmapCache.put(param1, _loc_4);
                    if (_loc_5 == false)
                    {
                        this.setNewBufferCachePage();
                        return null;
                    }
                    this.m_KeyToCachePageInformation[param1] = this.m_CurrentBufferCachePage;
                    this.onBitmapPositionChanged(param1);
                    return this.get(param1, param2);
                }
                else
                {
                    var _loc_6:* = this;
                    _loc_6.m_CurrentAccessKey = this.m_CurrentAccessKey + 1;
                    _loc_3.m_LastAccessKey = this.m_CurrentAccessKey + 1;
                    return _loc_4;
                }
            }
            else
            {
                return null;
            }
        }// end function

        public function get currentBufferCachePage() : BitmapPart
        {
            return this.m_CurrentBufferCachePage.m_BitmapCache.bitmapCache;
        }// end function

        public function get cachedBitmaps() : uint
        {
            this.calculateUsedSpace();
            return this.m_CachedBitmaps;
        }// end function

        protected function deprecateBitmap(param1:Object) : void
        {
            this.m_UncomittedFillFactor = true;
            return;
        }// end function

        protected function onBitmapAdded(param1:Object) : void
        {
            this.m_UncomittedFillFactor = true;
            return;
        }// end function

        public function get fillFactor() : Number
        {
            this.calculateUsedSpace();
            return this.m_FillFactor;
        }// end function

        private function markCachePageAsInvalid(param1:CachePage) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1.m_Valid == true)
            {
                param1.m_Valid = false;
                _loc_2 = param1.m_BitmapCache.storedKeys;
                _loc_3 = _loc_2.length;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = _loc_2[_loc_4] as Object;
                    this.deprecateBitmap(_loc_5);
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

        protected function onBitmapPositionChanged(param1:Object) : void
        {
            this.m_UncomittedFillFactor = true;
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.utils.*;

class CachePage extends Object
{
    public var m_BitmapCache:BinPackedBitmapCache = null;
    public var m_LastAccessKey:uint = 0;
    public var m_Valid:Boolean = true;

    function CachePage()
    {
        return;
    }// end function

}

