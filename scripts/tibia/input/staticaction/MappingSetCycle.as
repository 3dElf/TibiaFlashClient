package tibia.input.staticaction
{
    import tibia.options.*;

    public class MappingSetCycle extends StaticAction
    {
        protected var m_Direction:int = 1;
        public static const NEXT:int = 1;
        public static const PREV:int = -1;

        public function MappingSetCycle(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != NEXT && param4 != PREV)
            {
                throw new ArgumentError("MappingSetCycle.MappingSetCycle: Invalid direction: " + param4);
            }
            this.m_Direction = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.getMappingSetIDs();
                if (_loc_3 != null && _loc_3.length > 0)
                {
                    _loc_4 = 0;
                    _loc_5 = _loc_3.length;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_5)
                    {
                        
                        if (_loc_3[_loc_4] == _loc_2.generalInputSetID)
                        {
                            break;
                        }
                        _loc_4++;
                    }
                    _loc_4 = _loc_4 + this.m_Direction;
                    if (_loc_4 < 0)
                    {
                        _loc_4 = _loc_4 + _loc_5;
                    }
                    else if (_loc_4 >= _loc_5)
                    {
                        _loc_4 = _loc_4 - _loc_5;
                    }
                    _loc_2.generalInputSetID = _loc_3[_loc_4];
                }
            }
            return;
        }// end function

    }
}
