package tibia.magic
{
    import tibia.creatures.*;
    import tibia.magic.spellListWidgetClasses.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class SpellListWidget extends Widget
    {
        private var m_FilterProfession:int = -1;
        private var m_FilterPremium:int = -1;
        private var m_SortMode:int = 4;
        private var m_LayoutMode:int = 0;
        private var m_Player:Player = null;
        private var m_SpellStorage:SpellStorage = null;
        private var m_FilterGroup:int = -1;
        private var m_FilterKnown:int = -1;
        private var m_FilterLevel:int = -1;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
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
        static const TYPE_NPC:int = 2;
        public static const SORT_PROFESSION:int = 7;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_STAMINA:int = 17;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const GROUP_POWERSTRIKES:int = 4;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        public static const SORT_GROUP:int = 2;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        public static const LAYOUT_LIST:int = 0;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        public static const SORT_PREMIUM:int = 5;
        static const BLESSING_BLOOD_OF_THE_MOUNTAIN:int = BLESSING_HEART_OF_THE_MOUNTAIN << 1;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        public static const LAYOUT_TILE:int = 1;
        public static const SORT_NAME:int = 4;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const BLESSING_HEART_OF_THE_MOUNTAIN:int = BLESSING_EMBRACE_OF_TIBIA << 1;
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
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_TWIST_OF_FATE << 1;
        static const PROFESSION_PALADIN:int = 2;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        public static const SORT_PRICE:int = 6;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const SKILL_SOULPOINTS:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_ADVENTURER << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const BLESSING_NONE:int = 0;
        public static const SORT_LEVEL:int = 3;
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
        public static const SORT_FORMULA:int = 1;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static const TYPE_INSTANT:int = 1;
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
        static const TYPE_PLAYERSUMMON:int = 3;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_FIRE_OF_SUNS << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function SpellListWidget()
        {
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            options = null;
            this.player = null;
            super.releaseViewInstance();
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                this.m_Player = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).player = this.m_Player;
                }
            }
            return;
        }// end function

        public function get sortMode() : int
        {
            return this.m_SortMode;
        }// end function

        public function set filterPremium(param1:int) : void
        {
            if (param1 != 0 && param1 != 1)
            {
                param1 = -1;
            }
            if (this.m_FilterPremium != param1)
            {
                this.m_FilterPremium = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).filterPremium = this.m_FilterPremium;
                }
            }
            return;
        }// end function

        public function set sortMode(param1:int) : void
        {
            var _loc_2:* = Math.abs(param1);
            if (_loc_2 != SORT_FORMULA && _loc_2 != SORT_GROUP && _loc_2 != SORT_LEVEL && _loc_2 != SORT_NAME && _loc_2 != SORT_PREMIUM && _loc_2 != SORT_PRICE && _loc_2 != SORT_PROFESSION)
            {
                param1 = SORT_NAME;
            }
            if (this.m_SortMode != param1)
            {
                this.m_SortMode = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).sortMode = this.m_SortMode;
                }
            }
            return;
        }// end function

        public function set filterGroup(param1:int) : void
        {
            if (param1 != GROUP_ATTACK && param1 != GROUP_HEALING && param1 != GROUP_SUPPORT)
            {
                param1 = -1;
            }
            if (this.m_FilterGroup != param1)
            {
                this.m_FilterGroup = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).filterGroup = this.m_FilterGroup;
                }
            }
            return;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            this.player = Tibia.s_GetPlayer();
            var _loc_2:* = super.acquireViewInstance(param1) as SpellListWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.options = m_Options;
                _loc_2.player = this.m_Player;
                _loc_2.filterGroup = this.filterGroup;
                _loc_2.filterKnown = this.filterKnown;
                _loc_2.filterLevel = this.filterLevel;
                _loc_2.filterPremium = this.filterPremium;
                _loc_2.filterProfession = this.filterProfession;
                _loc_2.layoutMode = this.layoutMode;
                _loc_2.sortMode = this.sortMode;
            }
            return _loc_2;
        }// end function

        public function get filterProfession() : int
        {
            return this.m_FilterProfession;
        }// end function

        override public function marshall() : XML
        {
            var _loc_1:* = super.marshall();
            _loc_1.@filterGroup = this.filterGroup;
            _loc_1.@filterKnown = this.filterKnown;
            _loc_1.@filterLevel = this.filterLevel;
            _loc_1.@filterPremium = this.filterPremium;
            _loc_1.@filterProfession = this.filterProfession;
            _loc_1.@layoutMode = this.layoutMode;
            _loc_1.@sortMode = this.sortMode;
            return _loc_1;
        }// end function

        public function set filterKnown(param1:int) : void
        {
            if (param1 != -2)
            {
                param1 = -1;
            }
            if (this.m_FilterKnown != param1)
            {
                this.m_FilterKnown = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).filterKnown = this.m_FilterKnown;
                }
            }
            return;
        }// end function

        public function set filterLevel(param1:int) : void
        {
            if (param1 != -2)
            {
                param1 = -1;
            }
            if (this.m_FilterLevel != param1)
            {
                this.m_FilterLevel = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).filterLevel = this.m_FilterLevel;
                }
            }
            return;
        }// end function

        public function set layoutMode(param1:int) : void
        {
            if (param1 != LAYOUT_LIST && param1 != LAYOUT_TILE)
            {
                param1 = LAYOUT_LIST;
            }
            if (this.m_LayoutMode != param1)
            {
                this.m_LayoutMode = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).layoutMode = this.m_LayoutMode;
                }
            }
            return;
        }// end function

        public function get filterGroup() : int
        {
            return this.m_FilterGroup;
        }// end function

        public function set filterProfession(param1:int) : void
        {
            if (param1 != -2 && param1 != PROFESSION_DRUID && param1 != PROFESSION_KNIGHT && param1 != PROFESSION_PALADIN && param1 != PROFESSION_SORCERER)
            {
                param1 = -1;
            }
            if (this.m_FilterProfession != param1)
            {
                this.m_FilterProfession = param1;
                if (m_ViewInstance is SpellListWidgetView)
                {
                    SpellListWidgetView(m_ViewInstance).filterProfession = this.m_FilterProfession;
                }
            }
            return;
        }// end function

        public function get filterKnown() : int
        {
            return this.m_FilterKnown;
        }// end function

        public function get filterLevel() : int
        {
            return this.m_FilterLevel;
        }// end function

        override public function unmarshall(param1:XML, param2:int) : void
        {
            super.unmarshall(param1, param2);
            var _loc_3:* = null;
            var _loc_4:* = param1.@filterGroup;
            _loc_3 = param1.@filterGroup;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.filterGroup = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@filterKnown;
            _loc_3 = param1.@filterKnown;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.filterKnown = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@filterLevel;
            _loc_3 = param1.@filterLevel;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.filterLevel = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@filterPremium;
            _loc_3 = param1.@filterPremium;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.filterPremium = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@filterProfession;
            _loc_3 = param1.@filterProfession;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.filterProfession = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@layoutMode;
            _loc_3 = param1.@layoutMode;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.layoutMode = parseInt(_loc_3[0].toString());
            }
            var _loc_4:* = param1.@sortMode;
            _loc_3 = param1.@sortMode;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.sortMode = parseInt(_loc_3[0].toString());
            }
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function get layoutMode() : int
        {
            return this.m_LayoutMode;
        }// end function

        public function get filterPremium() : int
        {
            return this.m_FilterPremium;
        }// end function

    }
}
