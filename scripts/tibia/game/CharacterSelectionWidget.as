package tibia.game
{
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;

    public class CharacterSelectionWidget extends PopUpBase
    {
        private var m_SelectedCharacterIndex:int = -1;
        private var m_CharactersView:ListCollectionView = null;
        private var m_UncommittedCharacters:Boolean = false;
        private var m_Characters:IList = null;
        private var m_UIList:List = null;
        private var m_Timeout:Timer = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedSelectedCharacter:Boolean = false;
        public static const CLIENT_VERSION:uint = 2499;
        public static const CLIENT_PREVIEW_STATE:uint = 0;
        public static const PREVIEW_STATE_PREVIEW_NO_ACTIVE_CHANGE:uint = 1;
        private static const BUNDLE:String = "CharacterSelectionWidget";
        public static const PREVIEW_STATE_PREVIEW_WITH_ACTIVE_CHANGE:uint = 2;
        public static const CLIENT_TYPE:uint = 3;
        public static const TIMEOUT_EXPIRED:int = 2147483647;
        public static const PREVIEW_STATE_REGULAR:uint = 0;
        private static const CLOSE_TIMEOUT:Number = 60000;

        public function CharacterSelectionWidget()
        {
            height = 310;
            width = 350;
            buttonFlags = PopUpBase.BUTTON_CANCEL | PopUpBase.BUTTON_OKAY;
            title = resourceManager.getString(BUNDLE, "TITLE");
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyboardDown);
            if (!Tibia.s_GetInstance().isRunning)
            {
                this.m_Timeout = new Timer(CLOSE_TIMEOUT, 1);
                this.m_Timeout.addEventListener(TimerEvent.TIMER, this.onTimeout);
                this.m_Timeout.start();
            }
            return;
        }// end function

        private function scrollToSelectedCharacter() : void
        {
            if (this.m_UIList != null && this.selectedCharacterIndex != -1)
            {
                this.m_UIList.validateNow();
                this.m_UIList.scrollToIndex(this.selectedCharacterIndex);
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            if (this.m_Timeout != null)
            {
                this.m_Timeout.stop();
            }
            super.hide(param1);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedCharacters)
            {
                if (this.m_Characters != null)
                {
                    this.m_CharactersView = new ListCollectionView(this.m_Characters);
                }
                _loc_1 = new Sort();
                _loc_1.compareFunction = this.sortAccountCharacterByName;
                ICollectionView(this.m_CharactersView).sort = _loc_1;
                this.m_UIList.dataProvider = this.m_CharactersView;
                this.m_UncommittedCharacters = false;
            }
            if (this.m_UncommittedSelectedCharacter)
            {
                this.m_UIList.selectedIndex = this.m_SelectedCharacterIndex;
                if (this.m_Timeout != null)
                {
                    this.m_Timeout.stop();
                    this.m_Timeout.reset();
                    this.m_Timeout.start();
                }
                callLater(this.scrollToSelectedCharacter, null);
                this.m_UncommittedSelectedCharacter = false;
            }
            return;
        }// end function

        public function set selectedCharacterIndex(param1:int) : void
        {
            if (this.m_Characters != null)
            {
                param1 = Math.max(-1, Math.min(param1, (this.m_Characters.length - 1)));
            }
            else
            {
                param1 = -1;
            }
            if (this.m_SelectedCharacterIndex != param1)
            {
                this.m_SelectedCharacterIndex = param1;
                this.m_UncommittedSelectedCharacter = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function onTimeout(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = new CloseEvent(CloseEvent.CLOSE, true, false);
                _loc_2.detail = TIMEOUT_EXPIRED;
                dispatchEvent(_loc_2);
                if (!_loc_2.cancelable || !_loc_2.isDefaultPrevented())
                {
                    this.hide(false);
                }
            }
            return;
        }// end function

        public function set characters(param1:IList) : void
        {
            if (this.m_Characters != param1)
            {
                this.m_Characters = param1;
                this.m_UncommittedCharacters = true;
                invalidateProperties();
                this.m_SelectedCharacterIndex = -1;
            }
            return;
        }// end function

        private function buildCharacterLabel(param1:Object) : String
        {
            var _loc_2:* = AccountCharacter(param1).name + " (" + AccountCharacter(param1).world;
            if (AccountCharacter(param1).worldPreviewState != PREVIEW_STATE_REGULAR)
            {
                _loc_2 = _loc_2 + ", Preview";
            }
            _loc_2 = _loc_2 + ")";
            return _loc_2;
        }// end function

        private function onListDoubleClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                var _loc_4:* = this.m_UIList;
                _loc_2 = _loc_4.mx_internal::mouseEventToItemRendererOrEditor(event);
                if (_loc_2 != null)
                {
                    _loc_3 = new CloseEvent(CloseEvent.CLOSE, false, true);
                    _loc_3.detail = PopUpBase.BUTTON_OKAY;
                    dispatchEvent(_loc_3);
                    if (!_loc_3.cancelable || !_loc_3.isDefaultPrevented())
                    {
                        _loc_4.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onListDoubleClick);
                        this.hide(true);
                    }
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIList = new CustomList();
                this.m_UIList.doubleClickEnabled = true;
                this.m_UIList.labelFunction = this.buildCharacterLabel;
                this.m_UIList.percentWidth = 100;
                this.m_UIList.percentHeight = 100;
                this.m_UIList.addEventListener(ListEvent.CHANGE, this.onListChange);
                this.m_UIList.addEventListener(MouseEvent.DOUBLE_CLICK, this.onListDoubleClick);
                this.m_UIList.allowMultipleSelection = false;
                this.m_UIList.allowDragSelection = false;
                addChild(this.m_UIList);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function sortAccountCharacterByName(param1:AccountCharacter, param2:AccountCharacter, param3:Array = null) : int
        {
            if (param1.name == param2.name)
            {
                return 0;
            }
            if (param1.name < param2.name)
            {
                return 1;
            }
            return -1;
        }// end function

        private function onKeyboardDown(event:KeyboardEvent) : void
        {
            if (event != null)
            {
                switch(event.keyCode)
                {
                    case Keyboard.DOWN:
                    {
                        (this.selectedCharacterIndex + 1);
                        break;
                    }
                    case Keyboard.UP:
                    {
                        this.selectedCharacterIndex = Math.max(0, (this.selectedCharacterIndex - 1));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get characters() : IList
        {
            return this.m_Characters;
        }// end function

        public function get selectedCharacterIndex() : int
        {
            return this.m_SelectedCharacterIndex;
        }// end function

        private function onListChange(event:ListEvent) : void
        {
            if (event != null)
            {
                this.selectedCharacterIndex = this.m_UIList.selectedIndex;
                this.m_UncommittedSelectedCharacter = true;
            }
            return;
        }// end function

    }
}
