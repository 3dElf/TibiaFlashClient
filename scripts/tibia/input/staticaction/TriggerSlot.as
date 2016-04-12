package tibia.input.staticaction
{
    import mx.resources.*;
    import tibia.actionbar.*;
    import tibia.input.*;
    import tibia.options.*;

    public class TriggerSlot extends StaticAction
    {
        protected var m_Slot:int = -1;
        protected var m_Location:int = -1;

        public function TriggerSlot(param1:int, param2:String, param3:uint, param4:int, param5:int)
        {
            super(param1, param2, param3, false);
            if (param4 != ActionBarSet.LOCATION_TOP && param4 != ActionBarSet.LOCATION_BOTTOM && param4 != ActionBarSet.LOCATION_LEFT && param4 != ActionBarSet.LOCATION_RIGHT)
            {
                throw new ArgumentError("TriggerSlot.TriggerSlot: Invalid location: " + param4);
            }
            this.m_Location = param4;
            if (param5 < 0 || param5 >= ActionBar.NUM_ACTIONS)
            {
                throw new RangeError("TriggerSlot.TriggerSlot: Invalid slot: " + param5);
            }
            this.m_Slot = param5;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var a_Repeat:* = param1;
            var Options:* = Tibia.s_GetOptions();
            var _ActionBarSet:ActionBarSet;
            var _ActionBar:ActionBar;
            var _Action:IAction;
            var _loc_3:* = Options.getActionBarSet(Options.generalInputSetID);
            _ActionBarSet = Options.getActionBarSet(Options.generalInputSetID);
            var _loc_3:* = _ActionBarSet.getActionBar(this.m_Location);
            _ActionBar = _ActionBarSet.getActionBar(this.m_Location);
            var _loc_3:* = _ActionBar.getAction(this.m_Slot);
            _Action = _ActionBar.getAction(this.m_Slot);
            if (Options != null && _loc_3 != null && _loc_3 != null && _loc_3 != null)
            {
                try
                {
                    _Action.perform(a_Repeat);
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            if (m_Label != null)
            {
                return _loc_1.getString(BUNDLE, m_Label, [ActionBar.getLabel(this.m_Location, this.m_Slot)]);
            }
            return _loc_1.getString(BUNDLE, "UNKNOWN_ACTION");
        }// end function

    }
}
