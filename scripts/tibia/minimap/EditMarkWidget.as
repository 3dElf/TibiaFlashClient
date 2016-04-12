package tibia.minimap
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.minimap.editMarkWidgetClasses.*;

    public class EditMarkWidget extends PopUpBase
    {
        protected var m_Description:String = null;
        protected var m_UIMark:MarkIconChooser = null;
        private var m_UncommittedPosition:Boolean = false;
        protected var m_PositionX:int = 0;
        protected var m_PositionY:int = 0;
        protected var m_PositionZ:int = 0;
        private var m_UncommittedMiniMapStorage:Boolean = false;
        protected var m_MiniMapStorage:MiniMapStorage;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIDescription:TextInput = null;
        protected var m_Mark:int = 0;
        static const MM_SIDEBAR_ZOOM_MAX:int = 2;
        static const MM_SIDEBAR_HIGHLIGHT_DURATION:Number = 10000;
        static const MM_STORAGE_MAX_VERSION:int = 1;
        public static const BUNDLE:String = "EditMarkWidget";
        static const MM_SECTOR_SIZE:int = 256;
        static const MM_IE_TIMEOUT:Number = 50;
        static const MM_SIDEBAR_VIEW_HEIGHT:int = 106;
        static const MM_IO_TIMEOUT:Number = 500;
        static const MM_SIDEBAR_ZOOM_MIN:int = -1;
        static const MM_COLOUR_DEFAULT:uint = 0;
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const MM_STORAGE_MIN_VERSION:int = 1;
        static const MM_CACHE_SIZE:int = 48;

        public function EditMarkWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            if (param1)
            {
                if (this.m_MiniMapStorage != null)
                {
                    this.m_MiniMapStorage.setMark(this.m_PositionX, this.m_PositionY, this.m_PositionZ, this.m_Mark, this.m_Description);
                }
            }
            super.hide(param1);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedMiniMapStorage)
            {
                this.m_UncommittedPosition = true;
                this.m_UncommittedMiniMapStorage = false;
            }
            if (this.m_UncommittedPosition)
            {
                _loc_1 = null;
                if (this.m_MiniMapStorage != null)
                {
                    _loc_1 = this.m_MiniMapStorage.getMark(this.m_PositionX, this.m_PositionY, this.m_PositionZ);
                }
                if (_loc_1 != null)
                {
                    this.m_Mark = _loc_1.icon;
                    this.m_Description = _loc_1.text;
                }
                else
                {
                    this.m_Mark = 0;
                    this.m_Description = "";
                }
                this.m_UIMark.selectedIcon = this.m_Mark;
                this.m_UIDescription.text = this.m_Description;
                this.m_UncommittedPosition = false;
            }
            return;
        }// end function

        public function getPositionX() : int
        {
            return this.m_PositionX;
        }// end function

        public function getPositionZ() : int
        {
            return this.m_PositionZ;
        }// end function

        protected function onMarkChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                this.m_Mark = this.m_UIMark.selectedIcon;
            }
            return;
        }// end function

        public function getPositionY() : int
        {
            return this.m_PositionY;
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
                _loc_1.styleName = "editMarkWidgetRootContainer";
                _loc_2 = new FormItem();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.label = resourceManager.getString(BUNDLE, "LABEL_ICON");
                this.m_UIMark = new MarkIconChooser();
                this.m_UIMark.percentHeight = NaN;
                this.m_UIMark.percentWidth = 100;
                this.m_UIMark.selectedIcon = this.m_Mark;
                this.m_UIMark.styleName = getStyle("markSelectorStyle");
                this.m_UIMark.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMarkChange);
                _loc_2.addChild(this.m_UIMark);
                _loc_1.addChild(_loc_2);
                _loc_2 = new FormItem();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.label = resourceManager.getString(BUNDLE, "LABEL_TEXT");
                this.m_UIDescription = new TextInput();
                this.m_UIDescription.maxChars = 100;
                this.m_UIDescription.percentHeight = NaN;
                this.m_UIDescription.percentWidth = 100;
                this.m_UIDescription.styleName = getStyle("descriptionStyle");
                this.m_UIDescription.text = this.m_Description;
                this.m_UIDescription.addEventListener(Event.CHANGE, this.onDescriptionChange);
                this.m_UIDescription.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIDescription.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                _loc_2.addChild(this.m_UIDescription);
                _loc_1.addChild(_loc_2);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            if (this.m_PositionX != param1 || this.m_PositionY != param2 || this.m_PositionZ != param3)
            {
                this.m_PositionX = param1;
                this.m_PositionY = param2;
                this.m_PositionZ = param3;
                this.m_UncommittedPosition = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function getMiniMapStorage() : MiniMapStorage
        {
            return this.m_MiniMapStorage;
        }// end function

        protected function onDescriptionChange(event:Event) : void
        {
            if (event != null)
            {
                this.m_Description = this.m_UIDescription.text;
            }
            return;
        }// end function

        public function setMiniMapStorage(param1:MiniMapStorage) : void
        {
            if (this.m_MiniMapStorage != param1)
            {
                this.m_MiniMapStorage = param1;
                this.m_UncommittedMiniMapStorage = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}
