package tibia.worldmap.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import shared.stage3D.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.creatures.*;
    import tibia.options.*;
    import tibia.worldmap.*;

    public class RendererImpl extends UIComponent
    {
        protected var m_ClipRect:Rectangle = null;
        protected var m_Transform:Matrix = null;
        protected var m_LightTranslate:Matrix = null;
        protected var m_HangPatternX:int = 0;
        protected var m_HangPatternY:int = 0;
        protected var m_HangPatternZ:int = 0;
        protected var m_Player:Player = null;
        private var m_StopwatchShowFrame:IPerformanceCounter;
        private var m_HighlightTile:Vector3D = null;
        protected var m_LightClipRect:Rectangle = null;
        private const m_TempManaColour:Colour;
        protected var m_MaxZPlane:int = 0;
        private var m_OptionsLightEnabled:Boolean = false;
        private var m_ObjectCursor:ObjectCursor = null;
        private var m_HighlightObject:Object = null;
        protected var m_HUDArcScale:Number = NaN;
        private var m_HelperCreatureFlagsBitmapData:BitmapData = null;
        protected var m_CreatureStorage:CreatureStorage = null;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_HUDArcPoints:Vector.<Number> = null;
        protected var m_AtmosphereLayer:BitmapData = null;
        private var m_CursorOverRenderer:Boolean = false;
        private var m_UncommittedWorldMapStorage:Boolean = false;
        private var m_OptionsHighlight:Number = NaN;
        private var m_StopwatchEnterFrame:IPerformanceCounter;
        private const m_TempColor:Colour;
        private const m_TempCreatureColor:Colour;
        protected var m_HelperCoordinate:Vector3D = null;
        protected var m_MinZPlane:Vector.<int> = null;
        private var m_OptionsScaleMap:Boolean = true;
        protected var m_DrawnTextualEffectsCount:int = 0;
        protected var m_CreatureField:Vector.<Vector.<RenderAtom>> = null;
        protected var m_TiledLightmapRenderer:TiledLightmapRenderer = null;
        protected var m_HelperPoint:Point = null;
        private var m_CreatureFlagsBitmapCache:Dictionary = null;
        protected var m_CreatureCount:Vector.<int> = null;
        private var m_OptionsFrameRate:Number = NaN;
        protected var m_HelperPoint2:Point = null;
        protected var m_HUDArcStyle:int = 2;
        private var m_OptionsLevelSeparator:Number = NaN;
        protected var m_MainLayer:BitmapData = null;
        protected var m_HelperTrans:Matrix = null;
        protected var m_Tibia3D:Tibia3D = null;
        protected var m_DrawnCreaturesCount:int = 0;
        protected var m_PreviousHang:ObjectInstance = null;
        protected var m_DrawnCreatures:Vector.<RenderAtom> = null;
        private var m_OptionsAmbientBrightness:Number = NaN;
        private var m_WorldMapStorage:WorldMapStorage = null;
        private var m_OptionsAntialiasing:Boolean = false;
        protected var m_CreatureNameCache:TextFieldCache = null;
        protected var m_DrawnTextualEffects:Vector.<RenderAtom> = null;
        protected var m_HelperRect2:Rectangle = null;
        protected var m_HangPixelX:int = 0;
        protected var m_HangPixelY:int = 0;
        private var m_Options:OptionsStorage = null;
        private var m_TileCursor:TileCursor = null;
        protected var m_HelperRect:Rectangle = null;
        private const m_TempEffectColor:Colour;
        private const m_TempHealthColour:Colour;
        protected var m_PlayerZPlane:int = 0;
        protected var m_Rectangle:Rectangle = null;
        private const m_TempObjectColor:Colour;
        static const PATH_MATRIX_CENTER:int = 110;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        private static const TILE_CURSOR:BitmapData = Bitmap(new TILE_CURSOR_CLASS()).bitmapData;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const HUD_ARC_ORIENTATION_LEFT:int = 0;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_NONE:uint = 0;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        private static const OBJECT_CURSOR_COLOR:uint = 16769335;
        public static const COLOUR_ABOVE_GROUND:Colour = new Colour(200, 200, 255);
        static const PATH_COST_OBSTACLE:int = 255;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const FIELD_HEIGHT:int = 24;
        private static var CREATURE_FLAGS_BITMAP_CACHE_SIZE:uint = 100;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const PK_PARTYMODE:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const PARTY_MEMBER:int = 2;
        static const TYPE_NPC:int = 2;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const STATE_NONE:int = -1;
        static const SKILL_FIGHTDISTANCE:int = 9;
        public static const STATUS_STYLE_CLASSIC:int = 1;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const PATH_NORTH:int = 3;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const PATH_MAX_DISTANCE:int = 110;
        static const SKILL_FISHING:int = 14;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const GROUND_LAYER:int = 7;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        private static const s_TempMouseMoveEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_MOVE);
        static const SKILL_NONE:int = -1;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const PATH_EMPTY:int = 0;
        static const GUILD_MEMBER:int = 4;
        static const PATH_COST_UNDEFINED:int = 254;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const MAX_NAME_LENGTH:int = 29;
        static const HUD_ARC_STYLE_HORIZONTAL:int = 1;
        static const PARTY_LEADER:int = 1;
        static const PATH_MATRIX_SIZE:int = 221;
        static const PROFESSION_NONE:int = 0;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        static const PATH_COST_MAX:int = 250;
        private static var s_CreatureMarksView:MarksView = null;
        static const HUD_ARC_ORIENTATION_RIGHT:int = 1;
        static const PATH_MAX_STEPS:int = 128;
        static const HUD_ARC_STYLE_POINTY:int = 0;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        private static const HIGHLIGHT_MAX_OPACITY:Number = 0.8;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const HUD_ARC_TOTAL_WIDTH:Number = 10;
        static const STATE_DROWNING:int = 8;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const HUD_ARC_LOWER_LIMIT:Number = 45;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const NUM_EFFECTS:int = 200;
        static const PROFESSION_SORCERER:int = 3;
        static const COUNTER_WINDOW_SIZE:int = 50;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const PATH_SOUTH:int = 7;
        static const SUMMON_OWN:int = 1;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        public static const COLOUR_BELOW_GROUND:Colour = new Colour(255, 255, 255);
        static const PATH_NORTH_WEST:int = 4;
        private static const TILE_CURSOR_CLASS:Class = RendererImpl_TILE_CURSOR_CLASS;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        public static const STATUS_STYLE_HUD:int = 2;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const UNDERGROUND_LAYER:int = 2;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const ONSCREEN_MESSAGE_GAP:Number = 10;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const FIELD_CACHESIZE:int = 32;
        static const PATH_ERROR_UNREACHABLE:int = -4;
        static const PROFESSION_PALADIN:int = 2;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const HUD_ARC_BORDER_WIDTH:Number = 1;
        static const PATH_SOUTH_WEST:int = 6;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const PATH_NORTH_EAST:int = 2;
        static const SKILL_SOULPOINTS:int = 16;
        static const PATH_ERROR_TOO_FAR:int = -3;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const BLESSING_NONE:int = 0;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const PATH_WEST:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const SKILL_MANA:int = 5;
        static const HUD_ARC_ALPHA:Number = 0.75;
        static const STATE_MANA_SHIELD:int = 4;
        public static const STATUS_STYLE_OFF:int = 0;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const STATE_CURSED:int = 11;
        static const PATH_SOUTH_EAST:int = 8;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const NUM_FIELDS:int = 2016;
        static const PATH_EXISTS:int = 1;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static const HUD_ARC_RADIUS:Number = 75;
        static const HUD_ARC_UPPER_LIMIT:Number = -45;
        private static const HIGHLIGHT_MIN_OPACITY:Number = 0.5;
        static const STATE_POISONED:int = 0;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SKILL_LEVEL:int = 1;
        static const PATH_EAST:int = 1;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const SUMMON_NONE:int = 0;
        static const STATE_STRENGTHENED:int = 12;
        static const HUD_ARC_STYLE_RADIAL:int = 2;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
        static const SKILL_GOSTRENGTH:int = 6;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;

        public function RendererImpl()
        {
            this.m_StopwatchEnterFrame = new SlidingWindowPerformanceCounter(COUNTER_WINDOW_SIZE);
            this.m_StopwatchShowFrame = new SlidingWindowPerformanceCounter(COUNTER_WINDOW_SIZE);
            this.m_TempObjectColor = new Colour(0, 0, 0);
            this.m_TempCreatureColor = new Colour(0, 0, 0);
            this.m_TempEffectColor = new Colour(0, 0, 0);
            this.m_TempHealthColour = new Colour(0, 0, 0);
            this.m_TempManaColour = new Colour(0, 0, 0);
            this.m_TempColor = new Colour(0, 0, 0);
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            this.m_MaxZPlane = MAPSIZE_Z - 1;
            this.m_MinZPlane = new Vector.<int>(MAPSIZE_X * MAPSIZE_Y);
            this.m_Rectangle = new Rectangle(0, 0, MAPSIZE_X * FIELD_SIZE, MAPSIZE_Y * FIELD_SIZE);
            this.m_MainLayer = new BitmapData(this.m_Rectangle.width, this.m_Rectangle.height, true, 0);
            this.m_AtmosphereLayer = new BitmapData(this.m_Rectangle.width, this.m_Rectangle.height, true, 0);
            this.m_MainLayer.lock();
            this.m_AtmosphereLayer.lock();
            this.m_ClipRect = new Rectangle(0, 0, MAP_WIDTH * FIELD_SIZE, MAP_HEIGHT * FIELD_SIZE);
            this.m_Transform = new Matrix();
            var _loc_3:* = MAPSIZE_X * MAPSIZE_Y;
            this.m_CreatureField = new Vector.<Vector.<RenderAtom>>(_loc_3, true);
            this.m_CreatureCount = new Vector.<int>(_loc_3, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this.m_CreatureField[_loc_1] = new Vector.<RenderAtom>(MAPSIZE_W, true);
                _loc_2 = 0;
                while (_loc_2 < MAPSIZE_W)
                {
                    
                    this.m_CreatureField[_loc_1][_loc_2] = new RenderAtom();
                    _loc_2++;
                }
                this.m_CreatureCount[_loc_1] = 0;
                _loc_1++;
            }
            this.m_DrawnCreatures = new Vector.<RenderAtom>(_loc_3 * MAPSIZE_W, true);
            _loc_1 = 0;
            while (_loc_1 < _loc_3 * MAPSIZE_W)
            {
                
                this.m_DrawnCreatures[_loc_1] = new RenderAtom();
                _loc_1++;
            }
            this.m_DrawnCreaturesCount = 0;
            this.m_CreatureNameCache = new TextFieldCache(300, TextFieldCache.DEFAULT_HEIGHT, MAPSIZE_X * MAPSIZE_Y * 3, false);
            this.m_DrawnTextualEffects = new Vector.<RenderAtom>(NUM_EFFECTS);
            _loc_1 = 0;
            while (_loc_1 < this.m_DrawnTextualEffects.length)
            {
                
                this.m_DrawnTextualEffects[_loc_1] = new RenderAtom();
                _loc_1++;
            }
            this.m_ObjectCursor = ObjectCursor.createFromColor(OBJECT_CURSOR_COLOR, HIGHLIGHT_MIN_OPACITY, HIGHLIGHT_MAX_OPACITY, 8, 3 * FIELD_SIZE, 100);
            this.m_TileCursor = new TileCursor();
            this.m_TileCursor.bitmapData = TILE_CURSOR;
            this.m_TileCursor.frameDuration = 100;
            this.m_HelperCoordinate = new Vector3D();
            this.m_HelperPoint = new Point();
            this.m_HelperPoint2 = new Point();
            this.m_HelperTrans = new Matrix();
            this.m_HelperRect = new Rectangle();
            this.m_HelperRect2 = new Rectangle();
            this.m_HelperCreatureFlagsBitmapData = new BitmapData(3 * CreatureStorage.STATE_FLAG_SIZE + 2 * CreatureStorage.STATE_FLAG_GAP, 3 * CreatureStorage.STATE_FLAG_SIZE + 2 * CreatureStorage.STATE_FLAG_GAP);
            this.m_CreatureFlagsBitmapCache = new Dictionary();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        private function drawField(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Boolean) : void
        {
            var _loc_10:* = null;
            var _loc_12:* = 0;
            var _loc_31:* = 0;
            _loc_10 = this.m_WorldMapStorage.getField(param6, param7, param8);
            var _loc_11:* = _loc_10.m_ObjectsCount;
            _loc_12 = param7 * MAPSIZE_X + param6;
            var _loc_13:* = param8 >= this.m_MinZPlane[_loc_12] || (param6 == 0 || param8 >= this.m_MinZPlane[(_loc_12 - 1)]) || (param7 == 0 || param8 >= this.m_MinZPlane[_loc_12 - MAPSIZE_X]) || (param6 == 0 && param7 == 0 || param8 >= this.m_MinZPlane[_loc_12 - MAPSIZE_X - 1]);
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            if (param9 && _loc_11 > 0 && _loc_13)
            {
                if (_loc_10.m_CacheObjectsCount > 0)
                {
                    this.m_HelperPoint.x = param1 - FIELD_CACHESIZE;
                    this.m_HelperPoint.y = param2 - FIELD_CACHESIZE;
                    this.m_MainLayer.copyPixels(Field.s_CacheBitmap, _loc_10.m_CacheRectangle, this.m_HelperPoint, null, null, true);
                    _loc_17 = _loc_10.m_CacheObjectsHeight;
                }
                _loc_12 = _loc_10.m_CacheObjectsCount;
                while (_loc_12 < _loc_11)
                {
                    
                    var _loc_32:* = _loc_10.m_ObjectsRenderer[_loc_12];
                    _loc_14 = _loc_10.m_ObjectsRenderer[_loc_12];
                    if (_loc_32 == null || _loc_14.m_ID == AppearanceInstance.CREATURE || _loc_14.m_Type.isTop)
                    {
                        break;
                    }
                    if (this.m_OptionsLightEnabled && _loc_14.m_Type.isLight)
                    {
                        _loc_20 = (param1 - _loc_17 - _loc_14.m_Type.displacementX) / FIELD_SIZE;
                        _loc_21 = (param2 - _loc_17 - _loc_14.m_Type.displacementY) / FIELD_SIZE;
                        this.m_TempObjectColor.eightBit = _loc_14.m_Type.lightColour;
                        this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, _loc_14.m_Type.brightness, this.m_TempObjectColor);
                    }
                    _loc_14.drawTo(this.m_MainLayer, param1 - _loc_17, param2 - _loc_17, param3, param4, param5);
                    if (_loc_14 == this.m_HighlightObject)
                    {
                        this.m_ObjectCursor.drawTo(this.m_MainLayer, param1 - _loc_17, param2 - _loc_17, Tibia.s_FrameTibiaTimestamp);
                    }
                    _loc_16 = _loc_16 || _loc_14.m_Type.isLyingObject;
                    if (_loc_14.m_Type.isHangable && _loc_14.hang == AppearanceStorage.FLAG_HOOKSOUTH)
                    {
                        _loc_15 = _loc_14;
                    }
                    _loc_17 = _loc_17 + _loc_14.m_Type.elevation;
                    if (_loc_17 > FIELD_HEIGHT)
                    {
                        _loc_17 = FIELD_HEIGHT;
                    }
                    _loc_12++;
                }
                if (_loc_16 || _loc_10.m_CacheLyingObject)
                {
                    if (param6 > 0 && param7 > 0)
                    {
                        this.drawField(param1 - FIELD_SIZE, param2 - FIELD_SIZE, (param3 - 1), (param4 - 1), param5, (param6 - 1), (param7 - 1), param8, false);
                    }
                    if (param6 > 0)
                    {
                        this.drawField(param1 - FIELD_SIZE, param2, (param3 - 1), param4, param5, (param6 - 1), param7, param8, false);
                    }
                    if (param7 > 0)
                    {
                        this.drawField(param1, param2 - FIELD_SIZE, param3, (param4 - 1), param5, param6, (param7 - 1), param8, false);
                    }
                }
                if (this.m_PreviousHang != null)
                {
                    this.m_PreviousHang.drawTo(this.m_MainLayer, this.m_HangPixelX, this.m_HangPixelY, this.m_HangPatternX, this.m_HangPatternY, this.m_HangPatternZ);
                    if (this.m_PreviousHang == this.m_HighlightObject)
                    {
                        this.m_ObjectCursor.drawTo(this.m_MainLayer, this.m_HangPixelX, this.m_HangPixelY, Tibia.s_FrameTibiaTimestamp);
                    }
                    this.m_PreviousHang = null;
                }
                if (_loc_15 != null)
                {
                    this.m_PreviousHang = _loc_15;
                    this.m_HangPixelX = param1;
                    this.m_HangPixelY = param2;
                    this.m_HangPatternX = param3;
                    this.m_HangPatternY = param4;
                    this.m_HangPatternZ = param5;
                }
            }
            var _loc_22:* = null;
            var _loc_23:* = this.m_CreatureField[param7 * MAPSIZE_X + param6];
            var _loc_24:* = this.m_CreatureCount[param7 * MAPSIZE_X + param6];
            var _loc_25:* = null;
            var _loc_26:* = null;
            _loc_12 = 0;
            while (_loc_12 < _loc_24)
            {
                
                var _loc_32:* = _loc_23[_loc_12];
                _loc_22 = _loc_23[_loc_12];
                var _loc_32:* = _loc_22.object as Creature;
                _loc_26 = _loc_22.object as Creature;
                if (_loc_32 == null || _loc_32 == null || _loc_26.outfit == null)
                {
                }
                else
                {
                    if (param9)
                    {
                        _loc_22.x = _loc_22.x - _loc_17;
                        _loc_22.y = _loc_22.y - _loc_17;
                    }
                    this.m_HelperPoint.x = _loc_22.x - FIELD_SIZE;
                    this.m_HelperPoint.y = _loc_22.y - FIELD_SIZE;
                    _loc_25 = s_CreatureMarksView.getMarksBitmap(_loc_26.marks, this.m_HelperRect);
                    this.m_MainLayer.copyPixels(_loc_25, this.m_HelperRect, this.m_HelperPoint, null, null, true);
                    _loc_18 = 0;
                    _loc_19 = 0;
                    if (_loc_13 && _loc_26.mountOutfit != null)
                    {
                        _loc_18 = _loc_26.mountOutfit.m_Type.displacementX;
                        _loc_19 = _loc_26.mountOutfit.m_Type.displacementY;
                        _loc_26.mountOutfit.drawTo(this.m_MainLayer, _loc_22.x + _loc_18, _loc_22.y + _loc_19, _loc_26.direction, 0, 0);
                    }
                    if (_loc_13)
                    {
                        _loc_18 = _loc_18 + _loc_26.outfit.m_Type.displacementX;
                        _loc_19 = _loc_19 + _loc_26.outfit.m_Type.displacementY;
                        _loc_26.outfit.drawTo(this.m_MainLayer, _loc_22.x + _loc_18, _loc_22.y + _loc_19, _loc_26.direction, 0, _loc_26.mountOutfit != null ? (1) : (0));
                    }
                    if (_loc_13 && this.m_HighlightObject != null && (this.m_HighlightObject is ObjectInstance && _loc_26.ID == ObjectInstance(this.m_HighlightObject).data || this.m_HighlightObject is Creature && _loc_26 == this.m_HighlightObject))
                    {
                        this.m_ObjectCursor.drawTo(this.m_MainLayer, _loc_22.x + _loc_18, _loc_22.y + _loc_19, Tibia.s_FrameTibiaTimestamp);
                    }
                    if (param8 == this.m_PlayerZPlane && (this.m_CreatureStorage.isOpponent(_loc_26) || _loc_26.ID == this.m_Player.ID))
                    {
                        this.m_DrawnCreatures[this.m_DrawnCreaturesCount].assign(_loc_22);
                        var _loc_32:* = this;
                        var _loc_33:* = this.m_DrawnCreaturesCount + 1;
                        _loc_32.m_DrawnCreaturesCount = _loc_33;
                    }
                    if (_loc_13 && param9 && this.m_OptionsLightEnabled)
                    {
                        _loc_20 = _loc_22.x / FIELD_SIZE;
                        _loc_21 = _loc_22.y / FIELD_SIZE;
                        this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, _loc_26.brightness, _loc_26.lightColour);
                        if (_loc_26.mountOutfit != null && _loc_26.mountOutfit.m_Type.isLight)
                        {
                            this.m_TempCreatureColor.eightBit = _loc_26.mountOutfit.m_Type.lightColour;
                            this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, _loc_26.mountOutfit.m_Type.brightness, this.m_TempCreatureColor);
                        }
                        if (_loc_26.outfit.m_Type.isLight)
                        {
                            this.m_TempCreatureColor.eightBit = _loc_26.outfit.m_Type.lightColour;
                            this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, _loc_26.outfit.m_Type.brightness, this.m_TempCreatureColor);
                        }
                        if (_loc_26.ID == this.m_Player.ID && _loc_26.brightness < 2)
                        {
                            this.m_TempCreatureColor.setChannels(255, 255, 255);
                            this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, 2, this.m_TempCreatureColor);
                        }
                    }
                }
                _loc_12++;
            }
            var _loc_27:* = _loc_10.m_EffectsCount;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = 0;
            _loc_18 = param1 - _loc_17;
            _loc_19 = param2 - _loc_17;
            _loc_20 = _loc_18 / FIELD_SIZE;
            _loc_21 = _loc_19 / FIELD_SIZE;
            _loc_12 = _loc_10.m_EffectsCount - 1;
            while (_loc_12 >= 0)
            {
                
                var _loc_32:* = _loc_10.m_Effects[_loc_12];
                _loc_28 = _loc_10.m_Effects[_loc_12];
                if (_loc_32 == null)
                {
                }
                else if (_loc_28 is TextualEffectInstance)
                {
                    if (param9)
                    {
                        _loc_22 = this.m_DrawnTextualEffects[this.m_DrawnTextualEffectsCount];
                        _loc_22.update(_loc_28, _loc_18 - FIELD_SIZE / 2 + _loc_29, _loc_19 - FIELD_SIZE - 2 * _loc_28.phase, 0);
                        if (_loc_22.y + TextualEffectInstance(_loc_28).height > _loc_30)
                        {
                            _loc_29 = _loc_29 + TextualEffectInstance(_loc_28).width;
                        }
                        if (_loc_29 < 2 * FIELD_SIZE)
                        {
                            var _loc_32:* = this;
                            var _loc_33:* = this.m_DrawnTextualEffectsCount + 1;
                            _loc_32.m_DrawnTextualEffectsCount = _loc_33;
                            _loc_30 = _loc_22.y;
                        }
                    }
                }
                else if (_loc_28 is MissileInstance)
                {
                    _loc_28.drawTo(this.m_MainLayer, _loc_18 + MissileInstance(_loc_28).animationDelta.x, _loc_19 + MissileInstance(_loc_28).animationDelta.y, param3, param4, param5);
                    if (param9 && this.m_OptionsLightEnabled && _loc_28.m_Type.isLight)
                    {
                        this.m_TempEffectColor.eightBit = _loc_28.m_Type.lightColour;
                        this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, _loc_28.m_Type.brightness, this.m_TempEffectColor);
                    }
                }
                else
                {
                    _loc_28.drawTo(this.m_MainLayer, _loc_18, _loc_19, param3, param4, param5);
                    if (param9 && this.m_OptionsLightEnabled && _loc_28.m_Type.isLight)
                    {
                        _loc_31 = int((Math.min(_loc_28.phase, (_loc_28.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].phases + 1) - _loc_28.phase) * _loc_28.m_Type.brightness + 2) / 3);
                        this.m_TempEffectColor.eightBit = _loc_28.m_Type.lightColour;
                        this.m_TiledLightmapRenderer.setLightSource(_loc_20, _loc_21, param8, Math.min(_loc_31, _loc_28.m_Type.brightness), this.m_TempEffectColor);
                    }
                }
                _loc_12 = _loc_12 - 1;
            }
            if (_loc_10.m_Environment != null)
            {
                if (_loc_10.m_Environment.data == 1)
                {
                    if (param9)
                    {
                        _loc_10.m_Environment.drawTo(this.m_AtmosphereLayer, param1, param2, param3, param4, param5);
                    }
                }
                else
                {
                    _loc_10.m_Environment.drawTo(this.m_MainLayer, param1, param2, param3, param4, param5);
                }
            }
            var _loc_32:* = _loc_10.m_ObjectsRenderer[(_loc_11 - 1)];
            _loc_14 = _loc_10.m_ObjectsRenderer[(_loc_11 - 1)];
            if (param9 && _loc_11 > 0 && _loc_32 != null && _loc_14.m_Type.isTop)
            {
                _loc_14.drawTo(this.m_MainLayer, param1, param2, param3, param4, param5);
                if (_loc_14 == this.m_HighlightObject)
                {
                    this.m_ObjectCursor.drawTo(this.m_MainLayer, param1, param2, Tibia.s_FrameTibiaTimestamp);
                }
            }
            return;
        }// end function

        public function get highlightObject()
        {
            return this.m_HighlightObject;
        }// end function

        public function set highlightObject(param1) : void
        {
            this.m_HighlightObject = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function set highlightTile(param1:Vector3D) : void
        {
            this.m_HighlightTile = param1;
            invalidateDisplayList();
            return;
        }// end function

        function pointToMap(param1:Number, param2:Number, param3:Boolean, param4:Vector3D = null) : Vector3D
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            if (this.m_WorldMapStorage != null && (!param3 || this.m_Player != null))
            {
                _loc_5 = int((param1 - this.m_Transform.tx) / this.m_Transform.a / FIELD_SIZE);
                if (_loc_5 < 1 || _loc_5 > MAPSIZE_X - 3)
                {
                    return null;
                }
                _loc_6 = int((param2 - this.m_Transform.ty) / this.m_Transform.d / FIELD_SIZE);
                if (_loc_6 < 1 || _loc_6 > MAPSIZE_Y - 3)
                {
                    return null;
                }
                _loc_7 = -1;
                if (param3)
                {
                    this.m_WorldMapStorage.toMap(this.m_Player.position, this.m_HelperCoordinate);
                    _loc_7 = this.m_HelperCoordinate.z;
                }
                else
                {
                    _loc_8 = this.m_MinZPlane[_loc_6 * MAPSIZE_X + _loc_5];
                    _loc_7 = this.m_MaxZPlane;
                    while (_loc_7 >= _loc_8)
                    {
                        
                        _loc_9 = this.m_WorldMapStorage.getField(_loc_5, _loc_6, _loc_7);
                        _loc_10 = 0;
                        _loc_11 = _loc_9.m_ObjectsCount;
                        while (_loc_10 < _loc_11)
                        {
                            
                            _loc_12 = _loc_9.m_ObjectsRenderer[_loc_10].m_Type;
                            if ((_loc_12.isBank || _loc_12.isBottom) && !_loc_12.isIgnoreLook)
                            {
                                _loc_8 = -1;
                                break;
                            }
                            _loc_10++;
                        }
                        if (_loc_8 < 0)
                        {
                            break;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                }
                if (_loc_7 < 0 || _loc_7 >= MAPSIZE_Z)
                {
                    return null;
                }
                if (param4 == null)
                {
                    param4 = new Vector3D(_loc_5, _loc_6, _loc_7);
                }
                else
                {
                    param4.setComponents(_loc_5, _loc_6, _loc_7);
                }
                return param4;
            }
            return null;
        }// end function

        private function drawHUDArc(param1:Number, param2:Number, param3:int, param4:int, param5:uint) : void
        {
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            param3 = Math.max(HUD_ARC_ORIENTATION_LEFT, Math.min(param3, HUD_ARC_ORIENTATION_RIGHT));
            param4 = Math.max(0, Math.min(param4, 100));
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (this.m_HUDArcPoints == null || this.m_HUDArcScale != this.m_Transform.a)
            {
                this.m_HUDArcPoints = new Vector.<Number>(2 * 202, true);
                this.m_HUDArcScale = this.m_Transform.a;
                _loc_6 = 0;
                _loc_7 = 201;
                while (_loc_6 <= 100)
                {
                    
                    _loc_12 = (HUD_ARC_LOWER_LIMIT - _loc_6 / 100 * (HUD_ARC_LOWER_LIMIT - HUD_ARC_UPPER_LIMIT)) * (Math.PI / 180);
                    _loc_13 = Point.polar(this.m_HUDArcScale * HUD_ARC_RADIUS, _loc_12);
                    this.m_HUDArcPoints[2 * _loc_6 + 0] = _loc_13.x;
                    this.m_HUDArcPoints[2 * _loc_6 + 1] = _loc_13.y;
                    switch(this.m_HUDArcStyle)
                    {
                        case HUD_ARC_STYLE_POINTY:
                        {
                            this.m_HUDArcPoints[2 * _loc_7 + 0] = _loc_13.x + (-0.0004 * _loc_6 * _loc_6 + 0.04 * _loc_6) * this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH;
                            this.m_HUDArcPoints[2 * _loc_7 + 1] = _loc_13.y;
                            break;
                        }
                        case HUD_ARC_STYLE_HORIZONTAL:
                        {
                            this.m_HUDArcPoints[2 * _loc_7 + 0] = _loc_13.x + this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH;
                            this.m_HUDArcPoints[2 * _loc_7 + 1] = _loc_13.y;
                            break;
                        }
                        case HUD_ARC_STYLE_RADIAL:
                        {
                            _loc_13 = Point.polar(this.m_Transform.a * HUD_ARC_RADIUS + this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH, _loc_12);
                            this.m_HUDArcPoints[2 * _loc_7 + 0] = _loc_13.x;
                            this.m_HUDArcPoints[2 * _loc_7 + 1] = _loc_13.y;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_6++;
                    _loc_7 = _loc_7 - 1;
                }
            }
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (param3 == HUD_ARC_ORIENTATION_LEFT)
            {
                _loc_9 = -1;
                param1 = param1 + Math.sin(HUD_ARC_LOWER_LIMIT * (Math.PI / 180)) * this.m_HUDArcScale * HUD_ARC_RADIUS;
            }
            else
            {
                _loc_9 = 1;
                param1 = param1 - Math.sin(HUD_ARC_LOWER_LIMIT * (Math.PI / 180)) * this.m_HUDArcScale * HUD_ARC_RADIUS;
            }
            if (param4 < 100)
            {
                _loc_8 = 2 * (100 - param4 + 1);
                _loc_10 = new Vector.<Number>(2 * (_loc_8 + 1), true);
                _loc_6 = 0;
                _loc_7 = param4;
                while (_loc_6 < _loc_8)
                {
                    
                    _loc_10[2 * _loc_6 + 0] = param1 + _loc_9 * this.m_HUDArcPoints[2 * _loc_7 + 0];
                    _loc_10[2 * _loc_6 + 1] = param2 + this.m_HUDArcPoints[2 * _loc_7 + 1];
                    _loc_6++;
                    _loc_7++;
                }
                _loc_10[2 * _loc_6 + 0] = _loc_10[0];
                _loc_10[2 * _loc_6 + 1] = _loc_10[1];
                _loc_11 = new Vector.<int>((_loc_8 + 1), true);
                _loc_11[0] = GraphicsPathCommand.MOVE_TO;
                _loc_6 = 0;
                while (_loc_6 < _loc_8)
                {
                    
                    _loc_11[(_loc_6 + 1)] = GraphicsPathCommand.LINE_TO;
                    _loc_6++;
                }
                graphics.lineStyle(NaN, 0, NaN);
                graphics.beginFill(0, 0.33 * HUD_ARC_ALPHA);
                graphics.drawPath(_loc_11, _loc_10);
            }
            if (param4 > 0)
            {
                _loc_8 = 2 * (param4 + 1);
                _loc_10 = new Vector.<Number>(2 * (_loc_8 + 1), true);
                _loc_6 = 0;
                _loc_7 = 0;
                while (_loc_6 < (param4 + 1))
                {
                    
                    _loc_10[2 * _loc_6 + 0] = param1 + _loc_9 * this.m_HUDArcPoints[2 * _loc_7 + 0];
                    _loc_10[2 * _loc_6 + 1] = param2 + this.m_HUDArcPoints[2 * _loc_7 + 1];
                    _loc_6++;
                    _loc_7++;
                }
                _loc_6 = param4 + 1;
                _loc_7 = 202 - _loc_6;
                while (_loc_6 < _loc_8)
                {
                    
                    _loc_10[2 * _loc_6 + 0] = param1 + _loc_9 * this.m_HUDArcPoints[2 * _loc_7 + 0];
                    _loc_10[2 * _loc_6 + 1] = param2 + this.m_HUDArcPoints[2 * _loc_7 + 1];
                    _loc_6++;
                    _loc_7++;
                }
                _loc_10[2 * _loc_6 + 0] = _loc_10[0];
                _loc_10[2 * _loc_6 + 1] = _loc_10[1];
                _loc_11 = new Vector.<int>((_loc_8 + 1), true);
                _loc_11[0] = GraphicsPathCommand.MOVE_TO;
                _loc_6 = 0;
                while (_loc_6 < _loc_8)
                {
                    
                    _loc_11[(_loc_6 + 1)] = GraphicsPathCommand.LINE_TO;
                    _loc_6++;
                }
                graphics.lineStyle(NaN, 0, NaN);
                graphics.beginFill(param5, HUD_ARC_ALPHA);
                graphics.drawPath(_loc_11, _loc_10);
            }
            _loc_8 = 2 * (100 + 1);
            _loc_10 = new Vector.<Number>(2 * (_loc_8 + 1), true);
            _loc_6 = 0;
            _loc_7 = 0;
            while (_loc_6 < _loc_8)
            {
                
                _loc_10[2 * _loc_6 + 0] = param1 + _loc_9 * this.m_HUDArcPoints[2 * _loc_7 + 0];
                _loc_10[2 * _loc_6 + 1] = param2 + this.m_HUDArcPoints[2 * _loc_7 + 1];
                _loc_6++;
                _loc_7++;
            }
            _loc_10[2 * _loc_6 + 0] = _loc_10[0];
            _loc_10[2 * _loc_6 + 1] = _loc_10[1];
            _loc_11 = new Vector.<int>((_loc_8 + 1), true);
            _loc_11[0] = GraphicsPathCommand.MOVE_TO;
            _loc_6 = 0;
            while (_loc_6 < _loc_8)
            {
                
                _loc_11[(_loc_6 + 1)] = GraphicsPathCommand.LINE_TO;
                _loc_6++;
            }
            graphics.lineStyle(HUD_ARC_BORDER_WIDTH, 0, 1);
            graphics.beginFill(0, NaN);
            graphics.drawPath(_loc_11, _loc_10);
            graphics.lineStyle(NaN, 0, NaN);
            graphics.beginFill(0, NaN);
            graphics.endFill();
            return;
        }// end function

        public function get creatureStorage() : CreatureStorage
        {
            return this.m_CreatureStorage;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_UncommittedOptions = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function reset() : void
        {
            this.m_StopwatchEnterFrame.reset();
            this.m_StopwatchShowFrame.reset();
            return;
        }// end function

        private function drawCreatureStatusHUD(param1:Creature, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void
        {
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_9:* = param1.ID == this.m_Player.ID;
            if (param4)
            {
                this.m_TempHealthColour.ARGB = Creature.s_GetHealthColourARGB(param1.hitpointsPercent);
                this.m_TempManaColour.setChannels(0, 0, 255);
            }
            else
            {
                this.m_TempHealthColour.setChannels(192, 192, 192);
                this.m_TempManaColour.setChannels(192, 192, 192);
            }
            if (this.m_OptionsLightEnabled)
            {
                _loc_12 = this.m_TiledLightmapRenderer.calculateCreatureHudBrightnessFactor(param1, _loc_9);
                this.m_TempHealthColour.mulFloatToSelf(_loc_12, false);
                this.m_TempManaColour.mulFloatToSelf(_loc_12, false);
            }
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (param1.mountOutfit != null)
            {
                _loc_10 = param2 - param1.mountOutfit.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize / 2;
                _loc_11 = param3 - param1.mountOutfit.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize / 2;
            }
            else if (param1.outfit != null)
            {
                _loc_10 = param2 - param1.outfit.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize / 2;
                _loc_11 = param3 - param1.outfit.m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize / 2;
            }
            if ((_loc_9 || param4) && param6)
            {
                this.m_HelperPoint.x = _loc_10 - 3 * FIELD_SIZE / 2;
                this.m_HelperPoint.y = _loc_11;
                this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
                this.drawHUDArc(this.m_HelperPoint.x, this.m_HelperPoint.y, HUD_ARC_ORIENTATION_LEFT, param1.hitpointsPercent, this.m_TempHealthColour.RGB);
            }
            if ((_loc_9 || param4) && param7)
            {
                this.m_HelperPoint.x = _loc_10 + 3 * FIELD_SIZE / 2;
                this.m_HelperPoint.y = _loc_11;
                this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
                this.drawHUDArc(this.m_HelperPoint.x, this.m_HelperPoint.y, HUD_ARC_ORIENTATION_RIGHT, param1.manaPercent, this.m_TempManaColour.RGB);
            }
            if (param5)
            {
                _loc_13 = this.m_CreatureNameCache.getItem(param1.name + this.m_TempHealthColour.toString(), param1.name, this.m_TempHealthColour.RGB);
                this.m_HelperPoint.x = param2 - FIELD_SIZE / 2;
                this.m_HelperPoint.y = param3 - FIELD_SIZE;
                this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
                this.m_HelperPoint.x = Math.max(0, Math.min(this.m_HelperPoint.x - _loc_13.width / 2, unscaledWidth - _loc_13.width));
                this.m_HelperPoint.y = Math.max(0, Math.min(this.m_HelperPoint.y - _loc_13.height, unscaledHeight - _loc_13.height));
                this.m_HelperTrans.tx = this.m_HelperPoint.x - _loc_13.x;
                this.m_HelperTrans.ty = this.m_HelperPoint.y - _loc_13.y;
                graphics.beginBitmapFill(this.m_CreatureNameCache, this.m_HelperTrans, false, false);
                graphics.drawRect(this.m_HelperPoint.x, this.m_HelperPoint.y, _loc_13.width, _loc_13.height);
                graphics.endFill();
            }
            if (param8)
            {
                this.drawCreatureFlags(param1, param2 - FIELD_SIZE / 2, param3 - FIELD_SIZE, param4);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredMinWidth = RENDERER_MIN_WIDTH;
            measuredMinHeight = RENDERER_MIN_HEIGHT;
            measuredWidth = RENDERER_DEFAULT_WIDTH;
            measuredHeight = RENDERER_DEFAULT_HEIGHT;
            return;
        }// end function

        public function set worldMapStorage(param1:WorldMapStorage) : void
        {
            if (this.m_WorldMapStorage != param1)
            {
                this.m_WorldMapStorage = param1;
                this.m_UncommittedWorldMapStorage = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function drawCreatureStatusClassic(param1:Creature, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean) : void
        {
            var _loc_14:* = NaN;
            var _loc_10:* = param1.ID == this.m_Player.ID;
            if (param4)
            {
                this.m_TempHealthColour.ARGB = Creature.s_GetHealthColourARGB(param1.hitpointsPercent);
                this.m_TempManaColour.setChannels(0, 0, 255);
            }
            else
            {
                this.m_TempHealthColour.setChannels(192, 192, 192);
                this.m_TempManaColour.setChannels(192, 192, 192);
            }
            if (this.m_OptionsLightEnabled)
            {
                _loc_14 = this.m_TiledLightmapRenderer.calculateCreatureHudBrightnessFactor(param1, _loc_10);
                this.m_TempHealthColour.mulFloatToSelf(_loc_14, false);
                this.m_TempManaColour.mulFloatToSelf(_loc_14, false);
            }
            var _loc_11:* = 0;
            var _loc_12:* = -1;
            var _loc_13:* = null;
            if (param5)
            {
                _loc_13 = this.m_CreatureNameCache.getItem(param1.name + this.m_TempHealthColour.toString(), param1.name, this.m_TempHealthColour.RGB);
                _loc_12 = _loc_12 + (_loc_13.height + 1);
            }
            if (param6)
            {
                _loc_12 = _loc_12 + (4 + 1);
            }
            if (param7)
            {
                _loc_12 = _loc_12 + (4 + 1);
            }
            this.m_HelperPoint.x = param2 - FIELD_SIZE / 2;
            this.m_HelperPoint.y = param3 - FIELD_SIZE;
            this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
            this.m_HelperPoint.y = Math.max(0, Math.min(this.m_HelperPoint.y - _loc_12, unscaledHeight - _loc_12));
            if (param5)
            {
                _loc_11 = Math.max(1, Math.min(this.m_HelperPoint.x - _loc_13.width / 2, unscaledWidth - _loc_13.width - 1));
                _loc_12 = this.m_HelperPoint.y;
                this.m_HelperTrans.tx = _loc_11 - _loc_13.x;
                this.m_HelperTrans.ty = _loc_12 - _loc_13.y;
                graphics.beginBitmapFill(this.m_CreatureNameCache, this.m_HelperTrans, false, false);
                graphics.drawRect(_loc_11, _loc_12, _loc_13.width, _loc_13.height);
                this.m_HelperPoint.y = this.m_HelperPoint.y + (_loc_13.height + 1);
            }
            if (param6)
            {
                _loc_11 = Math.max(1, Math.min(this.m_HelperPoint.x - 14, unscaledWidth - 27 - 1));
                _loc_12 = this.m_HelperPoint.y;
                graphics.beginFill(0, 1);
                graphics.drawRect(_loc_11, _loc_12, 27, 4);
                graphics.beginFill(this.m_TempHealthColour.RGB, 1);
                graphics.drawRect((_loc_11 + 1), (_loc_12 + 1), param1.hitpointsPercent / 4, 2);
                this.m_HelperPoint.y = this.m_HelperPoint.y + (4 + 1);
            }
            if (param7)
            {
                _loc_11 = Math.max(1, Math.min(this.m_HelperPoint.x - 14, unscaledWidth - 27 - 1));
                _loc_12 = this.m_HelperPoint.y;
                graphics.beginFill(0, 1);
                graphics.drawRect(_loc_11, _loc_12, 27, 4);
                graphics.beginFill(this.m_TempManaColour.RGB, 1);
                graphics.drawRect((_loc_11 + 1), (_loc_12 + 1), param1.manaPercent / 4, 2);
                this.m_HelperPoint.y = this.m_HelperPoint.y + (4 + 1);
            }
            if (param8 && !param1.isNPC || param9 && param1.isNPC)
            {
                this.drawCreatureFlags(param1, param2 - FIELD_SIZE / 2, param3 - FIELD_SIZE, param4);
            }
            graphics.endFill();
            return;
        }// end function

        function absoluteToRect(param1:Vector3D) : Rectangle
        {
            var _loc_2:* = new Rectangle();
            param1.z = this.m_Player.position.z;
            var _loc_3:* = this.m_WorldMapStorage.toMap(param1);
            var _loc_4:* = _loc_3.x * FIELD_SIZE * this.m_Transform.a + this.m_Transform.tx;
            var _loc_5:* = _loc_3.y * FIELD_SIZE * this.m_Transform.d + this.m_Transform.ty;
            _loc_2.setTo(_loc_4, _loc_5, FIELD_SIZE * this.m_Transform.a, FIELD_SIZE * this.m_Transform.d);
            return _loc_2;
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            switch(event.property)
            {
                case "rendererAmbientBrightness":
                case "rendererHighlight":
                case "rendererLevelSeparator":
                case "rendererLightEnabled":
                case "rendererMaxFrameRate":
                case "rendererScaleMap":
                case "*":
                {
                    invalidateDisplayList();
                    this.updateOptions();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function drawCreatureStatus() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = false;
            var _loc_1:* = null;
            var _loc_2:* = -1;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this.m_DrawnCreaturesCount)
            {
                
                _loc_1 = this.m_DrawnCreatures[_loc_4].object as Creature;
                if (_loc_1 == null)
                {
                }
                else if (_loc_1 == this.m_Player)
                {
                    _loc_2 = _loc_4;
                }
                else
                {
                    _loc_5 = int(this.m_DrawnCreatures[_loc_4].x / FIELD_SIZE);
                    _loc_6 = int(this.m_DrawnCreatures[_loc_4].y / FIELD_SIZE);
                    _loc_7 = this.m_DrawnCreatures[_loc_4].z >= this.m_MinZPlane[_loc_6 * MAPSIZE_X + _loc_5];
                    _loc_3 = this.m_Options != null ? (this.m_Options.statusCreatureStyle) : (STATUS_STYLE_OFF);
                    switch(_loc_3)
                    {
                        case STATUS_STYLE_OFF:
                        {
                            break;
                        }
                        case STATUS_STYLE_HUD:
                        {
                            this.drawCreatureStatusHUD(_loc_1, this.m_DrawnCreatures[_loc_4].x, this.m_DrawnCreatures[_loc_4].y, _loc_7, this.m_Options.statusCreatureName, this.m_Options.statusCreatureHealth && !_loc_1.isNPC, false, this.m_Options.statusCreatureFlags);
                            break;
                        }
                        case STATUS_STYLE_CLASSIC:
                        {
                            this.drawCreatureStatusClassic(_loc_1, this.m_DrawnCreatures[_loc_4].x, this.m_DrawnCreatures[_loc_4].y, _loc_7, this.m_Options.statusCreatureName, this.m_Options.statusCreatureHealth && !_loc_1.isNPC, false, this.m_Options.statusCreatureFlags, this.m_Options.statusCreatureIcons);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                _loc_4++;
            }
            if (_loc_2 > -1)
            {
                _loc_1 = this.m_DrawnCreatures[_loc_2].object as Creature;
                _loc_3 = this.m_Options != null ? (this.m_Options.statusPlayerStyle) : (STATUS_STYLE_OFF);
                switch(_loc_3)
                {
                    case STATUS_STYLE_OFF:
                    {
                        break;
                    }
                    case STATUS_STYLE_HUD:
                    {
                        this.drawCreatureStatusHUD(_loc_1, this.m_DrawnCreatures[_loc_2].x, this.m_DrawnCreatures[_loc_2].y, true, this.m_Options.statusPlayerName, this.m_Options.statusPlayerHealth, this.m_Options.statusPlayerMana, this.m_Options.statusPlayerFlags);
                        break;
                    }
                    case STATUS_STYLE_CLASSIC:
                    {
                        this.drawCreatureStatusClassic(_loc_1, this.m_DrawnCreatures[_loc_2].x, this.m_DrawnCreatures[_loc_2].y, true, this.m_Options.statusPlayerName, this.m_Options.statusPlayerHealth, this.m_Options.statusPlayerMana, this.m_Options.statusPlayerFlags, false);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function set creatureStorage(param1:CreatureStorage) : void
        {
            if (this.m_CreatureStorage != param1)
            {
                this.m_CreatureStorage = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        function pointToCreature(param1:Number, param2:Number, param3:Boolean) : Creature
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (this.m_WorldMapStorage != null && (!param3 || this.m_Player != null))
            {
                _loc_4 = int(param1 - this.m_Transform.tx) / this.m_Transform.a;
                _loc_5 = int(param2 - this.m_Transform.ty) / this.m_Transform.d;
                _loc_6 = this.m_MinZPlane[int(_loc_5 / FIELD_SIZE) * MAPSIZE_X + int(_loc_4 / FIELD_SIZE)];
                if (param3)
                {
                    this.m_WorldMapStorage.toMap(this.m_Player.position, this.m_HelperCoordinate);
                    _loc_6 = this.m_HelperCoordinate.z;
                }
                _loc_7 = 0;
                while (_loc_7 < this.m_DrawnCreaturesCount)
                {
                    
                    if (this.m_DrawnCreatures[_loc_7] != null)
                    {
                        _loc_8 = this.m_DrawnCreatures[_loc_7].x - FIELD_SIZE / 2;
                        _loc_9 = this.m_DrawnCreatures[_loc_7].y - FIELD_SIZE / 2;
                        if (Math.abs(_loc_8 - _loc_4) > FIELD_SIZE / 2 || Math.abs(_loc_9 - _loc_5) > FIELD_SIZE / 2)
                        {
                        }
                        else
                        {
                            _loc_10 = Creature(this.m_DrawnCreatures[_loc_7].object);
                            if (_loc_10 == null)
                            {
                            }
                            else
                            {
                                _loc_11 = _loc_10.position;
                                if (!this.m_WorldMapStorage.isVisible(_loc_11.x, _loc_11.y, _loc_11.z, true))
                                {
                                }
                                else
                                {
                                    _loc_12 = this.m_WorldMapStorage.toMap(_loc_11);
                                    if (_loc_12.z < _loc_6)
                                    {
                                    }
                                    else
                                    {
                                        return _loc_10;
                                    }
                                }
                            }
                        }
                    }
                    _loc_7++;
                }
            }
            return null;
        }// end function

        public function get highlightTile() : Vector3D
        {
            return this.m_HighlightTile;
        }// end function

        private function updateOptions() : void
        {
            var _loc_1:* = NaN;
            if (this.options != null)
            {
                this.m_OptionsAmbientBrightness = this.options.rendererAmbientBrightness;
                this.m_OptionsFrameRate = this.options.rendererMaxFrameRate;
                this.m_OptionsHighlight = this.options.rendererHighlight;
                this.m_OptionsLevelSeparator = this.options.rendererLevelSeparator;
                this.m_OptionsLightEnabled = this.options.rendererLightEnabled;
                this.m_OptionsScaleMap = this.options.rendererScaleMap;
                this.m_OptionsAntialiasing = this.options.rendererAntialiasing;
                s_InitialiseMarksViews(this.options.statusCreaturePvpFrames);
            }
            else
            {
                this.m_OptionsAmbientBrightness = NaN;
                this.m_OptionsFrameRate = NaN;
                this.m_OptionsHighlight = NaN;
                this.m_OptionsLevelSeparator = NaN;
                this.m_OptionsLightEnabled = false;
                this.m_OptionsScaleMap = true;
                this.m_OptionsAntialiasing = false;
                s_InitialiseMarksViews(true);
            }
            if (stage != null && !isNaN(this.m_OptionsFrameRate))
            {
                stage.frameRate = this.m_OptionsFrameRate;
            }
            if (!isNaN(this.m_OptionsHighlight))
            {
                _loc_1 = this.m_OptionsHighlight * HIGHLIGHT_MAX_OPACITY + (1 - this.m_OptionsHighlight) * HIGHLIGHT_MIN_OPACITY;
                this.m_ObjectCursor.opacity = _loc_1;
                this.m_TileCursor.opacity = _loc_1;
            }
            else
            {
                this.m_ObjectCursor.opacity = HIGHLIGHT_MIN_OPACITY;
                this.m_TileCursor.opacity = HIGHLIGHT_MIN_OPACITY;
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.initialize3DObjects();
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function get worldMapStorage() : WorldMapStorage
        {
            return this.m_WorldMapStorage;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            invalidateDisplayList();
            return;
        }// end function

        private function layoutOnscreenMessages() : void
        {
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = this.m_WorldMapStorage.m_MessageBoxes;
            _loc_1 = _loc_3.length - 1;
            while (_loc_1 >= 0)
            {
                
                if (_loc_3[_loc_1] != null && _loc_3[_loc_1].visible && !_loc_3[_loc_1].empty)
                {
                    _loc_3[_loc_1].arrangeMessages();
                }
                _loc_1 = _loc_1 - 1;
            }
            var _loc_4:* = new Rectangle(0, 0, FIELD_SIZE * this.m_Transform.a, FIELD_SIZE * this.m_Transform.a);
            var _loc_5:* = new Vector.<Rectangle>(_loc_3.length, true);
            var _loc_6:* = new Vector.<Rectangle>(_loc_3.length, true);
            var _loc_7:* = new Vector.<Point>(_loc_3.length, true);
            _loc_1 = _loc_3.length - 1;
            while (_loc_1 >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
            {
                
                if (_loc_3[_loc_1] != null && _loc_3[_loc_1].visible && !_loc_3[_loc_1].empty)
                {
                    switch(_loc_1)
                    {
                        case WorldMapStorage.ONSCREEN_TARGET_BOX_LOW:
                        {
                            _loc_3[_loc_1].fixing = OnscreenMessageBox.FIXING_BOTH;
                            this.m_HelperPoint.x = unscaledWidth / 2;
                            this.m_HelperPoint.y = (unscaledHeight + _loc_4.height + _loc_3[_loc_1].height + ONSCREEN_MESSAGE_GAP) / 2;
                            break;
                        }
                        case WorldMapStorage.ONSCREEN_TARGET_BOX_HIGH:
                        {
                            _loc_3[_loc_1].fixing = OnscreenMessageBox.FIXING_BOTH;
                            this.m_HelperPoint.x = unscaledWidth / 2;
                            this.m_HelperPoint.y = (unscaledHeight + _loc_4.height - _loc_3[_loc_1].height - ONSCREEN_MESSAGE_GAP) / 2;
                            break;
                        }
                        case WorldMapStorage.ONSCREEN_TARGET_BOX_TOP:
                        {
                            _loc_3[_loc_1].fixing = OnscreenMessageBox.FIXING_BOTH;
                            this.m_HelperPoint.x = unscaledWidth / 2;
                            this.m_HelperPoint.y = unscaledHeight / 4;
                            break;
                        }
                        default:
                        {
                            _loc_3[_loc_1].fixing = OnscreenMessageBox.FIXING_NONE;
                            this.m_WorldMapStorage.toMapClosest(_loc_3[_loc_1].position, this.m_HelperCoordinate);
                            this.m_HelperPoint.x = (this.m_HelperCoordinate.x - 1) * _loc_4.width + _loc_4.width / 2;
                            this.m_HelperPoint.y = (this.m_HelperCoordinate.y - 1) * _loc_4.height - _loc_3[_loc_1].height / 2;
                            if (!this.m_OptionsScaleMap)
                            {
                                this.m_HelperPoint.x = this.m_HelperPoint.x - Math.max(0, MAP_WIDTH * FIELD_SIZE - unscaledWidth) / 2;
                                this.m_HelperPoint.y = this.m_HelperPoint.y - Math.max(0, MAP_HEIGHT * FIELD_SIZE - unscaledHeight) / 2;
                            }
                            break;
                            break;
                        }
                    }
                    _loc_7[_loc_1] = new Point();
                    _loc_5[_loc_1] = new Rectangle();
                    _loc_5[_loc_1].x = this.m_HelperPoint.x - (_loc_3[_loc_1].width + ONSCREEN_MESSAGE_GAP) / 2;
                    _loc_5[_loc_1].y = this.m_HelperPoint.y - (_loc_3[_loc_1].height + ONSCREEN_MESSAGE_GAP) / 2;
                    _loc_5[_loc_1].width = _loc_3[_loc_1].width + ONSCREEN_MESSAGE_GAP;
                    _loc_5[_loc_1].height = _loc_3[_loc_1].height + ONSCREEN_MESSAGE_GAP;
                    _loc_6[_loc_1] = new Rectangle();
                    _loc_6[_loc_1].x = _loc_5[_loc_1].x - _loc_5[_loc_1].width / 2;
                    _loc_6[_loc_1].y = _loc_5[_loc_1].y - _loc_5[_loc_1].height / 2;
                    _loc_6[_loc_1].width = _loc_5[_loc_1].width;
                    _loc_6[_loc_1].height = _loc_5[_loc_1].height;
                }
                _loc_1 = _loc_1 - 1;
            }
            var _loc_8:* = Number.POSITIVE_INFINITY;
            var _loc_9:* = 0;
            do
            {
                
                _loc_9 = _loc_8;
                _loc_8 = 0;
                _loc_1 = _loc_5.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (_loc_5[_loc_1] != null)
                    {
                        _loc_7[_loc_1].x = 0;
                        _loc_7[_loc_1].y = 0;
                        _loc_10 = Math.sqrt(_loc_5[_loc_1].width * _loc_5[_loc_1].width + _loc_5[_loc_1].height * _loc_5[_loc_1].height);
                        _loc_2 = _loc_5.length - 1;
                        while (_loc_2 >= 0)
                        {
                            
                            if (_loc_1 != _loc_2 && _loc_5[_loc_2] != null)
                            {
                                _loc_11 = _loc_5[_loc_1].intersection(_loc_5[_loc_2]);
                                if (!_loc_11.isEmpty())
                                {
                                    this.m_HelperPoint.x = Math.floor(_loc_5[_loc_1].x + _loc_5[_loc_1].width / 2) - Math.floor(_loc_5[_loc_2].x + _loc_5[_loc_2].width / 2);
                                    this.m_HelperPoint.y = Math.floor(_loc_5[_loc_1].y + _loc_5[_loc_1].height / 2) - Math.floor(_loc_5[_loc_2].y + _loc_5[_loc_2].height / 2);
                                    _loc_8 = _loc_8 + _loc_11.width * _loc_11.height * Math.pow(0.5, this.m_HelperPoint.length / _loc_10 - 1);
                                    if (this.m_HelperPoint.x < 0)
                                    {
                                        _loc_7[_loc_1].x = _loc_7[_loc_1].x - _loc_11.width;
                                    }
                                    else if (this.m_HelperPoint.x > 0)
                                    {
                                        _loc_7[_loc_1].x = _loc_7[_loc_1].x + _loc_11.width;
                                    }
                                    if (this.m_HelperPoint.y < 0)
                                    {
                                        _loc_7[_loc_1].y = _loc_7[_loc_1].y - _loc_11.height;
                                    }
                                    else if (this.m_HelperPoint.y > 0)
                                    {
                                        _loc_7[_loc_1].y = _loc_7[_loc_1].y + _loc_11.height;
                                    }
                                    if (this.m_HelperPoint.x == 0 && this.m_HelperPoint.y == 0 && _loc_2 == (_loc_5.length - 1))
                                    {
                                        _loc_7[_loc_1].x = _loc_7[_loc_1].x + (_loc_1 - _loc_2);
                                    }
                                }
                            }
                            _loc_2 = _loc_2 - 1;
                        }
                    }
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = _loc_5.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    if (_loc_5[_loc_1] != null)
                    {
                        if (_loc_7[_loc_1].x > 0)
                        {
                            _loc_5[_loc_1].x = Math.max(_loc_6[_loc_1].left, Math.min((_loc_5[_loc_1].x + 1), _loc_6[_loc_1].right));
                        }
                        else if (_loc_7[_loc_1].x < 0)
                        {
                            _loc_5[_loc_1].x = Math.max(_loc_6[_loc_1].left, Math.min((_loc_5[_loc_1].x - 1), _loc_6[_loc_1].right));
                        }
                        if (_loc_7[_loc_1].y > 0)
                        {
                            _loc_5[_loc_1].y = Math.max(_loc_6[_loc_1].top, Math.min((_loc_5[_loc_1].y + 1), _loc_6[_loc_1].bottom));
                        }
                        else if (_loc_7[_loc_1].y < 0)
                        {
                            _loc_5[_loc_1].y = Math.max(_loc_6[_loc_1].top, Math.min((_loc_5[_loc_1].y - 1), _loc_6[_loc_1].bottom));
                        }
                    }
                    _loc_1 = _loc_1 - 1;
                }
            }while (_loc_8 < _loc_9)
            _loc_1 = _loc_3.length - 1;
            while (_loc_1 >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
            {
                
                if (_loc_3[_loc_1] != null && _loc_3[_loc_1].visible && !_loc_3[_loc_1].empty)
                {
                    _loc_3[_loc_1].x = Math.max(_loc_6[_loc_1].left, Math.min(_loc_5[_loc_1].x, _loc_6[_loc_1].right)) + ONSCREEN_MESSAGE_GAP / 2;
                    _loc_3[_loc_1].y = Math.max(_loc_6[_loc_1].top, Math.min(_loc_5[_loc_1].y, _loc_6[_loc_1].bottom)) + ONSCREEN_MESSAGE_GAP / 2;
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                this.m_Player = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        function pointToAbsolute(param1:Number, param2:Number, param3:Boolean, param4:Vector3D = null) : Vector3D
        {
            var _loc_5:* = this.pointToMap(param1, param2, param3, param4);
            if (this.pointToMap(param1, param2, param3, param4) != null)
            {
                return this.m_WorldMapStorage.toAbsolute(_loc_5, _loc_5);
            }
            return null;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                this.updateOptions();
                this.m_TiledLightmapRenderer.options = this.options;
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedWorldMapStorage)
            {
                this.m_TiledLightmapRenderer.worldMapStorage = this.worldMapStorage;
                this.m_UncommittedWorldMapStorage = false;
            }
            return;
        }// end function

        private function drawCreatureFlags(param1:Creature, param2:int, param3:int, param4:Boolean) : void
        {
            if (!(param1.isHuman || param1.isSummon || param1.isNPC))
            {
                return;
            }
            if (param1.hasFlag == false)
            {
                return;
            }
            var _loc_5:* = this.getCreatureFlagsCachedBitmap(param1);
            this.m_HelperPoint.setTo(param2, param3);
            this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
            this.m_HelperPoint.setTo(Math.max(0, this.m_HelperPoint.x + 16 - CreatureStorage.STATE_FLAG_SIZE + 4), Math.max(0, (this.m_HelperPoint.y + 1)));
            this.m_HelperTrans.setTo(1, 0, 0, 1, this.m_HelperPoint.x, this.m_HelperPoint.y);
            graphics.beginBitmapFill(_loc_5, this.m_HelperTrans, false, false);
            graphics.drawRect(this.m_HelperPoint.x, this.m_HelperPoint.y, _loc_5.width, _loc_5.height);
            graphics.endFill();
            return;
        }// end function

        protected function initialize3DObjects() : void
        {
            var _loc_1:* = new Rectangle(0, 0, 100, 100);
            this.m_Tibia3D = new Tibia3D(this.stage.stage3Ds[0], _loc_1, Context3DRenderMode.AUTO);
            this.m_Tibia3D.visible = false;
            var _loc_2:* = new Camera2D(_loc_1.width, _loc_1.height);
            this.m_Tibia3D.camera = _loc_2;
            if (this.m_TiledLightmapRenderer == null)
            {
                this.m_TiledLightmapRenderer = new TiledLightmapRenderer();
            }
            this.m_LightTranslate = new Matrix();
            this.m_LightTranslate.scale(TiledLightmapRenderer.LIGHTMAP_SHRINK_FACTOR, TiledLightmapRenderer.LIGHTMAP_SHRINK_FACTOR);
            this.m_LightTranslate.translate((-FIELD_SIZE) / 2, (-FIELD_SIZE) / 2);
            this.m_LightClipRect = new Rectangle(0, 0, (MAP_WIDTH + 2) * FIELD_SIZE, (MAP_HEIGHT + 2) * FIELD_SIZE);
            return;
        }// end function

        private function drawTextualEffects() : void
        {
            var _loc_2:* = null;
            this.m_HelperTrans.a = 1;
            this.m_HelperTrans.d = 1;
            var _loc_1:* = 0;
            while (_loc_1 < this.m_DrawnTextualEffectsCount)
            {
                
                _loc_2 = this.m_DrawnTextualEffects[_loc_1].object as TextualEffectInstance;
                if (_loc_2 == null)
                {
                }
                else
                {
                    this.m_HelperPoint.x = this.m_DrawnTextualEffects[_loc_1].x - _loc_2.width / 2;
                    this.m_HelperPoint.y = this.m_DrawnTextualEffects[_loc_1].y;
                    this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
                    if (this.m_HelperPoint.x < 0)
                    {
                        this.m_HelperPoint.x = 0;
                    }
                    if (this.m_HelperPoint.x + _loc_2.width > unscaledWidth)
                    {
                        this.m_HelperPoint.x = unscaledWidth - _loc_2.width;
                    }
                    if (this.m_HelperPoint.y < 0)
                    {
                        this.m_HelperPoint.y = 0;
                    }
                    if (this.m_HelperPoint.y + _loc_2.height > unscaledHeight)
                    {
                        this.m_HelperPoint.y = unscaledHeight - _loc_2.height;
                    }
                    this.m_HelperTrans.tx = this.m_HelperPoint.x;
                    this.m_HelperTrans.ty = this.m_HelperPoint.y;
                    graphics.beginBitmapFill(_loc_2.m_InstanceBitmap, this.m_HelperTrans, false, false);
                    graphics.drawRect(this.m_HelperPoint.x, this.m_HelperPoint.y, _loc_2.width, _loc_2.height);
                }
                _loc_1++;
            }
            graphics.endFill();
            return;
        }// end function

        private function drawOnscreenMessages() : void
        {
            var _loc_8:* = null;
            if (this.m_WorldMapStorage.m_LayoutOnscreenMessages)
            {
                this.layoutOnscreenMessages();
                this.m_WorldMapStorage.m_LayoutOnscreenMessages = false;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.m_Player != null)
            {
                _loc_1 = this.m_Player.animationDelta.x * this.m_Transform.a;
                _loc_2 = this.m_Player.animationDelta.y * this.m_Transform.d;
            }
            var _loc_3:* = this.m_WorldMapStorage.m_MessageBoxes;
            var _loc_4:* = 0;
            var _loc_10:* = _loc_3[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM];
            _loc_8 = _loc_3[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM];
            if (_loc_10 != null && _loc_8.visible && !_loc_8.empty)
            {
                _loc_4 = _loc_8.height;
            }
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_8 = null;
            var _loc_9:* = null;
            this.m_HelperTrans.a = 1;
            this.m_HelperTrans.d = 1;
            _loc_5 = _loc_3.length - 1;
            while (_loc_5 >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
            {
                
                var _loc_10:* = _loc_3[_loc_5];
                _loc_8 = _loc_3[_loc_5];
                if (_loc_10 != null && _loc_8.visible && !_loc_8.empty)
                {
                    this.m_HelperPoint.x = _loc_8.x;
                    this.m_HelperPoint.y = _loc_8.y;
                    if ((_loc_8.fixing & OnscreenMessageBox.FIXING_X) == 0)
                    {
                        this.m_HelperPoint.x = this.m_HelperPoint.x - _loc_1;
                    }
                    if ((_loc_8.fixing & OnscreenMessageBox.FIXING_Y) == 0)
                    {
                        this.m_HelperPoint.y = this.m_HelperPoint.y - _loc_2;
                    }
                    this.m_HelperPoint.x = Math.max(0, Math.min(this.m_HelperPoint.x, unscaledWidth - _loc_8.width));
                    this.m_HelperPoint.y = Math.max(0, Math.min(this.m_HelperPoint.y, unscaledHeight - _loc_4 - _loc_8.height));
                    _loc_6 = 0;
                    _loc_7 = _loc_8.visibleMessages;
                    while (_loc_6 < _loc_7)
                    {
                        
                        _loc_9 = _loc_8.getCacheBitmap(_loc_6, this.m_HelperRect);
                        this.m_HelperTrans.tx = -this.m_HelperRect.x + this.m_HelperPoint.x + (_loc_8.width - this.m_HelperRect.width) / 2;
                        this.m_HelperTrans.ty = -this.m_HelperRect.y + this.m_HelperPoint.y;
                        graphics.beginBitmapFill(_loc_9, this.m_HelperTrans, false, false);
                        graphics.drawRect(this.m_HelperPoint.x + (_loc_8.width - this.m_HelperRect.width) / 2, this.m_HelperPoint.y, this.m_HelperRect.width, this.m_HelperRect.height);
                        this.m_HelperPoint.y = this.m_HelperPoint.y + this.m_HelperRect.height;
                        _loc_6++;
                    }
                }
                _loc_5 = _loc_5 - 1;
            }
            var _loc_10:* = _loc_3[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM];
            _loc_8 = _loc_3[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM];
            if (_loc_10 != null && _loc_8.visible && !_loc_8.empty)
            {
                _loc_9 = _loc_8.getCacheBitmap(0, this.m_HelperRect);
                this.m_HelperPoint.x = (unscaledWidth - this.m_HelperRect.width) / 2;
                this.m_HelperPoint.y = unscaledHeight - this.m_HelperRect.height;
                this.m_HelperTrans.tx = -this.m_HelperRect.x + this.m_HelperPoint.x;
                this.m_HelperTrans.ty = -this.m_HelperRect.y + this.m_HelperPoint.y;
                graphics.beginBitmapFill(_loc_9, this.m_HelperTrans, false, false);
                graphics.drawRect(this.m_HelperPoint.x, this.m_HelperPoint.y, this.m_HelperRect.width, this.m_HelperRect.height);
            }
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        private function getCreatureFlagsCachedBitmap(param1:Creature) : BitmapData
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_2:* = param1.pkFlag;
            var _loc_3:* = param1.partyFlag;
            var _loc_4:* = param1.summonFlag;
            var _loc_5:* = param1.guildFlag;
            var _loc_6:* = param1.riskinessFlag;
            var _loc_7:* = param1.speechCategory;
            if (param1.speechCategory == NPC_SPEECH_QUESTTRADER)
            {
                _loc_7 = getTimer() % 2048 > 1024 ? (NPC_SPEECH_TRADER) : (NPC_SPEECH_QUEST);
            }
            var _loc_8:* = _loc_2 + "," + _loc_3 + "," + _loc_4 + "," + _loc_5 + "," + _loc_6 + "," + _loc_7;
            if (this.m_CreatureFlagsBitmapCache.hasOwnProperty(_loc_8))
            {
                _loc_9 = this.m_CreatureFlagsBitmapCache[_loc_8];
                _loc_9["lastAccess"] = getTimer();
                return _loc_9["bitmap"];
            }
            _loc_10 = this.m_HelperRect;
            _loc_11 = this.m_HelperRect2;
            this.m_HelperCreatureFlagsBitmapData.fillRect(this.m_HelperCreatureFlagsBitmapData.rect, 0);
            _loc_12 = -2;
            _loc_13 = -2;
            _loc_14 = new Point(0, 0);
            _loc_10.setTo(0, 0, -CreatureStorage.STATE_FLAG_GAP, -CreatureStorage.STATE_FLAG_GAP);
            _loc_15 = null;
            if (_loc_3 > PARTY_NONE)
            {
                _loc_15 = CreatureStorage.s_GetPartyFlag(param1.partyFlag, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.x = _loc_14.x + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = _loc_10.width + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
            }
            if (param1.pkFlag > PK_NONE)
            {
                _loc_15 = CreatureStorage.s_GetPKFlag(param1.pkFlag, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.x = _loc_14.x + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = _loc_10.width + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
            }
            if (param1.summonFlag > SUMMON_NONE)
            {
                _loc_15 = CreatureStorage.s_GetSummonFlag(param1.summonFlag, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.x = _loc_14.x + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = _loc_10.width + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
            }
            if (_loc_7 > NPC_SPEECH_NONE)
            {
                _loc_15 = CreatureStorage.s_GetNpcSpeechFlag(_loc_7, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.x = _loc_14.x + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = _loc_10.width + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.SPEECH_FLAG_SIZE);
                _loc_10.height = _loc_10.height + CreatureStorage.SPEECH_FLAG_SIZE;
            }
            if (_loc_14.x > 0)
            {
                _loc_14.x = _loc_14.x / 2 - CreatureStorage.STATE_FLAG_SIZE / 2;
                _loc_14.y = _loc_14.y + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.height = _loc_10.height + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
            }
            if (param1.guildFlag > GUILD_NONE)
            {
                _loc_15 = CreatureStorage.s_GetGuildFlag(param1.guildFlag, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.y = _loc_14.y + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.height = _loc_10.height + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = Math.max(_loc_10.width, CreatureStorage.STATE_FLAG_SIZE);
            }
            if (param1.riskinessFlag > RISKINESS_NONE)
            {
                _loc_15 = CreatureStorage.s_GetRiskinessFlag(param1.riskinessFlag, _loc_11);
                this.m_HelperCreatureFlagsBitmapData.copyPixels(_loc_15, _loc_11, _loc_14);
                _loc_14.y = _loc_14.y + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.height = _loc_10.height + (CreatureStorage.STATE_FLAG_GAP + CreatureStorage.STATE_FLAG_SIZE);
                _loc_10.width = Math.max(_loc_10.width, CreatureStorage.STATE_FLAG_SIZE);
            }
            _loc_16 = new BitmapData(_loc_10.width, _loc_10.height);
            this.m_HelperPoint.setTo(0, 0);
            _loc_16.copyPixels(this.m_HelperCreatureFlagsBitmapData, _loc_10, this.m_HelperPoint);
            _loc_17 = null;
            _loc_18 = null;
            _loc_19 = 0;
            for (_loc_20 in this.m_CreatureFlagsBitmapCache)
            {
                
                _loc_21 = _loc_23[_loc_20];
                if (_loc_17 == null || _loc_21["lastAccess"] < _loc_17["lastAccess"])
                {
                    _loc_17 = _loc_21;
                    _loc_18 = _loc_20;
                }
                _loc_19 = _loc_19 + 1;
            }
            if (_loc_19 > CREATURE_FLAGS_BITMAP_CACHE_SIZE)
            {
                delete _loc_23[_loc_18];
            }
            _loc_17 = {lastAccess:getTimer(), bitmap:_loc_16};
            _loc_23[_loc_8] = _loc_17;
            return _loc_17["bitmap"];
        }// end function

        public function get fps() : Number
        {
            var _loc_1:* = this.m_StopwatchShowFrame.average;
            if (_loc_1 > 0)
            {
                return Math.round(1000 / _loc_1);
            }
            return 0;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = false;
            var _loc_17:* = NaN;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = 0;
            var _loc_28:* = 0;
            var _loc_29:* = 0;
            var _loc_30:* = 0;
            var _loc_31:* = 0;
            var _loc_32:* = 0;
            var _loc_33:* = null;
            var _loc_34:* = 0;
            var _loc_35:* = null;
            var _loc_36:* = null;
            this.m_StopwatchEnterFrame.stop();
            this.m_StopwatchEnterFrame.start();
            var _loc_3:* = null;
            _loc_4 = Tibia.s_GetTibiaTimer();
            var _loc_5:* = _loc_4 - Tibia.s_FrameTibiaTimestamp;
            Tibia.s_FrameRealTimestamp = getTimer();
            if (Math.floor(this.m_StopwatchEnterFrame.average) > Math.max(Math.ceil(1000 / this.m_OptionsFrameRate), _loc_5) || this.m_CreatureStorage == null || this.m_Options == null || this.m_Player == null || this.m_WorldMapStorage == null || !this.m_WorldMapStorage.valid)
            {
                return;
            }
            this.m_StopwatchShowFrame.stop();
            this.m_StopwatchShowFrame.start();
            this.m_MainLayer.fillRect(this.m_Rectangle, 4278190080);
            this.m_AtmosphereLayer.fillRect(this.m_Rectangle, 0);
            this.m_DrawnCreaturesCount = 0;
            this.m_DrawnTextualEffectsCount = 0;
            Tibia.s_FrameTibiaTimestamp = _loc_4;
            this.m_WorldMapStorage.animate();
            this.m_CreatureStorage.animate();
            this.m_MaxZPlane = MAPSIZE_Z - 1;
            this.m_WorldMapStorage.toMap(this.m_Player.position, this.m_HelperCoordinate);
            this.m_PlayerZPlane = this.m_HelperCoordinate.z;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            while (this.m_MaxZPlane > this.m_PlayerZPlane && this.m_WorldMapStorage.getObjectPerLayer(this.m_MaxZPlane) <= 0)
            {
                
                var _loc_37:* = this;
                var _loc_38:* = this.m_MaxZPlane - 1;
                _loc_37.m_MaxZPlane = _loc_38;
            }
            var _loc_11:* = null;
            var _loc_12:* = null;
            _loc_8 = PLAYER_OFFSET_X - 1;
            while (_loc_8 <= (PLAYER_OFFSET_X + 1))
            {
                
                _loc_9 = PLAYER_OFFSET_Y - 1;
                while (_loc_9 <= (PLAYER_OFFSET_Y + 1))
                {
                    
                    if (_loc_8 != PLAYER_OFFSET_X && _loc_9 != PLAYER_OFFSET_Y || !this.m_WorldMapStorage.isLookPossible(_loc_8, _loc_9, this.m_PlayerZPlane))
                    {
                    }
                    else
                    {
                        _loc_10 = this.m_PlayerZPlane + 1;
                        while ((_loc_10 - 1) < this.m_MaxZPlane && _loc_8 + this.m_PlayerZPlane - _loc_10 >= 0 && _loc_9 + this.m_PlayerZPlane - _loc_10 >= 0)
                        {
                            
                            var _loc_37:* = this.m_WorldMapStorage.getObject(_loc_8 + this.m_PlayerZPlane - _loc_10, _loc_9 + this.m_PlayerZPlane - _loc_10, _loc_10, 0);
                            _loc_11 = this.m_WorldMapStorage.getObject(_loc_8 + this.m_PlayerZPlane - _loc_10, _loc_9 + this.m_PlayerZPlane - _loc_10, _loc_10, 0);
                            var _loc_37:* = _loc_11.type;
                            _loc_12 = _loc_11.type;
                            if (_loc_37 != null && _loc_37 != null && _loc_12.isBank && !_loc_12.isDonthide)
                            {
                                this.m_MaxZPlane = _loc_10 - 1;
                            }
                            else
                            {
                                var _loc_37:* = this.m_WorldMapStorage.getObject(_loc_8, _loc_9, _loc_10, 0);
                                _loc_11 = this.m_WorldMapStorage.getObject(_loc_8, _loc_9, _loc_10, 0);
                                var _loc_37:* = _loc_11.type;
                                _loc_12 = _loc_11.type;
                                if (_loc_37 != null && _loc_37 != null && (_loc_12.isBank || _loc_12.isBottom) && !_loc_12.isDonthide)
                                {
                                    this.m_MaxZPlane = _loc_10 - 1;
                                }
                            }
                            _loc_10++;
                        }
                    }
                    _loc_9++;
                }
                _loc_8++;
            }
            if (!this.m_WorldMapStorage.m_CacheFullbank)
            {
                _loc_9 = 0;
                while (_loc_9 < MAPSIZE_Y)
                {
                    
                    _loc_8 = 0;
                    while (_loc_8 < MAPSIZE_X)
                    {
                        
                        _loc_6 = _loc_9 * MAPSIZE_X + _loc_8;
                        this.m_MinZPlane[_loc_6] = 0;
                        _loc_10 = this.m_MaxZPlane;
                        while (_loc_10 >= 0)
                        {
                            
                            var _loc_37:* = this.m_WorldMapStorage.getObject(_loc_8, _loc_9, _loc_10, 0);
                            _loc_11 = this.m_WorldMapStorage.getObject(_loc_8, _loc_9, _loc_10, 0);
                            var _loc_37:* = _loc_11.type;
                            _loc_12 = _loc_11.type;
                            if (_loc_37 != null && _loc_37 != null && _loc_12.isFullBank)
                            {
                                this.m_MinZPlane[_loc_6] = _loc_10;
                                break;
                            }
                            _loc_10 = _loc_10 - 1;
                        }
                        _loc_8++;
                    }
                    _loc_9++;
                }
                this.m_WorldMapStorage.m_CacheFullbank = true;
            }
            if (this.m_OptionsScaleMap)
            {
                this.m_ClipRect.width = MAP_WIDTH * FIELD_SIZE;
                this.m_ClipRect.height = MAP_HEIGHT * FIELD_SIZE;
                this.m_ClipRect.x = FIELD_SIZE + this.m_Player.animationDelta.x;
                this.m_ClipRect.y = FIELD_SIZE + this.m_Player.animationDelta.y;
                this.m_Transform.a = unscaledWidth / this.m_ClipRect.width;
                this.m_Transform.d = unscaledHeight / this.m_ClipRect.height;
                this.m_Transform.tx = (-this.m_ClipRect.x) * this.m_Transform.a;
                this.m_Transform.ty = (-this.m_ClipRect.y) * this.m_Transform.d;
            }
            else
            {
                this.m_ClipRect.width = Math.min(MAP_WIDTH * FIELD_SIZE, unscaledWidth);
                this.m_ClipRect.height = Math.min(MAP_HEIGHT * FIELD_SIZE, unscaledHeight);
                this.m_ClipRect.x = (MAP_WIDTH * FIELD_SIZE - this.m_ClipRect.width) / 2 + FIELD_SIZE + this.m_Player.animationDelta.x;
                this.m_ClipRect.y = (MAP_HEIGHT * FIELD_SIZE - this.m_ClipRect.height) / 2 + FIELD_SIZE + this.m_Player.animationDelta.y;
                this.m_Transform.a = 1;
                this.m_Transform.d = 1;
                this.m_Transform.tx = -this.m_ClipRect.x;
                this.m_Transform.ty = -this.m_ClipRect.y;
            }
            var _loc_13:* = this.m_TiledLightmapRenderer.rawColorData;
            _loc_10 = 0;
            while (_loc_10 <= this.m_MaxZPlane)
            {
                
                _loc_14 = this.m_WorldMapStorage.getAmbientBrightness();
                _loc_15 = this.m_OptionsLevelSeparator;
                _loc_16 = this.m_Player.position.z <= 7;
                _loc_17 = _loc_16 ? (_loc_14) : (0);
                _loc_6 = this.m_CreatureCount.length - 1;
                while (_loc_6 >= 0)
                {
                    
                    this.m_CreatureCount[_loc_6] = 0;
                    _loc_6 = _loc_6 - 1;
                }
                _loc_8 = 0;
                while (_loc_8 < MAPSIZE_X)
                {
                    
                    _loc_9 = 0;
                    while (_loc_9 < MAPSIZE_Y)
                    {
                        
                        _loc_21 = this.m_WorldMapStorage.getField(_loc_8, _loc_9, _loc_10);
                        if (this.m_OptionsLightEnabled)
                        {
                            _loc_6 = this.m_TiledLightmapRenderer.toColorIndexRed(_loc_8, _loc_9);
                            if (_loc_10 == this.m_PlayerZPlane && _loc_10 > 0)
                            {
                                _loc_13[_loc_6] = _loc_13[_loc_6] * this.m_OptionsLevelSeparator;
                                _loc_13[(_loc_6 + 1)] = _loc_13[(_loc_6 + 1)] * this.m_OptionsLevelSeparator;
                                _loc_13[_loc_6 + 2] = _loc_13[_loc_6 + 2] * this.m_OptionsLevelSeparator;
                            }
                            var _loc_37:* = _loc_21.m_ObjectsRenderer[0];
                            _loc_11 = _loc_21.m_ObjectsRenderer[0];
                            if (_loc_10 == 0 || _loc_37 != null && _loc_11.m_Type.isBank)
                            {
                                _loc_23 = _loc_13[_loc_6];
                                _loc_24 = _loc_13[(_loc_6 + 1)];
                                _loc_25 = _loc_13[_loc_6 + 2];
                                this.m_TiledLightmapRenderer.setFieldBrightness(_loc_8, _loc_9, _loc_17, _loc_16);
                                if (_loc_10 > 0 && _loc_21.m_CacheTranslucent)
                                {
                                    _loc_23 = _loc_23 * this.m_OptionsLevelSeparator;
                                    _loc_24 = _loc_24 * this.m_OptionsLevelSeparator;
                                    _loc_25 = _loc_25 * this.m_OptionsLevelSeparator;
                                    if (_loc_23 > _loc_13[_loc_6])
                                    {
                                        _loc_13[_loc_6] = _loc_23;
                                    }
                                    if (_loc_24 > _loc_13[(_loc_6 + 1)])
                                    {
                                        _loc_13[(_loc_6 + 1)] = _loc_24;
                                    }
                                    if (_loc_25 > _loc_13[_loc_6 + 2])
                                    {
                                        _loc_13[_loc_6 + 2] = _loc_25;
                                    }
                                }
                            }
                            if (_loc_8 > 0 && _loc_9 > 0 && _loc_10 < 7 && _loc_10 == this.m_PlayerZPlane + this.m_WorldMapStorage.m_Position.z - 8 && this.m_WorldMapStorage.isTranslucent((_loc_8 - 1), (_loc_9 - 1), (_loc_10 + 1)))
                            {
                                this.m_TiledLightmapRenderer.setFieldBrightness(_loc_8, _loc_9, _loc_14, _loc_16);
                            }
                        }
                        _loc_22 = null;
                        _loc_6 = _loc_21.m_ObjectsCount - 1;
                        while (_loc_6 >= _loc_21.m_CacheObjectsCount)
                        {
                            
                            var _loc_37:* = _loc_21.m_ObjectsRenderer[_loc_6];
                            _loc_11 = _loc_21.m_ObjectsRenderer[_loc_6];
                            var _loc_37:* = this.m_CreatureStorage.getCreature(_loc_11.data);
                            _loc_22 = this.m_CreatureStorage.getCreature(_loc_11.data);
                            if (_loc_37 == null || _loc_11.ID != AppearanceInstance.CREATURE || _loc_37 == null)
                            {
                            }
                            else
                            {
                                _loc_26 = 0;
                                _loc_27 = 0;
                                if (_loc_22.mountOutfit != null)
                                {
                                    _loc_26 = _loc_22.mountOutfit.type.displacementX;
                                    _loc_27 = _loc_22.mountOutfit.type.displacementY;
                                }
                                else if (_loc_22.outfit != null)
                                {
                                    _loc_26 = _loc_22.outfit.type.displacementX;
                                    _loc_27 = _loc_22.outfit.type.displacementY;
                                }
                                _loc_28 = (_loc_8 + 1) * FIELD_SIZE + _loc_22.animationDelta.x - _loc_26;
                                _loc_29 = (_loc_9 + 1) * FIELD_SIZE + _loc_22.animationDelta.y - _loc_27;
                                _loc_30 = int((_loc_28 - 1) / FIELD_SIZE);
                                _loc_31 = int((_loc_29 - 1) / FIELD_SIZE);
                                _loc_32 = _loc_31 * MAPSIZE_X + _loc_30;
                                if (_loc_32 < 0 || _loc_32 >= MAPSIZE_X * MAPSIZE_Y)
                                {
                                }
                                else
                                {
                                    _loc_33 = this.m_CreatureField[_loc_32];
                                    _loc_34 = 0;
                                    do
                                    {
                                        
                                        _loc_34++;
                                        var _loc_37:* = _loc_33[_loc_34];
                                        _loc_35 = _loc_33[_loc_34];
                                    }while (_loc_34 < this.m_CreatureCount[_loc_32] && _loc_37 != null && (_loc_35.y < _loc_29 || _loc_35.y == _loc_29 && _loc_35.x <= _loc_28))
                                    if (_loc_34 >= MAPSIZE_W)
                                    {
                                    }
                                    else
                                    {
                                        if (this.m_CreatureCount[_loc_32] < MAPSIZE_W)
                                        {
                                            var _loc_37:* = this.m_CreatureCount;
                                            var _loc_38:* = _loc_32;
                                            var _loc_39:* = _loc_37[_loc_32] + 1;
                                            _loc_37[_loc_38] = _loc_39;
                                        }
                                        _loc_35 = _loc_33[(_loc_37[_loc_32] - 1)];
                                        _loc_7 = _loc_37[_loc_32] - 1;
                                        while (_loc_7 > _loc_34)
                                        {
                                            
                                            _loc_33[_loc_7] = _loc_33[(_loc_7 - 1)];
                                            _loc_7 = _loc_7 - 1;
                                        }
                                        _loc_33[_loc_34] = _loc_35;
                                        _loc_35.update(_loc_22, _loc_28, _loc_29, _loc_10);
                                    }
                                }
                            }
                            _loc_6 = _loc_6 - 1;
                        }
                        _loc_9++;
                    }
                    _loc_8++;
                }
                _loc_18 = null;
                if (this.m_HighlightObject is Creature)
                {
                    _loc_18 = this.m_HighlightObject as Creature;
                    this.m_ObjectCursor.copyMaskFromCreature(_loc_18);
                }
                else if (this.m_OptionsHighlight > 0 && this.m_HighlightTile != null && this.m_HighlightTile.z == _loc_10)
                {
                    if (this.m_HighlightObject != null && this.m_HighlightObject is ObjectInstance)
                    {
                        _loc_36 = this.m_HighlightObject as ObjectInstance;
                        if (_loc_36.isCreature)
                        {
                            this.m_ObjectCursor.copyMaskFromCreature(this.m_CreatureStorage.getCreature(_loc_36.data));
                        }
                        else
                        {
                            this.m_WorldMapStorage.toAbsolute(this.m_HighlightTile, this.m_HelperCoordinate);
                            this.m_ObjectCursor.copyMaskFromAppearance(_loc_36, this.m_HelperCoordinate.x, this.m_HelperCoordinate.y, this.m_HelperCoordinate.z);
                        }
                    }
                    else if (this.m_HighlightObject is Creature)
                    {
                        _loc_18 = this.m_HighlightObject as Creature;
                        this.m_ObjectCursor.copyMaskFromCreature(_loc_18);
                    }
                }
                else
                {
                    this.m_ObjectCursor.clearMask();
                }
                this.m_HelperCoordinate.setComponents(0, 0, _loc_10);
                this.m_WorldMapStorage.toAbsolute(this.m_HelperCoordinate, this.m_HelperCoordinate);
                _loc_19 = 0;
                _loc_20 = MAPSIZE_X + MAPSIZE_Y;
                _loc_19 = 0;
                while (_loc_19 < _loc_20)
                {
                    
                    _loc_9 = Math.max(_loc_19 - MAPSIZE_X + 1, 0);
                    _loc_8 = Math.min(_loc_19, (MAPSIZE_X - 1));
                    while (_loc_8 >= 0 && _loc_9 < MAPSIZE_Y)
                    {
                        
                        this.drawField((_loc_8 + 1) * FIELD_SIZE, (_loc_9 + 1) * FIELD_SIZE, this.m_HelperCoordinate.x + _loc_8, this.m_HelperCoordinate.y + _loc_9, this.m_HelperCoordinate.z, _loc_8, _loc_9, _loc_10, true);
                        _loc_8 = _loc_8 - 1;
                        _loc_9++;
                    }
                    _loc_19++;
                }
                if (this.m_OptionsHighlight > 0 && this.m_HighlightTile != null && this.m_HighlightTile.z == _loc_10)
                {
                    this.m_TileCursor.drawTo(this.m_MainLayer, (this.m_HighlightTile.x + 1) * FIELD_SIZE, (this.m_HighlightTile.y + 1) * FIELD_SIZE, Tibia.s_FrameTibiaTimestamp);
                }
                _loc_10++;
            }
            this.m_HelperPoint.setTo(0, 0);
            this.m_MainLayer.copyPixels(this.m_AtmosphereLayer, this.m_Rectangle, this.m_HelperPoint, null, null, true);
            if (this.m_OptionsLightEnabled && Tibia3D.isReady)
            {
                this.m_TiledLightmapRenderer.createLightmap();
                this.m_MainLayer.draw(this.m_TiledLightmapRenderer.lightmapBitmap, this.m_LightTranslate, null, BlendMode.MULTIPLY, this.m_LightClipRect, true);
            }
            graphics.clear();
            graphics.beginBitmapFill(this.m_MainLayer, this.m_Transform, false, this.m_OptionsAntialiasing);
            graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
            graphics.endFill();
            this.drawCreatureStatus();
            this.drawTextualEffects();
            this.drawOnscreenMessages();
            if (Tibia3D.isReady)
            {
                Tibia3D.context3D.present();
            }
            return;
        }// end function

        private static function s_InitialiseMarksViews(param1:Boolean) : void
        {
            s_CreatureMarksView = new MarksView(0);
            s_CreatureMarksView.addMarkToView(Marks.MARK_TYPE_CLIENT_MAPWINDOW, MarksView.MARK_THICKNESS_BOLD);
            if (param1)
            {
                s_CreatureMarksView.addMarkToView(Marks.MARK_TYPE_PERMANENT, MarksView.MARK_THICKNESS_BOLD);
            }
            s_CreatureMarksView.addMarkToView(Marks.MARK_TYPE_ONE_SECOND_TEMP, MarksView.MARK_THICKNESS_BOLD);
            return;
        }// end function

        s_InitialiseMarksViews(true);
    }
}
