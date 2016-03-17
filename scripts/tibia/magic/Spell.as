package tibia.magic
{
   import flash.display.BitmapData;
   import mx.core.BitmapAsset;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import tibia.chat.ChatWidget;
   import tibia.chat.ns_chat_internal;
   
   public class Spell extends Magic
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      public static const ICON_SIZE:int = 32;
      
      protected static const GROUP_HEALING:int = 2;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      private static const ICON_CLASS:Class = Spell_ICON_CLASS;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      protected static const TYPE_NONE:int = 0;
      
      protected static const GROUP_NONE:int = 0;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const GROUP_ATTACK:int = 1;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const GROUP_POWERSTRIKES:int = 4;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const TYPE_RUNE:int = 2;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      protected static const SKILL_OFFLINETRAINING:int = 17;
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const TYPE_INSTANT:int = 1;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const GROUP_SUPPORT:int = 3;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      private static const ICON_BITMAP:BitmapData = (new ICON_CLASS() as BitmapAsset).bitmapData;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
       
      private var m_CastSoulPoints:int = 0;
      
      private var m_RestrictPremium:Boolean = false;
      
      private var m_FormulaPretty:String = null;
      
      private var m_FormulaParameter:Boolean = false;
      
      private var m_Price:int = 0;
      
      private var m_FormulaRaw:String = null;
      
      private var m_Icon:Point = null;
      
      private var m_Type:int = 1;
      
      private var m_Name:String = null;
      
      public function Spell(param1:int, param2:String, param3:String, param4:int, param5:int, param6:Point, param7:int, param8:int, param9:int, param10:Boolean, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int)
      {
         super(param1,param4,param5,param9,param11,param12,param14,param15,param16);
         this.m_Name = param2;
         this.m_FormulaRaw = param3;
         this.m_FormulaPretty = this.getFormattedFormula();
         this.m_FormulaParameter = this.m_FormulaRaw != this.m_FormulaPretty;
         this.m_Icon = param6;
         this.m_Price = param7;
         this.m_Type = param8;
         this.m_RestrictPremium = param10;
         this.m_CastSoulPoints = param13;
      }
      
      public function getFormattedFormula(... rest) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:RegExp = /\{([0-9]+)(:-[^}]*)?\}/g;
         var _loc3_:Array = _loc2_.exec(this.m_FormulaRaw);
         if(_loc3_ == null)
         {
            return this.m_FormulaRaw;
         }
         _loc4_ = 0;
         _loc5_ = "";
         while(_loc3_ != null)
         {
            _loc6_ = parseInt(_loc3_[1]);
            _loc7_ = _loc3_[2] != null?_loc3_[2].substring(2):null;
            _loc5_ = _loc5_ + this.m_FormulaRaw.substring(_loc4_,_loc3_.index);
            if(rest != null && Boolean(rest.hasOwnProperty(_loc6_)))
            {
               _loc5_ = _loc5_ + ("\"" + rest[_loc6_] + "\"");
            }
            else if(_loc7_ != null)
            {
               _loc5_ = _loc5_ + ("\"" + _loc7_ + "\"");
            }
            _loc4_ = _loc3_.index + _loc3_[0].length;
            _loc3_ = _loc2_.exec(this.m_FormulaRaw);
         }
         return _loc5_;
      }
      
      public function get type() : int
      {
         return this.m_Type;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function get price() : int
      {
         return this.m_Price;
      }
      
      public function get castSoulPoints() : int
      {
         return this.m_CastSoulPoints;
      }
      
      public function get formula() : String
      {
         return this.m_FormulaPretty;
      }
      
      public function get hasParameter() : Boolean
      {
         return this.m_FormulaParameter;
      }
      
      public function getIcon(param1:Rectangle) : BitmapData
      {
         if(param1 != null)
         {
            param1.x = this.m_Icon.x;
            param1.y = this.m_Icon.y;
            param1.width = ICON_SIZE;
            param1.height = ICON_SIZE;
         }
         return ICON_BITMAP;
      }
      
      public function get restrictPremium() : Boolean
      {
         return this.m_RestrictPremium;
      }
      
      public function cast(param1:ChatWidget = null, ... rest) : void
      {
         if(param1 == null)
         {
            param1 = Tibia.s_GetChatWidget();
         }
         if(param1 != null)
         {
            param1.text = "#s " + this.getFormattedFormula(rest);
            param1.ns_chat_internal::onChatSend();
         }
      }
   }
}
