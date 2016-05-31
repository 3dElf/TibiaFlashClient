package tibia.magic
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;
    import tibia.chat.*;

    public class Spell extends Magic
    {
        private var m_CastSoulPoints:int = 0;
        private var m_RestrictPremium:Boolean = false;
        private var m_FormulaPretty:String = null;
        private var m_FormulaParameter:Boolean = false;
        private var m_Price:int = 0;
        private var m_FormulaRaw:String = null;
        private var m_Icon:Point = null;
        private var m_Type:int = 1;
        private var m_Name:String = null;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        public static const ICON_SIZE:int = 32;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        private static const ICON_CLASS:Class = Spell_ICON_CLASS;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const GROUP_ATTACK:int = 1;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        static const TYPE_NPC:int = 2;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const GROUP_POWERSTRIKES:int = 4;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const STATE_PZ_ENTERED:int = 14;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const GROUP_HEALING:int = 2;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SUMMON_OWN:int = 1;
        static const GROUP_NONE:int = 0;
        static const TYPE_NONE:int = 0;
        static const TYPE_RUNE:int = 2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const STATE_FAST:int = 6;
        static const BLESSING_NONE:int = 0;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static const TYPE_INSTANT:int = 1;
        private static const ICON_BITMAP:BitmapData = (new ICON_CLASS() as BitmapAsset).bitmapData;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        static const GROUP_SUPPORT:int = 3;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const NPC_SPEECH_NORMAL:uint = 1;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function Spell(param1:int, param2:String, param3:String, param4:int, param5:int, param6:Point, param7:int, param8:int, param9:int, param10:Boolean, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int)
        {
            super(param1, param4, param5, param9, param11, param12, param14, param15, param16);
            this.m_Name = param2;
            this.m_FormulaRaw = param3;
            this.m_FormulaPretty = this.getFormattedFormula();
            this.m_FormulaParameter = this.m_FormulaRaw != this.m_FormulaPretty;
            this.m_Icon = param6;
            this.m_Price = param7;
            this.m_Type = param8;
            this.m_RestrictPremium = param10;
            this.m_CastSoulPoints = param13;
            return;
        }// end function

        public function getFormattedFormula(... args) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            args = /\{([0-9]+)(:-[^}]*)?\}/g;
            var _loc_3:* = args.exec(this.m_FormulaRaw);
            if (_loc_3 == null)
            {
                return this.m_FormulaRaw;
            }
            _loc_4 = 0;
            _loc_5 = "";
            while (_loc_3 != null)
            {
                
                _loc_6 = parseInt(_loc_3[1]);
                _loc_7 = _loc_3[2] != null ? (_loc_3[2].substring(2)) : (null);
                _loc_5 = _loc_5 + this.m_FormulaRaw.substring(_loc_4, _loc_3.index);
                if (args != null && args.hasOwnProperty(_loc_6))
                {
                    _loc_5 = _loc_5 + ("\"" + args[_loc_6] + "\"");
                }
                else if (_loc_7 != null)
                {
                    _loc_5 = _loc_5 + ("\"" + _loc_7 + "\"");
                }
                _loc_4 = _loc_3.index + _loc_3[0].length;
                _loc_3 = args.exec(this.m_FormulaRaw);
            }
            return _loc_5;
        }// end function

        public function get type() : int
        {
            return this.m_Type;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get price() : int
        {
            return this.m_Price;
        }// end function

        public function get castSoulPoints() : int
        {
            return this.m_CastSoulPoints;
        }// end function

        public function get formula() : String
        {
            return this.m_FormulaPretty;
        }// end function

        public function get hasParameter() : Boolean
        {
            return this.m_FormulaParameter;
        }// end function

        public function getIcon(param1:Rectangle) : BitmapData
        {
            if (param1 != null)
            {
                param1.x = this.m_Icon.x;
                param1.y = this.m_Icon.y;
                param1.width = ICON_SIZE;
                param1.height = ICON_SIZE;
            }
            return ICON_BITMAP;
        }// end function

        public function get restrictPremium() : Boolean
        {
            return this.m_RestrictPremium;
        }// end function

        public function cast(param1:ChatWidget = null, ... args) : void
        {
            Tibia.s_GameActionFactory.createTalkAction("#s " + this.getFormattedFormula(args), true).perform();
            return;
        }// end function

    }
}
