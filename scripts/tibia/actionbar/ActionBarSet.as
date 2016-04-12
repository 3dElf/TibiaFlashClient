package tibia.actionbar
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;

    public class ActionBarSet extends EventDispatcher
    {
        protected var m_ActionBars:Vector.<ActionBar> = null;
        protected var m_ID:int = 0;
        public static const DEFAULT_SET:int = 0;
        public static const NUM_LOCATIONS:int = 4;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 12;
        public static const LOCATION_TOP:int = 0;
        public static const LOCATION_BOTTOM:int = 1;
        public static const LOCATION_LEFT:int = 2;
        public static const LOCATION_RIGHT:int = 3;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function ActionBarSet(param1:int)
        {
            this.m_ActionBars = new Vector.<ActionBar>((LOCATION_RIGHT + 1), true);
            this.m_ID = param1;
            return;
        }// end function

        public function initialiseDefaultActionBars() : void
        {
            var _loc_1:* = new ActionBar(LOCATION_BOTTOM);
            _loc_1.visible = true;
            this.setActionBar(_loc_1);
            var _loc_2:* = new ActionBar(LOCATION_LEFT);
            this.setActionBar(_loc_2);
            var _loc_3:* = new ActionBar(LOCATION_RIGHT);
            this.setActionBar(_loc_3);
            var _loc_4:* = new ActionBar(LOCATION_TOP);
            this.setActionBar(_loc_4);
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function getActionBar(param1:int) : ActionBar
        {
            return this.m_ActionBars[param1];
        }// end function

        function changeID(param1:int) : void
        {
            this.m_ID = param1;
            return;
        }// end function

        protected function onActionBarChange(event:PropertyChangeEvent) : void
        {
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_3:* = null;
            var _loc_1:* = new XML("<actionbarset id=\"" + this.m_ID + "\"></actionbarset>");
            var _loc_2:* = 0;
            while (_loc_2 < this.m_ActionBars.length)
            {
                
                if (this.m_ActionBars[_loc_2] != null)
                {
                    _loc_3 = this.m_ActionBars[_loc_2].marshall();
                    _loc_3.@location = _loc_2;
                    _loc_1.appendChild(_loc_3);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function setActionBar(param1:ActionBar) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("ActionBarSet.setActionBar: Invalid action bar.");
            }
            var _loc_2:* = param1.location;
            if (this.m_ActionBars[_loc_2] != param1)
            {
                if (this.m_ActionBars[_loc_2] != null)
                {
                    this.m_ActionBars[_loc_2].removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange);
                }
                this.m_ActionBars[_loc_2] = param1;
                this.m_ActionBars[_loc_2].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange, false, EventPriority.DEFAULT_HANDLER, false);
            }
            return;
        }// end function

        public function clone() : ActionBarSet
        {
            var _loc_1:* = this.marshall();
            return s_Unmarshall(_loc_1, OPTIONS_MAX_COMPATIBLE_VERSION);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : ActionBarSet
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1 == null || param1.localName() != "actionbarset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("ActionBarSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_8:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_8 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_4 = parseInt(_loc_3[0].toString());
            var _loc_5:* = new ActionBarSet(_loc_4);
            for each (_loc_6 in param1.elements("actionbar"))
            {
                
                _loc_7 = ActionBar.s_Unmarshall(_loc_6, param2);
                if (_loc_7 != null)
                {
                    _loc_5.setActionBar(_loc_7);
                }
            }
            return _loc_5;
        }// end function

    }
}
