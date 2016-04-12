package tibia.creatures
{
    import mx.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.magic.*;
    import tibia.minimap.*;
    import tibia.network.*;
    import tibia.worldmap.*;

    public class Player extends Creature
    {
        protected var m_AutowalkPathDelta:Vector3D;
        private var m_StateFlags:uint = 4.29497e+009;
        private var m_Profession:int = 0;
        protected var m_AutowalkTargetDiagonal:Boolean = false;
        protected var m_ExperienceCounter:SkillCounter;
        protected var m_AutowalkPathAborting:Boolean = false;
        private var m_OpenPvPSituations:uint = 0;
        private var m_Blessings:uint = 0;
        protected var m_AutowalkTarget:Vector3D;
        protected var m_ExperienceBonus:Number = 0;
        protected var m_AutowalkTargetExact:Boolean = false;
        private var m_Premium:Boolean = false;
        protected var m_AutowalkPathSteps:Array;
        private var m_PremiumUntil:uint = 0;
        private var m_UnjustPoints:UnjustPointsInfo;
        private var m_KnownSpells:Array;
        static const PATH_MATRIX_CENTER:int = 110;
        static const PATH_MAX_STEPS:int = 128;
        static const PATH_ERROR_UNREACHABLE:int = -4;
        private static var s_v1:Vector3D = new Vector3D();
        private static var s_v2:Vector3D = new Vector3D();
        static const PATH_WEST:int = 5;
        static const PATH_NORTH:int = 3;
        static const PATH_EMPTY:int = 0;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const PATH_EAST:int = 1;
        static const PATH_COST_UNDEFINED:int = 254;
        static const PATH_SOUTH:int = 7;
        static const PATH_SOUTH_WEST:int = 6;
        static const PATH_NORTH_WEST:int = 4;
        static const PATH_MATRIX_SIZE:int = 221;
        static const PATH_COST_OBSTACLE:int = 255;
        static const PATH_MAX_DISTANCE:int = 110;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        static const PATH_COST_MAX:int = 250;
        static const PATH_NORTH_EAST:int = 2;
        static const PATH_SOUTH_EAST:int = 8;
        static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
        static const PATH_ERROR_TOO_FAR:int = -3;
        static const PATH_EXISTS:int = 1;

        public function Player()
        {
            this.m_ExperienceCounter = new SkillCounter();
            this.m_AutowalkPathDelta = new Vector3D(0, 0, 0);
            this.m_AutowalkPathSteps = [];
            this.m_AutowalkTarget = new Vector3D(-1, -1, -1);
            this.m_KnownSpells = [];
            this.m_UnjustPoints = new UnjustPointsInfo(0, 0, 0, 0, 0, 0, 0);
            super(0, TYPE_PLAYER, null);
            return;
        }// end function

        public function startAutowalk(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
        {
            if (param1 == this.m_AutowalkTarget.x && param2 == this.m_AutowalkTarget.y && param3 == this.m_AutowalkTarget.z)
            {
                return;
            }
            if (param1 == m_Position.x + 2 * this.m_AutowalkPathDelta.x && param2 == m_Position.y + 2 * this.m_AutowalkPathDelta.y && param3 == m_Position.z + 2 * this.m_AutowalkPathDelta.z)
            {
                return;
            }
            var _loc_6:* = Tibia.s_GetCommunication();
            var _loc_7:* = Tibia.s_GetWorldMapStorage();
            if (_loc_6 == null || !_loc_6.isGameRunning || _loc_7 == null)
            {
                return;
            }
            this.m_AutowalkTarget.setComponents(-1, -1, -1);
            this.m_AutowalkTargetDiagonal = false;
            this.m_AutowalkTargetExact = false;
            if (_loc_7.isVisible(param1, param2, param3, true))
            {
                s_v1.setComponents(param1, param2, param3);
                _loc_7.toMap(s_v1, s_v1);
                if ((s_v1.x != PLAYER_OFFSET_X || s_v1.y != PLAYER_OFFSET_Y) && _loc_7.getEnterPossibleFlag(s_v1.x, s_v1.y, s_v1.z, true) == FIELD_ENTER_NOT_POSSIBLE)
                {
                    _loc_7.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_SORRY_NOT_POSSIBLE);
                    return;
                }
            }
            this.m_AutowalkTarget.setComponents(param1, param2, param3);
            this.m_AutowalkTargetDiagonal = param4;
            this.m_AutowalkTargetExact = param5;
            if (this.m_AutowalkPathAborting)
            {
                return;
            }
            if (this.m_AutowalkPathSteps.length == 1)
            {
                return;
            }
            if (this.m_AutowalkPathSteps.length == 0)
            {
                this.startAutowalkInternal();
            }
            else
            {
                _loc_6.sendCSTOP();
                this.m_AutowalkPathAborting = true;
            }
            return;
        }// end function

        public function get anticipatedPosition() : Vector3D
        {
            return m_Position.add(this.m_AutowalkPathDelta);
        }// end function

        public function get level() : uint
        {
            return uint(getSkillValue(SKILL_LEVEL));
        }// end function

        public function set profession(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 != PROFESSION_DRUID && param1 != PROFESSION_KNIGHT && param1 != PROFESSION_PALADIN && param1 != PROFESSION_SORCERER)
            {
                param1 = PROFESSION_NONE;
            }
            if (this.m_Profession != param1)
            {
                this.m_Profession = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "profession";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get profession() : int
        {
            return this.m_Profession;
        }// end function

        public function set premiumUntil(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this.m_PremiumUntil != param1)
            {
                this.m_PremiumUntil = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "premiumUntil";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        override public function setSkill(param1:int, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = NaN;
            switch(param1)
            {
                case SKILL_EXPERIENCE:
                {
                    _loc_5 = getSkillValue(SKILL_EXPERIENCE);
                    if (param2 >= _loc_5)
                    {
                        if (_loc_5 > 0)
                        {
                            this.m_ExperienceCounter.addSkillGain(param2 - _loc_5);
                        }
                    }
                    else
                    {
                        this.m_ExperienceCounter.reset();
                    }
                    super.setSkill(param1, param2, param3, param4);
                    break;
                }
                case SKILL_FED:
                {
                    super.setSkill(param1, param2, param3, param4);
                    this.updateStateFlags();
                    break;
                }
                default:
                {
                    super.setSkill(param1, param2, param3, param4);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function set unjustPoints(param1:UnjustPointsInfo) : void
        {
            var _loc_2:* = null;
            if (!this.m_UnjustPoints.equals(param1))
            {
                this.m_UnjustPoints = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "unjustPoints";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function set blessings(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this.m_Blessings != param1)
            {
                this.m_Blessings = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "blessings";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function resetFlags() : void
        {
            setPartyFlag(PARTY_NONE);
            setPKFlag(PK_NONE);
            this.stateFlags = 0;
            guildFlag = GUILD_NONE;
            return;
        }// end function

        public function get isFighting() : Boolean
        {
            return (this.m_StateFlags & 1 << STATE_FIGHTING) > 0;
        }// end function

        public function get manaMax() : Number
        {
            return getSkillBase(SKILL_MANA);
        }// end function

        private function updateStateFlags(param1 = null) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = 2147483647 & (param1 != null ? (uint(param1)) : (this.m_StateFlags));
            if (getSkillValue(SKILL_FED) <= getSkillBase(SKILL_FED))
            {
                _loc_2 = _loc_2 | 1 << STATE_HUNGRY;
            }
            if (this.m_StateFlags != _loc_2)
            {
                _loc_3 = this.m_StateFlags;
                this.m_StateFlags = _loc_2;
                _loc_4 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_4.kind = PropertyChangeEventKind.UPDATE;
                _loc_4.property = "stateFlags";
                _loc_4.oldValue = _loc_3;
                _loc_4.newValue = _loc_2;
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

        public function get levelPercent() : uint
        {
            return uint(getSkillProgress(SKILL_LEVEL));
        }// end function

        override public function setSkillValue(param1:int, param2:Number) : void
        {
            var _loc_3:* = NaN;
            switch(param1)
            {
                case SKILL_EXPERIENCE:
                {
                    _loc_3 = getSkillValue(SKILL_EXPERIENCE);
                    if (param2 >= _loc_3)
                    {
                        if (_loc_3 > 0)
                        {
                            this.m_ExperienceCounter.addSkillGain(param2 - _loc_3);
                        }
                    }
                    else
                    {
                        this.m_ExperienceCounter.reset();
                    }
                    super.setSkillValue(param1, param2);
                    break;
                }
                case SKILL_FED:
                {
                    super.setSkillValue(param1, param2);
                    this.updateStateFlags();
                    break;
                }
                default:
                {
                    super.setSkillValue(param1, param2);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function getRuneUses(param1:Rune) : int
        {
            if (param1 == null || param1.restrictLevel > getSkillValue(SKILL_LEVEL) || param1.restrictMagicLevel > getSkillValue(SKILL_MAGLEVEL) || (param1.restrictProfession & 1 << this.profession) == 0)
            {
                return -1;
            }
            if (param1.castMana <= this.mana)
            {
                return param1.castMana > 0 ? (int(this.mana / param1.castMana)) : (int.MAX_VALUE);
            }
            else
            {
                return 0;
            }
        }// end function

        public function stopAutowalk(param1:Boolean) : void
        {
            if (param1)
            {
                stopMovementAnimation();
            }
            this.m_AutowalkPathAborting = false;
            this.m_AutowalkPathDelta.setZero();
            this.m_AutowalkPathSteps.length = 0;
            this.m_AutowalkTarget.setComponents(-1, -1, -1);
            this.m_AutowalkTargetDiagonal = false;
            this.m_AutowalkTargetExact = false;
            return;
        }// end function

        public function set openPvpSituations(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this.m_OpenPvPSituations != param1)
            {
                this.m_OpenPvPSituations = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "openPvpSituations";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        override public function get hitpointsPercent() : Number
        {
            var _loc_1:* = getSkillBase(SKILL_HITPOINTS);
            if (_loc_1 > 0)
            {
                return getSkillValue(SKILL_HITPOINTS) * 100 / _loc_1;
            }
            return 100;
        }// end function

        public function set experienceBonus(param1:Number) : void
        {
            this.m_ExperienceBonus = param1;
            return;
        }// end function

        public function set premium(param1:Boolean) : void
        {
            this.m_Premium = param1;
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            _loc_2.property = "premium";
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get soulPointPercent() : Number
        {
            var _loc_1:* = getSkillBase(SKILL_SOULPOINTS);
            if (_loc_1 > 0)
            {
                return getSkillValue(SKILL_SOULPOINTS) * 100 / _loc_1;
            }
            return 100;
        }// end function

        public function getSkillGain(param1:int) : Number
        {
            switch(param1)
            {
                case SKILL_EXPERIENCE:
                {
                    return this.m_ExperienceCounter.getAverageGain();
                }
                default:
                {
                    return NaN;
                    break;
                }
            }
        }// end function

        public function get soulPoints() : Number
        {
            return getSkillValue(SKILL_SOULPOINTS);
        }// end function

        public function animateMovement(param1:Number) : void
        {
            super.animateMovement(param1);
            m_AnimationDelta.x = m_AnimationDelta.x + this.m_AutowalkPathDelta.x * FIELD_SIZE;
            m_AnimationDelta.y = m_AnimationDelta.y + this.m_AutowalkPathDelta.y * FIELD_SIZE;
            if (!m_MovementRunning && this.m_AutowalkPathDelta.isZero())
            {
                if (this.m_AutowalkPathSteps.length > 0)
                {
                    this.nextAutowalkStep();
                }
                else
                {
                    this.startAutowalkInternal();
                }
            }
            return;
        }// end function

        public function getSpellCasts(param1:Spell) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 == null || !this.isSpellKnown(param1) || param1.restrictLevel > getSkillValue(SKILL_LEVEL) || param1.restrictPremium && !this.premium || (param1.restrictProfession & 1 << this.profession) == 0)
            {
                return -1;
            }
            if (param1.castMana <= this.mana && param1.castSoulPoints <= getSkillValue(SKILL_SOULPOINTS))
            {
                _loc_2 = param1.castMana > 0 ? (int(this.mana / param1.castMana)) : (int.MAX_VALUE);
                _loc_3 = param1.castSoulPoints > 0 ? (int(this.soulPoints / param1.castSoulPoints)) : (int.MAX_VALUE);
                return Math.min(_loc_2, _loc_3);
            }
            else
            {
                return 0;
            }
        }// end function

        public function isSpellKnown(param1:Spell) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = this.knownSpells.length - 1;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_2 = _loc_3 + _loc_4 >>> 1;
                if (param1.ID < this.knownSpells[_loc_2])
                {
                    _loc_4 = _loc_2 - 1;
                    continue;
                }
                if (param1.ID > this.knownSpells[_loc_2])
                {
                    _loc_3 = _loc_2 + 1;
                    continue;
                }
                return true;
            }
            return false;
        }// end function

        override public function get mana() : Number
        {
            return getSkillValue(SKILL_MANA);
        }// end function

        public function get blessings() : uint
        {
            return this.m_Blessings;
        }// end function

        public function get hitpointsMax() : Number
        {
            return getSkillBase(SKILL_HITPOINTS);
        }// end function

        public function get unjustPoints() : UnjustPointsInfo
        {
            return this.m_UnjustPoints;
        }// end function

        override public function startMovementAnimation(param1:int, param2:int, param3:int) : void
        {
            if (param1 != this.m_AutowalkPathDelta.x || param2 != this.m_AutowalkPathDelta.y)
            {
                super.startMovementAnimation(param1, param2, param3);
            }
            this.m_AutowalkPathDelta.setZero();
            if (this.m_AutowalkPathSteps.length > 0)
            {
                this.m_AutowalkPathSteps.shift();
            }
            return;
        }// end function

        public function get openPvpSituations() : uint
        {
            return this.m_OpenPvPSituations;
        }// end function

        public function get premiumUntil() : uint
        {
            if (this.m_PremiumUntil == 0 && this.m_Premium)
            {
                return uint.MAX_VALUE;
            }
            return this.m_PremiumUntil;
        }// end function

        public function get premium() : Boolean
        {
            return this.m_Premium;
        }// end function

        public function hasBlessing(param1:uint) : Boolean
        {
            if (param1 == BLESSING_NONE)
            {
                return this.blessings == param1;
            }
            return (this.blessings & param1) == param1;
        }// end function

        public function get soulPointsMax() : Number
        {
            return getSkillBase(SKILL_SOULPOINTS);
        }// end function

        override public function reset() : void
        {
            var _loc_1:* = m_ID;
            super.reset();
            this.resetAutowalk();
            this.resetFlags();
            this.resetSkills();
            m_ID = _loc_1;
            this.m_KnownSpells.length = 0;
            this.m_Premium = false;
            this.m_PremiumUntil = 0;
            this.m_Blessings = BLESSING_NONE;
            this.m_Profession = PROFESSION_NONE;
            m_Type = TYPE_PLAYER;
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            _loc_2.property = "*";
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function startAutowalkInternal() : void
        {
            if (m_MovementRunning || this.m_AutowalkPathAborting || !this.m_AutowalkPathDelta.isZero() || this.m_AutowalkTarget.x == -1 && this.m_AutowalkTarget.y == -1 && this.m_AutowalkTarget.z == -1)
            {
                return;
            }
            var _loc_1:* = Tibia.s_GetCommunication();
            var _loc_2:* = Tibia.s_GetMiniMapStorage();
            var _loc_3:* = Tibia.s_GetWorldMapStorage();
            if (_loc_1 == null || !_loc_1.isGameRunning || _loc_2 == null || _loc_3 == null)
            {
                return;
            }
            this.m_AutowalkPathAborting = false;
            this.m_AutowalkPathDelta.setZero();
            this.m_AutowalkPathSteps.length = 0;
            var _loc_4:* = _loc_2.calculatePath(m_Position.x, m_Position.y, m_Position.z, this.m_AutowalkTarget.x, this.m_AutowalkTarget.y, this.m_AutowalkTarget.z, this.m_AutowalkTargetDiagonal, this.m_AutowalkTargetExact, this.m_AutowalkPathSteps);
            if (_loc_3.isVisible(this.m_AutowalkTarget.x, this.m_AutowalkTarget.y, this.m_AutowalkTarget.z, false))
            {
                this.m_AutowalkTarget.setComponents(-1, -1, -1);
                this.m_AutowalkTargetDiagonal = false;
                this.m_AutowalkTargetExact = false;
            }
            switch(_loc_4)
            {
                case PATH_EMPTY:
                {
                    break;
                }
                case PATH_EXISTS:
                {
                    _loc_1.sendCGO(this.m_AutowalkPathSteps);
                    this.nextAutowalkStep();
                    break;
                }
                case PATH_ERROR_GO_DOWNSTAIRS:
                {
                    _loc_3.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_PATH_GO_DOWNSTAIRS);
                    break;
                }
                case PATH_ERROR_GO_UPSTAIRS:
                {
                    _loc_3.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_PATH_GO_UPSTAIRS);
                    break;
                }
                case PATH_ERROR_TOO_FAR:
                {
                    _loc_3.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_PATH_TOO_FAR);
                    break;
                }
                case PATH_ERROR_UNREACHABLE:
                {
                    _loc_3.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_PATH_UNREACHABLE);
                    this.stopAutowalk(false);
                    break;
                }
                case PATH_ERROR_INTERNAL:
                {
                    _loc_3.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, WorldMapStorage.MSG_SORRY_NOT_POSSIBLE);
                    this.stopAutowalk(false);
                    break;
                }
                default:
                {
                    throw new Error("Player.startAutowalkInternal: Unknown path state: " + _loc_4);
                    break;
                }
            }
            return;
        }// end function

        public function resetAutowalk() : void
        {
            this.stopAutowalk(true);
            this.abortAutowalk(2);
            return;
        }// end function

        public function abortAutowalk(param1:int) : void
        {
            m_Direction = param1;
            this.m_AutowalkPathAborting = false;
            this.m_AutowalkPathSteps.length = 0;
            if (!m_MovementRunning || !this.m_AutowalkPathDelta.isZero())
            {
                this.m_AutowalkPathDelta.setZero();
                stopMovementAnimation();
                this.startAutowalkInternal();
            }
            return;
        }// end function

        public function set knownSpells(param1:Array) : void
        {
            var _loc_2:* = null;
            if (param1 == null)
            {
                param1 = [];
            }
            if (this.m_KnownSpells != param1)
            {
                this.m_KnownSpells = param1.sort(Array.NUMERIC);
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "knownSpells";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function set stateFlags(param1:uint) : void
        {
            this.updateStateFlags(param1);
            return;
        }// end function

        public function get experienceBonus() : Number
        {
            return this.m_ExperienceBonus;
        }// end function

        public function get knownSpells() : Array
        {
            return this.m_KnownSpells;
        }// end function

        override public function resetSkills() : void
        {
            m_Skills = new Vector.<Number>((SKILL_OFFLINETRAINING + 1) * 3, true);
            var _loc_1:* = 0;
            while (_loc_1 < m_Skills.length)
            {
                
                m_Skills[_loc_1 + 0] = 0;
                m_Skills[(_loc_1 + 1)] = 0;
                m_Skills[_loc_1 + 2] = 0;
                _loc_1 = _loc_1 + 3;
            }
            this.m_ExperienceCounter.reset();
            return;
        }// end function

        public function get stateFlags() : uint
        {
            return this.m_StateFlags;
        }// end function

        private function nextAutowalkStep() : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (m_MovementRunning || this.m_AutowalkPathAborting || !this.m_AutowalkPathDelta.isZero() || this.m_AutowalkPathSteps.length == 0)
            {
                return;
            }
            var _loc_1:* = Tibia.s_GetCommunication();
            var _loc_2:* = Tibia.s_GetWorldMapStorage();
            if (_loc_1 == null || !_loc_1.isGameRunning || _loc_2 == null)
            {
                return;
            }
            switch(this.m_AutowalkPathSteps[0] & 65535)
            {
                case PATH_EAST:
                {
                    this.m_AutowalkPathDelta.x = 1;
                    break;
                }
                case PATH_NORTH_EAST:
                {
                    this.m_AutowalkPathDelta.x = 1;
                    this.m_AutowalkPathDelta.y = -1;
                    break;
                }
                case PATH_NORTH:
                {
                    this.m_AutowalkPathDelta.y = -1;
                    break;
                }
                case PATH_NORTH_WEST:
                {
                    this.m_AutowalkPathDelta.x = -1;
                    this.m_AutowalkPathDelta.y = -1;
                    break;
                }
                case PATH_WEST:
                {
                    this.m_AutowalkPathDelta.x = -1;
                    break;
                }
                case PATH_SOUTH_WEST:
                {
                    this.m_AutowalkPathDelta.x = -1;
                    this.m_AutowalkPathDelta.y = 1;
                    break;
                }
                case PATH_SOUTH:
                {
                    this.m_AutowalkPathDelta.y = 1;
                    break;
                }
                case PATH_SOUTH_EAST:
                {
                    this.m_AutowalkPathDelta.x = 1;
                    this.m_AutowalkPathDelta.y = 1;
                    break;
                }
                default:
                {
                    throw new Error("Player.nextAutowalkStep: Invalid step(1): " + (this.m_AutowalkPathSteps[0] & 65535));
                    break;
                }
            }
            _loc_2.toMap(m_Position, s_v1);
            _loc_2.toMap(m_Position, s_v2);
            s_v2.x = s_v2.x + this.m_AutowalkPathDelta.x;
            s_v2.y = s_v2.y + this.m_AutowalkPathDelta.y;
            var _loc_3:* = null;
            var _loc_9:* = _loc_2.getObject(s_v2.x, s_v2.y, s_v2.z, 0);
            _loc_3 = _loc_2.getObject(s_v2.x, s_v2.y, s_v2.z, 0);
            if (_loc_9 == null || _loc_3.type == null || !_loc_3.type.isBank)
            {
                this.m_AutowalkPathDelta.setZero();
                return;
            }
            var _loc_4:* = _loc_2.getEnterPossibleFlag(s_v2.x, s_v2.y, s_v2.z, false);
            if (_loc_2.getEnterPossibleFlag(s_v2.x, s_v2.y, s_v2.z, false) == FIELD_ENTER_NOT_POSSIBLE || (_loc_2.getFieldHeight(s_v1.x, s_v1.y, s_v1.z) + 1) < _loc_2.getFieldHeight(s_v2.x, s_v2.y, s_v2.z))
            {
                this.m_AutowalkPathDelta.setZero();
                return;
            }
            if (_loc_4 == FIELD_ENTER_POSSIBLE)
            {
                super.startMovementAnimation(this.m_AutowalkPathDelta.x, this.m_AutowalkPathDelta.y, _loc_3.type.waypoints);
                m_AnimationDelta.x = m_AnimationDelta.x + this.m_AutowalkPathDelta.x * FIELD_SIZE;
                m_AnimationDelta.y = m_AnimationDelta.y + this.m_AutowalkPathDelta.y * FIELD_SIZE;
            }
            else if (_loc_4 == FIELD_ENTER_POSSIBLE_NO_ANIMATION)
            {
                this.m_AutowalkPathDelta.setZero();
            }
            var _loc_5:* = 1;
            var _loc_6:* = this.m_AutowalkPathSteps.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_7 = this.m_AutowalkPathSteps[_loc_5] & 65535;
                _loc_8 = (this.m_AutowalkPathSteps[_loc_5] & 4294901760) >>> 16;
                switch(_loc_7)
                {
                    case PATH_EAST:
                    {
                        (s_v2.x + 1);
                        break;
                    }
                    case PATH_NORTH_EAST:
                    {
                        (s_v2.x + 1);
                        (s_v2.y - 1);
                        break;
                    }
                    case PATH_NORTH:
                    {
                        (s_v2.y - 1);
                        break;
                    }
                    case PATH_NORTH_WEST:
                    {
                        (s_v2.x - 1);
                        (s_v2.y - 1);
                        break;
                    }
                    case PATH_WEST:
                    {
                        (s_v2.x - 1);
                        break;
                    }
                    case PATH_SOUTH_WEST:
                    {
                        (s_v2.x - 1);
                        (s_v2.y + 1);
                        break;
                    }
                    case PATH_SOUTH:
                    {
                        (s_v2.y + 1);
                        break;
                    }
                    case PATH_SOUTH_EAST:
                    {
                        (s_v2.x + 1);
                        (s_v2.y + 1);
                        break;
                    }
                    default:
                    {
                        throw new Error("Player.nextAutowalkStep: Invalid step(2): " + (this.m_AutowalkPathSteps[_loc_5] & 65535));
                        break;
                    }
                }
                if (s_v2.x < 0 || s_v2.x >= MAPSIZE_X || s_v2.y < 0 || s_v2.y >= MAPSIZE_Y)
                {
                    break;
                }
                if (_loc_2.getMiniMapCost(s_v2.x, s_v2.y, s_v2.z) > _loc_8)
                {
                    _loc_1.sendCSTOP();
                    this.m_AutowalkPathAborting = true;
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        override public function set type(param1:int) : void
        {
            return;
        }// end function

        override public function get manaPercent() : Number
        {
            var _loc_1:* = getSkillBase(SKILL_MANA);
            if (_loc_1 > 0)
            {
                return getSkillValue(SKILL_MANA) * 100 / _loc_1;
            }
            return 100;
        }// end function

        public static function s_GetExperienceForLevel(param1:uint) : Number
        {
            if (param1 >= 81454)
            {
                return NaN;
            }
            return (((param1 - 6) * param1 + 17) * param1 - 12) / 6 * 100;
        }// end function

    }
}
