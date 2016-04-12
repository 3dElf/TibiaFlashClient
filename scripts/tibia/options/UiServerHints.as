package tibia.options
{
    import mx.events.*;

    public class UiServerHints extends Object
    {
        private var m_canChangePvPFramingOption:Boolean = true;
        private var m_Options:OptionsStorage = null;
        private var m_expertModeButtonEnabled:Boolean = true;

        public function UiServerHints(param1:OptionsStorage)
        {
            this.m_Options = param1;
            return;
        }// end function

        public function get expertModeButtonEnabled() : Boolean
        {
            return this.m_expertModeButtonEnabled;
        }// end function

        public function set expertModeButtonEnabled(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this.m_expertModeButtonEnabled != param1)
            {
                this.m_expertModeButtonEnabled = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "uiHints";
                this.m_Options.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function set canChangePvPFramingOption(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this.m_canChangePvPFramingOption != param1)
            {
                this.m_canChangePvPFramingOption = param1;
                _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_2.kind = PropertyChangeEventKind.UPDATE;
                _loc_2.property = "uiHints";
                this.m_Options.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get canChangePvPFramingOption() : Boolean
        {
            return this.m_canChangePvPFramingOption;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            return;
        }// end function

        public function clone() : UiServerHints
        {
            var _loc_1:* = new UiServerHints(this.m_Options);
            _loc_1.canChangePvPFramingOption = this.canChangePvPFramingOption;
            _loc_1.expertModeButtonEnabled = this.expertModeButtonEnabled;
            return _loc_1;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

    }
}
