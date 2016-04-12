package tibia.controls
{
    import flash.events.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.options.*;

    public class GameWindowContainer extends GridContainer
    {
        private var m_Options:OptionsStorage = null;
        private var m_UncommittedOptions:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UILock:Button = null;

        public function GameWindowContainer()
        {
            return;
        }// end function

        private function onLockClick(event:MouseEvent) : void
        {
            if (this.options != null)
            {
                this.options.generalActionBarsLock = !this.options.generalActionBarsLock;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                this.m_UILock.selected = this.options != null && this.options.generalActionBarsLock;
                this.m_UncommittedOptions = false;
            }
            return;
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "generalActionBarsLock" || event.property == "*")
            {
                this.m_UILock.selected = this.options != null && this.options.generalActionBarsLock;
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = this.m_UILock.getExplicitOrMeasuredWidth();
            var _loc_4:* = this.m_UILock.getExplicitOrMeasuredHeight();
            this.m_UILock.move(param1 - _loc_3, 0);
            this.m_UILock.setActualSize(_loc_3, _loc_4);
            setChildIndex(this.m_UILock, (numChildren - 1));
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILock = new CustomButton();
                this.m_UILock.selected = this.options != null && this.options.generalActionBarsLock;
                this.m_UILock.styleName = "gameWindowLockButton";
                this.m_UILock.toggle = true;
                this.m_UILock.addEventListener(MouseEvent.CLICK, this.onLockClick);
                addChild(this.m_UILock);
                this.m_UIConstructed = true;
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
                this.m_UncommittedOptions = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

    }
}
