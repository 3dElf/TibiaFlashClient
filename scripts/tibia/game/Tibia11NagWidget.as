package tibia.game
{
    import flash.text.*;
    import shared.utility.*;

    public class Tibia11NagWidget extends MessageWidget
    {
        private static const TEXT_STYLESHEET:StyleSheet = new StyleSheet();

        public function Tibia11NagWidget()
        {
            buttonFlags = PopUpBase.BUTTON_OKAY;
            message = resourceManager.getString("Tibia", "DLG_TIBIA11_ONLY_TEXT", [StringHelper.s_HilightToHTML(resourceManager.getString("Tibia", "DLG_TIBIA11_ONLY_LINK"), 255)]);
            title = resourceManager.getString("Tibia", "DLG_TIBIA11_ONLY_TITLE");
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            m_UIMessage.styleSheet = TEXT_STYLESHEET;
            return;
        }// end function

        private static function s_InitialiseStyleSheet() : void
        {
            TEXT_STYLESHEET.parseCSS("p {" + "font-family: Verdana;" + "font-size: 10;" + "margin-left: 15;" + "text-indent: -15;" + "color: #C9BDAB;" + "}" + "a {" + "color:#36b0d9;" + "font-weight:bold;" + "}" + "a:hover {" + "text-decoration:underline;" + "}");
            return;
        }// end function

        s_InitialiseStyleSheet();
    }
}
