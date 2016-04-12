package tibia.chat.chatWidgetClasses
{
    import flash.system.*;
    import mx.core.*;
    import tibia.game.*;

    public class PassiveTextFieldContextMenu extends ContextMenuBase
    {
        protected var m_TextField:PassiveTextField = null;
        private static const BUNDLE:String = "Global";

        public function PassiveTextFieldContextMenu(param1:PassiveTextField)
        {
            if (param1 == null)
            {
                throw new ArgumentError("PassiveTextFieldContextMenu.PassiveTextFieldContextMenu: Invalid text field.");
            }
            this.m_TextField = param1;
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            var Selection:* = this.m_TextField.getSelectedText();
            if (Selection != null && Selection.length > 0)
            {
                if (this.m_TextField.enabled)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_CUT"), function (param1) : void
            {
                if (m_TextField != null)
                {
                    System.setClipboard(m_TextField.getSelectedText());
                    m_TextField.replaceSelectedText("");
                }
                return;
            }// end function
            );
                }
                createTextItem(resourceManager.getString(BUNDLE, "CTX_COPY"), function (param1) : void
            {
                if (m_TextField != null)
                {
                    System.setClipboard(m_TextField.getSelectedText());
                }
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (Selection != null && Selection.length > 0)
            {
                if (this.m_TextField.enabled)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_DELETE"), function (param1) : void
            {
                if (m_TextField != null)
                {
                    m_TextField.replaceSelectedText("");
                }
                return;
            }// end function
            );
                    createSeparatorItem();
                }
            }
            createTextItem(resourceManager.getString(BUNDLE, "CTX_SELECT_ALL"), function (param1) : void
            {
                if (m_TextField != null && m_TextField.text != null)
                {
                    m_TextField.setSelection(0, m_TextField.text.length);
                }
                return;
            }// end function
            );
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

    }
}
