package tibia.creatures
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import tibia.worldmap.widgetClasses.RendererImpl;
   import tibia.creatures.battlelistWidgetClasses.BattlelistItemRenderer;
   import shared.utility.Colour;
   import mx.core.FlexShape;
   import flash.display.Graphics;
   import mx.core.BitmapAsset;
   import mx.collections.Sort;
   import tibia.network.Connection;
   import shared.utility.Vector3D;
   import tibia.options.OptionsStorage;
   import mx.collections.IList;
   import mx.events.PropertyChangeEvent;
   import mx.collections.ArrayCollection;
   import tibia.appearances.ObjectInstance;
   import tibia.appearances.AppearanceInstance;
   
   public class CreatureStorage
   {
      
      protected static const RENDERER_DEFAULT_HEIGHT:Number = MAP_WIDTH * FIELD_SIZE;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      public static const SORT_DISTANCE_ASC:int = 2;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      private static const MARK_NUM_TOTAL:uint = MARK_TRAPPER + 1;
      
      private static const OPPONENTS_REFRESH:int = 1;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_FISHING:int = 13;
      
      public static const SORT_NAME_DESC:int = 7;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      public static const SORT_NAME_ASC:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const GROUND_LAYER:int = 7;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const SKILL_NONE:int = -1;
      
      private static var s_MarksPerRow:int = -1;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const PARTY_LEADER:int = 1;
      
      private static const STATE_FLAG_BITMAP:BitmapData = (new STATE_FLAG_CLASS() as BitmapAsset).bitmapData;
      
      public static const STATE_FLAG_SIZE:int = 11;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      public static const MARK_AIM:uint = MARK_NUM_COLOURS + 1;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      private static const OPPONENTS_NOACTION:int = 0;
      
      public static const FILTER_NON_SKULLED:int = 8;
      
      public static const MARK_AIM_FOLLOW:uint = MARK_NUM_COLOURS + 3;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
      
      protected static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      public static const SORT_KNOWN_SINCE_ASC:int = 0;
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      public static const FILTER_PARTY:int = 16;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      public static const MARK_UNMARKED:uint = 0;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      public static const MARK_TRAPPER:uint = MARK_NUM_COLOURS + 6;
      
      private static const OPPONENTS_REBUILD:int = 2;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      private static const STATE_FLAG_CLASS:Class = CreatureStorage_STATE_FLAG_CLASS;
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      public static const MARK_AIM_ATTACK:uint = MARK_NUM_COLOURS + 2;
      
      private static var s_CreatureMarks:BitmapData = null;
      
      protected static const STATE_FAST:int = 6;
      
      public static const MARK_FOLLOW:uint = MARK_NUM_COLOURS + 5;
      
      public static const FILTER_NPC:int = 2;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_OFFLINETRAINING:int = 17;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      public static const FILTER_PLAYER:int = 1;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const RENDERER_DEFAULT_WIDTH:Number = MAP_WIDTH * FIELD_SIZE;
      
      public static const FILTER_NONE:int = 0;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const STATE_POISONED:int = 0;
      
      public static const SORT_DISTANCE_DESC:int = 3;
      
      public static const SORT_KNOWN_SINCE_DESC:int = 1;
      
      private static const MARK_NUM_COLOURS:uint = 216;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      public static const SORT_HITPOINTS_ASC:int = 4;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const STATE_FIGHTING:int = 7;
      
      public static const SORT_HITPOINTS_DESC:int = 5;
      
      public static const FILTER_MONSTER:int = 4;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      public static const MARK_ATTACK:uint = MARK_NUM_COLOURS + 4;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
      
      {
         s_InitialiseCreatureMarks();
      }
      
      protected var m_OpponentsSort:Sort = null;
      
      protected var m_Player:tibia.creatures.Player = null;
      
      protected var m_CreatureCount:int = 0;
      
      protected var m_AttackTarget:tibia.creatures.Creature = null;
      
      protected var m_Options:OptionsStorage = null;
      
      protected var m_OpponentsState:int = 0;
      
      protected var m_Opponents:ArrayCollection = null;
      
      protected var m_Aim:tibia.creatures.Creature = null;
      
      protected var m_FollowTarget:tibia.creatures.Creature = null;
      
      protected var m_Trappers:Vector.<tibia.creatures.Creature> = null;
      
      protected var m_CreatureIndex:int = 0;
      
      protected var m_Creature:Vector.<tibia.creatures.Creature> = null;
      
      public function CreatureStorage()
      {
         super();
         this.m_Player = new tibia.creatures.Player();
         this.m_Creature = new Vector.<tibia.creatures.Creature>();
         this.m_OpponentsSort = new Sort();
         this.m_OpponentsSort.compareFunction = this.opponentComparator;
         this.m_Opponents = new ArrayCollection();
         this.m_Opponents.filterFunction = this.opponentFilter;
         this.m_Opponents.sort = this.m_OpponentsSort;
         this.m_Trappers = null;
      }
      
      public static function s_GetCreatureMark(param1:uint, param2:int, param3:Rectangle) : BitmapData
      {
         if(param1 >= MARK_NUM_TOTAL)
         {
            throw new ArgumentError("CreatureStorage.s_GetCreatureMark: Invalid mark ID: " + param1 + ".");
         }
         if(param2 != RendererImpl.CREATURE_MARK_SIZE_NORMAL && param2 != RendererImpl.CREATURE_MARK_SIZE_INNER && param2 != BattlelistItemRenderer.CREATURE_ICON_SIZE)
         {
            throw new ArgumentError("CreatureStorage.s_GetCreatureMark: Invalid size: " + param2 + ".");
         }
         if(param2 == RendererImpl.CREATURE_MARK_SIZE_NORMAL)
         {
            param1 = param1 + 0 * MARK_NUM_TOTAL;
         }
         else if(param2 == RendererImpl.CREATURE_MARK_SIZE_INNER)
         {
            param1 = param1 + 1 * MARK_NUM_TOTAL;
         }
         else if(param2 == BattlelistItemRenderer.CREATURE_ICON_SIZE)
         {
            param1 = param1 + 2 * MARK_NUM_TOTAL;
         }
         param3.x = param1 % s_MarksPerRow * FIELD_SIZE;
         param3.y = int(param1 / s_MarksPerRow) * FIELD_SIZE;
         param3.width = FIELD_SIZE;
         param3.height = FIELD_SIZE;
         return s_CreatureMarks;
      }
      
      private static function s_InitialiseCreatureMarks() : void
      {
         s_MarksPerRow = Math.min(Math.ceil(Math.sqrt(3 * MARK_NUM_TOTAL)),int(2080 / FIELD_SIZE));
         var _loc1_:int = int((3 * MARK_NUM_TOTAL + s_MarksPerRow - 1) / s_MarksPerRow);
         if(_loc1_ * FIELD_SIZE > 2080)
         {
            throw new Error("CreatureStorage.s_InitialiseCreatureMarks: Bitmap is too small to hold all marks.");
         }
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = new Vector.<uint>(MARK_NUM_TOTAL,true);
         _loc2_ = 0;
         while(_loc2_ < MARK_NUM_COLOURS)
         {
            _loc3_[_loc2_] = Colour.s_RGBFromEightBit(_loc2_);
            _loc2_++;
         }
         _loc3_[MARK_AIM] = 248 << 16 | 248 << 8 | 248;
         _loc3_[MARK_AIM_ATTACK] = 248 << 16 | 164 << 8 | 164;
         _loc3_[MARK_AIM_FOLLOW] = 180 << 16 | 248 << 8 | 180;
         _loc3_[MARK_ATTACK] = 224 << 16 | 64 << 8 | 64;
         _loc3_[MARK_FOLLOW] = 64 << 16 | 224 << 8 | 64;
         _loc3_[MARK_TRAPPER] = 191 << 16 | 127 << 8 | 0;
         var _loc4_:FlexShape = new FlexShape();
         var _loc5_:Graphics = _loc4_.graphics;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < MARK_NUM_TOTAL)
         {
            _loc5_.lineStyle(1,_loc3_[_loc2_],1,true);
            _loc6_ = (0 * MARK_NUM_TOTAL + _loc2_) % s_MarksPerRow;
            _loc7_ = int((0 * MARK_NUM_TOTAL + _loc2_) / s_MarksPerRow);
            _loc8_ = Math.floor((FIELD_SIZE - RendererImpl.CREATURE_MARK_SIZE_NORMAL) / 2);
            _loc5_.drawRect(_loc6_ * FIELD_SIZE + _loc8_,_loc7_ * FIELD_SIZE + _loc8_,RendererImpl.CREATURE_MARK_SIZE_NORMAL - 1,RendererImpl.CREATURE_MARK_SIZE_NORMAL - 1);
            _loc5_.drawRect(_loc6_ * FIELD_SIZE + _loc8_ + 1,_loc7_ * FIELD_SIZE + _loc8_ + 1,RendererImpl.CREATURE_MARK_SIZE_NORMAL - 3,RendererImpl.CREATURE_MARK_SIZE_NORMAL - 3);
            _loc6_ = (1 * MARK_NUM_TOTAL + _loc2_) % s_MarksPerRow;
            _loc7_ = int((1 * MARK_NUM_TOTAL + _loc2_) / s_MarksPerRow);
            _loc8_ = Math.floor((FIELD_SIZE - RendererImpl.CREATURE_MARK_SIZE_INNER) / 2);
            _loc5_.drawRect(_loc6_ * FIELD_SIZE + _loc8_,_loc7_ * FIELD_SIZE + _loc8_,RendererImpl.CREATURE_MARK_SIZE_INNER - 1,RendererImpl.CREATURE_MARK_SIZE_INNER - 1);
            _loc5_.drawRect(_loc6_ * FIELD_SIZE + _loc8_ + 1,_loc7_ * FIELD_SIZE + _loc8_ + 1,RendererImpl.CREATURE_MARK_SIZE_INNER - 3,RendererImpl.CREATURE_MARK_SIZE_INNER - 3);
            _loc6_ = (2 * MARK_NUM_TOTAL + _loc2_) % s_MarksPerRow;
            _loc7_ = int((2 * MARK_NUM_TOTAL + _loc2_) / s_MarksPerRow);
            _loc8_ = Math.floor((FIELD_SIZE - BattlelistItemRenderer.CREATURE_ICON_SIZE) / 2);
            _loc5_.drawRect(_loc6_ * FIELD_SIZE + _loc8_,_loc7_ * FIELD_SIZE + _loc8_,BattlelistItemRenderer.CREATURE_ICON_SIZE - 1,BattlelistItemRenderer.CREATURE_ICON_SIZE - 1);
            _loc2_++;
         }
         s_CreatureMarks = new BitmapData(s_MarksPerRow * FIELD_SIZE,_loc1_ * FIELD_SIZE,true,0);
         s_CreatureMarks.draw(_loc4_);
      }
      
      public static function s_GetPartyFlag(param1:int, param2:Rectangle) : BitmapData
      {
         if(param1 < PARTY_NONE || param1 > PARTY_LEADER_SEXP_INACTIVE_INNOCENT)
         {
            throw new ArgumentError("CreatureStorage.s_GetPartyFlag: Invalid flag.");
         }
         if(param1 == PARTY_LEADER_SEXP_INACTIVE_INNOCENT)
         {
            param1 = PARTY_LEADER_SEXP_INACTIVE_GUILTY;
         }
         if(param1 == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT)
         {
            param1 = PARTY_LEADER_SEXP_INACTIVE_GUILTY;
         }
         param2.x = param1 * STATE_FLAG_SIZE;
         param2.y = 0;
         param2.width = STATE_FLAG_SIZE;
         param2.height = STATE_FLAG_SIZE;
         return STATE_FLAG_BITMAP;
      }
      
      public static function s_GetWarFlag(param1:int, param2:Rectangle) : BitmapData
      {
         if(param1 < WAR_NONE || param1 > WAR_NEUTRAL)
         {
            throw new ArgumentError("CreatureStorage.s_GetWarFlag: Invalid flag.");
         }
         param2.x = param1 * STATE_FLAG_SIZE;
         param2.y = 2 * STATE_FLAG_SIZE;
         param2.width = STATE_FLAG_SIZE;
         param2.height = STATE_FLAG_SIZE;
         return STATE_FLAG_BITMAP;
      }
      
      public static function s_GetPKFlag(param1:int, param2:Rectangle) : BitmapData
      {
         if(param1 < PK_NONE || param1 > PK_REVENGE)
         {
            throw new ArgumentError("CreatureStorage.s_GetPKFlag: Invalid flag.");
         }
         param2.x = param1 * STATE_FLAG_SIZE;
         param2.y = STATE_FLAG_SIZE;
         param2.width = STATE_FLAG_SIZE;
         param2.height = STATE_FLAG_SIZE;
         return STATE_FLAG_BITMAP;
      }
      
      public function setAim(param1:tibia.creatures.Creature) : void
      {
         var _loc2_:tibia.creatures.Creature = null;
         if(this.m_Aim != param1)
         {
            _loc2_ = this.m_Aim;
            this.m_Aim = param1;
            this.updateExtendedMark(_loc2_);
            this.updateExtendedMark(this.m_Aim);
         }
      }
      
      public function getNextAttackTarget(param1:int) : tibia.creatures.Creature
      {
         param1 = param1 < 0?-1:1;
         var _loc2_:int = this.m_Opponents.length;
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         if(_loc2_ < 1)
         {
            return null;
         }
         if(this.m_AttackTarget != null)
         {
            _loc3_ = this.m_Opponents.getItemIndex(this.m_AttackTarget);
         }
         var _loc5_:tibia.creatures.Creature = null;
         while(_loc4_++ < _loc2_)
         {
            _loc3_ = _loc3_ + param1;
            if(_loc3_ >= _loc2_)
            {
               _loc3_ = 0;
            }
            if(_loc3_ < 0)
            {
               _loc3_ = _loc2_ - 1;
            }
            _loc5_ = Creature(this.m_Opponents.getItemAt(_loc3_));
            if(_loc5_.type != TYPE_NPC)
            {
               return _loc5_;
            }
         }
         return null;
      }
      
      public function getAim() : tibia.creatures.Creature
      {
         return this.m_Aim;
      }
      
      public function markAllOpponentsVisible(param1:Boolean) : void
      {
         var _loc2_:int = this.m_Opponents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            Creature(this.m_Opponents.getItemAt(_loc3_)).visible = param1;
            _loc3_++;
         }
         if(_loc2_ > 0)
         {
            this.invalidateOpponents();
         }
      }
      
      public function replaceCreature(param1:tibia.creatures.Creature, param2:int = 0) : tibia.creatures.Creature
      {
         if(param1 == null)
         {
            throw new ArgumentError("CreatureStorage.appendCreature: Invalid creature.");
         }
         if(param2 != 0)
         {
            this.removeCreature(param2);
         }
         if(this.m_CreatureCount >= NUM_CREATURES)
         {
            throw new Error("CreatureStorage.appendCreature: No space left to append " + param1.ID);
         }
         var _loc3_:int = 0;
         var _loc4_:* = -1;
         var _loc5_:int = 0;
         var _loc6_:int = this.m_CreatureCount - 1;
         var _loc7_:tibia.creatures.Creature = null;
         while(_loc5_ <= _loc6_)
         {
            _loc4_ = _loc5_ + _loc6_ >> 1;
            _loc7_ = this.m_Creature[_loc4_];
            if(_loc7_.ID == param1.ID)
            {
               return param1;
            }
            if(_loc7_.ID < param1.ID)
            {
               _loc5_ = _loc4_ + 1;
            }
            else
            {
               _loc6_ = _loc4_ - 1;
            }
         }
         param1.knownSince = ++this.m_CreatureIndex;
         this.m_Creature.splice(_loc5_,0,param1);
         this.m_CreatureCount++;
         this.m_OpponentsState = OPPONENTS_REBUILD;
         return param1;
      }
      
      public function toggleFollowTarget(param1:tibia.creatures.Creature, param2:Boolean) : void
      {
         if(param1 == this.m_Player)
         {
            throw new ArgumentError("CreatureStorage.toggleFollowTarget: Cannot follow player.");
         }
         var _loc3_:tibia.creatures.Creature = this.m_FollowTarget;
         if(_loc3_ != param1)
         {
            this.m_FollowTarget = param1;
         }
         else
         {
            this.m_FollowTarget = null;
         }
         var _loc4_:Connection = null;
         if(Boolean(param2) && (_loc4_ = Tibia.s_GetConnection()) != null && Boolean(_loc4_.isGameRunning))
         {
            if(this.m_FollowTarget != null)
            {
               _loc4_.sendCFOLLOW(this.m_FollowTarget.ID);
            }
            else
            {
               _loc4_.sendCFOLLOW(0);
            }
         }
         this.updateExtendedMark(_loc3_);
         this.updateExtendedMark(this.m_FollowTarget);
         var _loc5_:tibia.creatures.Creature = this.m_AttackTarget;
         if(_loc5_ != null)
         {
            this.m_AttackTarget = null;
            this.updateExtendedMark(_loc5_);
         }
      }
      
      public function getFollowTarget() : tibia.creatures.Creature
      {
         return this.m_FollowTarget;
      }
      
      public function getTrappers() : Vector.<tibia.creatures.Creature>
      {
         return this.m_Trappers;
      }
      
      public function refreshOpponents() : void
      {
         var _loc1_:int = 0;
         switch(this.m_OpponentsState)
         {
            case OPPONENTS_NOACTION:
               break;
            case OPPONENTS_REFRESH:
               this.m_Opponents.refresh();
               break;
            case OPPONENTS_REBUILD:
               this.m_Opponents.disableAutoUpdate();
               this.m_Opponents.filterFunction = null;
               this.m_Opponents.sort = null;
               this.m_Opponents.refresh();
               this.m_Opponents.removeAll();
               _loc1_ = 0;
               while(_loc1_ < this.m_CreatureCount)
               {
                  this.m_Opponents.addItem(this.m_Creature[_loc1_]);
                  _loc1_++;
               }
               this.m_Opponents.filterFunction = this.opponentFilter;
               this.m_Opponents.sort = this.m_OpponentsSort;
               this.m_Opponents.refresh();
               this.m_Opponents.enableAutoUpdate();
         }
         this.m_OpponentsState = OPPONENTS_NOACTION;
      }
      
      protected function opponentComparator(param1:Object, param2:Object, param3:Array = null) : int
      {
         var _loc4_:tibia.creatures.Creature = null;
         var _loc5_:tibia.creatures.Creature = null;
         var _loc8_:Vector3D = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         _loc4_ = param1 as tibia.creatures.Creature;
         _loc5_ = param2 as tibia.creatures.Creature;
         var _loc6_:int = 0;
         var _loc7_:Boolean = true;
         if(_loc4_ != null && _loc5_ != null && this.m_Options != null)
         {
            switch(this.m_Options.opponentSort)
            {
               case SORT_DISTANCE_DESC:
                  _loc7_ = false;
               case SORT_DISTANCE_ASC:
                  _loc8_ = this.m_Player.position;
                  _loc9_ = Math.max(Math.abs(_loc8_.x - _loc4_.position.x),Math.abs(_loc8_.y - _loc4_.position.y));
                  _loc10_ = Math.max(Math.abs(_loc8_.x - _loc5_.position.x),Math.abs(_loc8_.y - _loc5_.position.y));
                  if(_loc9_ < _loc10_)
                  {
                     _loc6_ = -1;
                  }
                  else if(_loc9_ > _loc10_)
                  {
                     _loc6_ = 1;
                  }
                  break;
               case SORT_HITPOINTS_DESC:
                  _loc7_ = false;
               case SORT_HITPOINTS_ASC:
                  if(_loc4_.hitpoints < _loc5_.hitpoints)
                  {
                     _loc6_ = -1;
                  }
                  else if(_loc4_.hitpoints > _loc5_.hitpoints)
                  {
                     _loc6_ = 1;
                  }
                  break;
               case SORT_NAME_DESC:
                  _loc7_ = false;
               case SORT_NAME_ASC:
                  if(_loc4_.name < _loc5_.name)
                  {
                     _loc6_ = -1;
                  }
                  else if(_loc4_.name > _loc5_.name)
                  {
                     _loc6_ = 1;
                  }
                  break;
               case SORT_KNOWN_SINCE_DESC:
                  _loc7_ = false;
               case SORT_KNOWN_SINCE_ASC:
            }
            if(_loc6_ == 0)
            {
               if(_loc4_.knownSince < _loc5_.knownSince)
               {
                  _loc6_ = -1;
               }
               else if(_loc4_.knownSince > _loc5_.knownSince)
               {
                  _loc6_ = 1;
               }
            }
         }
         if(_loc7_)
         {
            return _loc6_;
         }
         return -_loc6_;
      }
      
      public function setFollowTarget(param1:tibia.creatures.Creature, param2:Boolean) : void
      {
         var _loc5_:Connection = null;
         if(param1 == this.m_Player)
         {
            throw new ArgumentError("CreatureStorage.setFollowTarget: Cannot follow player.");
         }
         var _loc3_:tibia.creatures.Creature = this.m_FollowTarget;
         if(_loc3_ != param1)
         {
            this.m_FollowTarget = param1;
            _loc5_ = null;
            if(Boolean(param2) && (_loc5_ = Tibia.s_GetConnection()) != null && Boolean(_loc5_.isGameRunning))
            {
               if(this.m_FollowTarget != null)
               {
                  _loc5_.sendCFOLLOW(this.m_FollowTarget.ID);
               }
               else
               {
                  _loc5_.sendCFOLLOW(0);
               }
            }
            this.updateExtendedMark(_loc3_);
            this.updateExtendedMark(this.m_FollowTarget);
         }
         var _loc4_:tibia.creatures.Creature = this.m_AttackTarget;
         if(_loc4_ != null)
         {
            this.m_AttackTarget = null;
            this.updateExtendedMark(_loc4_);
         }
      }
      
      public function get options() : OptionsStorage
      {
         return this.m_Options;
      }
      
      public function isOpponent(param1:tibia.creatures.Creature) : Boolean
      {
         return this.opponentFilter(param1,false);
      }
      
      protected function updateExtendedMark(param1:tibia.creatures.Creature) : void
      {
         var _loc2_:uint = 0;
         if(param1 != null)
         {
            _loc2_ = MARK_UNMARKED;
            if(param1 == this.m_Aim && param1 == this.m_AttackTarget)
            {
               _loc2_ = MARK_AIM_ATTACK;
            }
            else if(param1 == this.m_Aim && param1 == this.m_FollowTarget)
            {
               _loc2_ = MARK_AIM_FOLLOW;
            }
            else if(param1 == this.m_Aim)
            {
               _loc2_ = MARK_AIM;
            }
            else if(param1 == this.m_AttackTarget)
            {
               _loc2_ = MARK_ATTACK;
            }
            else if(param1 == this.m_FollowTarget)
            {
               _loc2_ = MARK_FOLLOW;
            }
            param1.extendedMarkID = _loc2_;
         }
      }
      
      public function setTrappers(param1:Vector.<tibia.creatures.Creature>) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.m_Trappers != null?this.m_Trappers.length:0 - 1;
         while(_loc2_ >= 0)
         {
            if(this.m_Trappers[_loc2_] != null)
            {
               this.m_Trappers[_loc2_].isTrapper = false;
            }
            _loc2_--;
         }
         this.m_Trappers = param1;
         _loc2_ = this.m_Trappers != null?this.m_Trappers.length:0 - 1;
         while(_loc2_ >= 0)
         {
            if(this.m_Trappers[_loc2_] != null)
            {
               this.m_Trappers[_loc2_].isTrapper = true;
            }
            _loc2_--;
         }
      }
      
      public function getCreature(param1:int) : tibia.creatures.Creature
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = this.m_CreatureCount - 1;
         var _loc5_:tibia.creatures.Creature = null;
         while(_loc3_ <= _loc4_)
         {
            _loc2_ = _loc3_ + _loc4_ >> 1;
            _loc5_ = this.m_Creature[_loc2_];
            if(_loc5_.ID == param1)
            {
               return _loc5_;
            }
            if(_loc5_.ID < param1)
            {
               _loc3_ = _loc2_ + 1;
            }
            else
            {
               _loc4_ = _loc2_ - 1;
            }
         }
         return null;
      }
      
      public function get opponents() : IList
      {
         return this.m_Opponents;
      }
      
      public function invalidateOpponents() : void
      {
         if(this.m_OpponentsState < OPPONENTS_REFRESH)
         {
            this.m_OpponentsState = OPPONENTS_REFRESH;
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
            this.invalidateOpponents();
            this.refreshOpponents();
         }
      }
      
      public function markOpponentVisible(param1:*, param2:Boolean) : void
      {
         var _loc3_:tibia.creatures.Creature = null;
         if(param1 is tibia.creatures.Creature)
         {
            _loc3_ = Creature(param1);
         }
         else if(param1 is ObjectInstance && ObjectInstance(param1).ID == AppearanceInstance.CREATURE)
         {
            _loc3_ = this.getCreature(ObjectInstance(param1).ID);
         }
         else if(param1 is int)
         {
            _loc3_ = this.getCreature(int(param1));
         }
         else
         {
            throw new ArgumentError("CreatureStorage.hideOpponent: Invalid overload.");
         }
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            this.invalidateOpponents();
         }
      }
      
      protected function opponentFilter(param1:Object, param2:Boolean = true) : Boolean
      {
         var _loc3_:tibia.creatures.Creature = param1 as tibia.creatures.Creature;
         if(_loc3_ == null || _loc3_ is tibia.creatures.Player)
         {
            return false;
         }
         if(!_loc3_.visible || _loc3_.hitpoints <= 0)
         {
            return false;
         }
         var _loc4_:Vector3D = _loc3_.position;
         var _loc5_:Vector3D = this.m_Player.position;
         if(_loc4_.z != _loc5_.z || Math.abs(_loc4_.x - _loc5_.x) > MAP_WIDTH / 2 || Math.abs(_loc4_.y - _loc5_.y) > MAP_HEIGHT / 2)
         {
            return false;
         }
         var _loc6_:int = FILTER_NONE;
         if(Boolean(param2) && this.m_Options != null && (_loc6_ = this.m_Options.opponentFilter) != FILTER_NONE)
         {
            if((_loc6_ & FILTER_PLAYER) > 0 && _loc3_.type == TYPE_PLAYER)
            {
               return false;
            }
            if((_loc6_ & FILTER_NPC) > 0 && _loc3_.type == TYPE_NPC)
            {
               return false;
            }
            if((_loc6_ & FILTER_MONSTER) > 0 && _loc3_.type == TYPE_MONSTER)
            {
               return false;
            }
            if((_loc6_ & FILTER_NON_SKULLED) > 0 && _loc3_.type == TYPE_PLAYER && _loc3_.pkFlag == PK_NONE)
            {
               return false;
            }
            if((_loc6_ & FILTER_PARTY) > 0 && _loc3_.partyFlag != PARTY_NONE)
            {
               return false;
            }
         }
         return true;
      }
      
      public function reset() : void
      {
         this.m_Player.reset();
         var _loc1_:int = this.m_Creature.length - 1;
         while(_loc1_ >= 0)
         {
            if(this.m_Creature[_loc1_] != null)
            {
               this.m_Creature[_loc1_].reset();
               this.m_Creature[_loc1_] = null;
            }
            _loc1_--;
         }
         this.m_Creature.length = 0;
         this.m_CreatureCount = 0;
         this.m_CreatureIndex = 0;
         this.m_Opponents.removeAll();
         this.m_OpponentsState = OPPONENTS_NOACTION;
         this.m_Aim = null;
         this.m_AttackTarget = null;
         this.m_FollowTarget = null;
         this.m_Trappers = null;
      }
      
      protected function onOptionsChange(param1:PropertyChangeEvent) : void
      {
         switch(param1.property)
         {
            case "opponentSort":
            case "opponentFilter":
            case "*":
               this.invalidateOpponents();
               this.refreshOpponents();
         }
      }
      
      public function removeCreature(param1:int) : void
      {
         var _loc2_:int = -1;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = this.m_CreatureCount - 1;
         var _loc6_:tibia.creatures.Creature = null;
         while(_loc4_ <= _loc5_)
         {
            _loc3_ = _loc4_ + _loc5_ >> 1;
            _loc6_ = this.m_Creature[_loc3_];
            if(_loc6_.ID == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
            if(_loc6_.ID < param1)
            {
               _loc4_ = _loc3_ + 1;
            }
            else
            {
               _loc5_ = _loc3_ - 1;
            }
         }
         if(_loc6_ == null || _loc2_ < 0)
         {
            throw new Error("CreatureStorage.removeCreature: Creature " + param1 + " not found.");
         }
         if(_loc6_ == this.m_Player)
         {
            throw new Error("CreatureStorage.removeCreature: Can\'t remove the player.");
         }
         if(_loc6_ == this.m_Aim)
         {
            this.m_Aim = null;
            this.updateExtendedMark(_loc6_);
         }
         if(_loc6_ == this.m_AttackTarget)
         {
            this.m_AttackTarget = null;
            this.updateExtendedMark(_loc6_);
         }
         if(_loc6_ == this.m_FollowTarget)
         {
            this.m_FollowTarget = null;
            this.updateExtendedMark(_loc6_);
         }
         _loc3_ = int(this.m_Trappers != null?this.m_Trappers.length:0 - 1);
         while(_loc3_ >= 0)
         {
            if(_loc6_ == this.m_Trappers[_loc3_])
            {
               this.m_Trappers[_loc3_].isTrapper = false;
               this.m_Trappers[_loc3_] = null;
            }
            _loc3_--;
         }
         _loc6_.reset();
         this.m_Creature.splice(_loc2_,1);
         this.m_CreatureCount--;
         this.m_OpponentsState = OPPONENTS_REBUILD;
      }
      
      public function get player() : tibia.creatures.Player
      {
         return this.m_Player;
      }
      
      public function toggleAttackTarget(param1:tibia.creatures.Creature, param2:Boolean) : void
      {
         if(param1 == this.m_Player)
         {
            throw new ArgumentError("CreatureStorage.toggleAttackTarget: Cannot attack player.");
         }
         var _loc3_:tibia.creatures.Creature = this.m_AttackTarget;
         if(_loc3_ != param1)
         {
            this.m_AttackTarget = param1;
         }
         else
         {
            this.m_AttackTarget = null;
         }
         var _loc4_:Connection = null;
         if(Boolean(param2) && (_loc4_ = Tibia.s_GetConnection()) != null && Boolean(_loc4_.isGameRunning))
         {
            if(this.m_AttackTarget != null)
            {
               _loc4_.sendCATTACK(this.m_AttackTarget.ID);
            }
            else
            {
               _loc4_.sendCATTACK(0);
            }
         }
         this.updateExtendedMark(_loc3_);
         this.updateExtendedMark(this.m_AttackTarget);
         var _loc5_:tibia.creatures.Creature = this.m_FollowTarget;
         if(this.m_AttackTarget != null && _loc5_ != null)
         {
            this.m_FollowTarget = null;
            this.updateExtendedMark(_loc5_);
         }
      }
      
      public function getAttackTarget() : tibia.creatures.Creature
      {
         return this.m_AttackTarget;
      }
      
      public function animate() : void
      {
         var _loc1_:Number = Tibia.s_FrameTimestamp;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_CreatureCount)
         {
            if(this.m_Creature[_loc2_] != null)
            {
               this.m_Creature[_loc2_].animateMovement(_loc1_);
               this.m_Creature[_loc2_].animateOutfit(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function clearTargets() : void
      {
         var _loc1_:Connection = null;
         if(this.m_AttackTarget != null && this.m_Options != null && Boolean(this.m_Options.combatAutoChaseOff) && this.m_Options.combatChaseMode != OptionsStorage.COMBAT_CHASE_OFF)
         {
            this.m_Options.combatChaseMode = OptionsStorage.COMBAT_CHASE_OFF;
            _loc1_ = Tibia.s_GetConnection();
            if(_loc1_ != null && Boolean(_loc1_.isGameRunning))
            {
               _loc1_.sendCSETTACTICS(this.m_Options.combatAttackMode,this.m_Options.combatChaseMode,this.m_Options.combatSecureMode);
            }
         }
         if(this.m_FollowTarget != null)
         {
            this.setFollowTarget(null,true);
         }
      }
      
      public function setAttackTarget(param1:tibia.creatures.Creature, param2:Boolean) : void
      {
         var _loc5_:Connection = null;
         if(param1 == this.m_Player)
         {
            throw new ArgumentError("CreatureStorage.setAttackTarget: Cannot attack player.");
         }
         var _loc3_:tibia.creatures.Creature = this.m_AttackTarget;
         if(_loc3_ != param1)
         {
            this.m_AttackTarget = param1;
            _loc5_ = null;
            if(Boolean(param2) && (_loc5_ = Tibia.s_GetConnection()) != null && Boolean(_loc5_.isGameRunning))
            {
               if(this.m_AttackTarget != null)
               {
                  _loc5_.sendCATTACK(this.m_AttackTarget.ID);
               }
               else
               {
                  _loc5_.sendCATTACK(0);
               }
            }
            this.updateExtendedMark(_loc3_);
            this.updateExtendedMark(this.m_AttackTarget);
         }
         var _loc4_:tibia.creatures.Creature = this.m_FollowTarget;
         if(_loc4_ != null)
         {
            this.m_FollowTarget = null;
            this.updateExtendedMark(_loc4_);
         }
      }
   }
}
