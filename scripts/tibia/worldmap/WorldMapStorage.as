package tibia.worldmap
{
    import __AS3__.vec.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.creatures.*;
    import tibia.options.*;

    public class WorldMapStorage extends Object
    {
        var m_AmbientTargetColour:Colour = null;
        var m_AmbientTargetBrightness:int = 0;
        var m_CacheObjectsCount:Vector.<int>;
        var m_EffectCount:int = 0;
        var m_Field:Vector.<Field>;
        var m_MessageBoxes:Vector.<OnscreenMessageBox>;
        var m_AmbientCurrentColour:Colour = null;
        var m_AmbientCurrentBrightness:int = 0;
        protected var m_Options:OptionsStorage = null;
        var m_Effect:Vector.<AppearanceInstance>;
        protected var m_CacheValid:Boolean = false;
        private const m_LayerBrightnessInfos:Vector.<Vector.<Boolean>>;
        var m_Position:Vector3D = null;
        var m_Origin:Vector3D = null;
        protected var m_AmbientNextUpdate:Number = 0;
        protected var m_ObjectNextUpdate:Number = 0;
        var m_LayoutOnscreenMessages:Boolean = false;
        var m_PlayerZPlane:int = 0;
        protected var m_HelperCoordinate:Vector3D;
        var m_CacheFullbank:Boolean = false;
        public static const ONSCREEN_TARGET_BOX_BOTTOM:int = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        public static const ONSCREEN_TARGET_EFFECT_COORDINATE:int = 5;
        public static const ONSCREEN_TARGET_BOX_HIGH:int = 2;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        private static const BUNDLE:String = "WorldMapStorage";
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        public static const MSG_NPC_TOO_FAR:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_NPC_TOO_FAR");
        public static const ONSCREEN_TARGET_BOX_LOW:int = 1;
        public static const MSG_PATH_GO_DOWNSTAIRS:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_PATH_GO_DOWNSTAIRS");
        static const OBJECT_UPDATE_INTERVAL:int = 40;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        public static const ONSCREEN_TARGET_NONE:int = -1;
        public static const MSG_PATH_GO_UPSTAIRS:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_PATH_GO_UPSTAIRS");
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        public static const MSG_PATH_UNREACHABLE:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_PATH_UNREACHABLE");
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const AMBIENT_UPDATE_INTERVAL:int = 1000;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        public static const ONSCREEN_TARGET_BOX_TOP:int = 3;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        public static const ONSCREEN_TARGET_BOX_COORDINATE:int = 4;
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        public static const MSG_SORRY_NOT_POSSIBLE:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_SORRY_NOT_POSSIBLE");
        public static const MSG_PATH_TOO_FAR:String = ResourceManager.getInstance().getString(BUNDLE, "MSG_PATH_TOO_FAR");
        static const GROUND_LAYER:int = 7;

        public function WorldMapStorage()
        {
            this.m_Field = new Vector.<Field>(NUM_FIELDS, true);
            this.m_Effect = new Vector.<AppearanceInstance>(NUM_EFFECTS, true);
            this.m_MessageBoxes = new Vector.<OnscreenMessageBox>;
            this.m_CacheObjectsCount = new Vector.<int>(MAPSIZE_Z);
            this.m_HelperCoordinate = new Vector3D();
            this.m_LayerBrightnessInfos = new Vector.<Vector.<Boolean>>(MAPSIZE_Z, false);
            this.m_Position = new Vector3D(0, 0, 0);
            this.m_PlayerZPlane = 0;
            this.m_Origin = new Vector3D(0, 0, 0);
            var _loc_1:* = 0;
            while (_loc_1 < NUM_FIELDS)
            {
                
                this.m_Field[_loc_1] = new Field();
                _loc_1++;
            }
            this.m_EffectCount = 0;
            this.m_MessageBoxes[ONSCREEN_TARGET_BOX_BOTTOM] = new OnscreenMessageBox(null, null, 0, MessageMode.MESSAGE_NONE, 1);
            this.m_MessageBoxes[ONSCREEN_TARGET_BOX_LOW] = new OnscreenMessageBox(null, null, 0, MessageMode.MESSAGE_NONE, NUM_ONSCREEN_MESSAGES);
            this.m_MessageBoxes[ONSCREEN_TARGET_BOX_HIGH] = new OnscreenMessageBox(null, null, 0, MessageMode.MESSAGE_NONE, 1);
            this.m_MessageBoxes[ONSCREEN_TARGET_BOX_TOP] = new OnscreenMessageBox(null, null, 0, MessageMode.MESSAGE_NONE, NUM_ONSCREEN_MESSAGES);
            this.m_AmbientCurrentColour = new Colour(0, 0, 0);
            this.m_AmbientCurrentBrightness = -1;
            this.m_AmbientTargetColour = new Colour(0, 0, 0);
            this.m_AmbientTargetBrightness = -1;
            var _loc_2:* = 0;
            while (_loc_2 < MAPSIZE_Z)
            {
                
                this.m_CacheObjectsCount[_loc_2] = 0;
                _loc_2++;
            }
            this.m_CacheFullbank = false;
            this.m_CacheValid = false;
            this.m_AmbientNextUpdate = 0;
            this.m_ObjectNextUpdate = 0;
            var _loc_3:* = 0;
            while (_loc_3 < MAPSIZE_Z)
            {
                
                this.m_LayerBrightnessInfos[_loc_3] = new Vector.<Boolean>(MAPSIZE_X * MAPSIZE_Y, false);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function appendObject(param1:int, param2:int, param3:int, param4:ObjectInstance) : ObjectInstance
        {
            var _loc_5:* = this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param4, MAPSIZE_W);
            if (this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param4, MAPSIZE_W) != null && _loc_5.ID == AppearanceInstance.CREATURE)
            {
                Tibia.s_GetCreatureStorage().markOpponentVisible(_loc_5.data, false);
            }
            if (_loc_5 == null)
            {
                var _loc_6:* = this.m_CacheObjectsCount;
                var _loc_7:* = (this.m_Origin.z + param3) % MAPSIZE_Z;
                var _loc_8:* = _loc_6[(this.m_Origin.z + param3) % MAPSIZE_Z] + 1;
                _loc_6[_loc_7] = _loc_8;
            }
            if (param4.type.isFullBank)
            {
                this.m_CacheFullbank = false;
            }
            return _loc_5;
        }// end function

        public function getMiniMapColour(param1:int, param2:int, param3:int) : uint
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].m_MiniMapColour;
        }// end function

        public function getObjectPerLayer(param1:int) : int
        {
            if (param1 < 0 || param1 >= MAPSIZE_Z)
            {
                throw new ArgumentError("WorldMapStorage.getObjectPerLayer: Z=" + param1 + " is out of range.");
            }
            return this.m_CacheObjectsCount[(this.m_Origin.z + param1) % MAPSIZE_Z];
        }// end function

        public function getEnvironmentalEffect(param1:int, param2:int, param3:int) : ObjectInstance
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getEnvironmentalEffect();
        }// end function

        public function toAbsolute(param1:Vector3D, param2:Vector3D = null) : Vector3D
        {
            if (param1.x < 0 || param1.x >= MAPSIZE_X || param1.y < 0 || param1.y >= MAPSIZE_Y || param1.z < 0 || param1.z >= MAPSIZE_Z)
            {
                throw new ArgumentError("WorldMapStorage.toAbsolute: Invalid co-ordinate: " + param1 + ".");
            }
            var _loc_3:* = param1.z - this.m_PlayerZPlane;
            if (param2 == null)
            {
                return new Vector3D(param1.x + (this.m_Position.x - PLAYER_OFFSET_X) + _loc_3, param1.y + (this.m_Position.y - PLAYER_OFFSET_Y) + _loc_3, this.m_Position.z - _loc_3);
            }
            param2.x = param1.x + (this.m_Position.x - PLAYER_OFFSET_X) + _loc_3;
            param2.y = param1.y + (this.m_Position.y - PLAYER_OFFSET_Y) + _loc_3;
            param2.z = this.m_Position.z - _loc_3;
            return param2;
        }// end function

        public function updateMiniMap(param1:int, param2:int, param3:int) : void
        {
            this.m_Field[this.toIndexInternal(param1, param2, param3)].updateMiniMap();
            return;
        }// end function

        public function getFieldHeight(param1:int, param2:int, param3:int) : int
        {
            var _loc_7:* = null;
            var _loc_4:* = this.m_Field[this.toIndexInternal(param1, param2, param3)];
            var _loc_5:* = 0;
            var _loc_6:* = _loc_4.m_ObjectsCount - 1;
            while (_loc_6 >= 0)
            {
                
                _loc_7 = _loc_4.m_ObjectsNetwork[_loc_6];
                if (_loc_7.type.isHeight)
                {
                    _loc_5++;
                }
                _loc_6 = _loc_6 - 1;
            }
            return _loc_5;
        }// end function

        public function getPositionZ() : int
        {
            return this.m_Position.z;
        }// end function

        public function resetMap() : void
        {
            this.m_Position.setZero();
            this.m_PlayerZPlane = 0;
            this.m_Origin.setZero();
            var _loc_1:* = 0;
            while (_loc_1 < NUM_FIELDS)
            {
                
                this.m_Field[_loc_1].reset();
                _loc_1++;
            }
            var _loc_2:* = 0;
            while (_loc_2 < NUM_EFFECTS)
            {
                
                this.m_Effect[_loc_2] = null;
                _loc_2++;
            }
            this.m_EffectCount = 0;
            var _loc_3:* = 0;
            while (_loc_3 < MAPSIZE_Z)
            {
                
                this.m_CacheObjectsCount[_loc_3] = 0;
                _loc_3++;
            }
            this.m_CacheFullbank = false;
            this.m_CacheValid = false;
            this.m_AmbientNextUpdate = 0;
            this.m_ObjectNextUpdate = 0;
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function getTopLookObject(param1:int, param2:int, param3:int, param4:Object = null) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getTopLookObject(param4);
        }// end function

        public function refreshFields() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_3 = 0;
            while (_loc_3 < MAPSIZE_Z)
            {
                
                if (this.getObjectPerLayer(_loc_3) > 0)
                {
                    this.m_HelperCoordinate.setComponents(0, 0, _loc_3);
                    this.toAbsolute(this.m_HelperCoordinate, this.m_HelperCoordinate);
                    _loc_1 = 0;
                    while (_loc_1 < MAPSIZE_X)
                    {
                        
                        _loc_2 = 0;
                        while (_loc_2 < MAPSIZE_Y)
                        {
                            
                            this.m_Field[this.toIndexInternal(_loc_1, _loc_2, _loc_3)].updateBitmapCache(this.m_HelperCoordinate.x + _loc_1, this.m_HelperCoordinate.y + _loc_2, this.m_HelperCoordinate.z);
                            _loc_2++;
                        }
                        _loc_1++;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function addOnscreenMessage(... args) : OnscreenMessageBox
        {
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            args = null;
            var _loc_3:* = -1;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = MessageMode.MESSAGE_NONE;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = uint.MAX_VALUE;
            if (args.length == 2)
            {
                _loc_6 = int(args[0]);
                _loc_7 = args[1] as String;
            }
            else if (args.length == 6)
            {
                args = args[0] as Vector3D;
                _loc_3 = int(args[1]);
                _loc_4 = args[2] as String;
                _loc_5 = int(args[3]);
                _loc_6 = int(args[4]);
                _loc_7 = args[5] as String;
            }
            else if (args.length == 7)
            {
                args = args[0] as Vector3D;
                _loc_3 = int(args[1]);
                _loc_4 = args[2] as String;
                _loc_5 = int(args[3]);
                _loc_6 = int(args[4]);
                _loc_8 = args[5] as Number;
                _loc_9 = int(args[6]);
            }
            else
            {
                throw new ArgumentError("WorldMapStorage.addOnscreenMessage: Illegal overload.");
            }
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = ONSCREEN_TARGET_NONE;
            var _loc_22:* = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            _loc_10 = this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET);
            var _loc_22:* = _loc_10.getMessageMode(_loc_6);
            _loc_11 = _loc_10.getMessageMode(_loc_6);
            var _loc_22:* = _loc_11.onscreenTarget;
            _loc_13 = _loc_11.onscreenTarget;
            var _loc_22:* = this.m_Options.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            _loc_12 = this.m_Options.getNameFilterSet(NameFilterSet.DEFAULT_SET);
            if (this.m_Options != null && _loc_22 != null && _loc_22 != null && _loc_11.showOnscreenMessage && _loc_22 != ONSCREEN_TARGET_NONE && _loc_22 != null && (_loc_11.ignoreNameFilter || _loc_12.acceptMessage(_loc_6, _loc_4, _loc_7)))
            {
                if (_loc_13 == ONSCREEN_TARGET_BOX_COORDINATE || _loc_13 == ONSCREEN_TARGET_BOX_TOP || _loc_13 == ONSCREEN_TARGET_BOX_HIGH || _loc_13 == ONSCREEN_TARGET_BOX_LOW || _loc_13 == ONSCREEN_TARGET_BOX_BOTTOM)
                {
                    _loc_14 = null;
                    if (_loc_13 == ONSCREEN_TARGET_BOX_COORDINATE)
                    {
                        if (args == null)
                        {
                            throw new Error("WorldMapStorage.addOnscreenMessage: Missing co-ordinate.");
                        }
                        _loc_16 = true;
                        _loc_17 = ONSCREEN_TARGET_BOX_COORDINATE;
                        while (_loc_17 < this.m_MessageBoxes.length)
                        {
                            
                            if (this.m_MessageBoxes[_loc_17].position == null || this.m_MessageBoxes[_loc_17].position.equals(args))
                            {
                                if (this.m_MessageBoxes[_loc_17].speaker == _loc_4 && this.m_MessageBoxes[_loc_17].mode == _loc_6)
                                {
                                    _loc_14 = this.m_MessageBoxes[_loc_17];
                                    break;
                                }
                                else
                                {
                                    _loc_16 = false;
                                }
                            }
                            _loc_17++;
                        }
                        if (_loc_14 == null)
                        {
                            _loc_14 = new OnscreenMessageBox(args, _loc_4, _loc_5, _loc_6, NUM_ONSCREEN_MESSAGES);
                            _loc_14.visible = _loc_16;
                            _loc_18 = _loc_11.getOnscreenMessageHeader(_loc_4, _loc_5);
                            if (_loc_18 != null)
                            {
                                _loc_19 = new OnscreenMessage(-1, _loc_4, _loc_5, _loc_6, _loc_18);
                                _loc_19.formatMessage(null, _loc_11.textARGB, _loc_11.highlightARGB);
                                _loc_19.TTL = Number.POSITIVE_INFINITY;
                                _loc_14.appendMessage(_loc_19);
                            }
                            this.m_MessageBoxes.push(_loc_14);
                        }
                    }
                    else
                    {
                        _loc_14 = this.m_MessageBoxes[_loc_13];
                    }
                    _loc_15 = new OnscreenMessage(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7);
                    _loc_15.formatMessage(_loc_11.getOnscreenMessagePrefix(_loc_4, _loc_5), _loc_11.textARGB, _loc_11.highlightARGB);
                    _loc_14.appendMessage(_loc_15);
                    this.invalidateOnscreenMessages();
                    return _loc_14;
                }
                else if (_loc_13 == ONSCREEN_TARGET_EFFECT_COORDINATE)
                {
                    if (args == null)
                    {
                        throw new Error("WorldMapStorage.addOnscreenMessage: Missing co-ordinate.");
                    }
                    _loc_20 = null;
                    var _loc_22:* = Tibia.s_GetAppearanceStorage();
                    _loc_20 = Tibia.s_GetAppearanceStorage();
                    if (_loc_8 > 0 && _loc_22 != null)
                    {
                        _loc_21 = _loc_20.createTextualEffectInstance(-1, _loc_9, _loc_8);
                        this.appendEffect(args.x, args.y, args.z, _loc_21);
                    }
                    ;
                }
            }
            return null;
        }// end function

        private function deleteEffect(param1:int) : void
        {
            if (param1 < 0 || param1 >= this.m_EffectCount)
            {
                throw new RangeError("WorldMapStorage.deleteEffect: Invalid index: " + param1);
            }
            var _loc_2:* = this.m_Effect[param1];
            if (_loc_2.mapField != -1)
            {
                this.m_Field[_loc_2.mapField].deleteEffect(_loc_2.mapData);
            }
            _loc_2.mapData = -1;
            _loc_2.mapField = -1;
            var _loc_3:* = this;
            var _loc_4:* = this.m_EffectCount - 1;
            _loc_3.m_EffectCount = _loc_4;
            if (param1 < this.m_EffectCount)
            {
                this.m_Effect[param1] = this.m_Effect[this.m_EffectCount];
            }
            this.m_Effect[this.m_EffectCount] = null;
            return;
        }// end function

        public function changeObject(param1:int, param2:int, param3:int, param4:int, param5:ObjectInstance) : ObjectInstance
        {
            var _loc_6:* = this.m_Field[this.toIndexInternal(param1, param2, param3)].changeObject(param5, param4);
            if (this.m_Field[this.toIndexInternal(param1, param2, param3)].changeObject(param5, param4) != null && _loc_6.ID == AppearanceInstance.CREATURE && param5 != null && param5.ID == AppearanceInstance.CREATURE && _loc_6.data != param5.data)
            {
                Tibia.s_GetCreatureStorage().markOpponentVisible(_loc_6.data, false);
            }
            if (_loc_6 != null && _loc_6.type.isFullBank || param5.type.isFullBank)
            {
                this.m_CacheFullbank = false;
            }
            return _loc_6;
        }// end function

        public function expireOldestMessage() : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_1:* = Number.POSITIVE_INFINITY;
            var _loc_2:* = -1;
            var _loc_3:* = this.m_MessageBoxes.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this.m_MessageBoxes[_loc_3].minExpirationTime;
                if (_loc_4 < _loc_1)
                {
                    _loc_1 = _loc_4;
                    _loc_2 = _loc_3;
                }
                _loc_3 = _loc_3 - 1;
            }
            if (_loc_2 > -1)
            {
                _loc_5 = this.m_MessageBoxes[_loc_2].expireOldestMessage();
                if (_loc_5 > 0)
                {
                    this.m_LayoutOnscreenMessages = true;
                }
                if (this.m_MessageBoxes[_loc_2].empty && _loc_2 >= ONSCREEN_TARGET_BOX_COORDINATE)
                {
                    this.m_MessageBoxes[_loc_2].removeMessages();
                    this.m_MessageBoxes.splice(_loc_2, 1);
                    this.m_LayoutOnscreenMessages = true;
                }
            }
            return;
        }// end function

        private function toIndexInternal(param1:int, param2:int, param3:int) : int
        {
            if (param1 < 0 || param1 >= MAPSIZE_X || param2 < 0 || param2 >= MAPSIZE_Y || param3 < 0 || param3 >= MAPSIZE_Z)
            {
                throw new ArgumentError("WorldMapStorage.toIndexInternal: Input co-oridnate (" + param1 + ", " + param2 + ", " + param3 + ") is out of range.");
            }
            return ((param3 + this.m_Origin.z) % MAPSIZE_Z * MAPSIZE_X + (param1 + this.m_Origin.x) % MAPSIZE_X) * MAPSIZE_Y + (param2 + this.m_Origin.y) % MAPSIZE_Y;
        }// end function

        public function getPosition(param1:Vector3D = null) : Vector3D
        {
            if (param1 == null)
            {
                return this.m_Position.clone();
            }
            param1.setComponents(this.m_Position.x, this.m_Position.y, this.m_Position.z);
            return param1;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            this.m_Position.x = param1;
            this.m_Position.y = param2;
            this.m_Position.z = param3;
            this.m_PlayerZPlane = param3 <= GROUND_LAYER ? ((MAPSIZE_Z - 1) - param3) : (UNDERGROUND_LAYER);
            return;
        }// end function

        public function getCreatureObjectForCreature(param1:Creature, param2:Object = null) : int
        {
            var _loc_3:* = null;
            if (param1 != null)
            {
                _loc_3 = this.toMap(param1.position);
                return this.m_Field[this.toIndexInternal(_loc_3.x, _loc_3.y, _loc_3.z)].getCreatureObjectForCreatureID(param1.ID, param2);
            }
            return -1;
        }// end function

        public function getObject(param1:int, param2:int, param3:int, param4:int) : ObjectInstance
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getObject(param4);
        }// end function

        public function getLightBlockingTilesForZLayer(param1:uint) : Vector.<Boolean>
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 < 0 || param1 >= MAPSIZE_Z)
            {
                throw new ArgumentError("WorldMapStorage.toIndexInternal: Input Z co-oridnate (" + param1 + ") is out of range.");
            }
            var _loc_2:* = this.m_LayerBrightnessInfos[param1];
            var _loc_3:* = 0;
            while (_loc_3 < MAPSIZE_Y)
            {
                
                _loc_4 = 0;
                while (_loc_4 < MAPSIZE_X)
                {
                    
                    _loc_5 = ((param1 + this.m_Origin.z) % MAPSIZE_Z * MAPSIZE_X + (_loc_4 + this.m_Origin.x) % MAPSIZE_X) * MAPSIZE_Y + (_loc_3 + this.m_Origin.y) % MAPSIZE_Y;
                    _loc_6 = _loc_3 * MAPSIZE_X + _loc_4;
                    _loc_7 = this.m_Field[_loc_5];
                    _loc_8 = _loc_7.getObject(0);
                    if (_loc_8 == null || !_loc_8.m_Type.isBank)
                    {
                        _loc_2[_loc_6] = true;
                    }
                    else
                    {
                        _loc_2[_loc_6] = false;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function toMapClosest(param1:Vector3D, param2:Vector3D = null) : Vector3D
        {
            var _loc_3:* = 0;
            _loc_3 = this.m_Position.z - param1.z;
            var _loc_4:* = Math.max(0, Math.min(param1.x - (this.m_Position.x - PLAYER_OFFSET_X) - _loc_3, (MAPSIZE_X - 1)));
            var _loc_5:* = Math.max(0, Math.min(param1.y - (this.m_Position.y - PLAYER_OFFSET_Y) - _loc_3, (MAPSIZE_Y - 1)));
            var _loc_6:* = Math.max(0, Math.min(this.m_PlayerZPlane + _loc_3, (MAPSIZE_Z - 1)));
            if (param2 == null)
            {
                return new Vector3D(_loc_4, _loc_5, _loc_6);
            }
            param2.x = _loc_4;
            param2.y = _loc_5;
            param2.z = _loc_6;
            return param2;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            return;
        }// end function

        public function putObject(param1:int, param2:int, param3:int, param4:ObjectInstance) : ObjectInstance
        {
            var _loc_5:* = this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param4, -1);
            if (this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param4, -1) != null && _loc_5.ID == AppearanceInstance.CREATURE)
            {
                Tibia.s_GetCreatureStorage().markOpponentVisible(_loc_5.data, false);
            }
            if (_loc_5 == null)
            {
                var _loc_6:* = this.m_CacheObjectsCount;
                var _loc_7:* = (this.m_Origin.z + param3) % MAPSIZE_Z;
                var _loc_8:* = _loc_6[(this.m_Origin.z + param3) % MAPSIZE_Z] + 1;
                _loc_6[_loc_7] = _loc_8;
            }
            if (_loc_5 != null && _loc_5.type.isFullBank || param4.type.isFullBank)
            {
                this.m_CacheFullbank = false;
            }
            return _loc_5;
        }// end function

        public function getEnterPossibleFlag(param1:int, param2:int, param3:int, param4:Boolean) : uint
        {
            var _loc_8:* = null;
            var _loc_5:* = this.m_Field[this.toIndexInternal(param1, param2, param3)];
            if (param4 && param1 < (MAPSIZE_X - 1) && param2 < (MAPSIZE_Y - 1) && param3 > 0 && _loc_5.m_ObjectsCount > 0 && !_loc_5.m_ObjectsNetwork[0].type.isBank && this.getFieldHeight((param1 + 1), (param2 + 1), (param3 - 1)) > 2)
            {
                return FIELD_ENTER_POSSIBLE;
            }
            if (param4 && this.getFieldHeight(PLAYER_OFFSET_X, PLAYER_OFFSET_Y, this.m_PlayerZPlane) > 2)
            {
                return FIELD_ENTER_POSSIBLE;
            }
            var _loc_6:* = null;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5.m_ObjectsCount)
            {
                
                _loc_8 = _loc_5.m_ObjectsNetwork[_loc_7];
                if (_loc_8.ID == AppearanceInstance.CREATURE && _loc_6 == null)
                {
                    _loc_6 = Tibia.s_GetCreatureStorage().getCreature(_loc_8.data);
                    if (!_loc_6.isTrapper && _loc_6.isUnpassable)
                    {
                        return _loc_6.isHuman ? (FIELD_ENTER_POSSIBLE_NO_ANIMATION) : (FIELD_ENTER_NOT_POSSIBLE);
                    }
                }
                else
                {
                    if (_loc_8.type.isUnpassable)
                    {
                        return FIELD_ENTER_NOT_POSSIBLE;
                    }
                    if (_loc_8.type.preventMovementAnimation)
                    {
                        return FIELD_ENTER_POSSIBLE_NO_ANIMATION;
                    }
                }
                _loc_7++;
            }
            return FIELD_ENTER_POSSIBLE;
        }// end function

        private function moveEffect(param1:int, param2:int, param3:int, param4:int) : void
        {
            if (param4 < 0 || param4 >= this.m_EffectCount)
            {
                throw new RangeError("WorldMapStorage.moveEffect: Invalid effect index: " + param4);
            }
            var _loc_5:* = this.toMapInternal(new Vector3D(param1, param2, param3));
            var _loc_6:* = -1;
            if (_loc_5 != null)
            {
                _loc_6 = this.toIndexInternal(_loc_5.x, _loc_5.y, _loc_5.z);
            }
            var _loc_7:* = this.m_Effect[param4];
            if (_loc_7.mapField == _loc_6)
            {
                return;
            }
            if (_loc_7.mapField > -1)
            {
                this.m_Field[_loc_7.mapField].deleteEffect(_loc_7.mapData);
                _loc_7.mapData = 0;
                _loc_7.mapField = -1;
            }
            if (_loc_6 > -1)
            {
                _loc_7.mapData = 0;
                _loc_7.mapField = _loc_6;
                this.m_Field[_loc_6].appendEffect(_loc_7);
            }
            return;
        }// end function

        private function toMapInternal(param1:Vector3D, param2:Vector3D = null) : Vector3D
        {
            var _loc_3:* = 0;
            if (param1 == null)
            {
                return null;
            }
            _loc_3 = this.m_Position.z - param1.z;
            var _loc_4:* = param1.x - (this.m_Position.x - PLAYER_OFFSET_X) - _loc_3;
            var _loc_5:* = param1.y - (this.m_Position.y - PLAYER_OFFSET_Y) - _loc_3;
            var _loc_6:* = this.m_PlayerZPlane + _loc_3;
            if (_loc_4 < 0 || _loc_4 >= MAPSIZE_X || _loc_5 < 0 || _loc_5 >= MAPSIZE_Y || _loc_6 < 0 || _loc_6 >= MAPSIZE_Z)
            {
                return null;
            }
            if (param2 == null)
            {
                return new Vector3D(_loc_4, _loc_5, _loc_6);
            }
            param2.x = _loc_4;
            param2.y = _loc_5;
            param2.z = _loc_6;
            return param2;
        }// end function

        public function getTopUseObject(param1:int, param2:int, param3:int, param4:Object = null) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getTopUseObject(param4);
        }// end function

        public function deleteObject(param1:int, param2:int, param3:int, param4:int) : ObjectInstance
        {
            var _loc_5:* = this.m_Field[this.toIndexInternal(param1, param2, param3)].deleteObject(param4);
            if (this.m_Field[this.toIndexInternal(param1, param2, param3)].deleteObject(param4) != null && _loc_5.ID == AppearanceInstance.CREATURE)
            {
                Tibia.s_GetCreatureStorage().markOpponentVisible(_loc_5.data, false);
            }
            if (_loc_5 != null)
            {
                var _loc_6:* = this.m_CacheObjectsCount;
                var _loc_7:* = (this.m_Origin.z + param3) % MAPSIZE_Z;
                var _loc_8:* = _loc_6[(this.m_Origin.z + param3) % MAPSIZE_Z] - 1;
                _loc_6[_loc_7] = _loc_8;
            }
            if (_loc_5 != null && _loc_5.type.isFullBank)
            {
                this.m_CacheFullbank = false;
            }
            return _loc_5;
        }// end function

        public function getField(param1:int, param2:int, param3:int) : Field
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)];
        }// end function

        public function getAmbientColour() : Colour
        {
            return this.m_AmbientCurrentColour;
        }// end function

        public function reset() : void
        {
            this.resetMap();
            this.resetOnscreenMessages();
            return;
        }// end function

        public function invalidateOnscreenMessages() : void
        {
            this.m_LayoutOnscreenMessages = true;
            return;
        }// end function

        public function getAmbientBrightness() : int
        {
            return this.m_AmbientCurrentBrightness;
        }// end function

        public function getMiniMapCost(param1:int, param2:int, param3:int) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].m_MiniMapCost;
        }// end function

        public function scrollMap(param1:int, param2:int, param3:int = 0) : void
        {
            if (param1 < -MAPSIZE_X || param1 > MAPSIZE_X)
            {
                throw new ArgumentError("WorldMapStorage.scrollMap: X=" + param1 + " is out of range.");
            }
            if (param2 < -MAPSIZE_Y || param2 > MAPSIZE_Y)
            {
                throw new ArgumentError("WorldMapStorage.scrollMap: Y=" + param2 + " is out of range.");
            }
            if (param3 < -MAPSIZE_Z || param3 > MAPSIZE_Z)
            {
                throw new ArgumentError("WorldMapStorage.scrollMap: Z=" + param3 + " is out of range.");
            }
            if (param1 * param2 + param2 * param3 + param1 * param3 != 0)
            {
                throw new ArgumentError("WorldMapStorage.scrollMap: Only one of the agruments  may be != 0.");
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param1 != 0)
            {
                _loc_4 = 0;
                _loc_5 = -param1;
                if (param1 > 0)
                {
                    _loc_4 = MAPSIZE_X - param1;
                    _loc_5 = MAPSIZE_X;
                }
                _loc_6 = _loc_4;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = 0;
                    while (_loc_7 < MAPSIZE_Y)
                    {
                        
                        _loc_8 = 0;
                        while (_loc_8 < MAPSIZE_Z)
                        {
                            
                            this.resetField(_loc_6, _loc_7, _loc_8);
                            _loc_8++;
                        }
                        _loc_7++;
                    }
                    _loc_6++;
                }
                this.m_Origin.x = this.m_Origin.x - param1;
                if (this.m_Origin.x < 0)
                {
                    this.m_Origin.x = this.m_Origin.x + MAPSIZE_X;
                }
                this.m_Origin.x = this.m_Origin.x % MAPSIZE_X;
            }
            if (param2 != 0)
            {
                _loc_4 = 0;
                _loc_5 = -param2;
                if (param2 > 0)
                {
                    _loc_4 = MAPSIZE_Y - param2;
                    _loc_5 = MAPSIZE_Y;
                }
                _loc_6 = 0;
                while (_loc_6 < MAPSIZE_X)
                {
                    
                    _loc_7 = _loc_4;
                    while (_loc_7 < _loc_5)
                    {
                        
                        _loc_8 = 0;
                        while (_loc_8 < MAPSIZE_Z)
                        {
                            
                            this.resetField(_loc_6, _loc_7, _loc_8);
                            _loc_8++;
                        }
                        _loc_7++;
                    }
                    _loc_6++;
                }
                this.m_Origin.y = this.m_Origin.y - param2;
                if (this.m_Origin.y < 0)
                {
                    this.m_Origin.y = this.m_Origin.y + MAPSIZE_Y;
                }
                this.m_Origin.y = this.m_Origin.y % MAPSIZE_Y;
            }
            if (param3 != 0)
            {
                _loc_4 = 0;
                _loc_5 = -param3;
                if (param3 > 0)
                {
                    _loc_4 = MAPSIZE_Z - param3;
                    _loc_5 = MAPSIZE_Z;
                }
                _loc_6 = 0;
                while (_loc_6 < MAPSIZE_X)
                {
                    
                    _loc_7 = 0;
                    while (_loc_7 < MAPSIZE_Y)
                    {
                        
                        _loc_8 = _loc_4;
                        while (_loc_8 < _loc_5)
                        {
                            
                            this.resetField(_loc_6, _loc_7, _loc_8);
                            _loc_8++;
                        }
                        _loc_7++;
                    }
                    _loc_6++;
                }
                this.m_Origin.z = this.m_Origin.z - param3;
                if (this.m_Origin.z < 0)
                {
                    this.m_Origin.z = this.m_Origin.z + MAPSIZE_Z;
                }
                this.m_Origin.z = this.m_Origin.z % MAPSIZE_Z;
                if (param3 > 0)
                {
                    _loc_6 = 0;
                    while (_loc_6 < MAPSIZE_X)
                    {
                        
                        _loc_7 = 0;
                        while (_loc_7 < MAPSIZE_Y)
                        {
                            
                            _loc_8 = MAPSIZE_Z - UNDERGROUND_LAYER - 1;
                            while (_loc_8 < MAPSIZE_Z)
                            {
                                
                                this.resetField(_loc_6, _loc_7, _loc_8);
                                _loc_8++;
                            }
                            _loc_7++;
                        }
                        _loc_6++;
                    }
                }
            }
            return;
        }// end function

        public function getTopCreatureObject(param1:int, param2:int, param3:int, param4:Object = null) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getTopCreatureObject(param4);
        }// end function

        public function isTranslucent(param1:int, param2:int, param3:int) : Boolean
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].m_CacheTranslucent;
        }// end function

        public function setAmbientLight(param1:Colour, param2:int) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("WorldMapStorage.setAmbientLight: Invalid colour value.");
            }
            var _loc_3:* = this.m_AmbientTargetBrightness < 0;
            this.m_AmbientTargetColour = param1;
            this.m_AmbientTargetBrightness = param2;
            if (_loc_3)
            {
                this.m_AmbientCurrentColour = this.m_AmbientTargetColour;
                this.m_AmbientCurrentBrightness = this.m_AmbientTargetBrightness;
            }
            return;
        }// end function

        public function toMap(param1:Vector3D, param2:Vector3D = null) : Vector3D
        {
            if (param1 == null)
            {
                throw new ArgumentError("WorldMapStorage.toMap: Input co-ordinate is null.");
            }
            var _loc_3:* = this.toMapInternal(param1, param2);
            if (_loc_3 == null)
            {
                throw new ArgumentError("WorldMapStorage.toMap: Input co-ordinate " + param1 + " is out of range.");
            }
            return _loc_3;
        }// end function

        public function appendEffect(param1:int, param2:int, param3:int, param4:AppearanceInstance) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_5:* = this.toMapInternal(new Vector3D(param1, param2, param3));
            var _loc_6:* = -1;
            var _loc_7:* = null;
            if (_loc_5 != null)
            {
                _loc_6 = this.toIndexInternal(_loc_5.x, _loc_5.y, _loc_5.z);
                _loc_7 = this.m_Field[_loc_6];
            }
            if (_loc_7 != null && param4 is TextualEffectInstance)
            {
                _loc_8 = _loc_7.m_EffectsCount - 1;
                while (_loc_8 >= 0)
                {
                    
                    _loc_9 = _loc_7.m_Effects[_loc_8];
                    if (_loc_9 is TextualEffectInstance && TextualEffectInstance(_loc_9).merge(param4))
                    {
                        return;
                    }
                    _loc_8 = _loc_8 - 1;
                }
            }
            if (this.m_EffectCount < NUM_EFFECTS)
            {
                param4.mapField = _loc_6;
                param4.mapData = 0;
                if (_loc_7 != null)
                {
                    _loc_7.appendEffect(param4);
                }
                this.m_Effect[this.m_EffectCount] = param4;
                var _loc_10:* = this;
                var _loc_11:* = this.m_EffectCount + 1;
                _loc_10.m_EffectCount = _loc_11;
            }
            return;
        }// end function

        public function insertObject(param1:int, param2:int, param3:int, param4:int, param5:ObjectInstance) : ObjectInstance
        {
            var _loc_6:* = this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param5, param4);
            if (this.m_Field[this.toIndexInternal(param1, param2, param3)].putObject(param5, param4) != null && _loc_6.ID == AppearanceInstance.CREATURE)
            {
                Tibia.s_GetCreatureStorage().markOpponentVisible(_loc_6.data, false);
            }
            if (_loc_6 == null)
            {
                var _loc_7:* = this.m_CacheObjectsCount;
                var _loc_8:* = (this.m_Origin.z + param3) % MAPSIZE_Z;
                var _loc_9:* = _loc_7[(this.m_Origin.z + param3) % MAPSIZE_Z] + 1;
                _loc_7[_loc_8] = _loc_9;
            }
            if (_loc_6 != null && _loc_6.type.isFullBank || param5.type.isFullBank)
            {
                this.m_CacheFullbank = false;
            }
            return _loc_6;
        }// end function

        public function isVisible(param1:int, param2:int, param3:int, param4:Boolean) : Boolean
        {
            var _loc_5:* = new Vector3D(param1, param2, param3);
            _loc_5 = this.toMapInternal(_loc_5, _loc_5);
            return _loc_5 != null && (param4 || this.m_Position.z == param3);
        }// end function

        public function resetField(param1:int, param2:int, param3:int, param4:Boolean = true, param5:Boolean = true) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_6:* = this.toIndexInternal(param1, param2, param3);
            var _loc_7:* = this.m_Field[_loc_6];
            this.m_CacheObjectsCount[(this.m_Origin.z + param3) % MAPSIZE_Z] = this.m_CacheObjectsCount[(this.m_Origin.z + param3) % MAPSIZE_Z] - _loc_7.m_ObjectsCount;
            this.m_CacheFullbank = false;
            if (param4)
            {
                _loc_8 = Tibia.s_GetCreatureStorage();
                _loc_9 = _loc_7.m_ObjectsCount - 1;
                while (_loc_9 >= 0)
                {
                    
                    _loc_10 = _loc_7.m_ObjectsNetwork[_loc_9];
                    if (_loc_10.ID == AppearanceInstance.CREATURE)
                    {
                        _loc_8.markOpponentVisible(_loc_10.data, false);
                    }
                    _loc_9 = _loc_9 - 1;
                }
            }
            _loc_7.resetObjects();
            if (param5)
            {
                _loc_11 = this.m_EffectCount - 1;
                while (_loc_11 >= 0)
                {
                    
                    if (this.m_Effect[_loc_11].mapField == _loc_6)
                    {
                        this.deleteEffect(_loc_11);
                    }
                    _loc_11 = _loc_11 - 1;
                }
                _loc_7.resetEffects();
            }
            return;
        }// end function

        public function getTopMultiUseObject(param1:int, param2:int, param3:int, param4:Object = null) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getTopMultiUseObject(param4);
        }// end function

        public function getTopMoveObject(param1:int, param2:int, param3:int, param4:Object = null) : int
        {
            return this.m_Field[this.toIndexInternal(param1, param2, param3)].getTopMoveObject(param4);
        }// end function

        public function setEnvironmentalEffect(param1:int, param2:int, param3:int, param4:ObjectInstance) : void
        {
            this.m_Field[this.toIndexInternal(param1, param2, param3)].setEnvironmentalEffect(param4);
            return;
        }// end function

        public function animate() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = Tibia.s_FrameTibiaTimestamp;
            if (_loc_1 < this.m_ObjectNextUpdate)
            {
                return;
            }
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = this.m_EffectCount - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_4 = this.m_Effect[_loc_2];
                if (!_loc_4.animate(_loc_1))
                {
                    this.deleteEffect(_loc_2);
                }
                else if (_loc_4 is MissileInstance)
                {
                    _loc_5 = (_loc_4 as MissileInstance).position;
                    this.moveEffect(_loc_5.x, _loc_5.y, _loc_5.z, _loc_2);
                }
                _loc_2 = _loc_2 - 1;
            }
            _loc_2 = NUM_FIELDS - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_6 = this.m_Field[_loc_2];
                _loc_3 = _loc_6.m_ObjectsCount - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_6.m_ObjectsNetwork[_loc_3].animate(_loc_1);
                    _loc_3 = _loc_3 - 1;
                }
                if (_loc_6.m_Environment != null)
                {
                    _loc_6.m_Environment.animate(_loc_1);
                }
                _loc_2 = _loc_2 - 1;
            }
            _loc_2 = this.m_MessageBoxes.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_7 = this.m_MessageBoxes[_loc_2].expireMessages(_loc_1);
                if (_loc_7 > 0)
                {
                    this.m_LayoutOnscreenMessages = true;
                }
                if (this.m_MessageBoxes[_loc_2].empty && _loc_2 >= ONSCREEN_TARGET_BOX_COORDINATE)
                {
                    _loc_3 = _loc_2 + 1;
                    while (_loc_3 < this.m_MessageBoxes.length)
                    {
                        
                        if (this.m_MessageBoxes[_loc_3].position == null || this.m_MessageBoxes[_loc_3].position.equals(this.m_MessageBoxes[_loc_2].position))
                        {
                            this.m_MessageBoxes[_loc_3].visible = true;
                            break;
                        }
                        _loc_3++;
                    }
                    this.m_MessageBoxes[_loc_2].removeMessages();
                    this.m_MessageBoxes.splice(_loc_2, 1);
                    this.m_LayoutOnscreenMessages = true;
                }
                _loc_2 = _loc_2 - 1;
            }
            if (_loc_1 >= this.m_AmbientNextUpdate)
            {
                if (this.m_AmbientCurrentColour.red < this.m_AmbientTargetColour.red)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.red + 1;
                    _loc_8.red = _loc_9;
                }
                if (_loc_8.red > this.m_AmbientTargetColour.red)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.red - 1;
                    _loc_8.red = _loc_9;
                }
                if (_loc_8.green < this.m_AmbientTargetColour.green)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.green + 1;
                    _loc_8.green = _loc_9;
                }
                if (_loc_8.green > this.m_AmbientTargetColour.green)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.green - 1;
                    _loc_8.green = _loc_9;
                }
                if (_loc_8.blue < this.m_AmbientTargetColour.blue)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.blue + 1;
                    _loc_8.blue = _loc_9;
                }
                if (_loc_8.blue > this.m_AmbientTargetColour.blue)
                {
                    var _loc_8:* = this.m_AmbientCurrentColour;
                    var _loc_9:* = _loc_8.blue - 1;
                    _loc_8.blue = _loc_9;
                }
                if (this.m_AmbientCurrentBrightness < this.m_AmbientTargetBrightness)
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this.m_AmbientCurrentBrightness + 1;
                    _loc_8.m_AmbientCurrentBrightness = _loc_9;
                }
                if (this.m_AmbientCurrentBrightness > this.m_AmbientTargetBrightness)
                {
                    var _loc_8:* = this;
                    var _loc_9:* = this.m_AmbientCurrentBrightness - 1;
                    _loc_8.m_AmbientCurrentBrightness = _loc_9;
                }
                this.m_AmbientNextUpdate = _loc_1 + AMBIENT_UPDATE_INTERVAL;
            }
            this.m_ObjectNextUpdate = _loc_1 + OBJECT_UPDATE_INTERVAL;
            return;
        }// end function

        public function isLookPossible(param1:int, param2:int, param3:int) : Boolean
        {
            return !this.m_Field[this.toIndexInternal(param1, param2, param3)].m_CacheUnsight;
        }// end function

        public function get valid() : Boolean
        {
            return this.m_CacheValid;
        }// end function

        public function resetOnscreenMessages(param1:Boolean = true) : void
        {
            var _loc_2:* = this.m_MessageBoxes.length - 1;
            while (_loc_2 >= ONSCREEN_TARGET_BOX_COORDINATE)
            {
                
                this.m_MessageBoxes[_loc_2].removeMessages();
                this.m_MessageBoxes[_loc_2] = null;
                _loc_2 = _loc_2 - 1;
            }
            var _loc_3:* = ONSCREEN_TARGET_BOX_COORDINATE - 1;
            while (param1 && _loc_3 >= 0)
            {
                
                this.m_MessageBoxes[_loc_3].removeMessages();
                _loc_3 = _loc_3 - 1;
            }
            this.m_MessageBoxes.length = ONSCREEN_TARGET_BOX_COORDINATE;
            this.m_LayoutOnscreenMessages = true;
            return;
        }// end function

        public function set valid(param1:Boolean) : void
        {
            this.m_CacheValid = param1;
            return;
        }// end function

    }
}
