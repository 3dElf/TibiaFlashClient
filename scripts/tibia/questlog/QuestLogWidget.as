package tibia.questlog
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.game.*;
    import tibia.network.*;
    import tibia.questlog.questLogWidgetClasses.*;

    public class QuestLogWidget extends PopUpBase
    {
        private var m_UncommittedState:Boolean = false;
        private var m_UncommittedQuestFlags:Boolean = false;
        protected var m_UIQuestLogView:QuestLogView = null;
        protected var m_QuestFlags:Array = null;
        protected var m_UIViewStack:ViewStack = null;
        protected var m_State:int = -1;
        private var m_UncommittedQuestLines:Boolean = false;
        protected var m_QuestLines:Array = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIQuestLineView:QuestLineView = null;
        private var m_UncommittedExtraButtonFlags:Boolean = false;
        protected var m_ExtraButtonFlags:uint = 0;
        private static const EXTRA_BUTTON_FLAGS:Array = [{data:EXTRA_BUTTON_SHOW, label:"BTN_SHOW"}, {data:EXTRA_BUTTON_CLOSE, label:"BTN_CLOSE"}];
        private static const EXTRA_BUTTON_MASK:uint = EXTRA_BUTTON_CLOSE | EXTRA_BUTTON_SHOW;
        private static const BUNDLE:String = "QuestLogWidget";
        private static const STATE_QUEST_LOG:int = 0;
        public static const EXTRA_BUTTON_CLOSE:uint = 8388608;
        public static const EXTRA_BUTTON_SHOW:uint = 4194304;
        private static const STATE_QUEST_LINE:int = 1;

        public function QuestLogWidget()
        {
            height = 350;
            width = 350;
            this.buttonFlags = EXTRA_BUTTON_CLOSE | EXTRA_BUTTON_SHOW;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            this.state = STATE_QUEST_LOG;
            return;
        }// end function

        public function set questLines(param1:Array) : void
        {
            if (this.m_QuestLines != param1)
            {
                this.m_QuestLines = param1;
                this.m_UncommittedQuestLines = true;
                invalidateProperties();
                this.state = STATE_QUEST_LOG;
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = footer.numChildren - 1;
            while (_loc_2 >= 0)
            {
                
                footer.getChildAt(_loc_2).removeEventListener(MouseEvent.CLICK, this.onExtraButton);
                _loc_2 = _loc_2 - 1;
            }
            super.hide(param1);
            return;
        }// end function

        protected function onExtraButton(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = event.currentTarget as Button;
                if (_loc_2 == null)
                {
                    return;
                }
                switch(uint(_loc_2.data))
                {
                    case EXTRA_BUTTON_CLOSE:
                    {
                        if (this.state == STATE_QUEST_LOG)
                        {
                            _loc_3 = new CloseEvent(CloseEvent.CLOSE, true, false);
                            _loc_3.detail = PopUpBase.BUTTON_CLOSE;
                            dispatchEvent(_loc_3);
                            if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                            {
                                this.hide(false);
                            }
                        }
                        else
                        {
                            this.state = STATE_QUEST_LOG;
                        }
                        break;
                    }
                    case EXTRA_BUTTON_SHOW:
                    {
                        this.onQuestLineSelected(event);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get questLines() : Array
        {
            return this.m_QuestLines;
        }// end function

        public function set questFlags(param1:Array) : void
        {
            if (this.m_QuestFlags != param1)
            {
                this.m_QuestFlags = param1;
                this.m_UncommittedQuestFlags = true;
                invalidateProperties();
                this.state = STATE_QUEST_LINE;
            }
            return;
        }// end function

        public function get questFlags() : Array
        {
            return this.m_QuestFlags;
        }// end function

        protected function get state() : int
        {
            return this.m_State;
        }// end function

        protected function onQuestLineSelected(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null && this.m_UIQuestLogView.selectedQuestLine != null && this.state == STATE_QUEST_LOG)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCGETQUESTLINE(this.m_UIQuestLogView.selectedQuestLine.ID);
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_UncommittedState)
            {
                switch(this.m_State)
                {
                    case STATE_QUEST_LINE:
                    {
                        this.buttonFlags = EXTRA_BUTTON_CLOSE;
                        title = resourceManager.getString(BUNDLE, "TITLE_QUEST_LINE");
                        this.m_UIViewStack.selectedIndex = 1;
                        this.m_UIQuestLineView.questLine = this.m_UIQuestLogView.selectedQuestLine;
                        this.m_UIQuestLineView.selectedQuestFlag = null;
                        break;
                    }
                    case STATE_QUEST_LOG:
                    {
                        this.buttonFlags = EXTRA_BUTTON_CLOSE | EXTRA_BUTTON_SHOW;
                        title = resourceManager.getString(BUNDLE, "TITLE_QUEST_LOG");
                        this.m_UIViewStack.selectedIndex = 0;
                        this.m_UIQuestLogView.selectedQuestLine = null;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_UncommittedState = false;
            }
            super.commitProperties();
            if (this.m_UncommittedExtraButtonFlags)
            {
                _loc_1 = 0;
                _loc_2 = 0;
                _loc_3 = null;
                _loc_1 = footer.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_3 = Button(footer.getChildAt(_loc_1));
                    if ((uint(_loc_3.data) & EXTRA_BUTTON_MASK) != 0)
                    {
                        _loc_3.removeEventListener(MouseEvent.CLICK, this.onExtraButton);
                        footer.removeChildAt(_loc_1);
                    }
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = 0;
                while (_loc_1 < EXTRA_BUTTON_FLAGS.length)
                {
                    
                    if ((this.m_ExtraButtonFlags & EXTRA_BUTTON_FLAGS[_loc_1].data) != 0)
                    {
                        _loc_3 = new CustomButton();
                        _loc_3.enabled = (this.m_ExtraButtonFlags & PopUpBase.DISABLE_BUTTONS) == 0;
                        _loc_3.label = resourceManager.getString(BUNDLE, EXTRA_BUTTON_FLAGS[_loc_1].label);
                        _loc_3.data = EXTRA_BUTTON_FLAGS[_loc_1].data;
                        _loc_3.addEventListener(MouseEvent.CLICK, this.onExtraButton);
                        footer.addChildAt(_loc_3, _loc_2);
                        _loc_2++;
                    }
                    _loc_1++;
                }
                this.m_UncommittedExtraButtonFlags = true;
            }
            if (this.m_UncommittedQuestLines)
            {
                this.m_UIQuestLogView.questLines = this.m_QuestLines;
                this.m_UIQuestLogView.selectedQuestLine = null;
                this.m_UncommittedQuestLines = false;
            }
            if (this.m_UncommittedQuestFlags)
            {
                this.m_UIQuestLineView.questFlags = this.m_QuestFlags;
                this.m_UIQuestLineView.selectedQuestFlag = null;
                this.m_UncommittedQuestFlags = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIQuestLogView = new QuestLogView();
                this.m_UIQuestLogView.percentHeight = 100;
                this.m_UIQuestLogView.percentWidth = 100;
                this.m_UIQuestLogView.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onQuestLineSelected);
                this.m_UIQuestLineView = new QuestLineView();
                this.m_UIQuestLineView.percentHeight = 100;
                this.m_UIQuestLineView.percentWidth = 100;
                this.m_UIViewStack = new ViewStack();
                this.m_UIViewStack.percentHeight = 100;
                this.m_UIViewStack.percentWidth = 100;
                this.m_UIViewStack.addChild(this.m_UIQuestLogView);
                this.m_UIViewStack.addChild(this.m_UIQuestLineView);
                addChild(this.m_UIViewStack);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function set state(param1:int) : void
        {
            if (param1 != STATE_QUEST_LINE && param1 != STATE_QUEST_LOG)
            {
                param1 = STATE_QUEST_LOG;
            }
            if (this.m_State != param1)
            {
                this.m_State = param1;
                this.m_UncommittedState = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function set buttonFlags(param1:uint) : void
        {
            super.buttonFlags = param1;
            var _loc_2:* = param1 & EXTRA_BUTTON_MASK;
            if (this.m_ExtraButtonFlags != _loc_2)
            {
                this.m_ExtraButtonFlags = _loc_2;
                this.m_UncommittedExtraButtonFlags = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function get buttonFlags() : uint
        {
            return super.buttonFlags | this.m_ExtraButtonFlags;
        }// end function

    }
}
