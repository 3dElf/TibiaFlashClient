package tibia.help
{
    import flash.events.*;
    import mx.core.*;

    public class UIEffectsRetrieveComponentCommandEvent extends Event
    {
        private var m_SubIdentifier:Object = null;
        private var m_ResultUIComponent:UIComponent = null;
        private var m_Identifier:Class = null;
        public static var GET_UI_COMPONENT:String = "GET_UI_COMPONENT";

        public function UIEffectsRetrieveComponentCommandEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        public function get subIdentifier()
        {
            return this.m_SubIdentifier;
        }// end function

        public function get resultUIComponent() : UIComponent
        {
            return this.m_ResultUIComponent;
        }// end function

        public function get identifier() : Class
        {
            return this.m_Identifier;
        }// end function

        public function set identifier(param1) : void
        {
            this.m_Identifier = param1;
            return;
        }// end function

        public function set resultUIComponent(param1:UIComponent) : void
        {
            this.m_ResultUIComponent = param1;
            return;
        }// end function

        public function set subIdentifier(param1) : void
        {
            this.m_SubIdentifier = param1;
            return;
        }// end function

    }
}
