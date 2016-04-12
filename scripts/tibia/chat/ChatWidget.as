package tibia.chat
{
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.controls.*;
    import shared.utility.*;
    import tibia.chat.chatWidgetClasses.*;
    import tibia.controls.*;
    import tibia.controls.dynamicTabBarClasses.*;
    import tibia.input.*;
    import tibia.input.staticaction.*;
    import tibia.network.*;
    import tibia.options.*;

    public class ChatWidget extends VBox
    {
        private var m_UncommittedRightChannel:Boolean = false;
        protected var m_LeftChannel:Channel = null;
        protected var m_ChatStorage:ChatStorage = null;
        protected var m_UILeftView:ChannelView = null;
        protected var m_RightChannel:Channel = null;
        protected var m_UITitleRow:Box = null;
        private var m_UncommittedLeftChannel:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedChatStorage:Boolean = false;
        protected var m_UIButtonSetCycle:Button = null;
        protected var m_Volume:int = 1;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_HistoryIndex:int = -1;
        protected var m_UIViewContainer:DividedBox = null;
        protected var m_UIRightHolder:Container = null;
        protected var m_UIButtonIgnore:Button = null;
        protected var m_UIInputRow:Box = null;
        private var m_UncommittedMappingSetID:Boolean = true;
        protected var m_MappingSetID:int = 0;
        protected var m_UITabBar:ChannelTabBar = null;
        private var m_UncommittedVolume:Boolean = false;
        protected var m_MappingMode:int = 1;
        protected var m_History:IList = null;
        protected var m_UIRightTab:ChannelTab = null;
        protected var m_Options:OptionsStorage = null;
        protected var m_UIButtonVolume:Button = null;
        private var m_UncommittedMappingMode:Boolean = true;
        protected var m_UIInput:PassiveTextField = null;
        protected var m_UIRightView:ChannelView = null;
        protected var m_UIButtonOpen:Button = null;
        protected var m_UIButtonMappingMode:Button = null;
        public static const BUNDLE:String = "ChatWidget";
        static const HISTORY_SIZE:int = 1000;
        static const VOLUME_DATA:Array = [{mode:MessageMode.MESSAGE_SAY, label:"BTN_CHANNEL_VOLUME_SAY_LABEL"}, {mode:MessageMode.MESSAGE_YELL, label:"BTN_CHANNEL_VOLUME_YELL_LABEL"}, {mode:MessageMode.MESSAGE_WHISPER, label:"BTN_CHANNEL_VOLUME_WHISPER_LABEL"}];

        public function ChatWidget()
        {
            focusEnabled = false;
            tabEnabled = false;
            tabChildren = false;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            this.m_History = new RingBuffer(HISTORY_SIZE);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onMouseDown);
            return;
        }// end function

        public function get chatStorage() : ChatStorage
        {
            return this.m_ChatStorage;
        }// end function

        public function set chatStorage(param1:ChatStorage) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_ChatStorage != param1)
            {
                _loc_2 = 0;
                _loc_3 = null;
                if (this.m_ChatStorage != null)
                {
                    _loc_2 = this.m_ChatStorage.channels.length - 1;
                    while (_loc_2 >= 0)
                    {
                        
                        _loc_3 = this.m_ChatStorage.getChannelAt(_loc_2);
                        _loc_3.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelPropertyChange);
                        _loc_2 = _loc_2 - 1;
                    }
                    this.m_ChatStorage.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onChannelAddRemove);
                }
                this.m_ChatStorage = param1;
                if (this.m_ChatStorage != null)
                {
                    _loc_2 = this.m_ChatStorage.channels.length - 1;
                    while (_loc_2 >= 0)
                    {
                        
                        _loc_3 = this.m_ChatStorage.getChannelAt(_loc_2);
                        _loc_3.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelPropertyChange);
                        _loc_2 = _loc_2 - 1;
                    }
                    this.m_ChatStorage.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onChannelAddRemove);
                }
                this.m_UncommittedChatStorage = true;
                this.m_UncommittedMappingMode = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get leftChannel() : Channel
        {
            return this.m_LeftChannel;
        }// end function

        function onChatCopyPaste(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : Boolean
        {
            var _loc_7:* = null;
            if (param4 || !param5 || param6)
            {
                throw new ArgumentError("ChatWidget.onChatSelection: Invalid modifier state: " + param4 + "/" + param5 + "/" + param6);
            }
            switch(param3)
            {
                case Keyboard.A:
                {
                    if (this.m_UIInput.length > 0)
                    {
                        this.m_UIInput.setSelection(0, this.m_UIInput.length);
                    }
                    else
                    {
                        this.m_UILeftView.selectAll();
                        this.m_UIRightView.clearSelection();
                    }
                    break;
                }
                case Keyboard.C:
                case Keyboard.X:
                {
                    _loc_7 = null;
                    var _loc_8:* = this.m_UIInput.getSelectedText();
                    _loc_7 = this.m_UIInput.getSelectedText();
                    if (_loc_8 != null && _loc_7.length > 0)
                    {
                        System.setClipboard(_loc_7);
                        if (param3 == Keyboard.X)
                        {
                            this.m_UIInput.replaceSelectedText("");
                        }
                    }
                    else
                    {
                        var _loc_8:* = this.m_UILeftView.getSelectedText();
                        _loc_7 = this.m_UILeftView.getSelectedText();
                        if (_loc_8 != null && _loc_7.length > 0)
                        {
                            System.setClipboard(_loc_7);
                        }
                        else
                        {
                            var _loc_8:* = this.m_UIRightView.getSelectedText();
                            _loc_7 = this.m_UIRightView.getSelectedText();
                            if (_loc_8 != null && _loc_7.length > 0)
                            {
                                System.setClipboard(_loc_7);
                            }
                        }
                    }
                    break;
                }
                case Keyboard.V:
                {
                    break;
                }
                default:
                {
                    throw new ArgumentError("ChatWidget.onChatSelection: Invalid key code.");
                    break;
                }
            }
            return true;
        }// end function

        private function getVolumeEnabled() : Boolean
        {
            return this.m_MappingMode != MappingSet.CHAT_MODE_OFF && this.m_LeftChannel != null && (this.m_LeftChannel.ID === ChatStorage.LOCAL_CHANNEL_ID || this.m_LeftChannel.ID == ChatStorage.SERVER_CHANNEL_ID || !this.m_LeftChannel.sendAllowed);
        }// end function

        protected function onRightChannelResize(event:DividerEvent) : void
        {
            var a_Event:* = event;
            if (a_Event != null)
            {
                callLater(function () : void
            {
                if (m_Options != null)
                {
                    m_Options.generalUIChatLeftViewWidth = getViewWidth();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITitleRow = new HBox();
                this.m_UITitleRow.height = 27;
                this.m_UITitleRow.percentHeight = NaN;
                this.m_UITitleRow.percentWidth = 100;
                this.m_UITitleRow.width = NaN;
                this.m_UITitleRow.styleName = getStyle("titleBarStyle");
                this.m_UITabBar = new ChannelTabBar();
                this.m_UITabBar.closePolicy = DynamicTabBar.CLOSE_SELECTED;
                this.m_UITabBar.dragEnabled = true;
                this.m_UITabBar.dropDownPolicy = DynamicTabBar.DROP_DOWN_ON;
                this.m_UITabBar.height = 27;
                this.m_UITabBar.labelField = "name";
                this.m_UITabBar.percentHeight = NaN;
                this.m_UITabBar.percentWidth = 100;
                this.m_UITabBar.scrollPolicy = ScrollPolicy.ON;
                this.m_UITabBar.styleName = getStyle("titleTabBarStyle");
                this.m_UITabBar.tabResize = true;
                this.m_UITabBar.tabMinWidth = 100;
                this.m_UITabBar.toolTipField = "name";
                this.m_UITabBar.width = NaN;
                this.m_UITabBar.addEventListener(TabBarEvent.CLOSE, this.onChannelClose);
                this.m_UITabBar.addEventListener(TabBarEvent.SELECT, this.onChannelSelect);
                this.m_UITabBar.addEventListener(ChannelEvent.HIGHLIGHT, this.onChannelHighlight);
                this.m_UITabBar.addEventListener(ChannelEvent.TAB_CONTEXT_MENU, this.onChannelContextMenu);
                this.m_UITitleRow.addChild(this.m_UITabBar);
                this.m_UIButtonOpen = new CustomButton();
                this.m_UIButtonOpen.styleName = getStyle("titleOpenButtonStyle");
                this.m_UIButtonOpen.toolTip = resourceManager.getString(BUNDLE, "TIP_CHANNEL_OPEN");
                this.m_UIButtonOpen.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
            {
                StaticActionList.CHAT_CHANNEL_OPEN.perform();
                return;
            }// end function
            );
                this.m_UITitleRow.addChild(this.m_UIButtonOpen);
                this.m_UIButtonIgnore = new CustomButton();
                this.m_UIButtonIgnore.styleName = getStyle("titleIgnoreButtonStyle");
                this.m_UIButtonIgnore.toolTip = resourceManager.getString(BUNDLE, "TIP_CHANNEL_IGNORE");
                this.m_UIButtonIgnore.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
            {
                StaticActionList.MISC_SHOW_EDIT_IGNORELIST.perform();
                return;
            }// end function
            );
                this.m_UITitleRow.addChild(this.m_UIButtonIgnore);
                this.m_UIRightHolder = new HBox();
                this.m_UIRightHolder.height = 27;
                this.m_UIRightHolder.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIRightHolder.styleName = getStyle("titleRightHolderStyle");
                this.m_UIRightHolder.toolTip = resourceManager.getString(BUNDLE, "TIP_RIGHT_TAB_EMPTY");
                this.m_UIRightHolder.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIRightHolder.width = 100;
                this.m_UIRightHolder.addEventListener(DragEvent.DRAG_DROP, this.onRightChannelDrag);
                this.m_UIRightHolder.addEventListener(DragEvent.DRAG_ENTER, this.onRightChannelDrag);
                this.m_UITitleRow.addChild(this.m_UIRightHolder);
                this.m_UIRightTab = new ChannelTab();
                this.m_UIRightTab.closePolicy = DynamicTabBar.CLOSE_SELECTED;
                this.m_UIRightTab.height = NaN;
                this.m_UIRightTab.label = this.m_RightChannel != null ? (this.m_RightChannel.name) : (null);
                this.m_UIRightTab.selected = this.m_RightChannel != null;
                this.m_UIRightTab.styleName = getStyle("titleRightTabStyle");
                this.m_UIRightTab.visible = this.m_RightChannel != null;
                this.m_UIRightTab.width = this.m_UIRightHolder.width * 0.9;
                this.m_UIRightTab.addEventListener(Event.CLOSE, this.onRightChannelClose);
                this.m_UIRightHolder.addChild(this.m_UIRightTab);
                addChild(this.m_UITitleRow);
                this.m_UIViewContainer = new CustomDividedBox();
                this.m_UIViewContainer.direction = BoxDirection.HORIZONTAL;
                this.m_UIViewContainer.minHeight = 48;
                this.m_UIViewContainer.percentHeight = 100;
                this.m_UIViewContainer.percentWidth = 100;
                this.m_UIViewContainer.resizeToContent = true;
                this.m_UIViewContainer.styleName = getStyle("viewBarStyle");
                this.m_UIViewContainer.addEventListener(DividerEvent.DIVIDER_RELEASE, this.onRightChannelResize);
                this.m_UILeftView = new ChannelView();
                this.m_UILeftView.channel = this.m_LeftChannel;
                this.m_UILeftView.minWidth = 200;
                this.m_UILeftView.percentHeight = 100;
                this.m_UILeftView.percentWidth = 100;
                this.m_UILeftView.styleName = this.m_RightChannel == null ? (getStyle("viewBarSingleViewStyle")) : (getStyle("viewBarLeftViewStyle"));
                this.m_UILeftView.addEventListener(ChannelEvent.NICKLIST_CONTEXT_MENU, this.onChannelContextMenu);
                this.m_UILeftView.addEventListener(ChannelEvent.VIEW_CONTEXT_MENU, this.onChannelContextMenu);
                this.m_UIViewContainer.addChild(this.m_UILeftView);
                this.m_UIRightView = new ChannelView();
                this.m_UIRightView.channel = this.m_RightChannel;
                this.m_UIRightView.minWidth = 200;
                this.m_UIRightView.percentHeight = 100;
                this.m_UIRightView.percentWidth = 0;
                this.m_UIRightView.styleName = getStyle("viewBarRightViewStyle");
                this.m_UIRightView.addEventListener(ChannelEvent.NICKLIST_CONTEXT_MENU, this.onChannelContextMenu);
                this.m_UIRightView.addEventListener(ChannelEvent.VIEW_CONTEXT_MENU, this.onChannelContextMenu);
                if (this.m_RightChannel != null)
                {
                    this.m_UIViewContainer.addChild(this.m_UIRightView);
                }
                addChild(this.m_UIViewContainer);
                this.m_UIInputRow = new HBox();
                this.m_UIInputRow.height = 27;
                this.m_UIInputRow.percentHeight = NaN;
                this.m_UIInputRow.percentWidth = 100;
                this.m_UIInputRow.width = NaN;
                this.m_UIInputRow.styleName = getStyle("inputBarStyle");
                this.m_UIButtonVolume = new CustomButton();
                this.m_UIButtonVolume.enabled = this.getVolumeEnabled();
                this.m_UIButtonVolume.label = resourceManager.getString(BUNDLE, this.getVolumeLabelResource());
                this.m_UIButtonVolume.width = 74;
                this.m_UIButtonVolume.addEventListener(MouseEvent.CLICK, this.onVolumeClick);
                this.m_UIInputRow.addChild(this.m_UIButtonVolume);
                this.m_UIInput = new PassiveTextField();
                this.m_UIInput.percentHeight = NaN;
                this.m_UIInput.percentWidth = 100;
                this.m_UIInput.styleName = getStyle("inputBarTextFieldStyle");
                this.m_UIInput.maxLength = ChatStorage.MAX_TALK_LENGTH;
                this.m_UIInput.addEventListener(MouseEvent.MOUSE_DOWN, this.onInputMouseDown);
                this.m_UIInput.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onInputMouseDown);
                this.m_UIInputRow.addChild(this.m_UIInput);
                this.m_UIButtonMappingMode = new CustomButton();
                this.m_UIButtonMappingMode.width = 74;
                this.m_UIButtonMappingMode.addEventListener(MouseEvent.CLICK, this.onMappingModeClick);
                this.m_UIInputRow.addChild(this.m_UIButtonMappingMode);
                this.m_UIButtonSetCycle = new CustomButton();
                this.m_UIButtonSetCycle.width = 120 + 2 * (6 + 9 * 0.66 + 2);
                this.m_UIButtonSetCycle.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
            {
                if (event.localX < DisplayObject(event.currentTarget).width / 2)
                {
                    StaticActionList.MISC_MAPPING_PREV.perform();
                }
                else
                {
                    StaticActionList.MISC_MAPPING_NEXT.perform();
                }
                return;
            }// end function
            );
                this.m_UIButtonSetCycle.setStyle("skin", CycleButtonSkin);
                this.m_UIButtonSetCycle.setStyle("arrowPadding", 6);
                this.m_UIButtonSetCycle.setStyle("arrowHeight", 15 * 0.66);
                this.m_UIButtonSetCycle.setStyle("arrowWidth", 9 * 0.66);
                this.m_UIButtonSetCycle.setStyle("paddingLeft", 6 + 9 * 0.66 + 2);
                this.m_UIButtonSetCycle.setStyle("paddingRight", 6 + 9 * 0.66 + 2);
                this.m_UIInputRow.addChild(this.m_UIButtonSetCycle);
                addChild(this.m_UIInputRow);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function getVolumeLabelResource() : String
        {
            var _loc_1:* = 0;
            while (_loc_1 < VOLUME_DATA.length)
            {
                
                if (VOLUME_DATA[_loc_1].mode == this.m_Volume)
                {
                    return VOLUME_DATA[_loc_1].label;
                }
                _loc_1++;
            }
            return null;
        }// end function

        public function get volume() : int
        {
            return this.m_Volume;
        }// end function

        public function set mappingMode(param1:int) : void
        {
            if (param1 != MappingSet.CHAT_MODE_OFF && param1 != MappingSet.CHAT_MODE_ON && param1 != MappingSet.CHAT_MODE_TEMPORARY)
            {
                throw new ArgumentError("ChatWidget.set mappingMode: Invalid mode: " + param1);
            }
            this.m_MappingMode = param1;
            this.m_UncommittedMappingMode = true;
            invalidateProperties();
            return;
        }// end function

        private function updateViewWidths(param1:Number = NaN) : void
        {
            if (isNaN(param1) && this.m_Options != null)
            {
                param1 = this.m_Options.generalUIChatLeftViewWidth;
            }
            if (!isNaN(param1) && this.m_UILeftView.channel != null && this.m_UIRightView.channel != null)
            {
                this.m_UILeftView.percentWidth = Math.round(param1);
                this.m_UIRightView.percentWidth = 100 - this.m_UILeftView.percentWidth;
            }
            else
            {
                this.m_UILeftView.percentWidth = 100;
                this.m_UIRightView.percentWidth = 0;
            }
            return;
        }// end function

        public function get text() : String
        {
            return this.m_UIInput.text;
        }// end function

        protected function onVolumeClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                _loc_2 = 0;
                _loc_2 = 0;
                while (_loc_2 < VOLUME_DATA.length)
                {
                    
                    if (VOLUME_DATA[_loc_2].mode == this.m_Volume)
                    {
                        _loc_2++;
                        break;
                    }
                    _loc_2++;
                }
                this.volume = VOLUME_DATA[_loc_2 % VOLUME_DATA.length].mode;
            }
            return;
        }// end function

        public function set volume(param1:int) : void
        {
            if (param1 != MessageMode.MESSAGE_SAY && param1 != MessageMode.MESSAGE_WHISPER && param1 != MessageMode.MESSAGE_YELL)
            {
                param1 = MessageMode.MESSAGE_SAY;
            }
            if (this.m_LeftChannel == null || this.m_LeftChannel.ID !== ChatStorage.LOCAL_CHANNEL_ID && this.m_LeftChannel.ID !== ChatStorage.SERVER_CHANNEL_ID && this.m_LeftChannel.sendAllowed)
            {
                param1 = MessageMode.MESSAGE_SAY;
            }
            if (this.m_Volume != param1)
            {
                this.m_Volume = param1;
                this.m_UncommittedVolume = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onChannelPropertyChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                switch(event.property)
                {
                    case "sendAllowed":
                    {
                        _loc_2 = this.getChannelTextColor(this.m_LeftChannel);
                        this.m_UIInput.setStyle("color", _loc_2);
                        this.m_UIButtonVolume.enabled = this.getVolumeEnabled();
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

        protected function onChannelClose(event:TabBarEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                _loc_2 = Channel(this.m_ChatStorage.getChannelAt(event.index));
                if (_loc_2.closable)
                {
                    this.m_ChatStorage.leaveChannel(_loc_2);
                }
            }
            return;
        }// end function

        protected function onChannelSelect(event:TabBarEvent) : void
        {
            if (event != null && this.m_ChatStorage != null)
            {
                this.leftChannel = Channel(this.m_ChatStorage.getChannelAt(event.index));
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

        public function get rightChannel() : Channel
        {
            return this.m_RightChannel;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = 0;
            if (event != null)
            {
                _loc_2 = 0;
                switch(event.property)
                {
                    case "generalUILeftViewWidth":
                    {
                        this.updateViewWidths();
                        break;
                    }
                    case "generalInputSetID":
                    case "generalInputSetMode":
                    case "mappingSet":
                    {
                        this.mappingMode = this.m_Options.generalInputSetMode;
                        this.mappingSetID = this.m_Options.generalInputSetID;
                        break;
                    }
                    case "messageFilterSet":
                    case "textColour":
                    case "highlightColour":
                    {
                        _loc_2 = this.getChannelTextColor(this.m_LeftChannel);
                        this.m_UIInput.setStyle("color", _loc_2);
                        break;
                    }
                    case "*":
                    {
                        this.updateViewWidths();
                        this.mappingSetID = this.m_Options.generalInputSetID;
                        this.mappingMode = this.m_Options.generalInputSetMode;
                        _loc_2 = this.getChannelTextColor(this.m_LeftChannel);
                        this.m_UIInput.setStyle("color", _loc_2);
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

        protected function onRightChannelDrag(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null)
            {
                _loc_2 = event.dragSource;
                if (!_loc_2.hasFormat("dragType") || _loc_2.dataForFormat("dragType") != "dynamicTab")
                {
                    return;
                }
                if (!_loc_2.hasFormat("dragTabBar") || _loc_2.dataForFormat("dragTabBar") != this.m_UITabBar)
                {
                    return;
                }
                if (!_loc_2.hasFormat("dragTabIndex"))
                {
                    return;
                }
                _loc_3 = int(_loc_2.dataForFormat("dragTabIndex"));
                _loc_4 = this.m_ChatStorage != null ? (this.m_ChatStorage.getChannelAt(_loc_3)) : (null);
                switch(event.type)
                {
                    case DragEvent.DRAG_DROP:
                    {
                        this.rightChannel = _loc_4;
                        break;
                    }
                    case DragEvent.DRAG_ENTER:
                    {
                        DragManager.acceptDragDrop(this.m_UIRightHolder);
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

        public function set text(param1:String) : void
        {
            this.m_UIInput.text = param1;
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_5:* = null;
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = numChildren;
            var _loc_3:* = 0;
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                _loc_5 = UIComponent(getChildAt(_loc_1));
                if (!isNaN(_loc_5.explicitHeight))
                {
                    _loc_3 = _loc_3 + _loc_5.explicitHeight;
                }
                else if (!isNaN(_loc_5.explicitMinHeight))
                {
                    _loc_3 = _loc_3 + _loc_5.explicitMinHeight;
                }
                else if (!isNaN(_loc_5.measuredMinHeight))
                {
                    _loc_3 = _loc_3 + _loc_5.measuredMinHeight;
                }
                _loc_1++;
            }
            if (_loc_2 > 1)
            {
                _loc_3 = _loc_3 + (_loc_2 - 1) * getStyle("verticalGap");
            }
            var _loc_4:* = viewMetricsAndPadding;
            explicitMinHeight = _loc_3 + _loc_4.top + _loc_4.bottom;
            return;
        }// end function

        private function getViewWidth() : Number
        {
            if (this.m_UILeftView == null || this.m_UIRightView == null || !isNaN(this.m_UILeftView.minWidth) && this.m_UILeftView.width == this.m_UILeftView.minWidth)
            {
                return 0;
            }
            if (this.m_UIRightView.channel == null || !isNaN(this.m_UIRightView.minWidth) && this.m_UIRightView.width == this.m_UIRightView.minWidth)
            {
                return 100;
            }
            return Math.round(100 * this.m_UILeftView.width / (this.m_UILeftView.width + this.m_UIRightView.width));
        }// end function

        public function get tabBar() : ChannelTabBar
        {
            return this.m_UITabBar;
        }// end function

        protected function onMappingModeClick(event:MouseEvent) : void
        {
            if (event != null)
            {
                this.mappingMode = this.mappingMode == MappingSet.CHAT_MODE_OFF ? (MappingSet.CHAT_MODE_ON) : (MappingSet.CHAT_MODE_OFF);
            }
            return;
        }// end function

        public function set rightChannel(param1:Channel) : void
        {
            if (this.m_RightChannel != param1)
            {
                this.m_RightChannel = param1;
                this.m_UncommittedRightChannel = true;
                invalidateProperties();
            }
            return;
        }// end function

        function onChatEdit(param1:uint, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Boolean) : Boolean
        {
            if (param4 || param5 || param6)
            {
                throw new ArgumentError("ChatWidget.onChatEdit: Invalid modifier state: " + param4 + "/" + param5 + "/" + param6);
            }
            this.m_UIInput.onKeyboardInput(param1, param2, param3, param4, param5, param6);
            if (this.m_UILeftView != null)
            {
                this.m_UILeftView.clearSelection();
            }
            if (this.m_UIRightView != null)
            {
                this.m_UIRightView.clearSelection();
            }
            return true;
        }// end function

        public function get mappingMode() : int
        {
            return this.m_MappingMode;
        }// end function

        public function set mappingSetID(param1:int) : void
        {
            this.m_MappingSetID = param1;
            this.m_UncommittedMappingSetID = true;
            invalidateProperties();
            return;
        }// end function

        function onChatText(param1:uint, param2:String) : Boolean
        {
            this.m_UIInput.onTextInput(param1, param2);
            if (this.m_UILeftView != null)
            {
                this.m_UILeftView.clearSelection();
            }
            if (this.m_UIRightView != null)
            {
                this.m_UIRightView.clearSelection();
            }
            return true;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        function onChatHistory(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            if (this.m_LeftChannel != null && this.m_LeftChannel.sendAllowed)
            {
                _loc_2 = this.m_History.length;
                if (_loc_2 < 1)
                {
                    this.m_HistoryIndex = -1;
                }
                else
                {
                    this.m_HistoryIndex = Math.min(Math.max(0, this.m_HistoryIndex + param1), _loc_2);
                }
                if (this.m_HistoryIndex >= 0 && this.m_HistoryIndex < _loc_2)
                {
                    this.m_UIInput.text = this.m_History.getItemAt(this.m_HistoryIndex) as String;
                }
                else
                {
                    this.m_UIInput.text = "";
                }
            }
            return true;
        }// end function

        protected function onChannelAddRemove(event:CollectionEvent) : void
        {
            var i:int;
            var n:int;
            var c:Channel;
            var _Communication:Communication;
            var AutoSwitch:Boolean;
            var a_Event:* = event;
            if (a_Event != null)
            {
                i;
                n;
                c;
                _Communication = Tibia.s_GetCommunication();
                AutoSwitch = _Communication != null && _Communication.isGameRunning && this.m_ChatStorage != null && this.m_ChatStorage.channelActivationTimeout < getTimer();
                switch(a_Event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        i;
                        n = a_Event.items.length;
                        while (i < n)
                        {
                            
                            c = Channel(a_Event.items[i]);
                            c.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelPropertyChange);
                            if (AutoSwitch)
                            {
                                this.leftChannel = c;
                            }
                            i = (i + 1);
                        }
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        i;
                        n = a_Event.items.length;
                        while (i < n)
                        {
                            
                            c = Channel(a_Event.items[i]);
                            c.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onChannelPropertyChange);
                            if (c == this.m_LeftChannel)
                            {
                                this.leftChannel = this.m_ChatStorage.getChannelAt(Math.min(a_Event.location + i, (this.m_ChatStorage.channels.length - 1)));
                            }
                            if (c == this.m_RightChannel)
                            {
                                callLater(function () : void
            {
                if (m_ChatStorage == null || m_ChatStorage.getChannelIndex(m_RightChannel) < 0)
                {
                    rightChannel = null;
                }
                return;
            }// end function
            );
                            }
                            i = (i + 1);
                        }
                        break;
                    }
                    case CollectionEventKind.RESET:
                    {
                        this.leftChannel = null;
                        this.rightChannel = null;
                        break;
                    }
                    case CollectionEventKind.UPDATE:
                    {
                        i;
                        n = a_Event.items.length;
                        while (i < n)
                        {
                            
                            var _loc_3:* = a_Event.items[i] as Channel;
                            c = a_Event.items[i] as Channel;
                            if (AutoSwitch && _loc_3 != null)
                            {
                                this.leftChannel = c;
                            }
                            i = (i + 1);
                        }
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

        protected function onMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as InteractiveObject;
            while (_loc_2 != null)
            {
                
                if (_loc_2 == this.m_UIInput)
                {
                    this.m_UILeftView.clearSelection();
                    this.m_UIRightView.clearSelection();
                    break;
                    continue;
                }
                if (_loc_2 == this.m_UILeftView)
                {
                    this.m_UIInput.clearSelection();
                    this.m_UIRightView.clearSelection();
                    break;
                    continue;
                }
                if (_loc_2 == this.m_UIRightView)
                {
                    this.m_UIInput.clearSelection();
                    this.m_UILeftView.clearSelection();
                    break;
                    continue;
                }
                if (_loc_2 == stage)
                {
                    break;
                    continue;
                }
                _loc_2 = _loc_2.parent as InteractiveObject;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedChatStorage)
            {
                this.volume = MessageMode.MESSAGE_SAY;
                if (this.m_ChatStorage != null)
                {
                    this.leftChannel = this.m_ChatStorage.getChannel(ChatStorage.LOCAL_CHANNEL_ID);
                    this.rightChannel = null;
                    this.m_UITabBar.dataProvider = this.m_ChatStorage.channels;
                }
                else
                {
                    this.leftChannel = null;
                    this.rightChannel = null;
                    this.m_UITabBar.dataProvider = null;
                }
                this.m_History.removeAll();
                this.m_HistoryIndex = -1;
                this.m_UncommittedChatStorage = false;
            }
            if (this.m_UncommittedOptions)
            {
                if (this.m_Options != null)
                {
                    this.mappingSetID = this.m_Options.generalInputSetID;
                    this.mappingMode = this.m_Options.generalInputSetMode;
                }
                else
                {
                    this.mappingSetID = -1;
                    this.mappingMode = MappingSet.CHAT_MODE_OFF;
                }
                this.updateViewWidths();
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedLeftChannel)
            {
                this.volume = MessageMode.MESSAGE_SAY;
                this.m_UIButtonVolume.enabled = this.getVolumeEnabled();
                this.m_UIButtonVolume.label = resourceManager.getString(BUNDLE, this.getVolumeLabelResource());
                _loc_2 = this.getChannelTextColor(this.m_LeftChannel);
                this.m_UIInput.setStyle("color", _loc_2 & 16777215);
                this.m_UILeftView.channel = this.m_LeftChannel;
                this.m_UITabBar.selectedIndex = this.m_ChatStorage != null ? (this.m_ChatStorage.getChannelIndex(this.m_LeftChannel)) : (-1);
                this.m_UncommittedLeftChannel = false;
            }
            if (this.m_UncommittedRightChannel)
            {
                if (this.m_RightChannel != null)
                {
                    this.m_UILeftView.styleName = getStyle("viewBarLeftViewStyle");
                    this.m_UIRightTab.label = this.m_RightChannel.name;
                    this.m_UIRightTab.highlight = false;
                    this.m_UIRightTab.selected = true;
                    this.m_UIRightTab.visible = true;
                    this.m_UIRightView.channel = this.m_RightChannel;
                    if (!this.m_UIViewContainer.contains(this.m_UIRightView))
                    {
                        this.m_UIViewContainer.addChild(this.m_UIRightView);
                    }
                }
                else
                {
                    this.m_UILeftView.styleName = getStyle("viewBarSingleViewStyle");
                    this.m_UIRightTab.label = resourceManager.getString(BUNDLE, "BTN_RIGHT_TAB_EMPTY");
                    this.m_UIRightTab.highlight = false;
                    this.m_UIRightTab.selected = false;
                    this.m_UIRightTab.visible = false;
                    this.m_UIRightView.channel = null;
                    if (this.m_UIViewContainer.contains(this.m_UIRightView))
                    {
                        this.m_UIViewContainer.removeChild(this.m_UIRightView);
                    }
                }
                this.updateViewWidths();
                this.m_UncommittedRightChannel = false;
            }
            if (this.m_UncommittedVolume)
            {
                this.m_UIButtonVolume.enabled = this.getVolumeEnabled();
                this.m_UIButtonVolume.label = resourceManager.getString(BUNDLE, this.getVolumeLabelResource());
                this.m_UncommittedVolume = false;
            }
            var _loc_1:* = null;
            if (this.m_UncommittedMappingSetID)
            {
                _loc_1 = null;
                if (this.m_Options != null)
                {
                    _loc_3 = this.m_Options.getMappingSet(this.m_MappingSetID);
                    if (_loc_3 != null)
                    {
                        this.m_Options.generalInputSetID = this.m_MappingSetID;
                        _loc_1 = _loc_3.name;
                    }
                }
                this.m_UIButtonSetCycle.label = _loc_1;
                this.m_UncommittedMappingSetID = false;
            }
            if (this.m_UncommittedMappingMode)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.generalInputSetMode = this.m_MappingMode;
                }
                _loc_1 = null;
                switch(this.m_MappingMode)
                {
                    case MappingSet.CHAT_MODE_OFF:
                    {
                        _loc_1 = "BTN_CHAT_MODE_OFF";
                        break;
                    }
                    case MappingSet.CHAT_MODE_ON:
                    {
                        _loc_1 = "BTN_CHAT_MODE_ON";
                        break;
                    }
                    case MappingSet.CHAT_MODE_TEMPORARY:
                    {
                        _loc_1 = "BTN_CHAT_MODE_TEMPORARY";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_UIButtonMappingMode.label = resourceManager.getString(BUNDLE, _loc_1);
                this.m_UIButtonVolume.enabled = this.getVolumeEnabled();
                this.m_UIButtonVolume.label = resourceManager.getString(BUNDLE, this.getVolumeLabelResource());
                this.m_UIInput.enabled = this.m_MappingMode != MappingSet.CHAT_MODE_OFF;
                this.m_UncommittedMappingMode = false;
            }
            return;
        }// end function

        public function get mappingSetID() : int
        {
            return this.m_MappingSetID;
        }// end function

        protected function onRightChannelClose(event:Event) : void
        {
            if (event != null)
            {
                event.preventDefault();
                this.rightChannel = null;
            }
            return;
        }// end function

        private function getChannelTextColor(param1:Channel) : uint
        {
            if (this.m_Options != null && this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET) != null)
            {
                if (param1 == null || !param1.sendAllowed)
                {
                    if (this.m_ChatStorage != null)
                    {
                        param1 = this.m_ChatStorage.getChannel(ChatStorage.LOCAL_CHANNEL_ID);
                    }
                    else
                    {
                        param1 = null;
                    }
                }
                if (param1 != null)
                {
                    return this.m_Options.getMessageFilterSet(MessageFilterSet.DEFAULT_SET).getMessageMode(param1.sendMode).textARGB;
                }
            }
            return 16777215;
        }// end function

        protected function onChannelContextMenu(event:ChannelEvent) : void
        {
            if (event != null)
            {
                switch(event.type)
                {
                    case ChannelEvent.NICKLIST_CONTEXT_MENU:
                    case ChannelEvent.VIEW_CONTEXT_MENU:
                    {
                        new ChannelContextMenu(this.m_ChatStorage, event.channel, event.message, event.name, ChannelView(event.currentTarget)).display(this, stage.mouseX, stage.mouseY);
                        break;
                    }
                    case ChannelEvent.TAB_CONTEXT_MENU:
                    {
                        new ChannelTabContextMenu(this.m_ChatStorage, event.channel).display(this, stage.mouseX, stage.mouseY);
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

        protected function onChannelHighlight(event:ChannelEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = event.channel;
                if (_loc_2.ID == ChatStorage.NPC_CHANNEL_ID)
                {
                    this.leftChannel = _loc_2;
                }
                if (_loc_2 == this.m_LeftChannel || _loc_2 == this.m_RightChannel)
                {
                    event.preventDefault();
                }
            }
            return;
        }// end function

        public function set leftChannel(param1:Channel) : void
        {
            if (this.m_LeftChannel != param1)
            {
                this.m_LeftChannel = param1;
                this.m_UncommittedLeftChannel = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onInputMouseDown(event:MouseEvent) : void
        {
            if (this.mappingMode == MappingSet.CHAT_MODE_OFF)
            {
                this.mappingMode = MappingSet.CHAT_MODE_ON;
            }
            return;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            if (mx_internal::border is IBorder)
            {
                return IBorder(mx_internal::border).borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

        function onChatSend() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (this.m_ChatStorage != null && this.m_LeftChannel != null)
            {
                _loc_1 = MessageMode.MESSAGE_NONE;
                if (this.m_LeftChannel.ID === ChatStorage.LOCAL_CHANNEL_ID || this.m_LeftChannel.ID === ChatStorage.SERVER_CHANNEL_ID || !this.m_LeftChannel.sendAllowed)
                {
                    _loc_1 = this.volume;
                    this.volume = MessageMode.MESSAGE_SAY;
                }
                _loc_2 = StringHelper.s_Trim(this.m_UIInput.text);
                if (_loc_2 == null || _loc_2.length < 1)
                {
                    this.m_UIInput.text = "";
                    return;
                }
                if (this.m_History.length == 0 || String(this.m_History.getItemAt((this.m_History.length - 1))) != _loc_2)
                {
                    this.m_History.addItem(_loc_2);
                }
                this.m_HistoryIndex = this.m_History.length;
                this.m_UIInput.text = this.m_ChatStorage.sendChannelMessage(_loc_2, this.m_LeftChannel, _loc_1);
            }
            if (this.m_UILeftView != null)
            {
                this.m_UILeftView.clearSelection();
            }
            if (this.m_UIRightView != null)
            {
                this.m_UIRightView.clearSelection();
            }
            return;
        }// end function

    }
}
