package tibia.appearances
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.game.*;

    public class SpritesInformation extends Object
    {
        private var m_SpriteAssetInformations:Vector.<SpriteAssetInformation> = null;
        private var m_SpriteCategoryRectangles:Vector.<Rectangle> = null;
        private var m_TempRectangle:Rectangle;
        private var m_CachedSpriteInformations:Dictionary = null;
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

        public function SpritesInformation(param1:Vector.<SpritesAsset>)
        {
            var _SpritesAsset:SpritesAsset;
            var _TempInformation:SpriteAssetInformation;
            var _Information:SpriteAssetInformation;
            var LastEndSpriteID:uint;
            var SpriteCount:uint;
            var TempSpriteID:uint;
            var a_SpritesAssets:* = param1;
            this.m_TempRectangle = new Rectangle();
            var i:uint;
            this.m_SpriteAssetInformations = new Vector.<SpriteAssetInformation>;
            var _loc_3:* = 0;
            var _loc_4:* = a_SpritesAssets;
            while (_loc_4 in _loc_3)
            {
                
                _SpritesAsset = _loc_4[_loc_3];
                _Information = new SpriteAssetInformation();
                _Information.m_FirstSpriteID = _SpritesAsset.firstSpriteID;
                _Information.m_LastSpriteID = _SpritesAsset.lastSpriteID;
                _Information.m_SpriteCategory = _SpritesAsset.spriteType;
                this.m_SpriteAssetInformations.push(_Information);
            }
            if (this.m_SpriteAssetInformations.length > 0)
            {
                this.m_SpriteAssetInformations.sort(function (param1:SpriteAssetInformation, param2:SpriteAssetInformation) : int
            {
                if (param1.m_FirstSpriteID < param2.m_FirstSpriteID)
                {
                    return -1;
                }
                if (param1.m_FirstSpriteID > param2.m_FirstSpriteID)
                {
                    return 1;
                }
                return 0;
            }// end function
            );
                LastEndSpriteID = this.m_SpriteAssetInformations[0].m_FirstSpriteID;
                i;
                while (i < this.m_SpriteAssetInformations.length)
                {
                    
                    if (this.m_SpriteAssetInformations[(i - 1)].m_LastSpriteID >= this.m_SpriteAssetInformations[i].m_FirstSpriteID)
                    {
                        throw new ArgumentError("SpritesInformation.SpriteAssetsInformation: SpriteID of content have overlapping ranges");
                    }
                    i = (i + 1);
                }
            }
            this.m_SpriteCategoryRectangles = new Vector.<Rectangle>(4, true);
            this.m_SpriteCategoryRectangles[0] = new Rectangle(0, 0, FIELD_SIZE, FIELD_SIZE);
            this.m_SpriteCategoryRectangles[1] = new Rectangle(0, 0, FIELD_SIZE, FIELD_SIZE * 2);
            this.m_SpriteCategoryRectangles[2] = new Rectangle(0, 0, FIELD_SIZE * 2, FIELD_SIZE);
            this.m_SpriteCategoryRectangles[3] = new Rectangle(0, 0, FIELD_SIZE * 2, FIELD_SIZE * 2);
            this.m_CachedSpriteInformations = new Dictionary();
            var _loc_3:* = 0;
            var _loc_4:* = this.m_SpriteAssetInformations;
            while (_loc_4 in _loc_3)
            {
                
                _TempInformation = _loc_4[_loc_3];
                SpriteCount = _TempInformation.m_LastSpriteID - _TempInformation.m_FirstSpriteID + 1;
                TempSpriteID = _TempInformation.m_FirstSpriteID;
                while (TempSpriteID <= _TempInformation.m_LastSpriteID)
                {
                    
                    this.m_CachedSpriteInformations[TempSpriteID] = new CachedSpriteInformation(TempSpriteID, null, this.m_SpriteCategoryRectangles[_TempInformation.m_SpriteCategory], true, false);
                    TempSpriteID = (TempSpriteID + 1);
                }
            }
            return;
        }// end function

        private function getSpriteSheetInformationForSpriteID(param1:uint) : SpriteAssetInformation
        {
            var _loc_5:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = this.m_SpriteAssetInformations.length - 1;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_2 = _loc_3 + _loc_4 >>> 1;
                _loc_5 = this.m_SpriteAssetInformations[_loc_2];
                if (param1 >= _loc_5.m_FirstSpriteID && param1 <= _loc_5.m_LastSpriteID)
                {
                    return _loc_5;
                }
                if (_loc_5.m_FirstSpriteID < param1)
                {
                    _loc_3 = _loc_2 + 1;
                    continue;
                }
                _loc_4 = _loc_2 - 1;
            }
            return null;
        }// end function

        public function get cachedSpriteInformations() : Dictionary
        {
            return this.m_CachedSpriteInformations;
        }// end function

        public function getSpriteCategory(param1:uint) : uint
        {
            var _loc_2:* = this.getSpriteSheetInformationForSpriteID(param1);
            if (_loc_2 == null)
            {
                throw new ArgumentError("SpritesInformation.getSpriteCategory: Invalid sprite  id " + param1);
            }
            return _loc_2.m_SpriteCategory;
        }// end function

        public function getSpriteRectangle(param1:uint, param2:uint, param3:Rectangle = null) : Rectangle
        {
            var _loc_4:* = this.getSpriteSheetInformationForSpriteID(param1);
            if (this.getSpriteSheetInformationForSpriteID(param1) == null)
            {
                throw new ArgumentError("SpritesInformation.getSpriteRectangle: Invalid sprite  id " + param1);
            }
            if (param3 == null)
            {
                param3 = this.m_TempRectangle;
            }
            this.getSpriteDimensions(param1, param3);
            var _loc_5:* = param1 - _loc_4.m_FirstSpriteID;
            var _loc_6:* = param2 / param3.width;
            param3.x = _loc_5 % _loc_6 * param3.width;
            param3.y = uint(_loc_5 / _loc_6) * param3.height;
            return param3;
        }// end function

        public function getSpriteDimensions(param1:uint, param2:Rectangle = null) : Rectangle
        {
            var _loc_3:* = this.getSpriteSheetInformationForSpriteID(param1);
            if (_loc_3 == null)
            {
                throw new ArgumentError("SpritesInformation.getSpriteDimensions: Invalid sprite  id " + param1);
            }
            if (param2 != null)
            {
                param2.copyFrom(this.m_SpriteCategoryRectangles[_loc_3.m_SpriteCategory]);
                return param2;
            }
            return this.m_SpriteCategoryRectangles[_loc_3.m_SpriteCategory];
        }// end function

        public function getFirstSpriteID(param1:uint) : uint
        {
            var _loc_2:* = this.getSpriteSheetInformationForSpriteID(param1);
            if (_loc_2 == null)
            {
                throw new ArgumentError("SpritesInformation.getFirstSpriteID: Invalid sprite  id " + param1);
            }
            return _loc_2.m_FirstSpriteID;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.geom.*;

import flash.utils.*;

import tibia.appearances.widgetClasses.*;

import tibia.game.*;

class SpriteAssetInformation extends Object
{
    public var m_SpriteCategory:uint = 0;
    public var m_LastSpriteID:uint = 0;
    public var m_FirstSpriteID:uint = 0;

    function SpriteAssetInformation()
    {
        return;
    }// end function

}

