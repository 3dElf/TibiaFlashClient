package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import tibia.chat.*;
    import tibia.options.*;
    import tibia.options.configurationWidgetClasses.*;

    public class NameFilterOptions extends HBox implements IOptionsEditor
    {
        protected var m_UIWhiteBuddies:CheckBox = null;
        protected var m_UIWhiteEnable:CheckBox = null;
        protected var m_UIBlackItems:NameFilterListEditor = null;
        protected var m_UIBlackPrivate:CheckBox = null;
        private var m_UncommittedOptions:Boolean = false;
        private var m_UncommittedValues:Boolean = true;
        protected var m_UIBlackEnable:CheckBox = null;
        protected var m_UIWhiteItems:NameFilterListEditor = null;
        protected var m_UIBlackYelling:CheckBox = null;
        protected var m_Options:OptionsStorage = null;
        private var m_UIConstructed:Boolean = false;

        public function NameFilterOptions()
        {
            label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_LABEL");
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                _loc_1 = null;
                if (this.m_Options != null)
                {
                    _loc_1 = this.m_Options.getNameFilterSet(NameFilterSet.DEFAULT_SET);
                }
                if (_loc_1 != null)
                {
                    this.m_UIBlackEnable.selected = _loc_1.blacklistEnabled;
                    this.m_UIBlackPrivate.selected = _loc_1.blacklistPrivate;
                    this.m_UIBlackYelling.selected = _loc_1.blacklistYelling;
                    this.m_UIBlackItems.dataProvider = this.cloneList(_loc_1.blacklistItems);
                    this.m_UIWhiteEnable.selected = _loc_1.whitelistEnabled;
                    this.m_UIWhiteBuddies.selected = _loc_1.whitelistBuddies;
                    this.m_UIWhiteItems.dataProvider = this.cloneList(_loc_1.whitelistItems);
                }
                else
                {
                    this.m_UIBlackEnable.selected = false;
                    this.m_UIBlackPrivate.selected = false;
                    this.m_UIBlackYelling.selected = false;
                    this.m_UIBlackItems.dataProvider = new ArrayCollection();
                    this.m_UIWhiteEnable.selected = false;
                    this.m_UIWhiteBuddies.selected = false;
                    this.m_UIWhiteItems.dataProvider = new ArrayCollection();
                }
                this.m_UIBlackItems.enabled = this.m_UIBlackEnable.selected;
                this.m_UIBlackPrivate.enabled = this.m_UIBlackEnable.selected;
                this.m_UIBlackYelling.enabled = this.m_UIBlackEnable.selected;
                this.m_UIWhiteItems.enabled = this.m_UIWhiteEnable.selected;
                this.m_UIWhiteBuddies.enabled = this.m_UIWhiteEnable.selected;
                this.m_UncommittedOptions = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var Bx:VBox;
            var Lbl:Label;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                Bx = new VBox();
                Bx.percentWidth = 50;
                Bx.percentHeight = 100;
                Bx.styleName = "optionsConfigurationWidgetRootContainer";
                this.m_UIBlackEnable = new CheckBox();
                this.m_UIBlackEnable.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_CHECK_IGNORE_LIST_ACTIVE");
                this.m_UIBlackEnable.styleName = this;
                this.m_UIBlackEnable.addEventListener(Event.CHANGE, function (event:Event) : void
            {
                m_UIBlackItems.enabled = m_UIBlackEnable.selected;
                m_UIBlackYelling.enabled = m_UIBlackEnable.selected;
                m_UIBlackPrivate.enabled = m_UIBlackEnable.selected;
                return;
            }// end function
            );
                this.m_UIBlackEnable.addEventListener(Event.CHANGE, this.onValueChange);
                Bx.addChild(this.m_UIBlackEnable);
                Lbl = new Label();
                Lbl.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_LBL_IGNORE_LIST_CHARACTERS");
                Lbl.setStyle("fontWeight", "bold");
                Bx.addChild(Lbl);
                this.m_UIBlackItems = new NameFilterListEditor();
                this.m_UIBlackItems.height = 250;
                this.m_UIBlackItems.percentHeight = NaN;
                this.m_UIBlackItems.percentWidth = 100;
                this.m_UIBlackItems.styleName = getStyle("blackListEditorStyle");
                this.m_UIBlackItems.setStyle("disabledOverlayAlpha", 0);
                Bx.addChild(this.m_UIBlackItems);
                Lbl = new Label();
                Lbl.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_LBL_IGNORE_LIST_GLOBAL");
                Lbl.setStyle("fontWeight", "bold");
                Bx.addChild(Lbl);
                this.m_UIBlackYelling = new CheckBox();
                this.m_UIBlackYelling.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_CHECK_IGNORE_LIST_YELLING");
                this.m_UIBlackYelling.styleName = this;
                this.m_UIBlackYelling.addEventListener(Event.CHANGE, this.onValueChange);
                Bx.addChild(this.m_UIBlackYelling);
                this.m_UIBlackPrivate = new CheckBox();
                this.m_UIBlackPrivate.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_CHECK_IGNORE_LIST_PRIVATE");
                this.m_UIBlackPrivate.styleName = this;
                this.m_UIBlackPrivate.addEventListener(Event.CHANGE, this.onValueChange);
                Bx.addChild(this.m_UIBlackPrivate);
                addChild(Bx);
                Bx = new VBox();
                Bx.percentWidth = 50;
                Bx.percentHeight = 100;
                Bx.styleName = "optionsConfigurationWidgetRootContainer";
                this.m_UIWhiteEnable = new CheckBox();
                this.m_UIWhiteEnable.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_CHECK_WHITE_LIST_ACTIVE");
                this.m_UIWhiteEnable.styleName = this;
                this.m_UIWhiteEnable.addEventListener(Event.CHANGE, function (event:Event) : void
            {
                m_UIWhiteItems.enabled = m_UIWhiteEnable.selected;
                m_UIWhiteBuddies.enabled = m_UIWhiteEnable.selected;
                return;
            }// end function
            );
                this.m_UIWhiteEnable.addEventListener(Event.CHANGE, this.onValueChange);
                Bx.addChild(this.m_UIWhiteEnable);
                Lbl = new Label();
                Lbl.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_LBL_WHITE_LIST_CHARACTERS");
                Lbl.setStyle("fontWeight", "bold");
                Bx.addChild(Lbl);
                this.m_UIWhiteItems = new NameFilterListEditor();
                this.m_UIWhiteItems.height = 250;
                this.m_UIWhiteItems.percentHeight = NaN;
                this.m_UIWhiteItems.percentWidth = 100;
                this.m_UIWhiteItems.styleName = getStyle("whiteListEditorStyle");
                this.m_UIWhiteItems.setStyle("disabledOverlayAlpha", 0);
                Bx.addChild(this.m_UIWhiteItems);
                Lbl = new Label();
                Lbl.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_LBL_WHITE_LIST_GLOBAL");
                Lbl.setStyle("fontWeight", "bold");
                Bx.addChild(Lbl);
                this.m_UIWhiteBuddies = new CheckBox();
                this.m_UIWhiteBuddies.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_CHECK_WHITE_LIST_BUDDY");
                this.m_UIWhiteBuddies.styleName = this;
                this.m_UIWhiteBuddies.addEventListener(Event.CHANGE, this.onValueChange);
                Bx.addChild(this.m_UIWhiteBuddies);
                addChild(Bx);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        private function onValueChange(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function cloneList(param1:IList, param2:IList = null) : IList
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_3:* = null;
            if (param1 != null)
            {
                _loc_3 = param2 != null ? (param2) : (new ArrayCollection());
                _loc_3.removeAll();
                _loc_4 = 0;
                _loc_5 = param1.length;
                while (_loc_4 < _loc_5)
                {
                    
                    _loc_3.addItem(param1.getItemAt(_loc_4).clone());
                    _loc_4++;
                }
            }
            return _loc_3;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
            return;
        }// end function

        public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (this.m_Options != null && param1 && this.m_UncommittedValues)
            {
                _loc_2 = new NameFilterSet(NameFilterSet.DEFAULT_SET);
                _loc_2.blacklistEnabled = this.m_UIBlackEnable.selected;
                _loc_2.blacklistPrivate = this.m_UIBlackPrivate.selected;
                _loc_2.blacklistYelling = this.m_UIBlackYelling.selected;
                this.cloneList(this.m_UIBlackItems.dataProvider, _loc_2.blacklistItems);
                _loc_2.whitelistEnabled = this.m_UIWhiteEnable.selected;
                _loc_2.whitelistBuddies = this.m_UIWhiteBuddies.selected;
                this.cloneList(this.m_UIWhiteItems.dataProvider, _loc_2.whitelistItems);
                this.m_Options.addNameFilterSet(_loc_2);
                this.m_UncommittedValues = false;
            }
            return;
        }// end function

    }
}
