package tibia.prey
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import mx.resources.*;

    public class PreyData extends EventDispatcher
    {
        private var m_BonusValue:uint = 0;
        private var m_BonusType:uint = 4;
        private var m_UnlockOption:uint = 2;
        private var m_Id:uint = 0;
        private var m_MinutesUntilFreeListReroll:Number = 0;
        private var m_State:uint = 1;
        private var m_MonsterList:Vector.<PreyMonsterInformation>;
        private var m_Monster:PreyMonsterInformation = null;
        private var m_SecondsLeftRunning:Number = 0;
        public static const BONUS_DAMAGE_REDUCTION:uint = 1;
        public static const UNLOCK_STORE:uint = 1;
        public static const UNLOCK_PREMIUM_OR_STORE:uint = 0;
        public static const UNLOCK_NONE:uint = 2;
        public static const STATE_ACTIVE:uint = 2;
        public static const BONUS_IMPROVED_LOOT:uint = 3;
        public static const STATE_SELECTION:uint = 3;
        public static const STATE_LOCKED:uint = 0;
        public static const STATE_SELECTION_CHANGE_MONSTER:uint = 4;
        public static const BONUS_DAMAGE_BOOST:uint = 0;
        public static const BONUS_XP_BONUS:uint = 2;
        public static const STATE_INACTIVE:uint = 1;
        public static const PREY_FULL_DURATION:uint = 7200;
        public static const BONUS_NONE:uint = 4;

        public function PreyData(param1:uint)
        {
            this.m_MonsterList = new Vector.<PreyMonsterInformation>;
            this.m_Id = param1;
            return;
        }// end function

        public function get timeUntilFreeListRerollMax() : Number
        {
            return 20 * 60;
        }// end function

        public function set bonusType(param1:uint) : void
        {
            if (param1 != this.m_BonusType)
            {
                this.m_BonusType = param1;
                this.dispatchChangeEvent("bonusType");
            }
            return;
        }// end function

        public function changeStateToActive(param1:uint, param2:uint, param3:PreyMonsterInformation) : void
        {
            if (param1 != BONUS_NONE)
            {
                this.clear();
                this.bonusType = param1;
                this.bonusValue = param2;
                this.monster = param3;
                this.state = STATE_ACTIVE;
            }
            else
            {
                this.changeStateToInactive();
            }
            return;
        }// end function

        public function changeStateToLocked(param1:uint) : void
        {
            if (param1 != UNLOCK_NONE)
            {
                this.clear();
                this.unlockOption = param1;
                this.state = STATE_LOCKED;
            }
            else
            {
                this.changeStateToInactive();
            }
            return;
        }// end function

        public function get preyTimeLeft() : Number
        {
            return this.m_SecondsLeftRunning;
        }// end function

        public function get state() : uint
        {
            return this.m_State;
        }// end function

        public function set preyTimeLeft(param1:Number) : void
        {
            if (this.m_SecondsLeftRunning != param1)
            {
                this.m_SecondsLeftRunning = param1;
                this.dispatchChangeEvent("preyTimeLeft");
            }
            return;
        }// end function

        public function changeStateToSelection(param1:Vector.<PreyMonsterInformation>) : void
        {
            if (param1.length > 0)
            {
                this.clear();
                this.monsterList = param1;
                this.state = STATE_SELECTION;
            }
            else
            {
                this.changeStateToInactive();
            }
            return;
        }// end function

        public function get monsterList() : Vector.<PreyMonsterInformation>
        {
            return this.m_MonsterList;
        }// end function

        public function get unlockOption() : uint
        {
            return this.m_UnlockOption;
        }// end function

        public function get id() : uint
        {
            return this.m_Id;
        }// end function

        private function clear() : void
        {
            this.unlockOption = UNLOCK_NONE;
            this.bonusType = BONUS_NONE;
            this.bonusValue = 0;
            this.monster = null;
            this.monsterList = new Vector.<PreyMonsterInformation>;
            this.preyTimeLeft = 0;
            return;
        }// end function

        public function get bonusValue() : uint
        {
            return this.m_BonusValue;
        }// end function

        public function set state(param1:uint) : void
        {
            if (param1 != this.m_State)
            {
                this.m_State = param1;
                this.dispatchChangeEvent("state");
            }
            return;
        }// end function

        public function set bonusValue(param1:uint) : void
        {
            if (param1 != this.m_BonusValue)
            {
                this.m_BonusValue = param1;
                this.dispatchChangeEvent("bonusValue");
            }
            return;
        }// end function

        public function changeStateToInactive() : void
        {
            this.clear();
            this.state = STATE_INACTIVE;
            return;
        }// end function

        public function get monster() : PreyMonsterInformation
        {
            return this.m_Monster;
        }// end function

        public function generateBonusString() : String
        {
            var _loc_1:* = "PreyWidget";
            var _loc_2:* = ResourceManager.getInstance();
            if (_loc_2 == null)
            {
                return "";
            }
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_BOOST)
            {
                return _loc_2.getString(_loc_1, "BONUS_DAMAGE_BOOST");
            }
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_REDUCTION)
            {
                return _loc_2.getString(_loc_1, "BONUS_DAMAGE_REDUCTION");
            }
            if (this.m_BonusType == PreyData.BONUS_IMPROVED_LOOT)
            {
                return _loc_2.getString(_loc_1, "BONUS_IMPROVED_LOOT");
            }
            if (this.m_BonusType == PreyData.BONUS_XP_BONUS)
            {
                return _loc_2.getString(_loc_1, "BONUS_XP_BONUS");
            }
            return _loc_2.getString(_loc_1, "BONUS_NONE");
        }// end function

        public function set timeUntilFreeListReroll(param1:Number) : void
        {
            if (this.m_MinutesUntilFreeListReroll != param1)
            {
                this.m_MinutesUntilFreeListReroll = param1;
                this.dispatchChangeEvent("timeUntilFreeListReroll");
            }
            return;
        }// end function

        public function set monsterList(param1:Vector.<PreyMonsterInformation>) : void
        {
            this.m_MonsterList = param1;
            this.dispatchChangeEvent("monsterList");
            return;
        }// end function

        public function set unlockOption(param1:uint) : void
        {
            if (param1 != this.m_UnlockOption)
            {
                this.m_UnlockOption = param1;
                this.dispatchChangeEvent("unlockOption");
            }
            return;
        }// end function

        public function set monster(param1:PreyMonsterInformation) : void
        {
            if (param1 != null && !param1.equals(this.m_Monster) || param1 == null && this.m_Monster != null)
            {
                this.m_Monster = param1;
                this.dispatchChangeEvent("monster");
            }
            return;
        }// end function

        private function dispatchChangeEvent(param1:String) : void
        {
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            _loc_2.property = param1;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function generateBonusDescription() : String
        {
            var _loc_1:* = "PreyWidget";
            var _loc_2:* = ResourceManager.getInstance();
            if (_loc_2 == null)
            {
                return "";
            }
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_BOOST)
            {
                return _loc_2.getString(_loc_1, "BONUS_DESCRIPTION_DAMAGE_BOOST", [this.m_BonusValue]);
            }
            if (this.m_BonusType == PreyData.BONUS_DAMAGE_REDUCTION)
            {
                return _loc_2.getString(_loc_1, "BONUS_DESCRIPTION_DAMAGE_REDUCTION", [this.m_BonusValue]);
            }
            if (this.m_BonusType == PreyData.BONUS_IMPROVED_LOOT)
            {
                return _loc_2.getString(_loc_1, "BONUS_DESCRIPTION_IMPROVED_LOOT", [this.m_BonusValue]);
            }
            if (this.m_BonusType == PreyData.BONUS_XP_BONUS)
            {
                return _loc_2.getString(_loc_1, "BONUS_DESCRIPTION_XP_BONUS", [this.m_BonusValue]);
            }
            return "";
        }// end function

        public function get bonusType() : uint
        {
            return this.m_BonusType;
        }// end function

        public function get timeUntilFreeListReroll() : Number
        {
            return this.m_MinutesUntilFreeListReroll;
        }// end function

        public function changeStateToSelectionChangeMonster(param1:uint, param2:uint, param3:Vector.<PreyMonsterInformation>) : void
        {
            if (param3.length > 0)
            {
                this.clear();
                this.bonusType = param1;
                this.bonusValue = param2;
                this.monsterList = param3;
                this.state = STATE_SELECTION_CHANGE_MONSTER;
            }
            else
            {
                this.changeStateToInactive();
            }
            return;
        }// end function

    }
}
