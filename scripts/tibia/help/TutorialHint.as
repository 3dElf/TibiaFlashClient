package tibia.help
{
    import mx.events.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.chat.*;
    import tibia.input.*;

    public class TutorialHint extends Object implements IActionImpl
    {
        private var m_Title:String = null;
        private var m_Images:Array = null;
        private var m_ID:int = 0;
        private var m_PostDisplayHook:Function = null;
        private var m_ShowDialog:Boolean = false;
        private var m_PreDisplayHook:Function = null;
        private var m_Text:String = null;
        private static const BUNDLE:String = "TutorialHintWidget";
        private static const TUTORIAL_HINTS:Array = [null, {ID:1, title:"HINT_01_TITLE", text:"HINT_01_TEXT", images:"HINT_01_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}, {ID:2, title:"HINT_02_TITLE", text:"HINT_02_TEXT", images:"HINT_02_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}, {ID:3, title:"HINT_03_TITLE", text:"HINT_03_TEXT", images:"HINT_03_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}, {ID:4, title:"HINT_04_TITLE", text:"HINT_04_TEXT", images:"HINT_04_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}, {ID:5, title:"HINT_05_TITLE", text:"HINT_05_TEXT", images:"HINT_05_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}, {ID:6, title:"HINT_06_TITLE", text:"HINT_06_TEXT", images:"HINT_06_IMAGES", showDialog:true, preDisplay:null, postDisplay:null}];

        public function TutorialHint(param1:int)
        {
            if (!TutorialHint.checkHint(param1))
            {
                this.m_ShowDialog = false;
                return;
            }
            var _loc_2:* = ResourceManager.getInstance();
            this.m_ID = param1;
            this.m_Title = _loc_2.getString(BUNDLE, TUTORIAL_HINTS[param1].title);
            this.m_Text = _loc_2.getString(BUNDLE, TUTORIAL_HINTS[param1].text);
            this.m_Images = _loc_2.getStringArray(BUNDLE, TUTORIAL_HINTS[param1].images);
            this.m_ShowDialog = TUTORIAL_HINTS[param1].showDialog;
            this.m_PreDisplayHook = TUTORIAL_HINTS[param1].preDisplay;
            this.m_PostDisplayHook = TUTORIAL_HINTS[param1].postDisplay;
            var _loc_3:* = 0;
            var _loc_4:* = this.m_Images != null ? (this.m_Images.length) : (0);
            while (_loc_3 < _loc_4)
            {
                
                this.m_Images[_loc_3] = _loc_2.getClass(BUNDLE, this.m_Images[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _Widget:TutorialHintWidget;
            var a_Repeat:* = param1;
            try
            {
                if (this.m_PreDisplayHook != null)
                {
                    this.m_PreDisplayHook();
                }
            }
            catch (e:Error)
            {
            }
            if (this.m_ShowDialog)
            {
                _Widget = new TutorialHintWidget();
                _Widget.title = this.m_Title;
                _Widget.images = this.m_Images;
                _Widget.addEventListener(CloseEvent.CLOSE, this.onDialogClose);
                _Widget.show();
            }
            else
            {
                this.showMessage();
            }
            return;
        }// end function

        protected function showMessage() : void
        {
            var _loc_1:* = null;
            if (this.m_Text != null)
            {
                _loc_1 = StringHelper.s_StripTags(this.m_Text);
                Tibia.s_GetWorldMapStorage().addOnscreenMessage(null, -1, null, 0, MessageMode.MESSAGE_TUTORIAL_HINT, _loc_1);
                Tibia.s_GetChatStorage().addChannelMessage(-1, -1, null, 0, MessageMode.MESSAGE_TUTORIAL_HINT, _loc_1);
            }
            return;
        }// end function

        protected function onDialogClose(event:CloseEvent) : void
        {
            var a_Event:* = event;
            var _Widget:TutorialHintWidget;
            var _loc_3:* = a_Event.currentTarget as TutorialHintWidget;
            _Widget = a_Event.currentTarget as TutorialHintWidget;
            if (a_Event != null && _loc_3 != null)
            {
                _Widget.removeEventListener(CloseEvent.CLOSE, this.onDialogClose);
                this.showMessage();
                try
                {
                    if (this.m_PostDisplayHook != null)
                    {
                        this.m_PostDisplayHook();
                    }
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public static function checkHint(param1:int) : Boolean
        {
            return param1 > 0 && param1 < TUTORIAL_HINTS.length && TUTORIAL_HINTS[param1] != null;
        }// end function

    }
}
