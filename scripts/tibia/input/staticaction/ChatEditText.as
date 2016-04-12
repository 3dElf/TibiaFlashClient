package tibia.input.staticaction
{
    import flash.ui.*;
    import tibia.chat.*;

    public class ChatEditText extends StaticAction
    {

        public function ChatEditText(param1:int, param2:String, param3:uint, param4:Boolean)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            throw new Error("ChatEditText.perform: Do not call perform.");
        }// end function

        public function textCallback(param1:uint, param2:String) : void
        {
            var _loc_3:* = Tibia.s_GetChatWidget();
            if (_loc_3 != null)
            {
                _loc_3.onChatText(param1, param2);
            }
            return;
        }// end function

        public function keyCallback(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : void
        {
            var _loc_7:* = Tibia.s_GetChatWidget();
            if (Tibia.s_GetChatWidget() != null)
            {
                if (!param4 && !param5 && !param6 && (param3 == Keyboard.BACKSPACE || param3 == Keyboard.DELETE || param3 == Keyboard.HOME || param3 == Keyboard.END))
                {
                    _loc_7.onChatEdit(param1, param2, param3, false, false, false);
                }
                else if (!param4 && param5 && !param6 && (param3 == Keyboard.A || param3 == Keyboard.C || param3 == Keyboard.V || param3 == Keyboard.X))
                {
                    _loc_7.onChatCopyPaste(param1, param2, param3, false, true, false);
                }
                else if (!param4 && !param5 && param6 && (param3 == Keyboard.LEFT || param3 == Keyboard.RIGHT))
                {
                    _loc_7.onChatEdit(param1, param2, param3, false, false, false);
                }
                else if (!param4 && !param5 && param6 && (param3 == Keyboard.UP || param3 == Keyboard.DOWN))
                {
                    _loc_7.onChatHistory(param3 == Keyboard.UP ? (-1) : (1));
                }
            }
            return;
        }// end function

    }
}
