package tibia.appearances
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import loader.asset.*;
    import shared.utility.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.market.*;

    public class AppearanceStorage extends EventDispatcher
    {
        private var m_OutfitTypes:Vector.<AppearanceType>;
        private var m_ObjectTypes:Vector.<AppearanceType>;
        public var m_AsyncSpriteCache:AsyncSpriteCache = null;
        private var m_AsyncCompressedSpriteProvider:AsyncCompressedSpriteProvider = null;
        private var m_MissileTypes:Vector.<AppearanceType>;
        private var m_ObjectTypeInfoCache:Vector.<AppearanceTypeInfo>;
        private var m_MarketObjectTypes:Array;
        private var m_AppearancesContentRevision:int;
        private var m_SpritesInformation:SpritesInformation = null;
        private var m_EffectTypes:Vector.<AppearanceType>;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        public static const FRAME_GROUP_WALKING:uint = 1;
        public static const FLAG_LIQUIDPOOL:int = 11;
        public static const FLAG_UNMOVE:int = 13;
        public static const FLAG_IGNORELOOK:int = 32;
        public static const PHASE_AUTOMATIC:int = -1;
        private static const MOUSE_BUTTON_RIGHT:int = 2;
        static const APPEARANCE_MISSILE:uint = 3;
        static const FIELD_HEIGHT:int = 24;
        public static const PHASE_RANDOM:int = 254;
        public static const FLAG_FORCEUSE:int = 6;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const MAXIMUM_SPEED_FRAME_DURATION:int = 280;
        static const APPEARANCE_OUTFIT:uint = 1;
        public static const FLAG_LYINGOBJECT:int = 27;
        public static const FLAG_CLIP:int = 1;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        public static const FLAG_ANIMATION:int = 16776961;
        public static const FLAG_CLOTHES:int = 33;
        public static const FLAG_BOTTOM:int = 2;
        public static const FLAG_LIGHT:int = 22;
        public static const FLAG_UNPASS:int = 12;
        private static const MOUSE_BUTTON_LEFT:int = 1;
        public static const FLAG_MARKET:int = 34;
        private static const ACTION_ATTACK:int = 1;
        public static const SPRITE_CACHE_PAGE_COUNT:uint = 25;
        static const GROUND_LAYER:int = 7;
        public static const FLAG_ANIMATEALWAYS:int = 28;
        public static const ANIMATION_DELAY_BEFORE_RESET:int = 1000;
        public static const FLAG_WRAPPABLE:int = 36;
        public static const FLAG_NOMOVEMENTANIMATION:int = 16;
        public static const PHASE_ASYNCHRONOUS:int = 255;
        public static const FLAG_UNSIGHT:int = 14;
        public static const FLAG_LENSHELP:int = 30;
        private static const ACTION_OPEN:int = 8;
        private static const MIN_SPEED_DELAY:int = 550;
        public static const FLAG_AVOID:int = 15;
        public static const FLAG_FULLBANK:int = 31;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        public static const FRAME_GROUP_DEFAULT:uint = 0;
        private static const MAX_SPEED_DELAY:int = 100;
        static const MAP_MIN_Z:int = 0;
        public static const FLAG_UNWRAPPABLE:int = 37;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        public static const FLAG_TRANSLUCENT:int = 24;
        private static const ENVIRONMENTAL_EFFECTS:Array = [];
        private static const ACTION_LOOK:int = 6;
        static const NUM_EFFECTS:int = 200;
        private static const MINIMUM_SPEED_FRAME_DURATION:int = 720;
        public static const FLAG_HOOKEAST:int = 20;
        private static const ACTION_TALK:int = 9;
        private static const ACTION_SMARTCLICK:int = 100;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        private static const MOUSE_BUTTON_MIDDLE:int = 3;
        public static const FLAG_MULTIUSE:int = 7;
        public static const COMPRESSED_IMAGES_CACHE_MEMORY:uint = 3.53894e+007;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        public static const FLAG_USABLE:int = 254;
        public static const FLAG_WRITE:int = 8;
        public static const FLAG_BANK:int = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const FIELD_CACHESIZE:int = 32;
        public static const FLAG_DEFAULT_ACTION:int = 35;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        public static const SPRITE_CACHE_PAGE_DIMENSION:uint = 512;
        public static const FLAG_CONTAINER:int = 4;
        public static const FLAG_HOOKSOUTH:int = 19;
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        public static const FLAG_HEIGHT:int = 26;
        public static const FLAG_HANG:int = 18;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        public static const FLAG_AUTOMAP:int = 29;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        private static const ACTION_CONTEXT_MENU:int = 5;
        static const APPEARANCE_OBJECT:uint = 0;
        public static const FLAG_TAKE:int = 17;
        static const MAP_HEIGHT:int = 11;
        public static const FLAG_ROTATE:int = 21;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        private static const ACTION_NONE:int = 0;
        public static const FLAG_CUMULATIVE:int = 5;
        public static const ANIMATION_ASYNCHRON:int = 0;
        public static const FLAG_WRITEONCE:int = 9;
        static const NUM_FIELDS:int = 2016;
        private static const MOUSE_BUTTON_BOTH:int = 4;
        private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
        private static const ACTION_UNSET:int = -1;
        private static const ACTION_ATTACK_OR_TALK:int = 102;
        private static const ACTION_USE_OR_OPEN:int = 101;
        public static const FLAG_DONTHIDE:int = 23;
        static const APPEARANCE_EFFECT:uint = 2;
        public static const FLAG_SHIFT:int = 25;
        public static const FLAG_LIQUIDCONTAINER:int = 10;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        private static const ACTION_USE:int = 7;
        private static const ACTION_AUTOWALK:int = 3;
        public static const FLAG_TOP:int = 3;
        public static const FRAME_GROUP_IDLE:uint = 0;
        public static const ANIMATION_SYNCHRON:int = 1;

        public function AppearanceStorage()
        {
            this.m_ObjectTypes = new Vector.<AppearanceType>;
            this.m_OutfitTypes = new Vector.<AppearanceType>;
            this.m_MissileTypes = new Vector.<AppearanceType>;
            this.m_EffectTypes = new Vector.<AppearanceType>;
            this.m_MarketObjectTypes = [];
            this.m_ObjectTypeInfoCache = new Vector.<AppearanceTypeInfo>;
            return;
        }// end function

        private function postprocessAppearances() : Boolean
        {
            var CachedSpriteInformations:Dictionary;
            var _Type:AppearanceType;
            var i:int;
            var j:int;
            _Type = new AppearanceType(AppearanceInstance.CREATURE);
            _Type.isAvoid = true;
            _Type.isCachable = false;
            _Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT] = new FrameGroup();
            this.m_ObjectTypes[AppearanceInstance.CREATURE] = _Type;
            _Type = this.m_ObjectTypes[AppearanceInstance.PURSE];
            _Type.isUnmoveable = true;
            _Type.isTakeable = false;
            var BlueStars:* = this.m_EffectTypes[13];
            _Type = new AppearanceType(OutfitInstance.INVISIBLE_OUTFIT_ID);
            var _FrameGroup:* = new FrameGroup();
            var _loc_2:* = _FrameGroup;
            _Type.FrameGroups[FRAME_GROUP_WALKING] = _FrameGroup;
            _Type.FrameGroups[FRAME_GROUP_IDLE] = _loc_2;
            _loc_2.width = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].width;
            _loc_2.height = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].height;
            _Type.displacementX = 8;
            _Type.displacementY = 8;
            _loc_2.exactSize = FIELD_SIZE;
            _loc_2.layers = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].layers;
            _loc_2.patternWidth = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].patternWidth;
            _loc_2.patternHeight = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].patternHeight;
            _loc_2.patternDepth = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].patternDepth;
            _loc_2.phases = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].phases;
            _loc_2.numSprites = _loc_2.phases * _loc_2.patternWidth;
            _Type.isDisplaced = true;
            _Type.isAnimateAlways = true;
            _loc_2.isAnimation = true;
            _Type.isCachable = false;
            _loc_2.animator = new AppearanceAnimator(_loc_2.phases, 0, 0, AppearanceAnimator.ANIMATION_SYNCHRON, BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].animator.frameDurations);
            if (BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].spriteIDs.length > 1)
            {
                _loc_2.spriteIDs = BlueStars.FrameGroups[FRAME_GROUP_DEFAULT].spriteIDs;
                this.m_OutfitTypes[OutfitInstance.INVISIBLE_OUTFIT_ID] = _Type;
            }
            _Type = new AppearanceType(MarketWidget.REQUEST_OWN_OFFERS);
            _Type.marketCategory = -1;
            _Type.marketShowAs = -1;
            _Type.marketTradeAs = MarketWidget.REQUEST_OWN_OFFERS;
            this.m_MarketObjectTypes.push(_Type);
            _Type = new AppearanceType(MarketWidget.REQUEST_OWN_HISTORY);
            _Type.marketCategory = -1;
            _Type.marketShowAs = -1;
            _Type.marketTradeAs = MarketWidget.REQUEST_OWN_HISTORY;
            this.m_MarketObjectTypes.push(_Type);
            this.m_MarketObjectTypes.sortOn("marketTradeAs", Array.NUMERIC);
            CachedSpriteInformations = this.m_SpritesInformation.cachedSpriteInformations;
            var UpdateAppearanceTypes:* = function (param1:AppearanceType, param2:int, param3:Vector.<AppearanceType>) : void
            {
                var _loc_4:* = null;
                var _loc_5:* = 0;
                var _loc_6:* = 0;
                if (param1 != null)
                {
                    for each (_loc_4 in param1.FrameGroups)
                    {
                        
                        if (m_OutfitTypes == this && _loc_4.layers == 2)
                        {
                            _loc_4.spriteProvider = m_AsyncCompressedSpriteProvider;
                        }
                        else
                        {
                            _loc_4.spriteProvider = m_AsyncSpriteCache;
                        }
                        _loc_5 = 0;
                        while (_loc_5 < _loc_4.spriteIDs.length)
                        {
                            
                            _loc_4.cachedSpriteInformations[_loc_5] = CachedSpriteInformations[_loc_4.spriteIDs[_loc_5]];
                            _loc_6 = m_SpritesInformation.getFirstSpriteID(_loc_4.spriteIDs[_loc_5]);
                            if (_loc_4.spritesheetIDs.indexOf(_loc_6) < 0)
                            {
                                _loc_4.spritesheetIDs.push(_loc_6);
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                }
                return;
            }// end function
            ;
            this.m_ObjectTypes.forEach(UpdateAppearanceTypes);
            this.m_OutfitTypes.forEach(UpdateAppearanceTypes, this.m_OutfitTypes);
            this.m_EffectTypes.forEach(UpdateAppearanceTypes);
            this.m_MissileTypes.forEach(UpdateAppearanceTypes);
            return true;
        }// end function

        public function setAssetProvider(param1:IAssetProvider) : void
        {
            var _loc_4:* = null;
            if (param1 == null)
            {
                throw new ArgumentError("AppearanceStorage.setAssetProvider: asset provider must not be null");
            }
            var _loc_2:* = false;
            this.m_SpritesInformation = new SpritesInformation(param1.getSpriteAssets());
            this.m_AsyncCompressedSpriteProvider = new AsyncCompressedSpriteProvider(param1, this.m_SpritesInformation, COMPRESSED_IMAGES_CACHE_MEMORY);
            this.m_AsyncSpriteCache = new AsyncSpriteCache(this.m_AsyncCompressedSpriteProvider, this.m_SpritesInformation.cachedSpriteInformations);
            var _loc_3:* = param1.getAppearances();
            _loc_2 = _loc_3 == null || !this.loadAppearances(_loc_3.rawBytes);
            this.contentRevision = _loc_3.contentRevision;
            if (this.postprocessAppearances())
            {
                param1.removeAsset(_loc_3);
                System.pauseForGCIfCollectionImminent(0.25);
                _loc_4 = new Event(Event.COMPLETE);
                dispatchEvent(_loc_4);
            }
            else
            {
                this.loadError();
            }
            if (_loc_2)
            {
                this.loadError();
            }
            return;
        }// end function

        private function loadError() : void
        {
            this.reset();
            var _loc_1:* = new ErrorEvent(ErrorEvent.ERROR);
            dispatchEvent(_loc_1);
            return;
        }// end function

        private function loadAppearances(param1:ByteArray) : Boolean
        {
            if (param1 == null || param1.bytesAvailable < 12)
            {
                return false;
            }
            var _loc_2:* = param1.endian;
            param1.endian = Endian.LITTLE_ENDIAN;
            this.m_ObjectTypes.length = param1.readUnsignedShort() + 1;
            this.m_OutfitTypes.length = param1.readUnsignedShort() + 1;
            this.m_EffectTypes.length = param1.readUnsignedShort() + 1;
            this.m_MissileTypes.length = param1.readUnsignedShort() + 1;
            var _loc_3:* = true;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            _loc_4 = AppearanceInstance.CREATURE + 1;
            _loc_5 = this.m_ObjectTypes.length;
            while (_loc_3 && _loc_4 < _loc_5)
            {
                
                _loc_3 = this.readAppearanceType(param1, APPEARANCE_OBJECT, this.m_ObjectTypes, _loc_4);
                _loc_4++;
            }
            _loc_4 = 1;
            _loc_5 = this.m_OutfitTypes.length;
            while (_loc_3 && _loc_4 < _loc_5)
            {
                
                _loc_3 = this.readAppearanceType(param1, APPEARANCE_OUTFIT, this.m_OutfitTypes, _loc_4);
                _loc_4++;
            }
            _loc_4 = 1;
            _loc_5 = this.m_EffectTypes.length;
            while (_loc_3 && _loc_4 < _loc_5)
            {
                
                _loc_3 = this.readAppearanceType(param1, APPEARANCE_EFFECT, this.m_EffectTypes, _loc_4);
                _loc_4++;
            }
            _loc_4 = 1;
            _loc_5 = this.m_MissileTypes.length;
            while (_loc_3 && _loc_4 < _loc_5)
            {
                
                _loc_3 = this.readAppearanceType(param1, APPEARANCE_MISSILE, this.m_MissileTypes, _loc_4);
                _loc_4++;
            }
            _loc_3 = _loc_3 && param1.bytesAvailable == 0;
            param1.endian = _loc_2;
            return _loc_3;
        }// end function

        public function reset() : void
        {
            this.m_ObjectTypes.length = 0;
            this.m_OutfitTypes.length = 0;
            this.m_MissileTypes.length = 0;
            this.m_EffectTypes.length = 0;
            this.m_MarketObjectTypes.length = 0;
            this.m_ObjectTypeInfoCache.length = 0;
            this.m_AppearancesContentRevision = 0;
            return;
        }// end function

        private function setTypeInfo(param1:Vector.<AppearanceTypeInfo>, param2:int, param3:int, param4:String) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = param1.length - 1;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = -1;
            while (_loc_5 <= _loc_6)
            {
                
                _loc_7 = (_loc_5 + _loc_6) / 2;
                _loc_8 = AppearanceTypeRef.s_CompareExternal(param1[_loc_7], param2, param3);
                if (_loc_8 < 0)
                {
                    _loc_5 = _loc_7 + 1;
                    continue;
                }
                if (_loc_8 > 0)
                {
                    _loc_6 = _loc_7 - 1;
                    continue;
                }
                _loc_9 = _loc_7;
                break;
            }
            if (_loc_9 < 0)
            {
                param1.splice(_loc_5, 0, new AppearanceTypeInfo(param2, param3, param4));
            }
            else
            {
                param1[_loc_9].name = param4;
            }
            return;
        }// end function

        public function createOutfitInstance(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : OutfitInstance
        {
            if (param1 >= 1 && param1 < this.m_OutfitTypes.length || param1 == OutfitInstance.INVISIBLE_OUTFIT_ID)
            {
                return new OutfitInstance(param1, this.m_OutfitTypes[param1], param2, param3, param4, param5, param6);
            }
            return null;
        }// end function

        public function getObjectType(param1:int) : AppearanceType
        {
            if (param1 >= AppearanceInstance.CREATURE && param1 < this.m_ObjectTypes.length)
            {
                return this.m_ObjectTypes[param1];
            }
            return null;
        }// end function

        public function getOutfitType(param1:int) : AppearanceType
        {
            if (param1 >= 1 && param1 < this.m_OutfitTypes.length)
            {
                return this.m_OutfitTypes[param1];
            }
            return null;
        }// end function

        public function createTextualEffectInstance(param1:int, param2:int, param3:Number) : TextualEffectInstance
        {
            return new TextualEffectInstance(param1, null, param2, param3);
        }// end function

        public function get marketObjectTypes() : Array
        {
            return this.m_MarketObjectTypes;
        }// end function

        public function createObjectInstance(param1:int, param2:int) : ObjectInstance
        {
            if (param1 >= AppearanceInstance.CREATURE && param1 < this.m_ObjectTypes.length)
            {
                return new ObjectInstance(param1, this.m_ObjectTypes[param1], param2);
            }
            return null;
        }// end function

        public function createEffectInstance(param1:int) : EffectInstance
        {
            if (param1 >= 1 && param1 < this.m_EffectTypes.length)
            {
                return new EffectInstance(param1, this.m_EffectTypes[param1]);
            }
            return null;
        }// end function

        public function set contentRevision(param1:int) : void
        {
            this.m_AppearancesContentRevision = param1;
            return;
        }// end function

        public function setCachedObjectTypeName(param1:int, param2:int, param3:String) : void
        {
            if (param3 == null || param3.length < 1)
            {
                throw new ArgumentError("AppearanceStorage.setCachedObjectTypeName: Invalid name.");
            }
            this.setTypeInfo(this.m_ObjectTypeInfoCache, param1, param2, param3);
            return;
        }// end function

        public function getMarketObjectType(param1) : AppearanceType
        {
            var _loc_6:* = null;
            var _loc_2:* = -1;
            if (param1 is AppearanceType && AppearanceType(param1).isMarket)
            {
                _loc_2 = AppearanceType(param1).marketTradeAs;
            }
            else
            {
                _loc_2 = int(param1);
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = this.m_MarketObjectTypes.length - 1;
            while (_loc_4 <= _loc_5)
            {
                
                _loc_3 = _loc_4 + _loc_5 >>> 1;
                _loc_6 = AppearanceType(this.m_MarketObjectTypes[_loc_3]);
                if (_loc_6.marketTradeAs == _loc_2)
                {
                    return _loc_6;
                }
                if (_loc_6.marketTradeAs < _loc_2)
                {
                    _loc_4 = _loc_3 + 1;
                    continue;
                }
                _loc_5 = _loc_3 - 1;
            }
            return null;
        }// end function

        public function get contentRevision() : int
        {
            return this.m_AppearancesContentRevision;
        }// end function

        public function createEnvironmentalEffect(param1:int) : ObjectInstance
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = ENVIRONMENTAL_EFFECTS.length - 1;
            var _loc_4:* = 0;
            while (_loc_2 <= _loc_3)
            {
                
                _loc_4 = (_loc_2 + _loc_3) / 2;
                _loc_5 = ENVIRONMENTAL_EFFECTS[_loc_4];
                if (_loc_5.ID < param1)
                {
                    _loc_2 = _loc_4 + 1;
                    continue;
                }
                if (_loc_5.ID > param1)
                {
                    _loc_3 = _loc_4 - _loc_4;
                    continue;
                }
                _loc_6 = _loc_5.appearanceType;
                _loc_7 = _loc_5.atmospheric ? (1) : (0);
                return new ObjectInstance(_loc_6, this.m_ObjectTypes[_loc_6], _loc_7);
            }
            return null;
        }// end function

        private function onLoaderError(event:Event) : void
        {
            this.loadError();
            return;
        }// end function

        public function hasOutfitType(param1:int) : Boolean
        {
            return param1 >= 1 && param1 < this.m_OutfitTypes.length;
        }// end function

        private function readAppearanceType(param1:ByteArray, param2:uint, param3:Vector.<AppearanceType>, param4:int, param5:int = 0) : Boolean
        {
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = null;
            var _loc_24:* = 0;
            if (param1 == null || param1.bytesAvailable < 11)
            {
                return false;
            }
            var _loc_6:* = new AppearanceType(param4);
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_7 < 255)
            {
                
                _loc_7 = param1.readUnsignedByte();
                switch(_loc_7)
                {
                    case FLAG_BANK:
                    {
                        _loc_6.isBank = true;
                        _loc_6.waypoints = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_CLIP:
                    {
                        _loc_6.isClip = true;
                        break;
                    }
                    case FLAG_BOTTOM:
                    {
                        _loc_6.isBottom = true;
                        break;
                    }
                    case FLAG_TOP:
                    {
                        _loc_6.isTop = true;
                        break;
                    }
                    case FLAG_CONTAINER:
                    {
                        _loc_6.isContainer = true;
                        break;
                    }
                    case FLAG_CUMULATIVE:
                    {
                        _loc_6.isCumulative = true;
                        break;
                    }
                    case FLAG_USABLE:
                    {
                        _loc_6.isUsable = true;
                        break;
                    }
                    case FLAG_FORCEUSE:
                    {
                        _loc_6.isForceUse = true;
                        break;
                    }
                    case FLAG_MULTIUSE:
                    {
                        _loc_6.isMultiUse = true;
                        break;
                    }
                    case FLAG_WRITE:
                    {
                        _loc_6.isWriteable = true;
                        _loc_6.maxTextLength = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_WRITEONCE:
                    {
                        _loc_6.isWriteableOnce = true;
                        _loc_6.maxTextLength = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_LIQUIDCONTAINER:
                    {
                        _loc_6.isLiquidContainer = true;
                        break;
                    }
                    case FLAG_LIQUIDPOOL:
                    {
                        _loc_6.isLiquidPool = true;
                        break;
                    }
                    case FLAG_UNPASS:
                    {
                        _loc_6.isUnpassable = true;
                        break;
                    }
                    case FLAG_UNMOVE:
                    {
                        _loc_6.isUnmoveable = true;
                        break;
                    }
                    case FLAG_UNSIGHT:
                    {
                        _loc_6.isUnsight = true;
                        break;
                    }
                    case FLAG_AVOID:
                    {
                        _loc_6.isAvoid = true;
                        break;
                    }
                    case FLAG_NOMOVEMENTANIMATION:
                    {
                        _loc_6.preventMovementAnimation = true;
                        break;
                    }
                    case FLAG_TAKE:
                    {
                        _loc_6.isTakeable = true;
                        break;
                    }
                    case FLAG_HANG:
                    {
                        _loc_6.isHangable = true;
                        break;
                    }
                    case FLAG_HOOKSOUTH:
                    {
                        _loc_6.isHookSouth = true;
                        break;
                    }
                    case FLAG_HOOKEAST:
                    {
                        _loc_6.isHookEast = true;
                        break;
                    }
                    case FLAG_ROTATE:
                    {
                        _loc_6.isRotateable = true;
                        break;
                    }
                    case FLAG_LIGHT:
                    {
                        _loc_6.isLight = true;
                        _loc_6.brightness = param1.readUnsignedShort();
                        _loc_6.lightColour = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_DONTHIDE:
                    {
                        _loc_6.isDonthide = true;
                        break;
                    }
                    case FLAG_TRANSLUCENT:
                    {
                        _loc_6.isTranslucent = true;
                        break;
                    }
                    case FLAG_SHIFT:
                    {
                        _loc_6.isDisplaced = true;
                        _loc_6.displacementX = param1.readUnsignedShort();
                        _loc_6.displacementY = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_HEIGHT:
                    {
                        _loc_6.isHeight = true;
                        _loc_6.elevation = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_LYINGOBJECT:
                    {
                        _loc_6.isLyingObject = true;
                        break;
                    }
                    case FLAG_ANIMATEALWAYS:
                    {
                        _loc_6.isAnimateAlways = true;
                        break;
                    }
                    case FLAG_AUTOMAP:
                    {
                        _loc_6.isAutomap = true;
                        _loc_6.automapColour = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_LENSHELP:
                    {
                        _loc_6.isLensHelp = true;
                        _loc_6.lensHelp = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_FULLBANK:
                    {
                        _loc_6.isFullBank = true;
                        break;
                    }
                    case FLAG_IGNORELOOK:
                    {
                        _loc_6.isIgnoreLook = true;
                        break;
                    }
                    case FLAG_CLOTHES:
                    {
                        _loc_6.isCloth = true;
                        _loc_6.clothSlot = param1.readUnsignedShort();
                        break;
                    }
                    case FLAG_WRAPPABLE:
                    {
                        _loc_6.isWrappable = true;
                        break;
                    }
                    case FLAG_UNWRAPPABLE:
                    {
                        _loc_6.isUnwrappable = true;
                        break;
                    }
                    case FLAG_DEFAULT_ACTION:
                    {
                        _loc_6.isDefaultAction = true;
                        _loc_13 = param1.readUnsignedShort();
                        switch(_loc_13)
                        {
                            case 0:
                            {
                                _loc_6.defaultAction = ACTION_NONE;
                                break;
                            }
                            case 1:
                            {
                                _loc_6.defaultAction = ACTION_LOOK;
                                break;
                            }
                            case 2:
                            {
                                _loc_6.defaultAction = ACTION_USE;
                                break;
                            }
                            case 3:
                            {
                                _loc_6.defaultAction = ACTION_OPEN;
                                break;
                            }
                            case 4:
                            {
                                _loc_6.defaultAction = ACTION_AUTOWALK_HIGHLIGHT;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        break;
                    }
                    case FLAG_MARKET:
                    {
                        _loc_6.isMarket = true;
                        _loc_6.marketCategory = param1.readUnsignedShort();
                        if (!MarketWidget.isValidCategoryID(_loc_6.marketCategory))
                        {
                            throw new Error("AppearanceStorage.readAppearanceType: Invalid market category  " + _loc_6.marketCategory + ".");
                        }
                        _loc_6.marketTradeAs = param1.readUnsignedShort();
                        _loc_6.marketShowAs = param1.readUnsignedShort();
                        _loc_6.marketName = StringHelper.s_ReadLongStringFromByteArray(param1, MarketWidget.DETAIL_NAME_LENGTH);
                        _loc_6.marketNameLowerCase = _loc_6.marketName.toLowerCase();
                        _loc_6.marketRestrictProfession = param1.readUnsignedShort();
                        _loc_6.marketRestrictLevel = param1.readUnsignedShort();
                        break;
                    }
                    case 255:
                    {
                        break;
                    }
                    default:
                    {
                        throw new Error("AppearanceStorage.readAppearanceType: Invalid flag: " + _loc_7 + ".");
                        break;
                    }
                }
            }
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = param2 == APPEARANCE_OUTFIT ? (param1.readUnsignedByte()) : (1);
            var _loc_12:* = 0;
            while (_loc_12 < _loc_11)
            {
                
                _loc_14 = param2 == APPEARANCE_OUTFIT ? (param1.readUnsignedByte()) : (0);
                _loc_15 = new FrameGroup();
                _loc_15.width = param1.readUnsignedByte();
                _loc_15.height = param1.readUnsignedByte();
                if (_loc_15.width > 1 || _loc_15.height > 1)
                {
                    _loc_15.exactSize = param1.readUnsignedByte();
                }
                else
                {
                    _loc_15.exactSize = FIELD_SIZE;
                }
                _loc_10 = Math.max(_loc_10, _loc_15.exactSize);
                _loc_15.layers = param1.readUnsignedByte();
                _loc_15.patternWidth = param1.readUnsignedByte();
                _loc_15.patternHeight = param1.readUnsignedByte();
                _loc_15.patternDepth = param1.readUnsignedByte();
                _loc_15.phases = param1.readUnsignedByte();
                if (_loc_15.phases > 1)
                {
                    var _loc_25:* = true;
                    _loc_9 = true;
                    _loc_15.isAnimation = _loc_25;
                    _loc_17 = param1.readUnsignedByte();
                    _loc_18 = param1.readInt();
                    _loc_19 = param1.readByte();
                    _loc_20 = new Vector.<FrameDuration>;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_15.phases)
                    {
                        
                        _loc_21 = param1.readUnsignedInt();
                        _loc_22 = param1.readUnsignedInt();
                        _loc_23 = new FrameDuration(_loc_21, _loc_22);
                        _loc_20.push(_loc_23);
                        _loc_8++;
                    }
                    _loc_15.animator = new AppearanceAnimator(_loc_15.phases, _loc_19, _loc_18, _loc_17, _loc_20);
                }
                _loc_15.numSprites = _loc_15.layers * _loc_15.patternWidth * _loc_15.patternHeight * _loc_15.patternDepth * _loc_15.phases;
                _loc_8 = 0;
                while (_loc_8 < _loc_15.numSprites)
                {
                    
                    _loc_15.spriteIDs[_loc_8] = param1.readUnsignedInt();
                    _loc_8++;
                }
                _loc_16 = _loc_6.FrameGroups.hasOwnProperty(FrameGroup.FRAME_GROUP_IDLE);
                if (_loc_14 == FrameGroup.FRAME_GROUP_WALKING && (!_loc_16 || _loc_16 && _loc_6.FrameGroups[FrameGroup.FRAME_GROUP_IDLE].phases == 0))
                {
                    _loc_6.FrameGroups[FrameGroup.FRAME_GROUP_IDLE] = _loc_15;
                }
                _loc_6.FrameGroups[_loc_14] = _loc_15;
                _loc_12 = _loc_12 + 1;
            }
            param3[param4] = _loc_6;
            _loc_6.isCachable = !_loc_9 && !_loc_6.isHangable && !_loc_6.isLight && _loc_10 + Math.max(_loc_6.displacementX, _loc_6.displacementY) <= FIELD_CACHESIZE;
            if (_loc_6.isMarket)
            {
                _loc_24 = -1;
                _loc_24 = this.m_MarketObjectTypes.length - 1;
                while (_loc_24 >= 0)
                {
                    
                    if (_loc_6.marketTradeAs == AppearanceType(this.m_MarketObjectTypes[_loc_24]).marketTradeAs)
                    {
                        break;
                    }
                    _loc_24 = _loc_24 - 1;
                }
                if (_loc_24 < 0)
                {
                    this.m_MarketObjectTypes.push(_loc_6);
                }
            }
            return true;
        }// end function

        public function getCachedObjectTypeName(param1:int, param2:int) : String
        {
            var _loc_3:* = this.getTypeInfo(this.m_ObjectTypeInfoCache, param1, param2);
            if (_loc_3 != null)
            {
                return _loc_3.name;
            }
            return null;
        }// end function

        private function getTypeInfo(param1:Vector.<AppearanceTypeInfo>, param2:int, param3:int) : AppearanceTypeInfo
        {
            var _loc_4:* = 0;
            var _loc_5:* = param1.length - 1;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_4 <= _loc_5)
            {
                
                _loc_6 = (_loc_4 + _loc_5) / 2;
                _loc_7 = AppearanceTypeRef.s_CompareExternal(param1[_loc_6], param2, param3);
                if (_loc_7 < 0)
                {
                    _loc_4 = _loc_6 + 1;
                    continue;
                }
                if (_loc_7 > 0)
                {
                    _loc_5 = _loc_6 - 1;
                    continue;
                }
                return param1[_loc_6];
            }
            return null;
        }// end function

        public function createMissileInstance(param1:uint, param2:Vector3D, param3:Vector3D) : MissileInstance
        {
            if (param1 >= 1 && param1 < this.m_MissileTypes.length)
            {
                return new MissileInstance(param1, this.m_MissileTypes[param1], param2, param3);
            }
            return null;
        }// end function

    }
}
