package tibia.worldmap.widgetClasses
{
   import mx.core.UIComponent;
   import shared.utility.Colour;
   import flash.geom.Rectangle;
   import tibia.creatures.CreatureStorage;
   import tibia.creatures.Creature;
   import shared.utility.Vector3D;
   import shared.utility.IPerformanceCounter;
   import tibia.worldmap.Field;
   import tibia.appearances.ObjectInstance;
   import tibia.appearances.AppearanceInstance;
   import tibia.appearances.AppearanceStorage;
   import flash.display.BitmapData;
   import tibia.appearances.TextualEffectInstance;
   import tibia.appearances.MissileInstance;
   import flash.geom.Point;
   import tibia.creatures.Player;
   import tibia.options.OptionsStorage;
   import tibia.worldmap.WorldMapStorage;
   import flash.events.Event;
   import flash.utils.getTimer;
   import tibia.appearances.AppearanceType;
   import flash.geom.Matrix;
   import shared.utility.TextFieldCache;
   import flash.display.GraphicsPathCommand;
   import tibia.worldmap.OnscreenMessageBox;
   import mx.events.PropertyChangeEvent;
   import shared.utility.SlidingWindowPerformanceCounter;
   
   public class RendererImpl extends UIComponent
   {
      
      protected static const PATH_MATRIX_CENTER:int = PATH_MAX_DISTANCE;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const HUD_ARC_ORIENTATION_LEFT:int = 0;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      public static const COLOUR_ABOVE_GROUND:Colour = new Colour(200,200,255);
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const PATH_COST_OBSTACLE:int = 255;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      protected static const STATE_DRUNK:int = 3;
      
      public static const STATUS_STYLE_CLASSIC:int = 1;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const PATH_NORTH:int = 3;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const PATH_MAX_DISTANCE:int = 110;
      
      public static const CREATURE_MARK_SIZE_NORMAL:int = FIELD_SIZE;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const GROUND_LAYER:int = 7;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const HUD_ARC_ORIENTATION_RIGHT:int = 1;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const PATH_ERROR_INTERNAL:int = -5;
      
      protected static const PATH_EMPTY:int = 0;
      
      protected static const PATH_COST_UNDEFINED:int = 254;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const HUD_ARC_STYLE_HORIZONTAL:int = 1;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PATH_MATRIX_SIZE:int = 2 * PATH_MAX_DISTANCE + 1;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PATH_ERROR_GO_UPSTAIRS:int = -2;
      
      protected static const PATH_COST_MAX:int = 250;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PATH_MAX_STEPS:int = 128;
      
      protected static const HUD_ARC_STYLE_POINTY:int = 0;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const HUD_ARC_TOTAL_WIDTH:Number = 10;
      
      protected static const HUD_ARC_LOWER_LIMIT:Number = 45;
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      public static const COLOUR_BELOW_GROUND:Colour = new Colour(255,255,255);
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const COUNTER_WINDOW_SIZE:int = 50;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PATH_SOUTH:int = 7;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      protected static const PATH_NORTH_WEST:int = 4;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      public static const STATUS_STYLE_HUD:int = 2;
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const WAR_ENEMY:int = 2;
      
      public static const CREATURE_MARK_SIZE_INNER:int = FIELD_SIZE - 4;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const ONSCREEN_MESSAGE_GAP:Number = 10;
      
      protected static const PATH_ERROR_UNREACHABLE:int = -4;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const HUD_ARC_BORDER_WIDTH:Number = 1;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const PATH_SOUTH_WEST:int = 6;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      protected static const PATH_NORTH_EAST:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const PATH_ERROR_TOO_FAR:int = -3;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const PATH_WEST:int = 5;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const HUD_ARC_ALPHA:Number = 0.75;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      public static const STATUS_STYLE_OFF:int = 0;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const HUD_ARC_RADIUS:Number = 75;
      
      protected static const PATH_SOUTH_EAST:int = 8;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const PATH_EXISTS:int = 1;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const HUD_ARC_UPPER_LIMIT:Number = -45;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const PATH_EAST:int = 1;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const HUD_ARC_STYLE_RADIAL:int = 2;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var m_MinZPlane:Vector.<int> = null;
      
      protected var m_ClipRect:Rectangle = null;
      
      protected var m_DrawnTextualEffectsCount:int = 0;
      
      protected var m_CreatureField:Vector.<Vector.<tibia.worldmap.widgetClasses.RenderAtom>> = null;
      
      protected var m_HangPatternY:int = 0;
      
      protected var m_HangPatternX:int = 0;
      
      private var m_StopwatchShowFrame:IPerformanceCounter;
      
      protected var m_HelperPoint:Point = null;
      
      protected var m_HangPatternZ:int = 0;
      
      protected var m_CreatureCount:Vector.<int> = null;
      
      private var m_OptionsFrameRate:Number = 50;
      
      protected var m_Player:Player = null;
      
      protected var m_MaxZPlane:int = 0;
      
      protected var m_HUDArcStyle:int = 2;
      
      protected var m_MainLayer:BitmapData = null;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_HelperTrans:Matrix = null;
      
      protected var m_DrawnCreaturesCount:int = 0;
      
      protected var m_PreviousHang:ObjectInstance = null;
      
      protected var m_DrawnCreatures:Vector.<tibia.worldmap.widgetClasses.RenderAtom> = null;
      
      protected var m_HUDArcScale:Number = NaN;
      
      protected var m_WorldMapStorage:WorldMapStorage = null;
      
      private var m_OptionsAmbientBrightness:Number = NaN;
      
      protected var m_CreatureNameCache:TextFieldCache = null;
      
      protected var m_DrawnTextualEffects:Vector.<tibia.worldmap.widgetClasses.RenderAtom> = null;
      
      protected var m_CreatureStorage:CreatureStorage = null;
      
      protected var m_HUDArcPoints:Vector.<Number> = null;
      
      protected var m_HangPixelX:int = 0;
      
      protected var m_HangPixelY:int = 0;
      
      protected var m_AtmosphereLayer:BitmapData = null;
      
      protected var m_HelperRect:Rectangle = null;
      
      private var m_StopwatchEnterFrame:IPerformanceCounter;
      
      protected var m_PlayerZPlane:int = 0;
      
      protected var m_Transform:Matrix = null;
      
      protected var m_Rectangle:Rectangle = null;
      
      private var m_OptionsScaleMap:Boolean = true;
      
      protected var m_HelperCoordinate:Vector3D = null;
      
      public function RendererImpl()
      {
         this.m_StopwatchEnterFrame = new SlidingWindowPerformanceCounter(COUNTER_WINDOW_SIZE);
         this.m_StopwatchShowFrame = new SlidingWindowPerformanceCounter(COUNTER_WINDOW_SIZE);
         super();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.m_MaxZPlane = MAPSIZE_Z - 1;
         this.m_MinZPlane = new Vector.<int>(MAPSIZE_X * MAPSIZE_Y);
         this.m_Rectangle = new Rectangle(0,0,MAPSIZE_X * FIELD_SIZE,MAPSIZE_Y * FIELD_SIZE);
         this.m_MainLayer = new BitmapData(this.m_Rectangle.width,this.m_Rectangle.height,true,0);
         this.m_AtmosphereLayer = new BitmapData(this.m_Rectangle.width,this.m_Rectangle.height,true,0);
         this.m_ClipRect = new Rectangle(0,0,MAP_WIDTH * FIELD_SIZE,MAP_HEIGHT * FIELD_SIZE);
         this.m_Transform = new Matrix();
         var _loc3_:int = MAPSIZE_X * MAPSIZE_Y;
         this.m_CreatureField = new Vector.<Vector.<tibia.worldmap.widgetClasses.RenderAtom>>(_loc3_,true);
         this.m_CreatureCount = new Vector.<int>(_loc3_,true);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            this.m_CreatureField[_loc1_] = new Vector.<tibia.worldmap.widgetClasses.RenderAtom>(MAPSIZE_W,true);
            _loc2_ = 0;
            while(_loc2_ < MAPSIZE_W)
            {
               this.m_CreatureField[_loc1_][_loc2_] = new tibia.worldmap.widgetClasses.RenderAtom();
               _loc2_++;
            }
            this.m_CreatureCount[_loc1_] = 0;
            _loc1_++;
         }
         this.m_DrawnCreatures = new Vector.<tibia.worldmap.widgetClasses.RenderAtom>(_loc3_ * MAPSIZE_W,true);
         _loc1_ = 0;
         while(_loc1_ < _loc3_ * MAPSIZE_W)
         {
            this.m_DrawnCreatures[_loc1_] = new tibia.worldmap.widgetClasses.RenderAtom();
            _loc1_++;
         }
         this.m_DrawnCreaturesCount = 0;
         this.m_CreatureNameCache = new TextFieldCache(300,TextFieldCache.DEFAULT_HEIGHT,MAPSIZE_X * MAPSIZE_Y * 3,false);
         this.m_DrawnTextualEffects = new Vector.<tibia.worldmap.widgetClasses.RenderAtom>(NUM_EFFECTS);
         _loc1_ = 0;
         while(_loc1_ < this.m_DrawnTextualEffects.length)
         {
            this.m_DrawnTextualEffects[_loc1_] = new tibia.worldmap.widgetClasses.RenderAtom();
            _loc1_++;
         }
         this.m_HelperCoordinate = new Vector3D();
         this.m_HelperPoint = new Point();
         this.m_HelperTrans = new Matrix();
         this.m_HelperRect = new Rectangle();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function set creatureStorage(param1:CreatureStorage) : void
      {
         if(this.m_CreatureStorage != param1)
         {
            this.m_CreatureStorage = param1;
         }
      }
      
      function pointToCreature(param1:Number, param2:Number, param3:Boolean) : Creature
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Creature = null;
         var _loc11_:Vector3D = null;
         var _loc12_:Vector3D = null;
         if(this.m_WorldMapStorage != null && (!param3 || this.m_Player != null))
         {
            _loc4_ = int(param1 - this.m_Transform.tx) / this.m_Transform.a;
            _loc5_ = int(param2 - this.m_Transform.ty) / this.m_Transform.d;
            _loc6_ = this.m_MinZPlane[int(_loc5_ / FIELD_SIZE) * MAPSIZE_X + int(_loc4_ / FIELD_SIZE)];
            if(param3)
            {
               this.m_WorldMapStorage.toMap(this.m_Player.position,this.m_HelperCoordinate);
               _loc6_ = this.m_HelperCoordinate.z;
            }
            _loc7_ = 0;
            while(_loc7_ < this.m_DrawnCreaturesCount)
            {
               if(this.m_DrawnCreatures[_loc7_] != null)
               {
                  _loc8_ = this.m_DrawnCreatures[_loc7_].x - FIELD_SIZE / 2;
                  _loc9_ = this.m_DrawnCreatures[_loc7_].y - FIELD_SIZE / 2;
                  if(!(Math.abs(_loc8_ - _loc4_) > FIELD_SIZE / 2 || Math.abs(_loc9_ - _loc5_) > FIELD_SIZE / 2))
                  {
                     _loc10_ = Creature(this.m_DrawnCreatures[_loc7_].object);
                     if(_loc10_ != null)
                     {
                        _loc11_ = _loc10_.position;
                        if(this.m_WorldMapStorage.isVisible(_loc11_.x,_loc11_.y,_loc11_.z,true))
                        {
                           _loc12_ = this.m_WorldMapStorage.toMap(_loc11_);
                           if(_loc12_.z >= _loc6_)
                           {
                              return _loc10_;
                           }
                        }
                     }
                  }
               }
               _loc7_++;
            }
         }
         return null;
      }
      
      private function drawField(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Boolean) : void
      {
         var _loc10_:Field = null;
         var _loc29_:* = false;
         _loc10_ = this.m_WorldMapStorage.getField(param6,param7,param8);
         var _loc11_:int = _loc10_.m_ObjectsCount;
         var _loc12_:int = param7 * MAPSIZE_X + param6;
         var _loc13_:Boolean = param8 >= this.m_MinZPlane[_loc12_] || (param6 == 0 || param8 >= this.m_MinZPlane[_loc12_ - 1]) || (param7 == 0 || param8 >= this.m_MinZPlane[_loc12_ - MAPSIZE_X]) || (param6 == 0 && param7 == 0 || param8 >= this.m_MinZPlane[_loc12_ - MAPSIZE_X - 1]);
         var _loc14_:ObjectInstance = null;
         var _loc15_:ObjectInstance = null;
         var _loc16_:Boolean = false;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         if(Boolean(param9) && _loc11_ > 0 && Boolean(_loc13_))
         {
            if(_loc10_.m_CacheObjectsCount > 0)
            {
               this.m_HelperPoint.x = param1 - FIELD_CACHESIZE;
               this.m_HelperPoint.y = param2 - FIELD_CACHESIZE;
               this.m_MainLayer.copyPixels(Field.s_CacheBitmap,_loc10_.m_CacheRectangle,this.m_HelperPoint,null,null,true);
               _loc17_ = _loc10_.m_CacheObjectsHeight;
            }
            _loc12_ = _loc10_.m_CacheObjectsCount;
            while(_loc12_ < _loc11_)
            {
               if((_loc14_ = _loc10_.m_ObjectsRenderer[_loc12_]) == null || _loc14_.m_ID == AppearanceInstance.CREATURE || Boolean(_loc14_.m_Type.isTop))
               {
                  break;
               }
               _loc14_.draw(this.m_MainLayer,param1 - _loc17_,param2 - _loc17_,param3,param4,param5);
               _loc16_ = Boolean(_loc16_) || Boolean(_loc14_.m_Type.isLyingObject);
               if(Boolean(_loc14_.m_Type.isHangable) && _loc14_.hang == AppearanceStorage.FLAG_HOOKSOUTH)
               {
                  _loc15_ = _loc14_;
               }
               _loc17_ = _loc17_ + _loc14_.m_Type.elevation;
               if(_loc17_ > FIELD_HEIGHT)
               {
                  _loc17_ = FIELD_HEIGHT;
               }
               _loc12_++;
            }
            if(Boolean(_loc16_) || Boolean(_loc10_.m_CacheLyingObject))
            {
               if(param6 > 0 && param7 > 0)
               {
                  this.drawField(param1 - FIELD_SIZE,param2 - FIELD_SIZE,param3 - 1,param4 - 1,param5,param6 - 1,param7 - 1,param8,false);
               }
               if(param6 > 0)
               {
                  this.drawField(param1 - FIELD_SIZE,param2,param3 - 1,param4,param5,param6 - 1,param7,param8,false);
               }
               if(param7 > 0)
               {
                  this.drawField(param1,param2 - FIELD_SIZE,param3,param4 - 1,param5,param6,param7 - 1,param8,false);
               }
            }
            if(this.m_PreviousHang != null)
            {
               this.m_PreviousHang.draw(this.m_MainLayer,this.m_HangPixelX,this.m_HangPixelY,this.m_HangPatternX,this.m_HangPatternY,this.m_HangPatternZ);
               this.m_PreviousHang = null;
            }
            if(_loc15_ != null)
            {
               this.m_PreviousHang = _loc15_;
               this.m_HangPixelX = param1;
               this.m_HangPixelY = param2;
               this.m_HangPatternX = param3;
               this.m_HangPatternY = param4;
               this.m_HangPatternZ = param5;
            }
         }
         var _loc20_:tibia.worldmap.widgetClasses.RenderAtom = null;
         var _loc21_:Vector.<tibia.worldmap.widgetClasses.RenderAtom> = this.m_CreatureField[param7 * MAPSIZE_X + param6];
         var _loc22_:int = this.m_CreatureCount[param7 * MAPSIZE_X + param6];
         var _loc23_:BitmapData = null;
         var _loc24_:Creature = null;
         _loc12_ = 0;
         while(_loc12_ < _loc22_)
         {
            if(!((_loc20_ = _loc21_[_loc12_]) == null || (_loc24_ = _loc21_[_loc12_].object as Creature) == null || _loc24_.outfit == null))
            {
               if(param9)
               {
                  _loc20_.x = _loc20_.x - _loc17_;
                  _loc20_.y = _loc20_.y - _loc17_;
               }
               _loc29_ = _loc24_.extendedMarkID != CreatureStorage.MARK_UNMARKED;
               this.m_HelperPoint.x = _loc20_.x - FIELD_SIZE;
               this.m_HelperPoint.y = _loc20_.y - FIELD_SIZE;
               if(_loc24_.isTrapper)
               {
                  _loc23_ = CreatureStorage.s_GetCreatureMark(CreatureStorage.MARK_TRAPPER,!!_loc29_?int(CREATURE_MARK_SIZE_INNER):int(CREATURE_MARK_SIZE_NORMAL),this.m_HelperRect);
                  this.m_MainLayer.copyPixels(_loc23_,this.m_HelperRect,this.m_HelperPoint,null,null,true);
               }
               else if(_loc24_.markEnd > Tibia.s_FrameTimestamp)
               {
                  _loc23_ = CreatureStorage.s_GetCreatureMark(_loc24_.markID,!!_loc29_?int(CREATURE_MARK_SIZE_INNER):int(CREATURE_MARK_SIZE_NORMAL),this.m_HelperRect);
                  this.m_MainLayer.copyPixels(_loc23_,this.m_HelperRect,this.m_HelperPoint,null,null,true);
               }
               if(_loc29_)
               {
                  _loc23_ = CreatureStorage.s_GetCreatureMark(_loc24_.extendedMarkID,CREATURE_MARK_SIZE_NORMAL,this.m_HelperRect);
                  this.m_MainLayer.copyPixels(_loc23_,this.m_HelperRect,this.m_HelperPoint,null,null,true);
               }
               _loc18_ = 0;
               _loc19_ = 0;
               if(Boolean(_loc13_) && _loc24_.mountOutfit != null)
               {
                  _loc18_ = _loc24_.mountOutfit.m_Type.displacementX;
                  _loc19_ = _loc24_.mountOutfit.m_Type.displacementY;
                  _loc24_.mountOutfit.draw(this.m_MainLayer,_loc20_.x + _loc18_,_loc20_.y + _loc19_,_loc24_.direction,0,0);
               }
               if(_loc13_)
               {
                  _loc18_ = _loc18_ + _loc24_.outfit.m_Type.displacementX;
                  _loc19_ = _loc19_ + _loc24_.outfit.m_Type.displacementY;
                  _loc24_.outfit.draw(this.m_MainLayer,_loc20_.x + _loc18_,_loc20_.y + _loc19_,_loc24_.direction,0,_loc24_.mountOutfit != null?1:0);
               }
               if(param8 == this.m_PlayerZPlane && (Boolean(this.m_CreatureStorage.isOpponent(_loc24_)) || _loc24_.ID == this.m_Player.ID))
               {
                  this.m_DrawnCreatures[this.m_DrawnCreaturesCount].assign(_loc20_);
                  this.m_DrawnCreaturesCount++;
               }
            }
            _loc12_++;
         }
         var _loc25_:int = _loc10_.m_EffectsCount;
         var _loc26_:AppearanceInstance = null;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         _loc18_ = param1 - _loc17_;
         _loc19_ = param2 - _loc17_;
         _loc12_ = _loc10_.m_EffectsCount - 1;
         while(_loc12_ >= 0)
         {
            if((_loc26_ = _loc10_.m_Effects[_loc12_]) != null)
            {
               if(_loc26_ is TextualEffectInstance)
               {
                  if(param9)
                  {
                     _loc20_ = this.m_DrawnTextualEffects[this.m_DrawnTextualEffectsCount];
                     _loc20_.update(_loc26_,_loc18_ - FIELD_SIZE / 2 + _loc27_,_loc19_ - FIELD_SIZE - 2 * _loc26_.phase,0);
                     if(_loc20_.y + TextualEffectInstance(_loc26_).height > _loc28_)
                     {
                        _loc27_ = _loc27_ + TextualEffectInstance(_loc26_).width;
                     }
                     if(_loc27_ < 2 * FIELD_SIZE)
                     {
                        this.m_DrawnTextualEffectsCount++;
                        _loc28_ = _loc20_.y;
                     }
                  }
               }
               else if(_loc26_ is MissileInstance)
               {
                  _loc26_.draw(this.m_MainLayer,_loc18_ + MissileInstance(_loc26_).animationDelta.x,_loc19_ + MissileInstance(_loc26_).animationDelta.y,param3,param4,param5);
               }
               else
               {
                  _loc26_.draw(this.m_MainLayer,_loc18_,_loc19_,param3,param4,param5);
               }
            }
            _loc12_--;
         }
         if(_loc10_.m_Environment != null)
         {
            if(_loc10_.m_Environment.data == 1)
            {
               if(param9)
               {
                  _loc10_.m_Environment.draw(this.m_AtmosphereLayer,param1,param2,param3,param4,param5);
               }
            }
            else
            {
               _loc10_.m_Environment.draw(this.m_MainLayer,param1,param2,param3,param4,param5);
            }
         }
         if(Boolean(param9) && _loc11_ > 0 && (_loc14_ = _loc10_.m_ObjectsRenderer[_loc11_ - 1]) != null && Boolean(_loc14_.m_Type.isTop))
         {
            _loc14_.draw(this.m_MainLayer,param1,param2,param3,param4,param5);
         }
      }
      
      private function updateOptions() : void
      {
         if(this.m_Options != null)
         {
            this.m_OptionsAmbientBrightness = this.m_Options.rendererAmbientBrightness;
            this.m_OptionsFrameRate = this.m_Options.rendererMaxFrameRate;
            this.m_OptionsScaleMap = this.m_Options.rendererScaleMap;
         }
         else
         {
            this.m_OptionsAmbientBrightness = NaN;
            this.m_OptionsFrameRate = 50;
            this.m_OptionsScaleMap = true;
         }
         if(stage != null)
         {
            stage.frameRate = this.m_OptionsFrameRate;
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      public function get worldMapStorage() : WorldMapStorage
      {
         return this.m_WorldMapStorage;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Field = null;
         var _loc15_:Creature = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Vector.<tibia.worldmap.widgetClasses.RenderAtom> = null;
         var _loc24_:int = 0;
         var _loc25_:tibia.worldmap.widgetClasses.RenderAtom = null;
         this.m_StopwatchEnterFrame.stop();
         this.m_StopwatchEnterFrame.start();
         _loc2_ = getTimer();
         var _loc3_:Number = _loc2_ - Tibia.s_FrameTimestamp;
         if(Math.floor(this.m_StopwatchEnterFrame.average) > Math.max(Math.ceil(1000 / this.m_OptionsFrameRate),_loc3_) || this.m_CreatureStorage == null || this.m_Options == null || this.m_Player == null || this.m_WorldMapStorage == null || !this.m_WorldMapStorage.valid)
         {
            return;
         }
         this.m_StopwatchShowFrame.stop();
         this.m_StopwatchShowFrame.start();
         this.m_MainLayer.lock();
         this.m_AtmosphereLayer.lock();
         this.m_MainLayer.fillRect(this.m_Rectangle,4278190080);
         this.m_AtmosphereLayer.fillRect(this.m_Rectangle,0);
         this.m_DrawnCreaturesCount = 0;
         this.m_DrawnTextualEffectsCount = 0;
         Tibia.s_FrameTimestamp = _loc2_;
         this.m_WorldMapStorage.animate();
         this.m_CreatureStorage.animate();
         this.m_MaxZPlane = MAPSIZE_Z - 1;
         this.m_WorldMapStorage.toMap(this.m_Player.position,this.m_HelperCoordinate);
         this.m_PlayerZPlane = this.m_HelperCoordinate.z;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(this.m_MaxZPlane > this.m_PlayerZPlane && this.m_WorldMapStorage.getObjectPerLayer(this.m_MaxZPlane) <= 0)
         {
            this.m_MaxZPlane--;
         }
         var _loc9_:ObjectInstance = null;
         var _loc10_:AppearanceType = null;
         _loc6_ = PLAYER_OFFSET_X - 1;
         while(_loc6_ <= PLAYER_OFFSET_X + 1)
         {
            _loc7_ = PLAYER_OFFSET_Y - 1;
            while(_loc7_ <= PLAYER_OFFSET_Y + 1)
            {
               if(!(_loc6_ != PLAYER_OFFSET_X && _loc7_ != PLAYER_OFFSET_Y || !this.m_WorldMapStorage.isLookPossible(_loc6_,_loc7_,this.m_PlayerZPlane)))
               {
                  _loc8_ = this.m_PlayerZPlane + 1;
                  while(_loc8_ - 1 < this.m_MaxZPlane && _loc6_ + this.m_PlayerZPlane - _loc8_ >= 0 && _loc7_ + this.m_PlayerZPlane - _loc8_ >= 0)
                  {
                     if((_loc9_ = this.m_WorldMapStorage.getObject(_loc6_ + this.m_PlayerZPlane - _loc8_,_loc7_ + this.m_PlayerZPlane - _loc8_,_loc8_,0)) != null && (_loc10_ = _loc9_.type) != null && Boolean(_loc10_.isBank) && !_loc10_.isDonthide)
                     {
                        this.m_MaxZPlane = _loc8_ - 1;
                     }
                     else if((_loc9_ = this.m_WorldMapStorage.getObject(_loc6_,_loc7_,_loc8_,0)) != null && (_loc10_ = _loc9_.type) != null && (Boolean(_loc10_.isBank) || Boolean(_loc10_.isBottom)) && !_loc10_.isDonthide)
                     {
                        this.m_MaxZPlane = _loc8_ - 1;
                     }
                     _loc8_++;
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         if(!this.m_WorldMapStorage.m_CacheFullbank)
         {
            _loc7_ = 0;
            while(_loc7_ < MAPSIZE_Y)
            {
               _loc6_ = 0;
               while(_loc6_ < MAPSIZE_X)
               {
                  _loc4_ = _loc7_ * MAPSIZE_X + _loc6_;
                  this.m_MinZPlane[_loc4_] = 0;
                  _loc8_ = this.m_MaxZPlane;
                  while(_loc8_ >= 0)
                  {
                     if((_loc9_ = this.m_WorldMapStorage.getObject(_loc6_,_loc7_,_loc8_,0)) != null && (_loc10_ = _loc9_.type) != null && Boolean(_loc10_.isFullBank))
                     {
                        this.m_MinZPlane[_loc4_] = _loc8_;
                        break;
                     }
                     _loc8_--;
                  }
                  _loc6_++;
               }
               _loc7_++;
            }
            this.m_WorldMapStorage.m_CacheFullbank = true;
         }
         _loc8_ = 0;
         while(_loc8_ <= this.m_MaxZPlane)
         {
            _loc11_ = this.m_WorldMapStorage.m_Position.z <= 7?Number(this.m_WorldMapStorage.getAmbientBrightness()):Number(0);
            _loc4_ = this.m_CreatureCount.length - 1;
            while(_loc4_ >= 0)
            {
               this.m_CreatureCount[_loc4_] = 0;
               _loc4_--;
            }
            _loc6_ = 0;
            while(_loc6_ < MAPSIZE_X)
            {
               _loc7_ = 0;
               while(_loc7_ < MAPSIZE_Y)
               {
                  _loc14_ = this.m_WorldMapStorage.getField(_loc6_,_loc7_,_loc8_);
                  _loc15_ = null;
                  _loc4_ = _loc14_.m_ObjectsCount - 1;
                  while(_loc4_ >= _loc14_.m_CacheObjectsCount)
                  {
                     if(!((_loc9_ = _loc14_.m_ObjectsRenderer[_loc4_]) == null || _loc9_.ID != AppearanceInstance.CREATURE || (_loc15_ = this.m_CreatureStorage.getCreature(_loc9_.data)) == null))
                     {
                        _loc16_ = 0;
                        _loc17_ = 0;
                        if(_loc15_.mountOutfit != null)
                        {
                           _loc16_ = _loc15_.mountOutfit.type.displacementX;
                           _loc17_ = _loc15_.mountOutfit.type.displacementY;
                        }
                        else if(_loc15_.outfit != null)
                        {
                           _loc16_ = _loc15_.outfit.type.displacementX;
                           _loc17_ = _loc15_.outfit.type.displacementY;
                        }
                        _loc18_ = (_loc6_ + 1) * FIELD_SIZE + _loc15_.animationDelta.x - _loc16_;
                        _loc19_ = (_loc7_ + 1) * FIELD_SIZE + _loc15_.animationDelta.y - _loc17_;
                        _loc20_ = int((_loc18_ - 1) / FIELD_SIZE);
                        _loc21_ = int((_loc19_ - 1) / FIELD_SIZE);
                        _loc22_ = _loc21_ * MAPSIZE_X + _loc20_;
                        if(!(_loc22_ < 0 || _loc22_ >= MAPSIZE_X * MAPSIZE_Y))
                        {
                           _loc23_ = this.m_CreatureField[_loc22_];
                           _loc24_ = 0;
                           while(_loc24_ < this.m_CreatureCount[_loc22_] && (_loc25_ = _loc23_[_loc24_]) != null && (_loc25_.y < _loc19_ || _loc25_.y == _loc19_ && _loc25_.x <= _loc18_))
                           {
                              _loc24_++;
                           }
                           if(_loc24_ < MAPSIZE_W)
                           {
                              if(this.m_CreatureCount[_loc22_] < MAPSIZE_W)
                              {
                                 this.m_CreatureCount[_loc22_]++;
                              }
                              _loc25_ = _loc23_[this.m_CreatureCount[_loc22_] - 1];
                              _loc5_ = this.m_CreatureCount[_loc22_] - 1;
                              while(_loc5_ > _loc24_)
                              {
                                 _loc23_[_loc5_] = _loc23_[_loc5_ - 1];
                                 _loc5_--;
                              }
                              _loc23_[_loc24_] = _loc25_;
                              _loc25_.update(_loc15_,_loc18_,_loc19_,_loc8_);
                           }
                        }
                     }
                     _loc4_--;
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            this.m_HelperCoordinate.setComponents(0,0,_loc8_);
            this.m_WorldMapStorage.toAbsolute(this.m_HelperCoordinate,this.m_HelperCoordinate);
            _loc12_ = 0;
            _loc13_ = MAPSIZE_X + MAPSIZE_Y;
            _loc12_ = 0;
            while(_loc12_ < _loc13_)
            {
               _loc7_ = Math.max(_loc12_ - MAPSIZE_X + 1,0);
               _loc6_ = Math.min(_loc12_,MAPSIZE_X - 1);
               while(_loc6_ >= 0 && _loc7_ < MAPSIZE_Y)
               {
                  this.drawField((_loc6_ + 1) * FIELD_SIZE,(_loc7_ + 1) * FIELD_SIZE,this.m_HelperCoordinate.x + _loc6_,this.m_HelperCoordinate.y + _loc7_,this.m_HelperCoordinate.z,_loc6_,_loc7_,_loc8_,true);
                  _loc6_--;
                  _loc7_++;
               }
               _loc12_++;
            }
            _loc8_++;
         }
         this.m_HelperPoint.setTo(0,0);
         this.m_MainLayer.copyPixels(this.m_AtmosphereLayer,this.m_Rectangle,this.m_HelperPoint,null,null,true);
         this.m_AtmosphereLayer.unlock();
         this.m_MainLayer.unlock();
         if(this.m_OptionsScaleMap)
         {
            this.m_ClipRect.width = MAP_WIDTH * FIELD_SIZE;
            this.m_ClipRect.height = MAP_HEIGHT * FIELD_SIZE;
            this.m_ClipRect.x = FIELD_SIZE + this.m_Player.animationDelta.x;
            this.m_ClipRect.y = FIELD_SIZE + this.m_Player.animationDelta.y;
            this.m_Transform.a = unscaledWidth / this.m_ClipRect.width;
            this.m_Transform.d = unscaledHeight / this.m_ClipRect.height;
            this.m_Transform.tx = -this.m_ClipRect.x * this.m_Transform.a;
            this.m_Transform.ty = -this.m_ClipRect.y * this.m_Transform.d;
         }
         else
         {
            this.m_ClipRect.width = Math.min(MAP_WIDTH * FIELD_SIZE,unscaledWidth);
            this.m_ClipRect.height = Math.min(MAP_HEIGHT * FIELD_SIZE,unscaledHeight);
            this.m_ClipRect.x = (MAP_WIDTH * FIELD_SIZE - this.m_ClipRect.width) / 2 + FIELD_SIZE + this.m_Player.animationDelta.x;
            this.m_ClipRect.y = (MAP_HEIGHT * FIELD_SIZE - this.m_ClipRect.height) / 2 + FIELD_SIZE + this.m_Player.animationDelta.y;
            this.m_Transform.a = 1;
            this.m_Transform.d = 1;
            this.m_Transform.tx = -this.m_ClipRect.x;
            this.m_Transform.ty = -this.m_ClipRect.y;
         }
         graphics.clear();
         graphics.beginBitmapFill(this.m_MainLayer,this.m_Transform,false,true);
         graphics.drawRect(0,0,unscaledWidth,unscaledHeight);
         graphics.endFill();
         this.drawCreatureStatus();
         this.drawTextualEffects();
         this.drawOnscreenMessages();
      }
      
      function pointToMap(param1:Number, param2:Number, param3:Boolean, param4:Vector3D = null) : Vector3D
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Field = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:AppearanceType = null;
         if(this.m_WorldMapStorage != null && (!param3 || this.m_Player != null))
         {
            _loc5_ = int((param1 - this.m_Transform.tx) / this.m_Transform.a / FIELD_SIZE);
            if(_loc5_ < 1 || _loc5_ > MAPSIZE_X - 3)
            {
               return null;
            }
            _loc6_ = int((param2 - this.m_Transform.ty) / this.m_Transform.d / FIELD_SIZE);
            if(_loc6_ < 1 || _loc6_ > MAPSIZE_Y - 3)
            {
               return null;
            }
            _loc7_ = -1;
            if(param3)
            {
               this.m_WorldMapStorage.toMap(this.m_Player.position,this.m_HelperCoordinate);
               _loc7_ = this.m_HelperCoordinate.z;
            }
            else
            {
               _loc8_ = this.m_MinZPlane[_loc6_ * MAPSIZE_X + _loc5_];
               _loc7_ = this.m_MaxZPlane;
               while(_loc7_ >= _loc8_)
               {
                  _loc9_ = this.m_WorldMapStorage.getField(_loc5_,_loc6_,_loc7_);
                  _loc10_ = 0;
                  _loc11_ = _loc9_.m_ObjectsCount;
                  while(_loc10_ < _loc11_)
                  {
                     _loc12_ = _loc9_.m_ObjectsRenderer[_loc10_].m_Type;
                     if((Boolean(_loc12_.isBank) || Boolean(_loc12_.isBottom)) && !_loc12_.isIgnoreLook)
                     {
                        _loc8_ = -1;
                        break;
                     }
                     _loc10_++;
                  }
                  if(_loc8_ < 0)
                  {
                     break;
                  }
                  _loc7_--;
               }
            }
            if(_loc7_ < 0 || _loc7_ >= MAPSIZE_Z)
            {
               return null;
            }
            if(param4 == null)
            {
               param4 = new Vector3D(_loc5_,_loc6_,_loc7_);
            }
            else
            {
               param4.setComponents(_loc5_,_loc6_,_loc7_);
            }
            return param4;
         }
         return null;
      }
      
      public function set player(param1:Player) : void
      {
         if(this.m_Player != param1)
         {
            this.m_Player = param1;
         }
      }
      
      private function drawHUDArc(param1:Number, param2:Number, param3:int, param4:int, param5:uint) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Point = null;
         param3 = Math.max(HUD_ARC_ORIENTATION_LEFT,Math.min(param3,HUD_ARC_ORIENTATION_RIGHT));
         param4 = Math.max(0,Math.min(param4,100));
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.m_HUDArcPoints == null || this.m_HUDArcScale != this.m_Transform.a)
         {
            this.m_HUDArcPoints = new Vector.<Number>(2 * 202,true);
            this.m_HUDArcScale = this.m_Transform.a;
            _loc6_ = 0;
            _loc7_ = 201;
            while(_loc6_ <= 100)
            {
               _loc12_ = (HUD_ARC_LOWER_LIMIT - _loc6_ / 100 * (HUD_ARC_LOWER_LIMIT - HUD_ARC_UPPER_LIMIT)) * (Math.PI / 180);
               _loc13_ = Point.polar(this.m_HUDArcScale * HUD_ARC_RADIUS,_loc12_);
               this.m_HUDArcPoints[2 * _loc6_ + 0] = _loc13_.x;
               this.m_HUDArcPoints[2 * _loc6_ + 1] = _loc13_.y;
               switch(this.m_HUDArcStyle)
               {
                  case HUD_ARC_STYLE_POINTY:
                     this.m_HUDArcPoints[2 * _loc7_ + 0] = _loc13_.x + (-0.0004 * _loc6_ * _loc6_ + 0.04 * _loc6_) * this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH;
                     this.m_HUDArcPoints[2 * _loc7_ + 1] = _loc13_.y;
                     break;
                  case HUD_ARC_STYLE_HORIZONTAL:
                     this.m_HUDArcPoints[2 * _loc7_ + 0] = _loc13_.x + this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH;
                     this.m_HUDArcPoints[2 * _loc7_ + 1] = _loc13_.y;
                     break;
                  case HUD_ARC_STYLE_RADIAL:
                     _loc13_ = Point.polar(this.m_Transform.a * HUD_ARC_RADIUS + this.m_HUDArcScale * HUD_ARC_TOTAL_WIDTH,_loc12_);
                     this.m_HUDArcPoints[2 * _loc7_ + 0] = _loc13_.x;
                     this.m_HUDArcPoints[2 * _loc7_ + 1] = _loc13_.y;
               }
               _loc6_++;
               _loc7_--;
            }
         }
         var _loc10_:Vector.<Number> = null;
         var _loc11_:Vector.<int> = null;
         if(param3 == HUD_ARC_ORIENTATION_LEFT)
         {
            _loc9_ = -1;
            param1 = param1 + Math.sin(HUD_ARC_LOWER_LIMIT * (Math.PI / 180)) * this.m_HUDArcScale * HUD_ARC_RADIUS;
         }
         else
         {
            _loc9_ = 1;
            param1 = param1 - Math.sin(HUD_ARC_LOWER_LIMIT * (Math.PI / 180)) * this.m_HUDArcScale * HUD_ARC_RADIUS;
         }
         if(param4 < 100)
         {
            _loc8_ = 2 * (100 - param4 + 1);
            _loc10_ = new Vector.<Number>(2 * (_loc8_ + 1),true);
            _loc6_ = 0;
            _loc7_ = param4;
            while(_loc6_ < _loc8_)
            {
               _loc10_[2 * _loc6_ + 0] = param1 + _loc9_ * this.m_HUDArcPoints[2 * _loc7_ + 0];
               _loc10_[2 * _loc6_ + 1] = param2 + this.m_HUDArcPoints[2 * _loc7_ + 1];
               _loc6_++;
               _loc7_++;
            }
            _loc10_[2 * _loc6_ + 0] = _loc10_[0];
            _loc10_[2 * _loc6_ + 1] = _loc10_[1];
            _loc11_ = new Vector.<int>(_loc8_ + 1,true);
            _loc11_[0] = GraphicsPathCommand.MOVE_TO;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc11_[_loc6_ + 1] = GraphicsPathCommand.LINE_TO;
               _loc6_++;
            }
            graphics.lineStyle(NaN,0,NaN);
            graphics.beginFill(0,0.33 * HUD_ARC_ALPHA);
            graphics.drawPath(_loc11_,_loc10_);
         }
         if(param4 > 0)
         {
            _loc8_ = 2 * (param4 + 1);
            _loc10_ = new Vector.<Number>(2 * (_loc8_ + 1),true);
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc6_ < param4 + 1)
            {
               _loc10_[2 * _loc6_ + 0] = param1 + _loc9_ * this.m_HUDArcPoints[2 * _loc7_ + 0];
               _loc10_[2 * _loc6_ + 1] = param2 + this.m_HUDArcPoints[2 * _loc7_ + 1];
               _loc6_++;
               _loc7_++;
            }
            _loc6_ = param4 + 1;
            _loc7_ = 202 - _loc6_;
            while(_loc6_ < _loc8_)
            {
               _loc10_[2 * _loc6_ + 0] = param1 + _loc9_ * this.m_HUDArcPoints[2 * _loc7_ + 0];
               _loc10_[2 * _loc6_ + 1] = param2 + this.m_HUDArcPoints[2 * _loc7_ + 1];
               _loc6_++;
               _loc7_++;
            }
            _loc10_[2 * _loc6_ + 0] = _loc10_[0];
            _loc10_[2 * _loc6_ + 1] = _loc10_[1];
            _loc11_ = new Vector.<int>(_loc8_ + 1,true);
            _loc11_[0] = GraphicsPathCommand.MOVE_TO;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc11_[_loc6_ + 1] = GraphicsPathCommand.LINE_TO;
               _loc6_++;
            }
            graphics.lineStyle(NaN,0,NaN);
            graphics.beginFill(param5,HUD_ARC_ALPHA);
            graphics.drawPath(_loc11_,_loc10_);
         }
         _loc8_ = 2 * (100 + 1);
         _loc10_ = new Vector.<Number>(2 * (_loc8_ + 1),true);
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc10_[2 * _loc6_ + 0] = param1 + _loc9_ * this.m_HUDArcPoints[2 * _loc7_ + 0];
            _loc10_[2 * _loc6_ + 1] = param2 + this.m_HUDArcPoints[2 * _loc7_ + 1];
            _loc6_++;
            _loc7_++;
         }
         _loc10_[2 * _loc6_ + 0] = _loc10_[0];
         _loc10_[2 * _loc6_ + 1] = _loc10_[1];
         _loc11_ = new Vector.<int>(_loc8_ + 1,true);
         _loc11_[0] = GraphicsPathCommand.MOVE_TO;
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc11_[_loc6_ + 1] = GraphicsPathCommand.LINE_TO;
            _loc6_++;
         }
         graphics.lineStyle(HUD_ARC_BORDER_WIDTH,0,1);
         graphics.beginFill(0,NaN);
         graphics.drawPath(_loc11_,_loc10_);
         graphics.lineStyle(NaN,0,NaN);
         graphics.beginFill(0,NaN);
         graphics.endFill();
      }
      
      function pointToAbsolute(param1:Number, param2:Number, param3:Boolean, param4:Vector3D = null) : Vector3D
      {
         var _loc5_:Vector3D = this.pointToMap(param1,param2,param3,param4);
         if(_loc5_ != null)
         {
            return this.m_WorldMapStorage.toAbsolute(_loc5_,_loc5_);
         }
         return null;
      }
      
      private function drawTextualEffects() : void
      {
         var _loc2_:TextualEffectInstance = null;
         this.m_HelperTrans.a = 1;
         this.m_HelperTrans.d = 1;
         var _loc1_:int = 0;
         while(_loc1_ < this.m_DrawnTextualEffectsCount)
         {
            _loc2_ = this.m_DrawnTextualEffects[_loc1_].object as TextualEffectInstance;
            if(_loc2_ != null)
            {
               this.m_HelperPoint.x = this.m_DrawnTextualEffects[_loc1_].x - _loc2_.width / 2;
               this.m_HelperPoint.y = this.m_DrawnTextualEffects[_loc1_].y;
               this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
               if(this.m_HelperPoint.x < 0)
               {
                  this.m_HelperPoint.x = 0;
               }
               if(this.m_HelperPoint.x + _loc2_.width > unscaledWidth)
               {
                  this.m_HelperPoint.x = unscaledWidth - _loc2_.width;
               }
               if(this.m_HelperPoint.y < 0)
               {
                  this.m_HelperPoint.y = 0;
               }
               if(this.m_HelperPoint.y + _loc2_.height > unscaledHeight)
               {
                  this.m_HelperPoint.y = unscaledHeight - _loc2_.height;
               }
               this.m_HelperTrans.tx = this.m_HelperPoint.x;
               this.m_HelperTrans.ty = this.m_HelperPoint.y;
               graphics.beginBitmapFill(_loc2_.m_InstanceBitmap,this.m_HelperTrans,false,false);
               graphics.drawRect(this.m_HelperPoint.x,this.m_HelperPoint.y,_loc2_.width,_loc2_.height);
            }
            _loc1_++;
         }
         graphics.endFill();
      }
      
      public function get creatureStorage() : CreatureStorage
      {
         return this.m_CreatureStorage;
      }
      
      private function layoutOnscreenMessages() : void
      {
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<OnscreenMessageBox> = this.m_WorldMapStorage.m_MessageBoxes;
         _loc1_ = _loc3_.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc3_[_loc1_] != null && Boolean(_loc3_[_loc1_].visible) && !_loc3_[_loc1_].empty)
            {
               _loc3_[_loc1_].arrangeMessages();
            }
            _loc1_--;
         }
         var _loc4_:Rectangle = new Rectangle(0,0,FIELD_SIZE * this.m_Transform.a,FIELD_SIZE * this.m_Transform.a);
         var _loc5_:Vector.<Rectangle> = new Vector.<Rectangle>(_loc3_.length,true);
         var _loc6_:Vector.<Rectangle> = new Vector.<Rectangle>(_loc3_.length,true);
         var _loc7_:Vector.<Point> = new Vector.<Point>(_loc3_.length,true);
         _loc1_ = _loc3_.length - 1;
         while(_loc1_ >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
         {
            if(_loc3_[_loc1_] != null && Boolean(_loc3_[_loc1_].visible) && !_loc3_[_loc1_].empty)
            {
               switch(_loc1_)
               {
                  case WorldMapStorage.ONSCREEN_TARGET_BOX_LOW:
                     _loc3_[_loc1_].fixing = OnscreenMessageBox.FIXING_BOTH;
                     this.m_HelperPoint.x = unscaledWidth / 2;
                     this.m_HelperPoint.y = (unscaledHeight + _loc4_.height + _loc3_[_loc1_].height + ONSCREEN_MESSAGE_GAP) / 2;
                     break;
                  case WorldMapStorage.ONSCREEN_TARGET_BOX_HIGH:
                     _loc3_[_loc1_].fixing = OnscreenMessageBox.FIXING_BOTH;
                     this.m_HelperPoint.x = unscaledWidth / 2;
                     this.m_HelperPoint.y = (unscaledHeight + _loc4_.height - _loc3_[_loc1_].height - ONSCREEN_MESSAGE_GAP) / 2;
                     break;
                  case WorldMapStorage.ONSCREEN_TARGET_BOX_TOP:
                     _loc3_[_loc1_].fixing = OnscreenMessageBox.FIXING_BOTH;
                     this.m_HelperPoint.x = unscaledWidth / 2;
                     this.m_HelperPoint.y = unscaledHeight / 4;
                     break;
                  default:
                     _loc3_[_loc1_].fixing = OnscreenMessageBox.FIXING_NONE;
                     this.m_WorldMapStorage.toMapClosest(_loc3_[_loc1_].position,this.m_HelperCoordinate);
                     this.m_HelperPoint.x = (this.m_HelperCoordinate.x - 1) * _loc4_.width + _loc4_.width / 2;
                     this.m_HelperPoint.y = (this.m_HelperCoordinate.y - 1) * _loc4_.height - _loc3_[_loc1_].height / 2;
               }
               _loc7_[_loc1_] = new Point();
               _loc5_[_loc1_] = new Rectangle();
               _loc5_[_loc1_].x = this.m_HelperPoint.x - (_loc3_[_loc1_].width + ONSCREEN_MESSAGE_GAP) / 2;
               _loc5_[_loc1_].y = this.m_HelperPoint.y - (_loc3_[_loc1_].height + ONSCREEN_MESSAGE_GAP) / 2;
               _loc5_[_loc1_].width = _loc3_[_loc1_].width + ONSCREEN_MESSAGE_GAP;
               _loc5_[_loc1_].height = _loc3_[_loc1_].height + ONSCREEN_MESSAGE_GAP;
               _loc6_[_loc1_] = new Rectangle();
               _loc6_[_loc1_].x = _loc5_[_loc1_].x - _loc5_[_loc1_].width / 2;
               _loc6_[_loc1_].y = _loc5_[_loc1_].y - _loc5_[_loc1_].height / 2;
               _loc6_[_loc1_].width = _loc5_[_loc1_].width;
               _loc6_[_loc1_].height = _loc5_[_loc1_].height;
            }
            _loc1_--;
         }
         var _loc8_:Number = Number.POSITIVE_INFINITY;
         var _loc9_:Number = 0;
         do
         {
            _loc9_ = _loc8_;
            _loc8_ = 0;
            _loc1_ = _loc5_.length - 1;
            while(_loc1_ >= 0)
            {
               if(_loc5_[_loc1_] != null)
               {
                  _loc7_[_loc1_].x = 0;
                  _loc7_[_loc1_].y = 0;
                  _loc10_ = Math.sqrt(_loc5_[_loc1_].width * _loc5_[_loc1_].width + _loc5_[_loc1_].height * _loc5_[_loc1_].height);
                  _loc2_ = _loc5_.length - 1;
                  while(_loc2_ >= 0)
                  {
                     if(_loc1_ != _loc2_ && _loc5_[_loc2_] != null)
                     {
                        _loc11_ = _loc5_[_loc1_].intersection(_loc5_[_loc2_]);
                        if(!_loc11_.isEmpty())
                        {
                           this.m_HelperPoint.x = Math.floor(_loc5_[_loc1_].x + _loc5_[_loc1_].width / 2) - Math.floor(_loc5_[_loc2_].x + _loc5_[_loc2_].width / 2);
                           this.m_HelperPoint.y = Math.floor(_loc5_[_loc1_].y + _loc5_[_loc1_].height / 2) - Math.floor(_loc5_[_loc2_].y + _loc5_[_loc2_].height / 2);
                           _loc8_ = _loc8_ + _loc11_.width * _loc11_.height * Math.pow(0.5,this.m_HelperPoint.length / _loc10_ - 1);
                           if(this.m_HelperPoint.x < 0)
                           {
                              _loc7_[_loc1_].x = _loc7_[_loc1_].x - _loc11_.width;
                           }
                           else if(this.m_HelperPoint.x > 0)
                           {
                              _loc7_[_loc1_].x = _loc7_[_loc1_].x + _loc11_.width;
                           }
                           if(this.m_HelperPoint.y < 0)
                           {
                              _loc7_[_loc1_].y = _loc7_[_loc1_].y - _loc11_.height;
                           }
                           else if(this.m_HelperPoint.y > 0)
                           {
                              _loc7_[_loc1_].y = _loc7_[_loc1_].y + _loc11_.height;
                           }
                           if(this.m_HelperPoint.x == 0 && this.m_HelperPoint.y == 0 && _loc2_ == _loc5_.length - 1)
                           {
                              _loc7_[_loc1_].x = _loc7_[_loc1_].x + (_loc1_ - _loc2_);
                           }
                        }
                     }
                     _loc2_--;
                  }
               }
               _loc1_--;
            }
            _loc1_ = _loc5_.length - 1;
            while(_loc1_ >= 0)
            {
               if(_loc5_[_loc1_] != null)
               {
                  if(_loc7_[_loc1_].x > 0)
                  {
                     _loc5_[_loc1_].x = Math.max(_loc6_[_loc1_].left,Math.min(_loc5_[_loc1_].x + 1,_loc6_[_loc1_].right));
                  }
                  else if(_loc7_[_loc1_].x < 0)
                  {
                     _loc5_[_loc1_].x = Math.max(_loc6_[_loc1_].left,Math.min(_loc5_[_loc1_].x - 1,_loc6_[_loc1_].right));
                  }
                  if(_loc7_[_loc1_].y > 0)
                  {
                     _loc5_[_loc1_].y = Math.max(_loc6_[_loc1_].top,Math.min(_loc5_[_loc1_].y + 1,_loc6_[_loc1_].bottom));
                  }
                  else if(_loc7_[_loc1_].y < 0)
                  {
                     _loc5_[_loc1_].y = Math.max(_loc6_[_loc1_].top,Math.min(_loc5_[_loc1_].y - 1,_loc6_[_loc1_].bottom));
                  }
               }
               _loc1_--;
            }
         }
         while(_loc8_ < _loc9_);
         
         _loc1_ = _loc3_.length - 1;
         while(_loc1_ >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
         {
            if(_loc3_[_loc1_] != null && Boolean(_loc3_[_loc1_].visible) && !_loc3_[_loc1_].empty)
            {
               _loc3_[_loc1_].x = Math.max(_loc6_[_loc1_].left,Math.min(_loc5_[_loc1_].x,_loc6_[_loc1_].right)) + ONSCREEN_MESSAGE_GAP / 2;
               _loc3_[_loc1_].y = Math.max(_loc6_[_loc1_].top,Math.min(_loc5_[_loc1_].y,_loc6_[_loc1_].bottom)) + ONSCREEN_MESSAGE_GAP / 2;
            }
            _loc1_--;
         }
      }
      
      private function drawCreatureStatusHUD(param1:Creature, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void
      {
         var _loc14_:Rectangle = null;
         var _loc9_:* = param1.ID == this.m_Player.ID;
         var _loc10_:Colour = null;
         var _loc11_:Colour = null;
         if(param4)
         {
            _loc10_ = Creature.s_GetHealthColour(param1.hitpointsPercent);
            _loc11_ = new Colour(0,0,255);
         }
         else
         {
            _loc10_ = new Colour(192,192,192);
            _loc11_ = new Colour(192,192,192);
         }
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         if(param1.mountOutfit != null)
         {
            _loc12_ = param2 - param1.mountOutfit.m_Type.exactSize / 2;
            _loc13_ = param3 - param1.mountOutfit.m_Type.exactSize / 2;
         }
         else if(param1.outfit != null)
         {
            _loc12_ = param2 - param1.outfit.m_Type.exactSize / 2;
            _loc13_ = param3 - param1.outfit.m_Type.exactSize / 2;
         }
         if((Boolean(_loc9_) || Boolean(param4)) && Boolean(param6))
         {
            this.m_HelperPoint.x = _loc12_ - 3 * FIELD_SIZE / 2;
            this.m_HelperPoint.y = _loc13_;
            this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
            this.drawHUDArc(this.m_HelperPoint.x,this.m_HelperPoint.y,HUD_ARC_ORIENTATION_LEFT,param1.hitpointsPercent,_loc10_.RGB);
         }
         if((Boolean(_loc9_) || Boolean(param4)) && Boolean(param7))
         {
            this.m_HelperPoint.x = _loc12_ + 3 * FIELD_SIZE / 2;
            this.m_HelperPoint.y = _loc13_;
            this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
            this.drawHUDArc(this.m_HelperPoint.x,this.m_HelperPoint.y,HUD_ARC_ORIENTATION_RIGHT,param1.manaPercent,_loc11_.RGB);
         }
         if(param5)
         {
            _loc14_ = this.m_CreatureNameCache.getItem(param1.name + _loc10_.toString(),param1.name,_loc10_.RGB);
            this.m_HelperPoint.x = param2 - FIELD_SIZE / 2;
            this.m_HelperPoint.y = param3 - FIELD_SIZE;
            this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
            this.m_HelperPoint.x = Math.max(0,Math.min(this.m_HelperPoint.x - _loc14_.width / 2,unscaledWidth - _loc14_.width));
            this.m_HelperPoint.y = Math.max(0,Math.min(this.m_HelperPoint.y - _loc14_.height,unscaledHeight - _loc14_.height));
            this.m_HelperTrans.tx = this.m_HelperPoint.x - _loc14_.x;
            this.m_HelperTrans.ty = this.m_HelperPoint.y - _loc14_.y;
            graphics.beginBitmapFill(this.m_CreatureNameCache,this.m_HelperTrans,false,false);
            graphics.drawRect(this.m_HelperPoint.x,this.m_HelperPoint.y,_loc14_.width,_loc14_.height);
            graphics.endFill();
         }
         if(param8)
         {
            this.drawCreatureMarks(param1,param2 - FIELD_SIZE / 2,param3 - FIELD_SIZE,param4);
         }
      }
      
      private function drawOnscreenMessages() : void
      {
         var _loc8_:OnscreenMessageBox = null;
         if(this.m_WorldMapStorage.m_LayoutOnscreenMessages)
         {
            this.layoutOnscreenMessages();
            this.m_WorldMapStorage.m_LayoutOnscreenMessages = false;
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(this.m_Player != null)
         {
            _loc1_ = this.m_Player.animationDelta.x * this.m_Transform.a;
            _loc2_ = this.m_Player.animationDelta.y * this.m_Transform.d;
         }
         var _loc3_:Vector.<OnscreenMessageBox> = this.m_WorldMapStorage.m_MessageBoxes;
         var _loc4_:Number = 0;
         if((_loc8_ = _loc3_[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM]) != null && Boolean(_loc8_.visible) && !_loc8_.empty)
         {
            _loc4_ = _loc8_.height;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc8_ = null;
         var _loc9_:BitmapData = null;
         this.m_HelperTrans.a = 1;
         this.m_HelperTrans.d = 1;
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= WorldMapStorage.ONSCREEN_TARGET_BOX_LOW)
         {
            if((_loc8_ = _loc3_[_loc5_]) != null && Boolean(_loc8_.visible) && !_loc8_.empty)
            {
               this.m_HelperPoint.x = _loc8_.x;
               this.m_HelperPoint.y = _loc8_.y;
               if((_loc8_.fixing & OnscreenMessageBox.FIXING_X) == 0)
               {
                  this.m_HelperPoint.x = this.m_HelperPoint.x - _loc1_;
               }
               if((_loc8_.fixing & OnscreenMessageBox.FIXING_Y) == 0)
               {
                  this.m_HelperPoint.y = this.m_HelperPoint.y - _loc2_;
               }
               this.m_HelperPoint.x = Math.max(0,Math.min(this.m_HelperPoint.x,unscaledWidth - _loc8_.width));
               this.m_HelperPoint.y = Math.max(0,Math.min(this.m_HelperPoint.y,unscaledHeight - _loc4_ - _loc8_.height));
               _loc6_ = 0;
               _loc7_ = _loc8_.visibleMessages;
               while(_loc6_ < _loc7_)
               {
                  _loc9_ = _loc8_.getCacheBitmap(_loc6_,this.m_HelperRect);
                  this.m_HelperTrans.tx = -this.m_HelperRect.x + this.m_HelperPoint.x + (_loc8_.width - this.m_HelperRect.width) / 2;
                  this.m_HelperTrans.ty = -this.m_HelperRect.y + this.m_HelperPoint.y;
                  graphics.beginBitmapFill(_loc9_,this.m_HelperTrans,false,false);
                  graphics.drawRect(this.m_HelperPoint.x + (_loc8_.width - this.m_HelperRect.width) / 2,this.m_HelperPoint.y,this.m_HelperRect.width,this.m_HelperRect.height);
                  this.m_HelperPoint.y = this.m_HelperPoint.y + this.m_HelperRect.height;
                  _loc6_++;
               }
            }
            _loc5_--;
         }
         if((_loc8_ = _loc3_[WorldMapStorage.ONSCREEN_TARGET_BOX_BOTTOM]) != null && Boolean(_loc8_.visible) && !_loc8_.empty)
         {
            _loc9_ = _loc8_.getCacheBitmap(0,this.m_HelperRect);
            this.m_HelperPoint.x = (unscaledWidth - this.m_HelperRect.width) / 2;
            this.m_HelperPoint.y = unscaledHeight - this.m_HelperRect.height;
            this.m_HelperTrans.tx = -this.m_HelperRect.x + this.m_HelperPoint.x;
            this.m_HelperTrans.ty = -this.m_HelperRect.y + this.m_HelperPoint.y;
            graphics.beginBitmapFill(_loc9_,this.m_HelperTrans,false,false);
            graphics.drawRect(this.m_HelperPoint.x,this.m_HelperPoint.y,this.m_HelperRect.width,this.m_HelperRect.height);
         }
      }
      
      public function set options(param1:OptionsStorage) : void
      {
         if(this.m_Options != param1)
         {
            if(this.m_Options != null)
            {
               this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
            this.m_Options = param1;
            if(this.m_Options != null)
            {
               this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onOptionsChange);
            }
            this.updateOptions();
         }
      }
      
      public function get player() : Player
      {
         return this.m_Player;
      }
      
      public function set worldMapStorage(param1:WorldMapStorage) : void
      {
         if(this.m_WorldMapStorage != param1)
         {
            this.m_WorldMapStorage = param1;
         }
      }
      
      private function drawCreatureMarks(param1:Creature, param2:int, param3:int, param4:Boolean) : void
      {
         if(!param1.isHuman)
         {
            return;
         }
         var _loc5_:Number = -2;
         var _loc6_:Number = -2;
         if(param1.partyFlag > PARTY_NONE)
         {
            _loc5_ = _loc5_ + (2 + CreatureStorage.STATE_FLAG_SIZE);
            _loc6_ = 2 + CreatureStorage.STATE_FLAG_SIZE;
         }
         if(param1.pkFlag > PK_NONE)
         {
            _loc5_ = _loc5_ + (2 + CreatureStorage.STATE_FLAG_SIZE);
            _loc6_ = 2 + CreatureStorage.STATE_FLAG_SIZE;
         }
         if(param1.warFlag > WAR_NONE)
         {
            _loc5_ = Math.max(_loc5_,2 + CreatureStorage.STATE_FLAG_SIZE);
            _loc6_ = 2 * (2 + CreatureStorage.STATE_FLAG_SIZE);
         }
         if(_loc5_ < 0 || _loc6_ < 0)
         {
            return;
         }
         this.m_HelperPoint.x = param2;
         this.m_HelperPoint.y = param3;
         this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
         this.m_HelperPoint.x = Math.max(0,Math.min(this.m_HelperPoint.x + 16 - CreatureStorage.STATE_FLAG_SIZE + 4,unscaledWidth - _loc5_));
         this.m_HelperPoint.y = Math.max(0,Math.min(this.m_HelperPoint.y + 1,unscaledHeight - _loc6_));
         var _loc7_:BitmapData = null;
         if(param1.partyFlag > PARTY_NONE)
         {
            _loc5_ = this.m_HelperPoint.x;
            _loc6_ = this.m_HelperPoint.y;
            if(param1.partyFlag != PARTY_LEADER_SEXP_INACTIVE_GUILTY && param1.partyFlag != PARTY_MEMBER_SEXP_INACTIVE_GUILTY || Boolean(Tibia.s_GetFrameFlash()))
            {
               _loc7_ = CreatureStorage.s_GetPartyFlag(param1.partyFlag,this.m_HelperRect);
               this.m_HelperTrans.tx = _loc5_ - this.m_HelperRect.x;
               this.m_HelperTrans.ty = _loc6_ - this.m_HelperRect.y;
               graphics.beginBitmapFill(_loc7_,this.m_HelperTrans,false,false);
               graphics.drawRect(_loc5_,_loc6_,this.m_HelperRect.width,this.m_HelperRect.height);
            }
         }
         if(param1.pkFlag > PK_NONE)
         {
            if(param1.partyFlag > PARTY_NONE)
            {
               this.m_HelperPoint.x = this.m_HelperPoint.x + (2 + CreatureStorage.STATE_FLAG_SIZE);
            }
            _loc5_ = this.m_HelperPoint.x;
            _loc6_ = this.m_HelperPoint.y;
            if(param1.pkEnd <= 0 || Boolean(Tibia.s_GetFrameFlash()))
            {
               _loc7_ = CreatureStorage.s_GetPKFlag(param1.pkFlag,this.m_HelperRect);
               this.m_HelperTrans.tx = _loc5_ - this.m_HelperRect.x;
               this.m_HelperTrans.ty = _loc6_ - this.m_HelperRect.y;
               graphics.beginBitmapFill(_loc7_,this.m_HelperTrans,false,false);
               graphics.drawRect(_loc5_,_loc6_,this.m_HelperRect.width,this.m_HelperRect.height);
            }
         }
         this.m_HelperPoint.y = this.m_HelperPoint.y + (2 + CreatureStorage.STATE_FLAG_SIZE);
         if(param1.warFlag > WAR_NONE)
         {
            _loc5_ = this.m_HelperPoint.x;
            _loc6_ = this.m_HelperPoint.y;
            _loc7_ = CreatureStorage.s_GetWarFlag(param1.warFlag,this.m_HelperRect);
            this.m_HelperTrans.tx = _loc5_ - this.m_HelperRect.x;
            this.m_HelperTrans.ty = _loc6_ - this.m_HelperRect.y;
            graphics.beginBitmapFill(_loc7_,this.m_HelperTrans,false,false);
            graphics.drawRect(_loc5_,_loc6_,this.m_HelperRect.width,this.m_HelperRect.height);
         }
         graphics.endFill();
      }
      
      public function reset() : void
      {
         this.m_StopwatchEnterFrame.reset();
         this.m_StopwatchShowFrame.reset();
      }
      
      private function drawCreatureStatus() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = false;
         var _loc1_:Creature = null;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_DrawnCreaturesCount)
         {
            _loc1_ = this.m_DrawnCreatures[_loc4_].object as Creature;
            if(_loc1_ != null)
            {
               if(_loc1_ == this.m_Player)
               {
                  _loc2_ = _loc4_;
               }
               else
               {
                  _loc5_ = int(this.m_DrawnCreatures[_loc4_].x / FIELD_SIZE);
                  _loc6_ = int(this.m_DrawnCreatures[_loc4_].y / FIELD_SIZE);
                  _loc7_ = this.m_DrawnCreatures[_loc4_].z >= this.m_MinZPlane[_loc6_ * MAPSIZE_X + _loc5_];
                  _loc3_ = this.m_Options != null?int(this.m_Options.statusCreatureStyle):int(STATUS_STYLE_OFF);
                  switch(_loc3_)
                  {
                     case STATUS_STYLE_OFF:
                        break;
                     case STATUS_STYLE_HUD:
                        this.drawCreatureStatusHUD(_loc1_,this.m_DrawnCreatures[_loc4_].x,this.m_DrawnCreatures[_loc4_].y,_loc7_,this.m_Options.statusCreatureName,this.m_Options.statusCreatureHealth,false,this.m_Options.statusCreatureFlags);
                        break;
                     case STATUS_STYLE_CLASSIC:
                        this.drawCreatureStatusClassic(_loc1_,this.m_DrawnCreatures[_loc4_].x,this.m_DrawnCreatures[_loc4_].y,_loc7_,this.m_Options.statusCreatureName,this.m_Options.statusCreatureHealth,false,this.m_Options.statusCreatureFlags);
                  }
               }
            }
            _loc4_++;
         }
         if(_loc2_ > -1)
         {
            _loc1_ = this.m_DrawnCreatures[_loc2_].object as Creature;
            _loc3_ = this.m_Options != null?int(this.m_Options.statusPlayerStyle):int(STATUS_STYLE_OFF);
            switch(_loc3_)
            {
               case STATUS_STYLE_OFF:
                  break;
               case STATUS_STYLE_HUD:
                  this.drawCreatureStatusHUD(_loc1_,this.m_DrawnCreatures[_loc2_].x,this.m_DrawnCreatures[_loc2_].y,true,this.m_Options.statusPlayerName,this.m_Options.statusPlayerHealth,this.m_Options.statusPlayerMana,this.m_Options.statusPlayerFlags);
                  break;
               case STATUS_STYLE_CLASSIC:
                  this.drawCreatureStatusClassic(_loc1_,this.m_DrawnCreatures[_loc2_].x,this.m_DrawnCreatures[_loc2_].y,true,this.m_Options.statusPlayerName,this.m_Options.statusPlayerHealth,this.m_Options.statusPlayerMana,this.m_Options.statusPlayerFlags);
            }
         }
      }
      
      public function get fps() : Number
      {
         var _loc1_:Number = this.m_StopwatchShowFrame.average;
         if(_loc1_ > 0)
         {
            return Math.round(1000 / _loc1_);
         }
         return 0;
      }
      
      private function drawCreatureStatusClassic(param1:Creature, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void
      {
         var _loc9_:* = param1.ID == this.m_Player.ID;
         var _loc10_:Colour = null;
         var _loc11_:Colour = null;
         if(param4)
         {
            _loc10_ = Creature.s_GetHealthColour(param1.hitpointsPercent);
            _loc11_ = new Colour(0,0,255);
         }
         else
         {
            _loc10_ = new Colour(192,192,192);
            _loc11_ = new Colour(192,192,192);
         }
         var _loc12_:Number = 0;
         var _loc13_:Number = -1;
         var _loc14_:Rectangle = null;
         if(param5)
         {
            _loc14_ = this.m_CreatureNameCache.getItem(param1.name + _loc10_.toString(),param1.name,_loc10_.RGB);
            _loc13_ = _loc13_ + (_loc14_.height + 1);
         }
         if(param6)
         {
            _loc13_ = _loc13_ + (4 + 1);
         }
         if(param7)
         {
            _loc13_ = _loc13_ + (4 + 1);
         }
         this.m_HelperPoint.x = param2 - FIELD_SIZE / 2;
         this.m_HelperPoint.y = param3 - FIELD_SIZE;
         this.m_HelperPoint = this.m_Transform.transformPoint(this.m_HelperPoint);
         this.m_HelperPoint.y = Math.max(0,Math.min(this.m_HelperPoint.y - _loc13_,unscaledHeight - _loc13_));
         if(param5)
         {
            _loc12_ = Math.max(1,Math.min(this.m_HelperPoint.x - _loc14_.width / 2,unscaledWidth - _loc14_.width - 1));
            _loc13_ = this.m_HelperPoint.y;
            this.m_HelperTrans.tx = _loc12_ - _loc14_.x;
            this.m_HelperTrans.ty = _loc13_ - _loc14_.y;
            graphics.beginBitmapFill(this.m_CreatureNameCache,this.m_HelperTrans,false,false);
            graphics.drawRect(_loc12_,_loc13_,_loc14_.width,_loc14_.height);
            this.m_HelperPoint.y = this.m_HelperPoint.y + (_loc14_.height + 1);
         }
         if(param6)
         {
            _loc12_ = Math.max(1,Math.min(this.m_HelperPoint.x - 14,unscaledWidth - 27 - 1));
            _loc13_ = this.m_HelperPoint.y;
            graphics.beginFill(0,1);
            graphics.drawRect(_loc12_,_loc13_,27,4);
            graphics.beginFill(_loc10_.RGB,1);
            graphics.drawRect(_loc12_ + 1,_loc13_ + 1,param1.hitpointsPercent / 4,2);
            this.m_HelperPoint.y = this.m_HelperPoint.y + (4 + 1);
         }
         if(param7)
         {
            _loc12_ = Math.max(1,Math.min(this.m_HelperPoint.x - 14,unscaledWidth - 27 - 1));
            _loc13_ = this.m_HelperPoint.y;
            graphics.beginFill(0,1);
            graphics.drawRect(_loc12_,_loc13_,27,4);
            graphics.beginFill(_loc11_.RGB,1);
            graphics.drawRect(_loc12_ + 1,_loc13_ + 1,param1.manaPercent / 4,2);
            this.m_HelperPoint.y = this.m_HelperPoint.y + (4 + 1);
         }
         if(param8)
         {
            this.drawCreatureMarks(param1,param2 - FIELD_SIZE / 2,param3 - FIELD_SIZE,param4);
         }
         graphics.endFill();
      }
      
      private function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "rendererAmbientBrightness":
               case "rendererMaxFrameRate":
               case "rendererLevelSeparator":
               case "rendererLightEnabled":
               case "rendererScaleMap":
               case "*":
                  this.updateOptions();
            }
         }
      }
   }
}
