package tibia.worldmap
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import shared.utility.*;
    import tibia.appearances.*;

    public class Field extends Object
    {
        var m_MiniMapCost:int = 2.14748e+009;
        var m_ObjectsRenderer:Vector.<ObjectInstance> = null;
        var m_CacheObjectsCount:int = 0;
        var m_ObjectsCount:int = 0;
        var m_Effects:Vector.<AppearanceInstance> = null;
        var m_Environment:ObjectInstance = null;
        var m_CacheLyingObject:Boolean = false;
        var m_CacheTranslucent:Boolean = false;
        var m_CacheObjectsHeight:int = 0;
        var m_ObjectsNetwork:Vector.<ObjectInstance> = null;
        var m_CacheBitmapDirty:Boolean = false;
        var m_MiniMapColour:uint = 0;
        var m_CacheRectangle:Rectangle = null;
        var m_CacheObjectsDirty:Boolean = false;
        var m_EffectsCount:int = 0;
        var m_CacheUnsight:Boolean = false;
        var m_MiniMapDirty:Boolean = false;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const ACTION_LOOK:int = 6;
        static const NUM_EFFECTS:int = 200;
        private static const ACTION_SMARTCLICK:int = 100;
        static const PATH_SOUTH:int = 7;
        private static const ACTION_TALK:int = 9;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const MM_SECTOR_SIZE:int = 256;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        static const PATH_NORTH_WEST:int = 4;
        static const MM_IE_TIMEOUT:Number = 50;
        static const MM_IO_TIMEOUT:Number = 500;
        static const MM_SIDEBAR_ZOOM_MIN:int = -1;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const FIELD_HEIGHT:int = 24;
        static const MM_COLOUR_DEFAULT:uint = 0;
        static const PATH_COST_OBSTACLE:int = 255;
        static const UNDERGROUND_LAYER:int = 2;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const MM_SIDEBAR_ZOOM_MAX:int = 2;
        private static var s_CacheCount:int = 0;
        static const FIELD_CACHESIZE:int = 32;
        static const PATH_ERROR_UNREACHABLE:int = -4;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const PATH_NORTH:int = 3;
        static var s_CacheBitmap:BitmapData = new BitmapData(MAPSIZE_X * FIELD_CACHESIZE, MAPSIZE_Y * MAPSIZE_Z * FIELD_CACHESIZE, true, 4278255360);
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const PATH_MAX_DISTANCE:int = 110;
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const PATH_NORTH_EAST:int = 2;
        static const PATH_SOUTH_WEST:int = 6;
        static const MM_SIDEBAR_VIEW_HEIGHT:int = 106;
        private static const ACTION_ATTACK:int = 1;
        static const GROUND_LAYER:int = 7;
        private static const ACTION_CONTEXT_MENU:int = 5;
        static const PATH_WEST:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const PATH_COST_UNDEFINED:int = 254;
        static const PATH_EMPTY:int = 0;
        static const PATH_ERROR_TOO_FAR:int = -3;
        private static const ACTION_NONE:int = 0;
        static const PATH_MATRIX_SIZE:int = 221;
        static const MM_STORAGE_MIN_VERSION:int = 1;
        static const PATH_SOUTH_EAST:int = 8;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        static const NUM_FIELDS:int = 2016;
        static const PATH_COST_MAX:int = 250;
        static const PATH_MAX_STEPS:int = 128;
        static const MM_STORAGE_MAX_VERSION:int = 1;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        static const MM_CACHE_SIZE:int = 48;
        private static const ACTION_UNSET:int = -1;
        static const PATH_EXISTS:int = 1;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        private static const ACTION_OPEN:int = 8;
        private static const ACTION_USE_OR_OPEN:int = 101;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MM_SIDEBAR_HIGHLIGHT_DURATION:Number = 10000;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const PATH_EAST:int = 1;
        private static const ACTION_AUTOWALK:int = 3;
        static const MAP_WIDTH:int = 15;
        private static const ACTION_USE:int = 7;
        static const PATH_MATRIX_CENTER:int = 110;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;

        public function Field()
        {
            s_AllocateCache(this);
            this.m_ObjectsNetwork = new Vector.<ObjectInstance>(MAPSIZE_W, true);
            this.m_ObjectsRenderer = new Vector.<ObjectInstance>(MAPSIZE_W, true);
            this.m_Effects = new Vector.<AppearanceInstance>;
            return;
        }// end function

        function getObjectPriority(param1:ObjectInstance) : int
        {
            var _loc_2:* = param1.type;
            if (_loc_2.isBank)
            {
                return 0;
            }
            if (_loc_2.isClip)
            {
                return 1;
            }
            if (_loc_2.isBottom)
            {
                return 2;
            }
            if (_loc_2.isTop)
            {
                return 3;
            }
            if (_loc_2.ID == AppearanceInstance.CREATURE)
            {
                return 4;
            }
            return 5;
        }// end function

        public function getEffect(param1:int) : AppearanceInstance
        {
            return this.m_Effects[param1];
        }// end function

        public function changeObject(param1:ObjectInstance, param2:int) : ObjectInstance
        {
            if (param1 == null)
            {
                return null;
            }
            if (param2 < 0 || param2 >= this.m_ObjectsCount)
            {
                return null;
            }
            var _loc_3:* = this.m_ObjectsNetwork[param2];
            this.m_ObjectsNetwork[param2] = param1;
            this.m_CacheObjectsDirty = true;
            this.m_CacheBitmapDirty = true;
            this.m_MiniMapDirty = true;
            return _loc_3;
        }// end function

        public function updateBitmapCache(param1:int, param2:int, param3:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this.m_CacheBitmapDirty)
            {
                return;
            }
            this.m_CacheBitmapDirty = false;
            this.updateObjectsCache();
            this.m_CacheObjectsCount = 0;
            this.m_CacheObjectsHeight = 0;
            this.m_CacheLyingObject = false;
            s_CacheBitmap.fillRect(this.m_CacheRectangle, 0);
            var _loc_4:* = this.getTopLookObject();
            while (this.m_CacheObjectsCount < _loc_4)
            {
                
                _loc_5 = this.m_ObjectsRenderer[this.m_CacheObjectsCount];
                _loc_6 = _loc_5.type;
                if (!_loc_6.isCachable || _loc_6.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize + Math.max(_loc_6.displacementX, _loc_6.displacementY) + this.m_CacheObjectsHeight > FIELD_CACHESIZE)
                {
                    break;
                }
                _loc_5.drawTo(s_CacheBitmap, this.m_CacheRectangle.right - this.m_CacheObjectsHeight, this.m_CacheRectangle.bottom - this.m_CacheObjectsHeight, param1, param2, param3);
                this.m_CacheBitmapDirty = this.m_CacheBitmapDirty || _loc_5.cacheDirty;
                this.m_CacheObjectsHeight = Math.min(this.m_CacheObjectsHeight + _loc_6.elevation, FIELD_HEIGHT);
                this.m_CacheLyingObject = this.m_CacheLyingObject || _loc_6.isLyingObject;
                if (this.m_CacheBitmapDirty)
                {
                    break;
                    continue;
                }
                var _loc_7:* = this;
                var _loc_8:* = this.m_CacheObjectsCount + 1;
                _loc_7.m_CacheObjectsCount = _loc_8;
            }
            return;
        }// end function

        function deleteEffect(param1:int) : void
        {
            if (param1 < 0 || param1 >= this.m_EffectsCount)
            {
                throw new ArgumentError("Field.deleteEffect: Index is out of range: " + param1 + ".");
            }
            this.m_Effects[param1].mapData = -1;
            this.m_Effects[param1] = null;
            var _loc_3:* = this;
            var _loc_4:* = this.m_EffectsCount - 1;
            _loc_3.m_EffectsCount = _loc_4;
            var _loc_2:* = param1;
            while (_loc_2 < this.m_EffectsCount)
            {
                
                this.m_Effects[_loc_2] = this.m_Effects[(_loc_2 + 1)];
                this.m_Effects[_loc_2].mapData = _loc_2;
                _loc_2++;
            }
            return;
        }// end function

        public function putObject(param1:ObjectInstance, param2:int) : ObjectInstance
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1 == null)
            {
                return null;
            }
            if (param2 < 0)
            {
                param2 = 0;
                _loc_5 = this.getObjectPriority(param1);
                while (param2 < this.m_ObjectsCount)
                {
                    
                    _loc_6 = this.getObjectPriority(this.m_ObjectsNetwork[param2]);
                    if (_loc_6 > _loc_5 || _loc_6 == _loc_5 && _loc_6 == 5)
                    {
                        break;
                    }
                    param2++;
                }
                if (param2 >= MAPSIZE_W)
                {
                    return param1;
                }
            }
            else if (param2 <= this.m_ObjectsCount || param2 == MAPSIZE_W)
            {
                param2 = Math.min(param2, this.m_ObjectsCount, (MAPSIZE_W - 1));
            }
            else
            {
                return null;
            }
            var _loc_3:* = null;
            if (this.m_ObjectsCount >= MAPSIZE_W)
            {
                this.m_ObjectsCount = MAPSIZE_W;
                _loc_3 = this.m_ObjectsNetwork[(MAPSIZE_W - 1)];
            }
            else
            {
                var _loc_7:* = this;
                var _loc_8:* = this.m_ObjectsCount + 1;
                _loc_7.m_ObjectsCount = _loc_8;
            }
            var _loc_4:* = this.m_ObjectsCount - 1;
            while (_loc_4 > param2)
            {
                
                this.m_ObjectsNetwork[_loc_4] = this.m_ObjectsNetwork[(_loc_4 - 1)];
                _loc_4 = _loc_4 - 1;
            }
            this.m_ObjectsNetwork[param2] = param1;
            this.m_CacheObjectsDirty = true;
            this.m_CacheBitmapDirty = true;
            this.m_MiniMapDirty = true;
            return _loc_3;
        }// end function

        public function getObject(param1:int) : ObjectInstance
        {
            if (param1 == 0 && this.m_ObjectsCount == 0)
            {
                return null;
            }
            if (param1 < 0 || param1 >= this.m_ObjectsCount)
            {
                return null;
            }
            return this.m_ObjectsNetwork[param1];
        }// end function

        public function updateObjectsCache() : void
        {
            if (!this.m_CacheObjectsDirty)
            {
                return;
            }
            this.m_CacheObjectsDirty = false;
            var _loc_1:* = 0;
            var _loc_2:* = this.m_ObjectsCount;
            var _loc_3:* = null;
            _loc_1 = 0;
            do
            {
                
                this.m_ObjectsRenderer[_loc_1] = this.m_ObjectsNetwork[_loc_1];
                _loc_1++;
                var _loc_6:* = this.m_ObjectsNetwork[_loc_1].type;
                _loc_3 = this.m_ObjectsNetwork[_loc_1].type;
            }while (_loc_1 < this.m_ObjectsCount && (_loc_6.isBank || _loc_3.isClip || _loc_3.isBottom))
            while (_loc_1 < this.m_ObjectsCount)
            {
                
                this.m_ObjectsRenderer[_loc_1] = this.m_ObjectsNetwork[--_loc_2];
                _loc_1++;
            }
            while (_loc_1 < MAPSIZE_W)
            {
                
                this.m_ObjectsRenderer[_loc_1] = null;
                _loc_1++;
            }
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.m_CacheTranslucent = false;
            this.m_CacheUnsight = false;
            _loc_1 = 0;
            while (_loc_1 < this.m_ObjectsCount)
            {
                
                _loc_3 = this.m_ObjectsNetwork[_loc_1].type;
                this.m_CacheTranslucent = this.m_CacheTranslucent || _loc_3.isTranslucent;
                this.m_CacheUnsight = this.m_CacheUnsight || _loc_3.isUnsight;
                if (_loc_3.isHangable)
                {
                    _loc_4 = this.m_ObjectsNetwork[_loc_1];
                }
                else if (_loc_3.isHookEast || _loc_3.isHookSouth)
                {
                    _loc_5 = _loc_3;
                }
                _loc_1++;
            }
            if (_loc_4 != null)
            {
                if (_loc_5 != null && _loc_5.isHookEast)
                {
                    _loc_4.hang = AppearanceStorage.FLAG_HOOKEAST;
                }
                else if (_loc_5 != null)
                {
                    _loc_4.hang = AppearanceStorage.FLAG_HOOKSOUTH;
                }
                else
                {
                    _loc_4.hang = 0;
                }
            }
            return;
        }// end function

        public function getTopLookObject(param1:Object = null) : int
        {
            var _loc_5:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            while (_loc_4 < this.m_ObjectsCount)
            {
                
                _loc_5 = this.m_ObjectsNetwork[_loc_4].type;
                if (_loc_2 != -1 && _loc_5.isIgnoreLook)
                {
                }
                else
                {
                    _loc_2 = _loc_4;
                    _loc_3 = this.m_ObjectsNetwork[_loc_4];
                    if (!_loc_5.isBank && !_loc_5.isClip && !_loc_5.isBottom && !_loc_5.isTop)
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            if (param1 != null)
            {
                param1.position = _loc_2;
                param1.object = _loc_3;
            }
            return _loc_2;
        }// end function

        function resetObjects() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < MAPSIZE_W)
            {
                
                this.m_ObjectsNetwork[_loc_1] = null;
                this.m_ObjectsRenderer[_loc_1] = null;
                _loc_1++;
            }
            this.m_ObjectsCount = 0;
            this.m_CacheObjectsCount = 0;
            this.m_CacheObjectsHeight = 0;
            this.m_CacheLyingObject = false;
            this.m_CacheTranslucent = false;
            this.m_CacheUnsight = false;
            this.m_CacheObjectsDirty = false;
            this.m_CacheBitmapDirty = false;
            this.m_MiniMapColour = MM_COLOUR_DEFAULT;
            this.m_MiniMapCost = PATH_COST_OBSTACLE;
            this.m_MiniMapDirty = false;
            return;
        }// end function

        public function getTopUseObject(param1:Object = null) : int
        {
            var _loc_4:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = null;
            if (this.m_ObjectsCount > 0)
            {
                _loc_4 = null;
                _loc_2 = 0;
                while (_loc_2 < (this.m_ObjectsCount - 1))
                {
                    
                    _loc_4 = this.m_ObjectsNetwork[_loc_2].type;
                    if (_loc_4.isForceUse)
                    {
                        break;
                    }
                    if (!_loc_4.isBank && !_loc_4.isClip && !_loc_4.isBottom && !_loc_4.isTop && _loc_4.ID != AppearanceInstance.CREATURE)
                    {
                        break;
                    }
                    _loc_2++;
                }
                do
                {
                    
                    _loc_2 = _loc_2 - 1;
                    var _loc_5:* = this.m_ObjectsNetwork[_loc_2].type;
                    _loc_4 = this.m_ObjectsNetwork[_loc_2].type;
                }while (_loc_2 > 0 && (_loc_5.ID == AppearanceInstance.CREATURE || _loc_4.isLiquidPool))
                _loc_3 = this.m_ObjectsNetwork[_loc_2];
            }
            if (param1 != null)
            {
                param1.position = _loc_2;
                param1.object = _loc_3;
            }
            return _loc_2;
        }// end function

        public function deleteObject(param1:int) : ObjectInstance
        {
            if (param1 < 0 || param1 >= this.m_ObjectsCount)
            {
                return null;
            }
            var _loc_2:* = this.m_ObjectsNetwork[param1];
            this.m_ObjectsCount = Math.max(0, (this.m_ObjectsCount - 1));
            while (param1 < this.m_ObjectsCount)
            {
                
                this.m_ObjectsNetwork[param1] = this.m_ObjectsNetwork[(param1 + 1)];
                param1++;
            }
            this.m_ObjectsNetwork[this.m_ObjectsCount] = null;
            this.m_CacheObjectsDirty = true;
            this.m_CacheBitmapDirty = true;
            this.m_MiniMapDirty = true;
            return _loc_2;
        }// end function

        function appendEffect(param1:AppearanceInstance) : void
        {
            var _loc_2:* = 0;
            if (param1 == null)
            {
                throw new ArgumentError("Field.appendEffect: Invalid effect.");
            }
            if (param1.type != null && param1.type.isTopEffect)
            {
                this.m_Effects.unshift(param1);
                _loc_2 = 0;
                while (_loc_2 < (this.m_EffectsCount + 1))
                {
                    
                    this.m_Effects[_loc_2].mapData = _loc_2;
                    _loc_2++;
                }
            }
            else
            {
                this.m_Effects[this.m_EffectsCount] = param1;
                this.m_Effects[this.m_EffectsCount].mapData = this.m_EffectsCount;
            }
            var _loc_3:* = this;
            var _loc_4:* = this.m_EffectsCount + 1;
            _loc_3.m_EffectsCount = _loc_4;
            return;
        }// end function

        public function reset() : void
        {
            this.resetObjects();
            this.resetEffects();
            return;
        }// end function

        function consistencyCheck() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.m_ObjectsCount)
            {
                
                _loc_2 = this.m_ObjectsNetwork[_loc_1];
                if (_loc_2 == null)
                {
                    throw new Error("Field.consistencyCheck: null object found at position " + _loc_1 + ".");
                }
                _loc_3 = _loc_2.type;
                if (_loc_3 == null)
                {
                    throw new Error("Field.consistencyCheck: Object at position " + _loc_1 + " has no valid type.");
                }
                _loc_1++;
            }
            return;
        }// end function

        function resetEffects() : void
        {
            var _loc_1:* = this.m_EffectsCount - 1;
            while (_loc_1 >= 0)
            {
                
                this.m_Effects[_loc_1] = null;
                _loc_1 = _loc_1 - 1;
            }
            this.m_Effects.length = 0;
            this.m_EffectsCount = 0;
            this.m_Environment = null;
            return;
        }// end function

        public function getTopCreatureObject(param1:Object = null) : int
        {
            var _loc_3:* = null;
            var _loc_2:* = this.getTopLookObject(param1);
            if (param1.object != null)
            {
                _loc_3 = param1.object as ObjectInstance;
                if (_loc_3 != null && _loc_3.isCreature)
                {
                    return _loc_2;
                }
                param1.object = undefined;
                return -1;
            }
            else
            {
                return -1;
            }
        }// end function

        public function getCreatureObjectForCreatureID(param1:int, param2:Object = null) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = -1;
            if (param2 != null && param1 != 0)
            {
                param2.position = -1;
                param2.object = null;
            }
            else
            {
                return -1;
            }
            if (this.m_ObjectsCount > 0)
            {
                _loc_4 = null;
                _loc_3 = 1;
                while (_loc_3 < this.m_ObjectsCount)
                {
                    
                    _loc_4 = this.m_ObjectsNetwork[_loc_3].type;
                    if (_loc_4.isCreature)
                    {
                        if (this.m_ObjectsNetwork[_loc_3].data == param1)
                        {
                            if (param2 != null)
                            {
                                param2.position = _loc_3;
                                param2.object = this.m_ObjectsNetwork[_loc_3];
                            }
                            break;
                        }
                    }
                    _loc_3++;
                }
            }
            return -1;
        }// end function

        public function getTopMultiUseObject(param1:Object = null) : int
        {
            var _loc_4:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = null;
            if (this.m_ObjectsCount > 0)
            {
                _loc_4 = null;
                _loc_2 = 0;
                while (_loc_2 < (this.m_ObjectsCount - 1))
                {
                    
                    _loc_4 = this.m_ObjectsNetwork[_loc_2].type;
                    if (_loc_4.isForceUse)
                    {
                        break;
                    }
                    if (!_loc_4.isBank && !_loc_4.isClip && !_loc_4.isBottom && !_loc_4.isTop)
                    {
                        break;
                    }
                    _loc_2++;
                }
                var _loc_5:* = this.m_ObjectsNetwork[_loc_2].type;
                _loc_4 = this.m_ObjectsNetwork[_loc_2].type;
                if (_loc_2 > 0 && !_loc_5.isForceUse && _loc_4.isLiquidPool)
                {
                    _loc_2 = _loc_2 - 1;
                }
                _loc_3 = this.m_ObjectsNetwork[_loc_2];
            }
            if (param1 != null)
            {
                param1.position = _loc_2;
                param1.object = _loc_3;
            }
            return _loc_2;
        }// end function

        public function setEnvironmentalEffect(param1:ObjectInstance) : void
        {
            this.m_Environment = param1;
            return;
        }// end function

        public function getTopMoveObject(param1:Object = null) : int
        {
            var _loc_4:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = null;
            if (this.m_ObjectsCount > 0)
            {
                _loc_2 = 0;
                while (_loc_2 < (this.m_ObjectsCount - 1))
                {
                    
                    _loc_4 = this.m_ObjectsNetwork[_loc_2].type;
                    if (!_loc_4.isBank && !_loc_4.isClip && !_loc_4.isBottom && !_loc_4.isTop && _loc_4.ID != AppearanceInstance.CREATURE)
                    {
                        break;
                    }
                    _loc_2++;
                }
                if (_loc_2 > 0 && _loc_4.isUnmoveable)
                {
                    _loc_2 = _loc_2 - 1;
                }
                _loc_3 = this.m_ObjectsNetwork[_loc_2];
            }
            if (param1 != null)
            {
                param1.position = _loc_2;
                param1.object = _loc_3;
            }
            return _loc_2;
        }// end function

        public function getEnvironmentalEffect() : ObjectInstance
        {
            return this.m_Environment;
        }// end function

        public function updateMiniMap() : void
        {
            var _loc_3:* = null;
            if (!this.m_MiniMapDirty)
            {
                return;
            }
            this.m_MiniMapDirty = false;
            this.updateObjectsCache();
            this.m_MiniMapColour = MM_COLOUR_DEFAULT;
            this.m_MiniMapCost = PATH_COST_MAX;
            var _loc_1:* = this.m_ObjectsCount == 0 || !this.m_ObjectsRenderer[0].type.isBank;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_ObjectsCount)
            {
                
                _loc_3 = this.m_ObjectsRenderer[_loc_2].type;
                if (_loc_3.isBank)
                {
                    this.m_MiniMapCost = Math.min(PATH_COST_MAX, _loc_3.waypoints);
                }
                if (_loc_3.isAutomap)
                {
                    this.m_MiniMapColour = Colour.s_ARGBFromEightBit(_loc_3.automapColour);
                }
                if (_loc_3.isAvoid || _loc_3.isUnpassable)
                {
                    _loc_1 = true;
                }
                _loc_2++;
            }
            if (_loc_1)
            {
                this.m_MiniMapCost = PATH_COST_OBSTACLE;
            }
            return;
        }// end function

        private static function s_AllocateCache(param1:Field) : void
        {
            if (s_CacheCount >= NUM_FIELDS)
            {
                throw new Error("Field.s_AllocateCache: Allocation limit exceeded.");
            }
            var _loc_2:* = s_CacheCount % MAPSIZE_X;
            var _loc_3:* = int(s_CacheCount / MAPSIZE_X);
            param1.m_CacheRectangle = new Rectangle(_loc_2 * FIELD_CACHESIZE, _loc_3 * FIELD_CACHESIZE, FIELD_CACHESIZE, FIELD_CACHESIZE);
            var _loc_5:* = s_CacheCount + 1;
            s_CacheCount = _loc_5;
            return;
        }// end function

        s_CacheBitmap.lock();
    }
}
