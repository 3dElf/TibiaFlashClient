package tibia.prey
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;

    public class PreyManager extends EventDispatcher
    {
        private var m_ListRerollPrice:Number = 0;
        private var m_Preys:Vector.<PreyData> = null;
        private var m_BonusRerollAmount:uint = 0;
        private var m_StillNeedsInformationForPrey:Vector.<uint> = null;
        private static var s_Instance:PreyManager = null;
        public static var PREY_ACTION_MONSTERSELECTION:uint = 2;
        private static const MAXIMUM_NUMBER_OF_PREYS:uint = 3;
        public static var PREY_ACTION_LISTREROLL:uint = 0;
        public static var PREY_ACTION_BONUSREROLL:uint = 1;

        public function PreyManager()
        {
            this.m_Preys = new Vector.<PreyData>;
            this.m_StillNeedsInformationForPrey = new Vector.<uint>;
            var _loc_1:* = 0;
            while (_loc_1 < MAXIMUM_NUMBER_OF_PREYS)
            {
                
                this.m_Preys.push(new PreyData(_loc_1));
                this.m_StillNeedsInformationForPrey.push(_loc_1);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function changeStateToSelectionChangeMonster(param1:uint, param2:uint, param3:uint, param4:Vector.<PreyMonsterInformation>) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].changeStateToSelectionChangeMonster(param2, param3, param4);
                this.setInformationAvailable(param1);
                ;
            }
            return;
        }// end function

        public function changeStateToActive(param1:uint, param2:uint, param3:uint, param4:PreyMonsterInformation) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].changeStateToActive(param2, param3, param4);
                this.setInformationAvailable(param1);
                ;
            }
            return;
        }// end function

        public function get preys() : Vector.<PreyData>
        {
            return this.m_Preys;
        }// end function

        public function changeStateToLocked(param1:uint, param2:uint) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].changeStateToLocked(param2);
                this.setInformationAvailable(param1);
                ;
            }
            return;
        }// end function

        public function get bonusRerollAmount() : uint
        {
            return this.m_BonusRerollAmount;
        }// end function

        public function setPreyTimeLeft(param1:uint, param2:Number) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].preyTimeLeft = param2;
                ;
            }
            return;
        }// end function

        public function set bonusRerollAmount(param1:uint) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_BonusRerollAmount)
            {
                this.m_BonusRerollAmount = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "bonusRerollAmount";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function changeStateToSelection(param1:uint, param2:Vector.<PreyMonsterInformation>) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].changeStateToSelection(param2);
                this.setInformationAvailable(param1);
                ;
            }
            return;
        }// end function

        private function setInformationAvailable(param1:uint) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.m_StillNeedsInformationForPrey.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this.m_StillNeedsInformationForPrey.splice(_loc_2, 1);
                if (this.m_StillNeedsInformationForPrey.length == 0)
                {
                    _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _loc_3.kind = PropertyChangeEventKind.UPDATE;
                    _loc_3.property = "prey";
                    dispatchEvent(_loc_3);
                }
            }
            return;
        }// end function

        public function setTimeUntilFreeListReroll(param1:uint, param2:Number) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].timeUntilFreeListReroll = param2;
                ;
            }
            return;
        }// end function

        public function get listRerollPrice() : Number
        {
            return this.m_ListRerollPrice;
        }// end function

        public function set listRerollPrice(param1:Number) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_ListRerollPrice)
            {
                this.m_ListRerollPrice = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "listRerollPrice";
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function changeStateToInactive(param1:uint) : void
        {
            if (param1 < this.m_Preys.length)
            {
                this.m_Preys[param1].changeStateToInactive();
                this.setInformationAvailable(param1);
                ;
            }
            return;
        }// end function

        public static function getInstance() : PreyManager
        {
            if (s_Instance == null)
            {
                s_Instance = new PreyManager;
            }
            return s_Instance;
        }// end function

    }
}
