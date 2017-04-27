package tibia.creatures
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.battlelistWidgetClasses.*;
    import tibia.network.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class Creature extends EventDispatcher implements IReportable
    {
        protected var m_IsUnpassable:Boolean = false;
        protected var m_Direction:int = 0;
        protected var m_PartyFlag:int = 0;
        protected var m_PKFlag:int = 0;
        protected var m_MovementRunning:Boolean = false;
        protected var m_ID:int = 0;
        protected var m_SpeechCategory:uint = 0;
        var m_Outfit:AppearanceInstance = null;
        protected var m_Name:String = null;
        protected var m_NumberOfPVPHelpers:uint = 0;
        protected var m_AnimationSpeed:Vector3D;
        protected var m_AnimationEnd:Number = 0;
        protected var m_Skills:Vector.<Number> = null;
        protected var m_Visible:Boolean = false;
        protected var m_Brightness:int = 0;
        var m_MountOutfit:AppearanceInstance = null;
        protected var m_AnimationDirection:int = 0;
        protected var m_LightColour:Colour;
        protected var m_GuildFlag:int = 0;
        protected var m_SummonerCreatureID:uint = 0;
        protected var m_MovementEnd:Number = 0;
        protected var m_AnimationDelta:Vector3D;
        protected var m_IsTrapper:Boolean = false;
        protected var m_Marks:Marks = null;
        var m_Position:Vector3D;
        protected var m_KnownSince:int = -1;
        protected var m_Type:int = 1;
        static const BLESSING_SPARK_OF_PHOENIX:int = BLESSING_WISDOM_OF_SOLITUDE << 1;
        static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
        static const PARTY_MAX_FLASHING_TIME:uint = 5000;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const STATE_PZ_BLOCK:int = 13;
        static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
        static const PK_REVENGE:int = 6;
        static const SKILL_FIGHTCLUB:int = 10;
        static const NPC_SPEECH_TRAVEL:uint = 5;
        static const RISKINESS_DANGEROUS:int = 1;
        static const NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS:uint = 5;
        public static const MAX_DESCRIPTION_LENGHT:int = 128;
        static const PK_PARTYMODE:int = 2;
        static const RISKINESS_NONE:int = 0;
        static const GUILD_NONE:int = 0;
        static const FIELD_HEIGHT:int = 24;
        static const PARTY_MEMBER:int = 2;
        static const STATE_DRUNK:int = 3;
        static const PARTY_OTHER:int = 11;
        static const SKILL_EXPERIENCE:int = 0;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const TYPE_NPC:int = 2;
        static const BLESSING_FIRE_OF_SUNS:int = BLESSING_SPARK_OF_PHOENIX << 1;
        static const SKILL_STAMINA:int = 17;
        static const STATE_NONE:int = -1;
        static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
        static const SKILL_FIGHTSHIELD:int = 8;
        static const SKILL_MANA_LEECH_CHANCE:int = 23;
        static const FIELD_SIZE:int = 32;
        private static var s_SpeedB:Number = 1;
        private static var s_SpeedA:Number = 0;
        static const SKILL_FIGHTDISTANCE:int = 9;
        static const PK_EXCPLAYERKILLER:int = 5;
        static const NUM_CREATURES:int = 1300;
        static const NUM_TRAPPERS:int = 8;
        static const SKILL_FED:int = 15;
        static const SKILL_MAGLEVEL:int = 2;
        static const SKILL_FISHING:int = 14;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const SKILL_HITPOINTS_PERCENT:int = 3;
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
        private static var s_SpeedC:Number = 1;
        static const BLESSING_BLOOD_OF_THE_MOUNTAIN:int = BLESSING_HEART_OF_THE_MOUNTAIN << 1;
        static const MAX_NAME_LENGTH:int = 29;
        static const PARTY_LEADER:int = 1;
        static const SKILL_CARRYSTRENGTH:int = 7;
        static const STATE_PZ_ENTERED:int = 14;
        static const PK_ATTACKER:int = 1;
        static const STATE_ELECTRIFIED:int = 2;
        static const SKILL_FIGHTSWORD:int = 11;
        static const GUILD_WAR_NEUTRAL:int = 3;
        static const STATE_DROWNING:int = 8;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const MAP_MIN_X:int = 24576;
        static const BLESSING_HEART_OF_THE_MOUNTAIN:int = BLESSING_EMBRACE_OF_TIBIA << 1;
        static const SKILL_LIFE_LEECH_AMOUNT:int = 22;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const PARTY_MEMBER_SEXP_OFF:int = 3;
        static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
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
        static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
        static const PROFESSION_KNIGHT:int = 1;
        static const NPC_SPEECH_QUESTTRADER:uint = 4;
        static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
        public static const MAX_NAME_LENGHT:int = 29;
        static const UNDERGROUND_LAYER:int = 2;
        static const BLESSING_WISDOM_OF_SOLITUDE:int = BLESSING_TWIST_OF_FATE << 1;
        static const FIELD_CACHESIZE:int = 32;
        static const PROFESSION_PALADIN:int = 2;
        static const PLAYER_OFFSET_X:int = 8;
        static const SKILL_FIGHTAXE:int = 12;
        static const SKILL_CRITICAL_HIT_DAMAGE:int = 20;
        static const PLAYER_OFFSET_Y:int = 6;
        static const PARTY_LEADER_SEXP_OFF:int = 4;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const SKILL_SOULPOINTS:int = 16;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const BLESSING_EMBRACE_OF_TIBIA:int = BLESSING_SPIRITUAL_SHIELDING << 1;
        static const STATE_FAST:int = 6;
        static const BLESSING_TWIST_OF_FATE:int = BLESSING_ADVENTURER << 1;
        static const SKILL_MANA_LEECH_AMOUNT:int = 24;
        static const BLESSING_NONE:int = 0;
        static const GUILD_OTHER:int = 5;
        static const TYPE_PLAYER:int = 0;
        static const SKILL_HITPOINTS:int = 4;
        static const SKILL_OFFLINETRAINING:int = 18;
        static const STATE_MANA_SHIELD:int = 4;
        static const SKILL_MANA:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const STATE_CURSED:int = 11;
        static const BLESSING_ADVENTURER:int = 1;
        static const STATE_FREEZING:int = 9;
        private static const s_TempHealthColour:Colour = new Colour(0, 0, 0);
        static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
        static const NUM_FIELDS:int = 2016;
        static const STATE_POISONED:int = 0;
        static const SKILL_LIFE_LEECH_CHANCE:int = 21;
        static const TYPE_MONSTER:int = 1;
        static const STATE_BURNING:int = 1;
        static const SKILL_FIGHTFIST:int = 13;
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
        static const TYPE_PLAYERSUMMON:int = 3;
        static const MAPSIZE_W:int = 10;
        static const BLESSING_SPIRITUAL_SHIELDING:int = BLESSING_FIRE_OF_SUNS << 1;
        static const NPC_SPEECH_NONE:uint = 0;
        static const PK_MAX_FLASHING_TIME:uint = 5000;
        static const SKILL_GOSTRENGTH:int = 6;

        public function Creature(param1:int = 0, param2:int = 1, param3:String = null)
        {
            this.m_AnimationDelta = new Vector3D();
            this.m_AnimationSpeed = new Vector3D();
            this.m_LightColour = new Colour(0, 0, 0);
            this.m_Position = new Vector3D();
            this.m_ID = param1;
            this.m_Type = param2;
            this.m_Name = param3;
            this.m_Marks = new Marks();
            this.m_Marks.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMarksDataChange);
            this.resetSkills();
            return;
        }// end function

        private function onMarksDataChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "marks")
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function get outfit() : AppearanceInstance
        {
            return this.m_Outfit;
        }// end function

        public function set lightColour(param1:Colour) : void
        {
            this.m_LightColour = param1;
            return;
        }// end function

        public function get isPartyLeader() : Boolean
        {
            return this.m_PartyFlag == PARTY_LEADER || this.m_PartyFlag == PARTY_LEADER_SEXP_ACTIVE || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_GUILTY || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_INNOCENT || this.m_PartyFlag == PARTY_LEADER_SEXP_OFF;
        }// end function

        public function getSkillBase(param1:int) : Number
        {
            if (param1 >= 0 && param1 < this.m_Skills.length)
            {
                return this.m_Skills[3 * param1 + 1];
            }
            return 0;
        }// end function

        public function get pkFlag() : int
        {
            return this.m_PKFlag;
        }// end function

        public function set outfit(param1:AppearanceInstance) : void
        {
            var _loc_2:* = this.outfit;
            if (_loc_2 !== param1)
            {
                this._1005522429outfit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outfit", _loc_2, param1));
            }
            return;
        }// end function

        public function set direction(param1:int) : void
        {
            this.m_Direction = param1;
            return;
        }// end function

        public function set summonerCreatureID(param1:uint) : void
        {
            var _loc_2:* = this.summonerCreatureID;
            if (_loc_2 !== param1)
            {
                this._74792328summonerCreatureID = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "summonerCreatureID", _loc_2, param1));
            }
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        private function set _3373707name(param1:String) : void
        {
            this.m_Name = param1 ? (param1.substr(0, MAX_NAME_LENGTH)) : (null);
            if (this.m_Name && !this.isHuman)
            {
                this.m_Name = StringHelper.s_Capitalise(this.m_Name);
            }
            return;
        }// end function

        public function set name(param1:String) : void
        {
            var _loc_2:* = this.name;
            if (_loc_2 !== param1)
            {
                this._3373707name = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _loc_2, param1));
            }
            return;
        }// end function

        public function get isHuman() : Boolean
        {
            return this.m_Type == TYPE_PLAYER;
        }// end function

        public function set mountOutfit(param1:AppearanceInstance) : void
        {
            var _loc_2:* = this.mountOutfit;
            if (_loc_2 !== param1)
            {
                this._1023992700mountOutfit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mountOutfit", _loc_2, param1));
            }
            return;
        }// end function

        public function get hasFlag() : Boolean
        {
            return this.pkFlag != PK_NONE || this.partyFlag != PARTY_NONE || this.summonFlag != SUMMON_NONE || this.guildFlag != GUILD_NONE || this.riskinessFlag != RISKINESS_NONE || this.speechCategory != NPC_SPEECH_NONE;
        }// end function

        private function set _3575610type(param1:int) : void
        {
            if (param1 != TYPE_PLAYER && param1 != TYPE_MONSTER && param1 != TYPE_NPC && param1 != TYPE_PLAYERSUMMON)
            {
                throw new ArgumentError("Creature.set type: Invalid creature type: " + param1 + ".");
            }
            this.m_Type = param1;
            return;
        }// end function

        public function set guildFlag(param1:int) : void
        {
            var _loc_2:* = this.guildFlag;
            if (_loc_2 !== param1)
            {
                this._1848738305guildFlag = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "guildFlag", _loc_2, param1));
            }
            return;
        }// end function

        public function get hitpointsPercent() : Number
        {
            return this.getSkillValue(SKILL_HITPOINTS_PERCENT);
        }// end function

        private function set _1023992700mountOutfit(param1:AppearanceInstance) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.m_MountOutfit != param1)
            {
                _loc_2 = this.m_MountOutfit;
                if (this.m_MountOutfit == null && this.m_Name != null)
                {
                    BattlelistWidgetView.s_ClearCreatureCache(this.m_Name);
                }
                this.m_MountOutfit = param1;
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                _loc_3.property = "mountOutfit";
                _loc_3.oldValue = _loc_2;
                _loc_3.newValue = this.m_MountOutfit;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function getMovementSpeed() : int
        {
            var _loc_1:* = this.getSkillValue(SKILL_GOSTRENGTH);
            if (_loc_1 <= -speedB)
            {
                return 0;
            }
            return Math.round(speedA * Math.log(_loc_1 + speedB) + speedC);
        }// end function

        public function get hitpoints() : Number
        {
            return uint(this.getSkillValue(SKILL_HITPOINTS));
        }// end function

        public function setPartyFlag(param1:int) : void
        {
            if (param1 < PARTY_NONE || param1 > PARTY_OTHER)
            {
                throw new ArgumentError("Creature.set partyFlag: Invalid flag.");
            }
            this.m_PartyFlag = param1;
            return;
        }// end function

        public function get position() : Vector3D
        {
            return this.m_Position.clone();
        }// end function

        public function get type() : int
        {
            return this.m_Type;
        }// end function

        public function isReportTypeAllowed(param1:uint) : Boolean
        {
            return this.isHuman && (param1 == Type.REPORT_NAME || param1 == Type.REPORT_BOT);
        }// end function

        function animateOutfit(param1:Number) : void
        {
            var _loc_2:* = !this.m_MovementRunning || this.m_MovementEnd != this.m_AnimationEnd && param1 >= this.m_AnimationEnd;
            if (this.m_Outfit != null && this.m_Outfit.tibia.appearances:ns_appearance_internal::m_Type != null)
            {
                this.m_Outfit.switchFrameGroup(_loc_2 ? (FrameGroup.FRAME_GROUP_IDLE) : (FrameGroup.FRAME_GROUP_WALKING));
                this.m_Outfit.animate(param1, !_loc_2 ? (this.m_AnimationSpeed.z) : (0));
            }
            if (this.m_MountOutfit != null && this.m_MountOutfit.tibia.appearances:ns_appearance_internal::m_Type != null)
            {
                this.m_MountOutfit.switchFrameGroup(_loc_2 ? (FrameGroup.FRAME_GROUP_IDLE) : (FrameGroup.FRAME_GROUP_WALKING));
                this.m_MountOutfit.animate(param1, !_loc_2 ? (this.m_AnimationSpeed.z) : (0));
            }
            return;
        }// end function

        public function set numberOfPVPHelpers(param1:uint) : void
        {
            this.m_NumberOfPVPHelpers = param1;
            return;
        }// end function

        public function get marks() : Marks
        {
            return this.m_Marks;
        }// end function

        public function get mana() : Number
        {
            return 0;
        }// end function

        public function get numberOfPVPHelpers() : uint
        {
            return this.m_NumberOfPVPHelpers;
        }// end function

        public function get isUnpassable() : Boolean
        {
            return this.m_IsUnpassable;
        }// end function

        public function reset() : void
        {
            this.resetSkills();
            this.m_AnimationDelta.setZero();
            this.m_AnimationDirection = 0;
            this.m_AnimationEnd = 0;
            this.m_AnimationSpeed.setZero();
            this.m_Brightness = 0;
            this.m_Direction = 0;
            this.m_ID = 0;
            this.m_IsTrapper = false;
            this.m_IsUnpassable = false;
            this.m_KnownSince = -1;
            this.m_LightColour.setChannels(0, 0, 0);
            this.m_MovementEnd = 0;
            this.m_MovementRunning = false;
            if (this.m_Name != null)
            {
                BattlelistWidgetView.s_ClearCreatureCache(this.m_Name);
            }
            this.m_Name = null;
            this.m_PartyFlag = PARTY_NONE;
            this.m_PKFlag = PK_NONE;
            this.m_Type = TYPE_MONSTER;
            this.m_Visible = false;
            this.m_GuildFlag = GUILD_NONE;
            this.m_Marks.clear();
            this.m_MountOutfit = null;
            this.m_Outfit = null;
            this.m_Position.setZero();
            return;
        }// end function

        public function get brightness() : int
        {
            return this.m_Brightness;
        }// end function

        public function startMovementAnimation(param1:int, param2:int, param3:int) : void
        {
            var _loc_7:* = null;
            var _loc_4:* = Tibia.s_GetCommunication();
            if (Tibia.s_GetCommunication() == null || !(_loc_4.isGameRunning || _loc_4.isPending))
            {
                _loc_7 = Tibia.s_GetConnection();
                throw new Error("Creature.startMovementAnimation: Invalid state." + _loc_4 == null || _loc_7 == null ? ("(connection or communication is null)") : ("(State: " + _loc_7.connectionState + ")"));
            }
            if (param1 > 0)
            {
                this.m_Direction = 1;
            }
            else if (param1 < 0)
            {
                this.m_Direction = 3;
            }
            else if (param2 < 0)
            {
                this.m_Direction = 0;
            }
            else if (param2 > 0)
            {
                this.m_Direction = 2;
            }
            this.m_AnimationDirection = this.m_Direction;
            this.m_AnimationDelta.x = (-param1) * FIELD_SIZE;
            this.m_AnimationDelta.y = (-param2) * FIELD_SIZE;
            this.m_AnimationDelta.z = 0;
            var _loc_5:* = Math.max(1, this.getMovementSpeed());
            var _loc_6:* = Math.floor(1000 * param3 / _loc_5);
            _loc_6 = Math.ceil(_loc_6 / _loc_4.beatDuration) * _loc_4.beatDuration;
            this.m_AnimationSpeed.x = (-param1) * FIELD_SIZE;
            this.m_AnimationSpeed.y = (-param2) * FIELD_SIZE;
            this.m_AnimationSpeed.z = _loc_6;
            this.m_AnimationEnd = Tibia.s_FrameTibiaTimestamp + _loc_6;
            if (param1 != 0 && param2 != 0)
            {
                _loc_6 = Math.floor(1000 * param3 * 3 / _loc_5);
            }
            this.m_MovementEnd = Tibia.s_FrameTibiaTimestamp + _loc_6;
            this.m_MovementRunning = true;
            return;
        }// end function

        public function get characterName() : String
        {
            return this.m_Name;
        }// end function

        public function get isNPC() : Boolean
        {
            return this.m_Type == TYPE_NPC;
        }// end function

        public function set ID(param1:int) : void
        {
            var _loc_2:* = this.ID;
            if (_loc_2 !== param1)
            {
                this._2331ID = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ID", _loc_2, param1));
            }
            return;
        }// end function

        public function get isTrapper() : Boolean
        {
            return this.m_IsTrapper;
        }// end function

        public function set earliestMoveTime(param1:Number) : void
        {
            this.m_MovementEnd = param1;
            return;
        }// end function

        public function get speechCategory() : uint
        {
            return this.m_SpeechCategory;
        }// end function

        function set knownSince(param1:int) : void
        {
            this.m_KnownSince = param1;
            return;
        }// end function

        public function resetSkills() : void
        {
            this.m_Skills = new Vector.<Number>((Math.max(SKILL_HITPOINTS_PERCENT, SKILL_GOSTRENGTH) + 1) * 3, true);
            var _loc_1:* = 0;
            while (_loc_1 < this.m_Skills.length)
            {
                
                this.m_Skills[_loc_1 + 0] = 0;
                this.m_Skills[(_loc_1 + 1)] = 0;
                this.m_Skills[_loc_1 + 2] = 0;
                _loc_1 = _loc_1 + 3;
            }
            return;
        }// end function

        public function get partyFlag() : int
        {
            return this.m_PartyFlag;
        }// end function

        public function set speechCategory(param1:uint) : void
        {
            if (param1 < NPC_SPEECH_NONE || param1 > NPC_SPEECH_TRAVEL)
            {
                throw new ArgumentError("Creature.speechFlag: Invalid speech flag: " + param1);
            }
            this.m_SpeechCategory = param1;
            return;
        }// end function

        function get visible() : Boolean
        {
            return this.m_Visible;
        }// end function

        public function get mountOutfit() : AppearanceInstance
        {
            return this.m_MountOutfit;
        }// end function

        public function get direction() : int
        {
            return this.m_MovementRunning ? (this.m_AnimationDirection) : (this.m_Direction);
        }// end function

        public function get lightColour() : Colour
        {
            return this.m_LightColour;
        }// end function

        public function get summonerCreatureID() : uint
        {
            return this.m_SummonerCreatureID;
        }// end function

        public function get isConfirmedPartyMember() : Boolean
        {
            return this.m_PartyFlag == PARTY_LEADER_SEXP_ACTIVE || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_GUILTY || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_INNOCENT || this.m_PartyFlag == PARTY_LEADER_SEXP_OFF || this.m_PartyFlag == PARTY_MEMBER_SEXP_ACTIVE || this.m_PartyFlag == PARTY_MEMBER_SEXP_INACTIVE_GUILTY || this.m_PartyFlag == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT || this.m_PartyFlag == PARTY_MEMBER_SEXP_OFF;
        }// end function

        public function get isPartySharedExperienceActive() : Boolean
        {
            return this.m_PartyFlag == PARTY_LEADER_SEXP_ACTIVE || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_GUILTY || this.m_PartyFlag == PARTY_LEADER_SEXP_INACTIVE_INNOCENT || this.m_PartyFlag == PARTY_MEMBER_SEXP_ACTIVE || this.m_PartyFlag == PARTY_MEMBER_SEXP_INACTIVE_GUILTY || this.m_PartyFlag == PARTY_MEMBER_SEXP_INACTIVE_INNOCENT;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function set isTrapper(param1:Boolean) : void
        {
            this.m_IsTrapper = param1;
            return;
        }// end function

        public function get isPartyMember() : Boolean
        {
            return this.m_PartyFlag == PARTY_LEADER || this.isConfirmedPartyMember;
        }// end function

        public function get animationDelta() : Vector3D
        {
            return this.m_AnimationDelta;
        }// end function

        public function set isUnpassable(param1:Boolean) : void
        {
            this.m_IsUnpassable = param1;
            return;
        }// end function

        public function getSkillValue(param1:int) : Number
        {
            if (param1 >= 0 && param1 < this.m_Skills.length)
            {
                return this.m_Skills[3 * param1 + 0];
            }
            return 0;
        }// end function

        public function getPosition(param1:Vector3D = null) : Vector3D
        {
            if (param1 == null)
            {
                return this.m_Position.clone();
            }
            param1.x = this.m_Position.x;
            param1.y = this.m_Position.y;
            param1.z = this.m_Position.z;
            return param1;
        }// end function

        public function set brightness(param1:int) : void
        {
            this.m_Brightness = param1;
            return;
        }// end function

        public function setSkill(param1:int, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = null;
            if (param1 >= 0 && param1 < this.m_Skills.length)
            {
                this.m_Skills[3 * param1 + 0] = param2;
                this.m_Skills[3 * param1 + 1] = param3;
                this.m_Skills[3 * param1 + 2] = param4;
                _loc_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_5.kind = PropertyChangeEventKind.UPDATE;
                _loc_5.property = "skill";
                dispatchEvent(_loc_5);
                ;
            }
            return;
        }// end function

        public function setSkillValue(param1:int, param2:Number) : void
        {
            var _loc_3:* = null;
            if (param1 >= 0 && param1 < this.m_Skills.length)
            {
                this.m_Skills[3 * param1 + 0] = param2;
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                _loc_3.property = "skill";
                dispatchEvent(_loc_3);
                ;
            }
            return;
        }// end function

        public function get isSummon() : Boolean
        {
            return this.m_Type == TYPE_PLAYERSUMMON;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = this.type;
            if (_loc_2 !== param1)
            {
                this._3575610type = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _loc_2, param1));
            }
            return;
        }// end function

        function animateMovement(param1:Number) : void
        {
            var _loc_2:* = NaN;
            this.m_AnimationDelta.setZero();
            if (this.m_MovementRunning)
            {
                _loc_2 = param1 - (this.m_AnimationEnd - this.m_AnimationSpeed.z);
                if (_loc_2 <= 0)
                {
                    this.m_AnimationDelta.x = this.m_AnimationSpeed.x;
                    this.m_AnimationDelta.y = this.m_AnimationSpeed.y;
                }
                else if (_loc_2 >= this.m_AnimationSpeed.z)
                {
                    this.m_AnimationDelta.x = 0;
                    this.m_AnimationDelta.y = 0;
                }
                else if (this.m_AnimationSpeed.z != 0)
                {
                    this.m_AnimationDelta.x = this.m_AnimationSpeed.x - Math.round(this.m_AnimationSpeed.x * _loc_2 / this.m_AnimationSpeed.z);
                    this.m_AnimationDelta.y = this.m_AnimationSpeed.y - Math.round(this.m_AnimationSpeed.y * _loc_2 / this.m_AnimationSpeed.z);
                }
            }
            this.m_MovementRunning = param1 < this.m_MovementEnd || this.m_AnimationDelta.x != 0 || this.m_AnimationDelta.y != 0;
            return;
        }// end function

        public function get earliestMoveTime() : Number
        {
            return this.m_MovementEnd;
        }// end function

        private function set _2331ID(param1:int) : void
        {
            this.m_ID = param1;
            return;
        }// end function

        public function getPositionZ() : int
        {
            return this.m_Position.z;
        }// end function

        function get knownSince() : int
        {
            return this.m_KnownSince;
        }// end function

        private function set _1848738305guildFlag(param1:int) : void
        {
            if (param1 < GUILD_NONE || param1 > GUILD_OTHER)
            {
                throw new ArgumentError("Creature.set guildFlag: Invalid flag.");
            }
            this.m_GuildFlag = param1;
            return;
        }// end function

        public function stopMovementAnimation() : void
        {
            this.m_AnimationDirection = this.m_Direction;
            this.m_AnimationDelta.setZero();
            this.m_AnimationSpeed.setZero();
            this.m_AnimationEnd = 0;
            this.m_MovementEnd = 0;
            this.m_MovementRunning = false;
            return;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            this.m_Position.x = param1;
            this.m_Position.y = param2;
            this.m_Position.z = param3;
            return;
        }// end function

        private function set _74792328summonerCreatureID(param1:uint) : void
        {
            this.m_SummonerCreatureID = param1;
            return;
        }// end function

        public function get riskinessFlag() : int
        {
            if (this.m_NumberOfPVPHelpers >= NUM_PVP_HELPERS_FOR_RISKINESS_DANGEROUS)
            {
                return RISKINESS_DANGEROUS;
            }
            return RISKINESS_NONE;
        }// end function

        private function set _1005522429outfit(param1:AppearanceInstance) : void
        {
            if (this.m_Outfit != param1)
            {
                if (this.m_Name != null)
                {
                    BattlelistWidgetView.s_ClearCreatureCache(this.m_Name);
                }
                this.m_Outfit = param1;
            }
            return;
        }// end function

        function set visible(param1:Boolean) : void
        {
            this.m_Visible = param1;
            return;
        }// end function

        public function get summonFlag() : uint
        {
            if (this.m_Type == TYPE_PLAYERSUMMON)
            {
                if (this.m_SummonerCreatureID == Tibia.s_GetCreatureStorage().player.ID)
                {
                    return SUMMON_OWN;
                }
                return SUMMON_OTHERS;
            }
            else
            {
                return SUMMON_NONE;
            }
        }// end function

        public function getSkillProgress(param1:int) : Number
        {
            if (param1 >= 0 && param1 < this.m_Skills.length)
            {
                return this.m_Skills[3 * param1 + 2];
            }
            return 0;
        }// end function

        public function setPKFlag(param1:int) : void
        {
            if (param1 < PK_NONE || param1 > PK_REVENGE)
            {
                throw new ArgumentError("Creature.set pkFlag: Invalid flag.");
            }
            var _loc_2:* = this.m_PKFlag;
            this.m_PKFlag = param1;
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            _loc_3.property = "pkFlag";
            _loc_3.oldValue = _loc_2;
            _loc_3.newValue = this.m_PKFlag;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function setReportTypeAllowed(param1:uint, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get manaPercent() : Number
        {
            return 100;
        }// end function

        public function get guildFlag() : int
        {
            return this.m_GuildFlag;
        }// end function

        public static function get speedA() : Number
        {
            return s_SpeedA;
        }// end function

        public static function get speedB() : Number
        {
            return s_SpeedB;
        }// end function

        public static function get speedC() : Number
        {
            return s_SpeedC;
        }// end function

        public static function s_GetHealthColourARGB(param1:Number) : uint
        {
            if (param1 < 4)
            {
                s_TempHealthColour.setChannels(96, 0, 0);
            }
            else if (param1 < 10)
            {
                s_TempHealthColour.setChannels(192, 0, 0);
            }
            else if (param1 < 30)
            {
                s_TempHealthColour.setChannels(192, 48, 48);
            }
            else if (param1 < 60)
            {
                s_TempHealthColour.setChannels(192, 192, 0);
            }
            else if (param1 < 95)
            {
                s_TempHealthColour.setChannels(96, 192, 96);
            }
            else
            {
                s_TempHealthColour.setChannels(0, 192, 0);
            }
            return s_TempHealthColour.ARGB;
        }// end function

        public static function set speedA(param1:Number) : void
        {
            s_SpeedA = param1;
            return;
        }// end function

        public static function set speedC(param1:Number) : void
        {
            s_SpeedC = param1;
            return;
        }// end function

        public static function set speedB(param1:Number) : void
        {
            s_SpeedB = param1;
            return;
        }// end function

    }
}
