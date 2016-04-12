package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.game.*;
    import tibia.options.*;
    import tibia.options.configurationWidgetClasses.*;

    public class GeneralOptions extends VBox implements IOptionsEditor
    {
        protected var m_UIShowPremiumWidget:CheckBox = null;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_UIAskBeforeBuying:CheckBox = null;
        private var m_UncommittedValues:Boolean = true;
        protected var m_UIResetAllOptions:Button = null;
        protected var m_UIAutoChaseOff:CheckBox = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Options:OptionsStorage = null;
        private static const DIALOG_OPTIONS_RESET:int = 1;
        private static const DIALOG_NONE:int = 0;

        public function GeneralOptions()
        {
            label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_LABEL");
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                if (Tibia.s_GetPremiumManager() != null)
                {
                    this.m_UIShowPremiumWidget.selected = Tibia.s_GetPremiumManager().isWidgetVisible();
                }
                if (this.m_Options != null)
                {
                    this.m_UIAutoChaseOff.selected = this.m_Options.combatAutoChaseOff;
                    this.m_UIAskBeforeBuying.selected = this.m_Options.generalShopShowBuyConfirmation;
                }
                else
                {
                    this.m_UIAutoChaseOff.selected = false;
                    this.m_UIAskBeforeBuying.selected = true;
                    this.m_UIShowPremiumWidget.selected = true;
                }
                this.m_UncommittedOptions = false;
            }
            return;
        }// end function

        private function showEmbeddedDialog(param1:int, param2:String = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = PopUpBase.getCurrent().embeddedDialog;
            _loc_3 = PopUpBase.getCurrent().embeddedDialog;
            if (param1 != DIALOG_NONE && _loc_4 == null)
            {
                _loc_3 = new EmbeddedDialog();
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onCloseEmbeddedDialog, false, EventPriority.DEFAULT, true);
            }
            if (_loc_3 != null)
            {
                _loc_3.data = param1;
            }
            switch(param1)
            {
                case DIALOG_OPTIONS_RESET:
                {
                    _loc_3.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
                    _loc_3.title = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_OPTIONS_DLG_RESET_TITLE");
                    _loc_3.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_OPTIONS_DLG_RESET_TEXT");
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            PopUpBase.getCurrent().embeddedDialog = _loc_3;
            return;
        }// end function

        private function onButtonClick(event:MouseEvent) : void
        {
            if (event.currentTarget == this.m_UIResetAllOptions)
            {
                this.showEmbeddedDialog(DIALOG_OPTIONS_RESET);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var LocalisedLabelFunction:Function;
            var Frm:Form;
            var Heading:FormHeading;
            var Item:FormItem;
            var FreePlayerLimitations:Boolean;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                LocalisedLabelFunction = function (param1:Object) : String
            {
                if (param1.hasOwnProperty("label"))
                {
                    return resourceManager.getString(ConfigurationWidget.BUNDLE, param1.label);
                }
                return String(param1);
            }// end function
            ;
                Frm = new Form();
                Frm.styleName = "optionsConfigurationWidgetRootContainer";
                Heading;
                Item;
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_COMBAT_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_COMBAT_AUTOCHASEOFF");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIAutoChaseOff = new CheckBox();
                this.m_UIAutoChaseOff.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIAutoChaseOff);
                Frm.addChild(Item);
                addChild(Frm);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "INGAMESHOP_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "INGAMESHOP_ASK_BEFORE_BUYING");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIAskBeforeBuying = new CheckBox();
                this.m_UIAskBeforeBuying.addEventListener(Event.CHANGE, this.onValueChange);
                Item.addChild(this.m_UIAskBeforeBuying);
                Frm.addChild(Item);
                addChild(Frm);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "PREMIUM_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "PREMIUM_SHOW_WIDGET");
                Item.percentHeight = NaN;
                Item.percentWidth = 100;
                this.m_UIShowPremiumWidget = new CheckBox();
                this.m_UIShowPremiumWidget.addEventListener(Event.CHANGE, this.onValueChange);
                FreePlayerLimitations;
                if (Tibia.s_GetPremiumManager() != null)
                {
                    FreePlayerLimitations = Tibia.s_GetPremiumManager().freePlayerLimitations;
                }
                this.m_UIShowPremiumWidget.enabled = !FreePlayerLimitations;
                Item.addChild(this.m_UIShowPremiumWidget);
                Frm.addChild(Item);
                addChild(Frm);
                Heading = new FormHeading();
                Heading.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_OPTIONS_RESET_HEADING");
                Heading.percentHeight = NaN;
                Heading.percentWidth = 100;
                Frm.addChild(Heading);
                Item = new FormItem();
                Item.direction = FormItemDirection.VERTICAL;
                Item.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_OPTIONS_RESET_LABEL");
                this.m_UIResetAllOptions = new Button();
                this.m_UIResetAllOptions.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "GENERAL_OPTIONS_RESET");
                this.m_UIResetAllOptions.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                Item.addChild(this.m_UIResetAllOptions);
                Frm.addChild(Item);
                addChild(Frm);
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

        private function onCloseEmbeddedDialog(event:CloseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = event.currentTarget as EmbeddedDialog;
            if (_loc_2.data === DIALOG_OPTIONS_RESET)
            {
                if (event.detail == EmbeddedDialog.YES)
                {
                    this.m_Options.reset();
                    _loc_3 = PopUpBase.getParentPopUp(this) as ConfigurationWidget;
                    if (_loc_3 != null)
                    {
                        _loc_3.options = _loc_3.options;
                    }
                    _loc_4 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                    dispatchEvent(_loc_4);
                }
            }
            return;
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
            if (this.m_Options != null && param1 && this.m_UncommittedValues)
            {
                this.m_Options.combatAutoChaseOff = this.m_UIAutoChaseOff.selected;
                this.m_Options.generalShopShowBuyConfirmation = this.m_UIAskBeforeBuying.selected;
                if (Tibia.s_GetPremiumManager() != null)
                {
                    Tibia.s_GetPremiumManager().showOrHideWidget(this.m_UIShowPremiumWidget.selected);
                }
                this.m_UncommittedValues = false;
            }
            return;
        }// end function

    }
}
