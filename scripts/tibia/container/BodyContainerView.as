package tibia.container
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;
    import tibia.appearances.*;

    public class BodyContainerView extends EventDispatcher
    {
        private var m_Objects:Vector.<ObjectInstance> = null;
        public static const STORE:int = 12;
        public static const STOREINBOX:int = 11;
        public static const BOTH_HANDS:int = 0;
        public static const LAST_SLOT:int = 13;
        public static const FIRST_SLOT:int = 1;
        public static const RIGHT_HAND:int = 5;
        public static const TORSO:int = 4;
        public static const NECK:int = 2;
        public static const HEAD:int = 1;
        public static const LEGS:int = 7;
        public static const LEFT_HAND:int = 6;
        public static const FINGER:int = 9;
        public static const BLESSINGS:int = 13;
        public static const BACK:int = 3;
        public static const HIP:int = 10;
        public static const FEET:int = 8;

        public function BodyContainerView()
        {
            this.m_Objects = new Vector.<ObjectInstance>(LAST_SLOT - FIRST_SLOT + 1, true);
            return;
        }// end function

        public function setObject(param1:int, param2:ObjectInstance) : void
        {
            if (param1 < FIRST_SLOT || param1 > LAST_SLOT)
            {
                throw new RangeError("BodyContainerView.getObject: Index out of range: " + param1);
            }
            this.m_Objects[param1 - FIRST_SLOT] = param2;
            var _loc_3:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_3.property = "objects";
            _loc_3.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function getObject(param1:int) : ObjectInstance
        {
            if (param1 < FIRST_SLOT || param1 > LAST_SLOT)
            {
                throw new RangeError("BodyContainerView.getObject: Index out of range: " + param1);
            }
            return this.m_Objects[param1 - FIRST_SLOT];
        }// end function

        public function isEquipped(param1:int) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetAppearanceStorage();
            if (_loc_3 != null)
            {
                _loc_2 = _loc_3.getObjectType(param1);
            }
            if (_loc_2 != null && _loc_2.isCloth)
            {
                _loc_4 = _loc_2.clothSlot;
                if (_loc_4 == BOTH_HANDS)
                {
                    _loc_4 = LEFT_HAND;
                }
                _loc_5 = this.m_Objects[_loc_4 - FIRST_SLOT];
                return _loc_5 != null && _loc_5.ID == param1;
            }
            else
            {
                return false;
            }
        }// end function

        public function reset() : void
        {
            var _loc_1:* = FIRST_SLOT;
            while (_loc_1 <= LAST_SLOT)
            {
                
                this.m_Objects[_loc_1 - FIRST_SLOT] = null;
                _loc_1++;
            }
            var _loc_2:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_2.property = "objects";
            _loc_2.kind = PropertyChangeEventKind.UPDATE;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
