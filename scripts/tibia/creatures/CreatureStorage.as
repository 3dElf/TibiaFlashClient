package tibia.creatures
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.network.*;
    import tibia.options.*;

    public class CreatureStorage extends Object
    {
        protected var m_OpponentsSort:Sort = null;
        protected var m_Player:Player = null;
        protected var m_CreatureCount:int = 0;
        protected var m_AttackTarget:Creature = null;
        protected var m_Options:OptionsStorage = null;
        protected var m_OpponentsState:int = 0;
        protected var m_Opponents:ArrayCollection = null;
        protected var m_Aim:Creature = null;
        protected var m_FollowTarget:Creature = null;
        protected var m_Trappers:Vector.<Creature> = null;
        protected var m_CreatureIndex:int = 0;
        protected var m_MaxCreaturesCount:uint = 1300;
        protected var m_Creature:Vector.<Creature> = null;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        public static const SORT_DISTANCE_ASC:int = 2;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        private static const MARK_NUM_TOTAL:uint = MARK_TRAPPER + 1;
        private static const OPPONENTS_REFRESH:int = 1;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const FIELD_HEIGHT:int = 24;
        public static const FILTER_PLAYER:int = 1;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const TYPE_SUMMON_OTHERS:int = 4;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_STAMINA:int = 17;
        private static const SPEECH_FLAG_CLASS:Class = CreatureStorage_SPEECH_FLAG_CLASS;
        static const TYPE_NPC:int = 2;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const FIELD_SIZE:int = 32;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        public static const SORT_NAME_DESC:int = 7;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
        public static const SORT_NAME_ASC:int = 6;
        static const STATE_BLEEDING:int = 15;
        static const PK_PLAYERKILLER:int = 4;
        static const GROUND_LAYER:int = 7;
        static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
        static const STATE_DAZZLED:int = 10;
        static const SUMMON_OTHERS:int = 2;
        static const SKILL_NONE:int = -1;
        static const NPC_SPEECH_TRADER:uint = 2;
        static const GUILD_MEMBER:int = 4;
        static const PROFESSION_NONE:int = 0;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        private static const STATE_FLAG_BITMAP:BitmapData = (new STATE_FLAG_CLASS() as BitmapAsset).bitmapData;
        public static const STATE_FLAG_SIZE:int = 11;
        static const STATE_PZ_ENTERED:int = 14;
        public static const MARK_AIM:uint = MARK_NUM_COLOURS + 1;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        private static const OPPONENTS_NOACTION:int = 0;
        public static const FILTER_NON_SKULLED:int = 8;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        public static const MARK_AIM_FOLLOW:uint = MARK_NUM_COLOURS + 3;
        static const MAP_MIN_X:int = 24576;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
        public static const SORT_KNOWN_SINCE_ASC:int = 0;
        static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
        static const GUILD_WAR_ALLY:int = 1;
        static const PK_NONE:int = 0;
        static const NUM_EFFECTS:int = 200;
        static const PROFESSION_SORCERER:int = 3;
        static const STATE_SLOW:int = 5;
        static const PARTY_NONE:int = 0;
        static const SKILL_CRITICAL_HIT_CHANCE:int = 19;
        static const SUMMON_OWN:int = 1;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const SKILL_EXPERIENCE_GAIN:int = -2;
        static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const TYPE_SUMMON_OWN:int = 3;
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        public static const MARK_UNMARKED:uint = 0;
        static const UNDERGROUND_LAYER:int = 2;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_FIRE_OF_SUNS << 1;
        public static const FILTER_PARTY:int = 16;
        static const FIELD_CACHESIZE:int = 32;
        static const PROFESSION_PALADIN:int = 2;
        static const PLAYER_OFFSET_X:int = 8;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PLAYER_OFFSET_Y:int = 6;
        public static const MARK_TRAPPER:uint = MARK_NUM_COLOURS + 6;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        private static const OPPONENTS_REBUILD:int = 2;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        private static const STATE_FLAG_CLASS:Class = CreatureStorage_STATE_FLAG_CLASS;
        static const MAP_MAX_Z:int = 15;
        static const SKILL_SOULPOINTS:int = 16;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_SPARK_OF_PHOENIX << 1;
        public static const MARK_AIM_ATTACK:uint = MARK_NUM_COLOURS + 2;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        public static const STATE_FLAG_GAP:int = 2;
        public static const MARK_FOLLOW:uint = MARK_NUM_COLOURS + 5;
        static const BLESSING_NONE:int = 0;
        public static const FILTER_NPC:int = 2;
        static const GUILD_OTHER:int = 5;
        private static const SPEECH_FLAG_BITMAP:BitmapData = (new SPEECH_FLAG_CLASS() as BitmapAsset).bitmapData;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        public static const FILTER_NONE:int = 0;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const NUM_FIELDS:int = 2016;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        public static const SORT_DISTANCE_DESC:int = 3;
        public static const SORT_KNOWN_SINCE_DESC:int = 1;
        private static const MARK_NUM_COLOURS:uint = 216;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
        public static const SORT_HITPOINTS_ASC:int = 4;
        static const PK_AGGRESSOR:int = 3;
        static const GUILD_WAR_ENEMY:int = 2;
        static const SKILL_LEVEL:int = 1;
        static const STATE_STRENGTHENED:int = 12;
        static const MAPSIZE_Z:int = 8;
        static const STATE_HUNGRY:int = 31;
        static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
        static const SUMMON_NONE:int = 0;
        static const MAPSIZE_Y:int = 14;
        static const PROFESSION_DRUID:int = 4;
        static const STATE_FIGHTING:int = 7;
        static const NPC_SPEECH_QUEST:uint = 3;
        static const MAPSIZE_X:int = 18;
        static const NPC_SPEECH_NORMAL:uint = 1;
        public static const SORT_HITPOINTS_DESC:int = 5;
        static const MAPSIZE_W:int = 10;
        public static const SPEECH_FLAG_SIZE:int = 18;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_ADVENTURER << 1;
        public static const FILTER_MONSTER:int = 4;
        static const NPC_SPEECH_NONE:uint = 0;
        public static const MARK_ATTACK:uint = MARK_NUM_COLOURS + 4;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function CreatureStorage()
        {
            this.m_Player = new Player();
            this.m_Creature = new Vector.<Creature>;
            this.m_OpponentsSort = new Sort();
            this.m_OpponentsSort.compareFunction = this.opponentComparator;
            this.m_Opponents = new ArrayCollection();
            this.m_Opponents.filterFunction = this.opponentFilter;
            this.m_Opponents.sort = this.m_OpponentsSort;
            this.options = Tibia.s_GetOptions();
            this.m_Trappers = null;
            return;
        }// end function

        public function setAim(param1:Creature) : void
        {
            var _loc_2:* = null;
            if (this.m_Aim != param1)
            {
                _loc_2 = this.m_Aim;
                this.m_Aim = param1;
                this.updateExtendedMark(_loc_2);
                this.updateExtendedMark(this.m_Aim);
            }
            return;
        }// end function

        public function getNextAttackTarget(param1:int) : Creature
        {
            param1 = param1 < 0 ? (-1) : (1);
            var _loc_2:* = this.m_Opponents.length;
            var _loc_3:* = -1;
            var _loc_4:* = 0;
            if (_loc_2 < 1)
            {
                return null;
            }
            if (this.m_AttackTarget != null)
            {
                _loc_3 = this.m_Opponents.getItemIndex(this.m_AttackTarget);
            }
            var _loc_5:* = null;
            while (_loc_4++ < _loc_2)
            {
                
                _loc_3 = _loc_3 + param1;
                if (_loc_3 >= _loc_2)
                {
                    _loc_3 = 0;
                }
                if (_loc_3 < 0)
                {
                    _loc_3 = _loc_2 - 1;
                }
                _loc_5 = Creature(this.m_Opponents.getItemAt(_loc_3));
                if (_loc_5.type != TYPE_NPC)
                {
                    return _loc_5;
                }
            }
            return null;
        }// end function

        public function getAim() : Creature
        {
            return this.m_Aim;
        }// end function

        public function markAllOpponentsVisible(param1:Boolean) : void
        {
            var _loc_2:* = this.m_Opponents.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                Creature(this.m_Opponents.getItemAt(_loc_3)).visible = param1;
                _loc_3++;
            }
            if (_loc_2 > 0)
            {
                this.invalidateOpponents();
            }
            return;
        }// end function

        public function replaceCreature(param1:Creature, param2:int = 0) : Creature
        {
            if (param1 == null)
            {
                throw new ArgumentError("CreatureStorage.appendCreature: Invalid creature.");
            }
            if (param2 != 0)
            {
                this.removeCreature(param2);
            }
            if (this.m_CreatureCount >= this.m_MaxCreaturesCount)
            {
                throw new Error("CreatureStorage.appendCreature: No space left to append " + param1.ID);
            }
            var _loc_3:* = 0;
            var _loc_4:* = -1;
            var _loc_5:* = 0;
            var _loc_6:* = this.m_CreatureCount - 1;
            var _loc_7:* = null;
            while (_loc_5 <= _loc_6)
            {
                
                _loc_4 = _loc_5 + _loc_6 >> 1;
                _loc_7 = this.m_Creature[_loc_4];
                if (_loc_7.ID == param1.ID)
                {
                    return param1;
                }
                if (_loc_7.ID < param1.ID)
                {
                    _loc_5 = _loc_4 + 1;
                    continue;
                }
                _loc_6 = _loc_4 - 1;
            }
            var _loc_8:* = this;
            this.m_CreatureIndex = (this.m_CreatureIndex + 1);
            _loc_8.m_CreatureIndex = this.m_CreatureIndex + 1;
            param1.knownSince = this.m_CreatureIndex + 1;
            this.m_Creature.splice(_loc_5, 0, param1);
            var _loc_8:* = this;
            var _loc_9:* = this.m_CreatureCount + 1;
            _loc_8.m_CreatureCount = _loc_9;
            this.m_OpponentsState = OPPONENTS_REBUILD;
            return param1;
        }// end function

        public function toggleFollowTarget(param1:Creature, param2:Boolean) : void
        {
            if (param1 == this.m_Player)
            {
                throw new ArgumentError("CreatureStorage.toggleFollowTarget: Cannot follow player.");
            }
            var _loc_3:* = this.m_FollowTarget;
            if (_loc_3 != param1)
            {
                this.m_FollowTarget = param1;
            }
            else
            {
                this.m_FollowTarget = null;
            }
            var _loc_4:* = null;
            var _loc_6:* = Tibia.s_GetCommunication();
            _loc_4 = Tibia.s_GetCommunication();
            if (param2 && _loc_6 != null && _loc_4.isGameRunning)
            {
                if (this.m_FollowTarget != null)
                {
                    _loc_4.sendCFOLLOW(_loc_3.ID);
                }
                else
                {
                    _loc_4.sendCFOLLOW(0);
                }
            }
            this.updateExtendedMark(_loc_3);
            this.updateExtendedMark(this.m_FollowTarget);
            var _loc_5:* = this.m_AttackTarget;
            if (this.m_AttackTarget != null)
            {
                this.m_AttackTarget = null;
                this.updateExtendedMark(_loc_5);
            }
            return;
        }// end function

        public function getCreatureByName(param1:String) : Creature
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.m_Creature)
            {
                
                if (_loc_2.name == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getFollowTarget() : Creature
        {
            return this.m_FollowTarget;
        }// end function

        public function getTrappers() : Vector.<Creature>
        {
            return this.m_Trappers;
        }// end function

        public function refreshOpponents() : void
        {
            var _loc_1:* = 0;
            switch(this.m_OpponentsState)
            {
                case OPPONENTS_NOACTION:
                {
                    break;
                }
                case OPPONENTS_REFRESH:
                {
                    this.m_Opponents.refresh();
                    break;
                }
                case OPPONENTS_REBUILD:
                {
                    this.m_Opponents.disableAutoUpdate();
                    this.m_Opponents.filterFunction = null;
                    this.m_Opponents.sort = null;
                    this.m_Opponents.refresh();
                    this.m_Opponents.removeAll();
                    _loc_1 = 0;
                    while (_loc_1 < this.m_CreatureCount)
                    {
                        
                        this.m_Opponents.addItem(this.m_Creature[_loc_1]);
                        _loc_1++;
                    }
                    this.m_Opponents.filterFunction = this.opponentFilter;
                    this.m_Opponents.sort = this.m_OpponentsSort;
                    this.m_Opponents.refresh();
                    this.m_Opponents.enableAutoUpdate();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.m_OpponentsState = OPPONENTS_NOACTION;
            return;
        }// end function

        protected function opponentComparator(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            _loc_4 = param1 as Creature;
            _loc_5 = param2 as Creature;
            var _loc_6:* = 0;
            var _loc_7:* = true;
            if (_loc_4 != null && _loc_5 != null && this.m_Options != null)
            {
                switch(this.m_Options.opponentSort)
                {
                    case SORT_DISTANCE_DESC:
                    {
                        _loc_7 = false;
                    }
                    case SORT_DISTANCE_ASC:
                    {
                        _loc_8 = this.m_Player.position;
                        _loc_9 = Math.max(Math.abs(_loc_8.x - _loc_4.position.x), Math.abs(_loc_8.y - _loc_4.position.y));
                        _loc_10 = Math.max(Math.abs(_loc_8.x - _loc_5.position.x), Math.abs(_loc_8.y - _loc_5.position.y));
                        if (_loc_9 < _loc_10)
                        {
                            _loc_6 = -1;
                        }
                        else if (_loc_9 > _loc_10)
                        {
                            _loc_6 = 1;
                        }
                        break;
                    }
                    case SORT_HITPOINTS_DESC:
                    {
                        _loc_7 = false;
                    }
                    case SORT_HITPOINTS_ASC:
                    {
                        if (_loc_4.hitpointsPercent < _loc_5.hitpointsPercent)
                        {
                            _loc_6 = -1;
                        }
                        else if (_loc_4.hitpointsPercent > _loc_5.hitpointsPercent)
                        {
                            _loc_6 = 1;
                        }
                        break;
                    }
                    case SORT_NAME_DESC:
                    {
                        _loc_7 = false;
                    }
                    case SORT_NAME_ASC:
                    {
                        if (_loc_4.name < _loc_5.name)
                        {
                            _loc_6 = -1;
                        }
                        else if (_loc_4.name > _loc_5.name)
                        {
                            _loc_6 = 1;
                        }
                        break;
                    }
                    case SORT_KNOWN_SINCE_DESC:
                    {
                        _loc_7 = false;
                    }
                    case SORT_KNOWN_SINCE_ASC:
                    {
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                if (_loc_6 == 0)
                {
                    if (_loc_4.knownSince < _loc_5.knownSince)
                    {
                        _loc_6 = -1;
                    }
                    else if (_loc_4.knownSince > _loc_5.knownSince)
                    {
                        _loc_6 = 1;
                    }
                }
            }
            if (_loc_7)
            {
                return _loc_6;
            }
            return -_loc_6;
        }// end function

        public function setFollowTarget(param1:Creature, param2:Boolean) : void
        {
            var _loc_5:* = null;
            if (param1 == this.m_Player)
            {
                throw new ArgumentError("CreatureStorage.setFollowTarget: Cannot follow player.");
            }
            var _loc_3:* = this.m_FollowTarget;
            if (_loc_3 != param1)
            {
                this.m_FollowTarget = param1;
                _loc_5 = null;
                var _loc_6:* = Tibia.s_GetCommunication();
                _loc_5 = Tibia.s_GetCommunication();
                if (param2 && _loc_6 != null && _loc_5.isGameRunning)
                {
                    if (this.m_FollowTarget != null)
                    {
                        _loc_5.sendCFOLLOW(_loc_3.ID);
                    }
                    else
                    {
                        _loc_5.sendCFOLLOW(0);
                    }
                }
                this.updateExtendedMark(_loc_3);
                this.updateExtendedMark(this.m_FollowTarget);
            }
            var _loc_4:* = this.m_AttackTarget;
            if (this.m_AttackTarget != null)
            {
                this.m_AttackTarget = null;
                this.updateExtendedMark(_loc_4);
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function isOpponent(param1:Creature) : Boolean
        {
            return this.opponentFilter(param1, false);
        }// end function

        protected function updateExtendedMark(param1:Creature) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1 != null)
            {
                _loc_2 = param1.marks;
                _loc_2.setMark(Marks.MARK_TYPE_CLIENT_MAPWINDOW, Marks.MARK_UNMARKED);
                _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_UNMARKED);
                _loc_3 = Marks.MARK_UNMARKED;
                if (param1 == this.m_Aim && param1 == this.m_AttackTarget)
                {
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_MAPWINDOW, Marks.MARK_AIM_ATTACK);
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_AIM_ATTACK);
                }
                else if (param1 == this.m_Aim && param1 == this.m_FollowTarget)
                {
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_MAPWINDOW, Marks.MARK_AIM_FOLLOW);
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_AIM_FOLLOW);
                }
                else if (param1 == this.m_Aim)
                {
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_AIM);
                }
                else if (param1 == this.m_AttackTarget)
                {
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_MAPWINDOW, Marks.MARK_ATTACK);
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_ATTACK);
                }
                else if (param1 == this.m_FollowTarget)
                {
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_MAPWINDOW, Marks.MARK_FOLLOW);
                    _loc_2.setMark(Marks.MARK_TYPE_CLIENT_BATTLELIST, Marks.MARK_FOLLOW);
                }
            }
            return;
        }// end function

        public function setTrappers(param1:Vector.<Creature>) : void
        {
            var _loc_2:* = 0;
            _loc_2 = (this.m_Trappers != null ? (this.m_Trappers.length) : (0)) - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Trappers[_loc_2] != null)
                {
                    this.m_Trappers[_loc_2].isTrapper = false;
                }
                _loc_2 = _loc_2 - 1;
            }
            this.m_Trappers = param1;
            _loc_2 = (this.m_Trappers != null ? (this.m_Trappers.length) : (0)) - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Trappers[_loc_2] != null)
                {
                    this.m_Trappers[_loc_2].isTrapper = true;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function getCreature(param1:int) : Creature
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = this.m_CreatureCount - 1;
            var _loc_5:* = null;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_2 = _loc_3 + _loc_4 >> 1;
                _loc_5 = this.m_Creature[_loc_2];
                if (_loc_5.ID == param1)
                {
                    return _loc_5;
                }
                if (_loc_5.ID < param1)
                {
                    _loc_3 = _loc_2 + 1;
                    continue;
                }
                _loc_4 = _loc_2 - 1;
            }
            return null;
        }// end function

        public function get opponents() : IList
        {
            return this.m_Opponents;
        }// end function

        public function invalidateOpponents() : void
        {
            if (this.m_OpponentsState < OPPONENTS_REFRESH)
            {
                this.m_OpponentsState = OPPONENTS_REFRESH;
            }
            return;
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
                this.invalidateOpponents();
                this.refreshOpponents();
            }
            return;
        }// end function

        public function markOpponentVisible(param1, param2:Boolean) : void
        {
            var _loc_3:* = null;
            if (param1 is Creature)
            {
                _loc_3 = Creature(param1);
            }
            else if (param1 is ObjectInstance && ObjectInstance(param1).ID == AppearanceInstance.CREATURE)
            {
                _loc_3 = this.getCreature(ObjectInstance(param1).ID);
            }
            else if (param1 is int)
            {
                _loc_3 = this.getCreature(int(param1));
            }
            else
            {
                throw new ArgumentError("CreatureStorage.hideOpponent: Invalid overload.");
            }
            if (_loc_3 != null)
            {
                _loc_3.visible = param2;
                this.invalidateOpponents();
            }
            return;
        }// end function

        protected function opponentFilter(param1:Object, param2:Boolean = true) : Boolean
        {
            var _loc_3:* = param1 as Creature;
            if (_loc_3 == null || _loc_3 is Player)
            {
                return false;
            }
            if (!_loc_3.visible || _loc_3.hitpointsPercent <= 0)
            {
                return false;
            }
            var _loc_4:* = _loc_3.position;
            var _loc_5:* = this.m_Player.position;
            if (_loc_4.z != _loc_5.z || Math.abs(_loc_4.x - _loc_5.x) > MAP_WIDTH / 2 || Math.abs(_loc_4.y - _loc_5.y) > MAP_HEIGHT / 2)
            {
                return false;
            }
            var _loc_6:* = FILTER_NONE;
            var _loc_7:* = this.m_Options.opponentFilter;
            _loc_6 = this.m_Options.opponentFilter;
            if (param2 && this.m_Options != null && _loc_7 != FILTER_NONE)
            {
                if ((_loc_6 & FILTER_PLAYER) > 0 && _loc_3.type == TYPE_PLAYER)
                {
                    return false;
                }
                if ((_loc_6 & FILTER_NPC) > 0 && _loc_3.type == TYPE_NPC)
                {
                    return false;
                }
                if ((_loc_6 & FILTER_MONSTER) > 0 && _loc_3.type == TYPE_MONSTER)
                {
                    return false;
                }
                if ((_loc_6 & FILTER_NON_SKULLED) > 0 && _loc_3.type == TYPE_PLAYER && _loc_3.pkFlag == PK_NONE)
                {
                    return false;
                }
                if ((_loc_6 & FILTER_PARTY) > 0 && _loc_3.partyFlag != PARTY_NONE)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function reset(param1:Boolean = true) : void
        {
            if (param1)
            {
                this.m_Player.reset();
            }
            var _loc_2:* = this.m_Creature.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Creature[_loc_2] != null)
                {
                    if (this.m_Creature[_loc_2] != this.m_Player || this.m_Creature[_loc_2] == this.m_Player && param1 == true)
                    {
                        this.m_Creature[_loc_2].reset();
                        this.m_Creature[_loc_2] = null;
                    }
                }
                _loc_2 = _loc_2 - 1;
            }
            this.m_Creature.length = 0;
            this.m_CreatureCount = 0;
            this.m_CreatureIndex = 0;
            if (param1 == false)
            {
                this.replaceCreature(this.m_Player, 0);
            }
            this.m_Opponents.removeAll();
            this.m_OpponentsState = OPPONENTS_NOACTION;
            this.m_Aim = null;
            this.m_AttackTarget = null;
            this.m_FollowTarget = null;
            this.m_Trappers = null;
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            switch(event.property)
            {
                case "opponentSort":
                case "opponentFilter":
                case "*":
                {
                    this.invalidateOpponents();
                    this.refreshOpponents();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function removeCreature(param1:int) : void
        {
            var _loc_2:* = -1;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = this.m_CreatureCount - 1;
            var _loc_6:* = null;
            while (_loc_4 <= _loc_5)
            {
                
                _loc_3 = _loc_4 + _loc_5 >> 1;
                _loc_6 = this.m_Creature[_loc_3];
                if (_loc_6.ID == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                    continue;
                }
                if (_loc_6.ID < param1)
                {
                    _loc_4 = _loc_3 + 1;
                    continue;
                }
                _loc_5 = _loc_3 - 1;
            }
            if (_loc_6 == null || _loc_2 < 0)
            {
                throw new Error("CreatureStorage.removeCreature: Creature " + param1 + " not found.");
            }
            if (_loc_6 == this.m_Player)
            {
                throw new Error("CreatureStorage.removeCreature: Can\'t remove the player.");
            }
            if (_loc_6 == this.m_Aim)
            {
                this.m_Aim = null;
                this.updateExtendedMark(_loc_6);
            }
            if (_loc_6 == this.m_AttackTarget)
            {
                this.m_AttackTarget = null;
                this.updateExtendedMark(_loc_6);
            }
            if (_loc_6 == this.m_FollowTarget)
            {
                this.m_FollowTarget = null;
                this.updateExtendedMark(_loc_6);
            }
            _loc_3 = (this.m_Trappers != null ? (this.m_Trappers.length) : (0)) - 1;
            while (_loc_3 >= 0)
            {
                
                if (_loc_6 == this.m_Trappers[_loc_3])
                {
                    this.m_Trappers[_loc_3].isTrapper = false;
                    this.m_Trappers[_loc_3] = null;
                }
                _loc_3 = _loc_3 - 1;
            }
            _loc_6.reset();
            this.m_Creature.splice(_loc_2, 1);
            var _loc_7:* = this;
            var _loc_8:* = this.m_CreatureCount - 1;
            _loc_7.m_CreatureCount = _loc_8;
            this.m_OpponentsState = OPPONENTS_REBUILD;
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        public function getAttackTarget() : Creature
        {
            return this.m_AttackTarget;
        }// end function

        public function animate() : void
        {
            var _loc_1:* = Tibia.s_FrameTibiaTimestamp;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_CreatureCount)
            {
                
                if (this.m_Creature[_loc_2] != null)
                {
                    this.m_Creature[_loc_2].animateMovement(_loc_1);
                    this.m_Creature[_loc_2].animateOutfit(_loc_1);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function toggleAttackTarget(param1:Creature, param2:Boolean) : void
        {
            if (param1 == this.m_Player)
            {
                throw new ArgumentError("CreatureStorage.toggleAttackTarget: Cannot attack player.");
            }
            var _loc_3:* = this.m_AttackTarget;
            if (_loc_3 != param1)
            {
                this.m_AttackTarget = param1;
            }
            else
            {
                this.m_AttackTarget = null;
            }
            var _loc_4:* = null;
            var _loc_6:* = Tibia.s_GetCommunication();
            _loc_4 = Tibia.s_GetCommunication();
            if (param2 && _loc_6 != null && _loc_4.isGameRunning)
            {
                if (this.m_AttackTarget != null)
                {
                    _loc_4.sendCATTACK(_loc_3.ID);
                }
                else
                {
                    _loc_4.sendCATTACK(0);
                }
            }
            this.updateExtendedMark(_loc_3);
            this.updateExtendedMark(this.m_AttackTarget);
            var _loc_5:* = this.m_FollowTarget;
            if (this.m_AttackTarget != null && _loc_5 != null)
            {
                this.m_FollowTarget = null;
                this.updateExtendedMark(_loc_5);
            }
            return;
        }// end function

        public function clearTargets() : void
        {
            var _loc_1:* = null;
            if (this.m_AttackTarget != null && this.m_Options != null && this.m_Options.combatAutoChaseOff && this.m_Options.combatChaseMode != OptionsStorage.COMBAT_CHASE_OFF)
            {
                this.m_Options.combatChaseMode = OptionsStorage.COMBAT_CHASE_OFF;
                _loc_1 = Tibia.s_GetCommunication();
                if (_loc_1 != null && _loc_1.isGameRunning)
                {
                    _loc_1.sendCSETTACTICS(this.m_Options.combatAttackMode, this.m_Options.combatChaseMode, this.m_Options.combatSecureMode, this.m_Options.combatPVPMode);
                }
            }
            if (this.m_FollowTarget != null)
            {
                this.setFollowTarget(null, true);
            }
            return;
        }// end function

        public function setAttackTarget(param1:Creature, param2:Boolean) : void
        {
            var _loc_5:* = null;
            if (param1 == this.m_Player)
            {
                throw new ArgumentError("CreatureStorage.setAttackTarget: Cannot attack player.");
            }
            var _loc_3:* = this.m_AttackTarget;
            if (_loc_3 != param1)
            {
                this.m_AttackTarget = param1;
                _loc_5 = null;
                var _loc_6:* = Tibia.s_GetCommunication();
                _loc_5 = Tibia.s_GetCommunication();
                if (param2 && _loc_6 != null && _loc_5.isGameRunning)
                {
                    if (this.m_AttackTarget != null)
                    {
                        _loc_5.sendCATTACK(_loc_3.ID);
                    }
                    else
                    {
                        _loc_5.sendCATTACK(0);
                    }
                }
                this.updateExtendedMark(_loc_3);
                this.updateExtendedMark(this.m_AttackTarget);
            }
            var _loc_4:* = this.m_FollowTarget;
            if (this.m_FollowTarget != null)
            {
                this.m_FollowTarget = null;
                this.updateExtendedMark(_loc_4);
            }
            return;
        }// end function

        public static function s_GetPKFlag(param1:int, param2:Rectangle) : BitmapData
        {
            if (param1 < PK_NONE || param1 > PK_REVENGE)
            {
                throw new ArgumentError("CreatureStorage.s_GetPKFlag: Invalid flag.");
            }
            param2.x = param1 * STATE_FLAG_SIZE;
            param2.y = STATE_FLAG_SIZE;
            param2.width = STATE_FLAG_SIZE;
            param2.height = STATE_FLAG_SIZE;
            return STATE_FLAG_BITMAP;
        }// end function

        public static function s_GetRiskinessFlag(param1:int, param2:Rectangle) : BitmapData
        {
            if (param1 < RISKINESS_NONE || param1 > RISKINESS_DANGEROUS)
            {
                throw new ArgumentError("CreatureStorage.s_GetRiskinessFlag: Invalid flag.");
            }
            param2.x = param1 * STATE_FLAG_SIZE;
            param2.y = 4 * STATE_FLAG_SIZE;
            param2.width = STATE_FLAG_SIZE;
            param2.height = STATE_FLAG_SIZE;
            return STATE_FLAG_BITMAP;
        }// end function

        public static function s_GetSummonFlag(param1:int, param2:Rectangle) : BitmapData
        {
            if (param1 < SUMMON_NONE || param1 > SUMMON_OTHERS)
            {
                throw new ArgumentError("CreatureStorage.s_GetSummonFlag: Invalid flag.");
            }
            param2.x = param1 * STATE_FLAG_SIZE;
            param2.y = 3 * STATE_FLAG_SIZE;
            param2.width = STATE_FLAG_SIZE;
            param2.height = STATE_FLAG_SIZE;
            return STATE_FLAG_BITMAP;
        }// end function

        public static function s_GetPartyFlag(param1:int, param2:Rectangle) : BitmapData
        {
            if (param1 < PARTY_NONE || param1 > PARTY_OTHER)
            {
                throw new ArgumentError("CreatureStorage.s_GetPartyFlag: Invalid flag.");
            }
            if (param1 == PARTY_LEADER_SEXP_INACTIVE_INNOCENT)
            {
                param1 = PARTY_LEADER_SEXP_INACTIVE_GUILTY;
            }
            if (param1 == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT)
            {
                param1 = PARTY_LEADER_SEXP_INACTIVE_GUILTY;
            }
            if (param1 == PARTY_OTHER)
            {
                param1 = 9;
            }
            param2.x = param1 * STATE_FLAG_SIZE;
            param2.y = 0;
            param2.width = STATE_FLAG_SIZE;
            param2.height = STATE_FLAG_SIZE;
            return STATE_FLAG_BITMAP;
        }// end function

        public static function s_GetGuildFlag(param1:int, param2:Rectangle) : BitmapData
        {
            if (param1 < GUILD_NONE || param1 > GUILD_OTHER)
            {
                throw new ArgumentError("CreatureStorage.s_GetGuildFlag: Invalid flag.");
            }
            param2.x = param1 * STATE_FLAG_SIZE;
            param2.y = 2 * STATE_FLAG_SIZE;
            param2.width = STATE_FLAG_SIZE;
            param2.height = STATE_FLAG_SIZE;
            return STATE_FLAG_BITMAP;
        }// end function

        public static function s_GetNpcSpeechFlag(param1:uint, param2:Rectangle) : BitmapData
        {
            var _loc_3:* = 0;
            if (param1 < NPC_SPEECH_NONE || param1 > NPC_SPEECH_TRAVEL)
            {
                throw new ArgumentError("CreatureStorage.s_GetNpcSpeechFlag: Invalid flag.");
            }
            switch(param1)
            {
                case NPC_SPEECH_NORMAL:
                {
                    _loc_3 = 1;
                    break;
                }
                case NPC_SPEECH_TRADER:
                {
                    _loc_3 = 2;
                    break;
                }
                case NPC_SPEECH_QUEST:
                {
                    _loc_3 = 3;
                    break;
                }
                case NPC_SPEECH_TRAVEL:
                {
                    _loc_3 = 4;
                    break;
                }
                default:
                {
                    _loc_3 = 0;
                    break;
                    break;
                }
            }
            param2.x = _loc_3 * SPEECH_FLAG_SIZE;
            param2.y = 0;
            param2.width = SPEECH_FLAG_SIZE;
            param2.height = SPEECH_FLAG_SIZE;
            return SPEECH_FLAG_BITMAP;
        }// end function

    }
}
