package tibia.creatures.battlelistWidgetClasses
{
   import shared.utility.BitmapCache;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import flash.display.BitmapData;
   import tibia.creatures.Creature;
   import tibia.appearances.AppearanceInstance;
   import tibia.appearances.OutfitInstance;
   
   public class CreatureIconCache extends BitmapCache
   {
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      private static var s_SourceRect:Rectangle = new Rectangle();
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const GROUND_LAYER:int = 7;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
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
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE + FIELD_HEIGHT;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const STATE_POISONED:int = 0;
      
      private static var s_Trans:Matrix = new Matrix();
      
      protected static const STATE_BURNING:int = 1;
      
      private static var s_ClipRect:Rectangle = new Rectangle();
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      protected var m_IconSize:Number = NaN;
      
      protected var m_ScaleFactor:Number = NaN;
      
      public function CreatureIconCache(param1:Number, param2:Number, param3:uint)
      {
         super(param1,param2,param3);
         this.m_IconSize = Math.min(param1,param2);
         this.m_ScaleFactor = this.m_IconSize / Math.sqrt(2 * FIELD_SIZE);
      }
      
      override protected function addItem(param1:Rectangle, param2:Array) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:Creature = null;
         var _loc4_:AppearanceInstance = null;
         if(param2 != null && param2.length == 1 && (_loc3_ = param2[0] as Creature) != null && (_loc4_ = _loc3_.outfit) != null && _loc4_.ID != OutfitInstance.INVISIBLE_OUTFIT_ID)
         {
            _loc5_ = _loc4_.getSprite(0,2,0,0,s_SourceRect);
            if(_loc5_ != null)
            {
               _loc6_ = _loc4_.type.exactSize;
               _loc7_ = Math.sqrt(_loc6_) * this.m_ScaleFactor;
               _loc8_ = _loc7_ / _loc6_;
               s_ClipRect.x = param1.x + Math.floor(slotWidth - _loc7_);
               s_ClipRect.y = param1.y + Math.floor(slotHeight - _loc7_);
               s_ClipRect.width = Math.ceil(_loc7_);
               s_ClipRect.height = Math.ceil(_loc7_);
               s_Trans.tx = -(s_SourceRect.right - _loc6_) * _loc8_ + s_ClipRect.x;
               s_Trans.ty = -(s_SourceRect.bottom - _loc6_) * _loc8_ + s_ClipRect.y;
               s_Trans.a = _loc8_;
               s_Trans.d = _loc8_;
               draw(_loc5_,s_Trans,null,null,s_ClipRect,true);
            }
         }
      }
   }
}
