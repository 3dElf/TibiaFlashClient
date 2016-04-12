package tibia.creatures
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.creatures.buddylistClasses.*;
    import tibia.creatures.editBuddyWidgetClasses.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.network.*;

    public class EditBuddyWidget extends PopUpBase
    {
        private var m_UncommittedBuddySet:Boolean = false;
        protected var m_BuddySet:BuddySet = null;
        protected var m_UINotify:CheckBox = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Buddy:Buddy = null;
        private var m_UncommittedBuddy:Boolean = false;
        protected var m_UIDescription:TextArea = null;
        protected var m_UIIcon:BuddyIconChooser = null;
        public static const BUNDLE:String = "EditBuddyWidget";

        public function EditBuddyWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (param1 && this.m_Buddy != null)
            {
                this.m_Buddy.description = StringHelper.s_Trim(this.m_UIDescription.text);
                this.m_Buddy.icon = this.m_UIIcon.selectedID;
                this.m_Buddy.notify = this.m_UINotify.selected;
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCEDITBUDDY(this.m_Buddy.ID, this.m_Buddy.description, this.m_Buddy.icon, this.m_Buddy.notify);
                }
            }
            super.hide(param1);
            return;
        }// end function

        public function get buddySet() : BuddySet
        {
            return this.m_BuddySet;
        }// end function

        public function get buddy() : Buddy
        {
            return this.m_Buddy;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = 0;
            var _loc_2:* = -1;
            var _loc_3:* = -1;
            var _loc_4:* = null;
            var _loc_5:* = false;
            if (this.m_UncommittedBuddySet)
            {
                if (this.m_BuddySet != null)
                {
                    this.m_UIIcon.dataProvider = this.m_BuddySet.icons;
                }
                else
                {
                    this.m_UIIcon.dataProvider = null;
                }
                this.m_UncommittedBuddySet = false;
            }
            if (this.m_UncommittedBuddy)
            {
                if (this.m_Buddy != null)
                {
                    this.m_UIDescription.text = this.m_Buddy.description;
                    this.m_UIIcon.selectedID = this.m_Buddy.icon;
                    this.m_UINotify.selected = this.m_Buddy.notify;
                }
                else
                {
                    this.m_UIDescription.text = null;
                    this.m_UIIcon.selectedID = -1;
                    this.m_UINotify.selected = false;
                }
                this.m_UncommittedBuddy = false;
            }
            return;
        }// end function

        public function set buddySet(param1:BuddySet) : void
        {
            if (this.m_BuddySet != param1)
            {
                this.m_BuddySet = param1;
                this.m_UncommittedBuddySet = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set buddy(param1:Buddy) : void
        {
            if (this.m_Buddy != param1)
            {
                this.m_Buddy = param1;
                this.m_UncommittedBuddy = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new Form();
                _loc_1.percentWidth = 100;
                _loc_1.percentHeight = 100;
                _loc_1.styleName = "editBuddyRootContainer";
                _loc_2 = new FormItem();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.label = resourceManager.getString(BUNDLE, "LABEL_ICON");
                this.m_UIIcon = new BuddyIconChooser();
                this.m_UIIcon.percentHeight = NaN;
                this.m_UIIcon.percentWidth = 100;
                _loc_2.addChild(this.m_UIIcon);
                _loc_1.addChild(_loc_2);
                _loc_2 = new FormItem();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.label = resourceManager.getString(BUNDLE, "LABEL_DESCRIPTION");
                this.m_UIDescription = new TextArea();
                this.m_UIDescription.maxChars = 128;
                this.m_UIDescription.percentHeight = NaN;
                this.m_UIDescription.percentWidth = 100;
                this.m_UIDescription.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIDescription.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                _loc_2.addChild(this.m_UIDescription);
                _loc_1.addChild(_loc_2);
                _loc_2 = new FormItem();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.label = resourceManager.getString(BUNDLE, "LABEL_NOTIFY");
                this.m_UINotify = new CheckBox();
                this.m_UINotify.percentHeight = NaN;
                this.m_UINotify.percentWidth = 100;
                _loc_2.addChild(this.m_UINotify);
                _loc_1.addChild(_loc_2);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
