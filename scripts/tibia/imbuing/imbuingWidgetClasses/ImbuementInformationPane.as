package tibia.imbuing.imbuingWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.i18n.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.controls.*;
    import tibia.creatures.statusWidgetClasses.*;
    import tibia.game.*;
    import tibia.imbuing.*;
    import tibia.ingameshop.*;

    public class ImbuementInformationPane extends HBox
    {
        protected var m_UIAstralSourceAmountWidgets:Vector.<AstralSourceAmountWidget>;
        protected var m_UIImbuementSelection:ComboBox = null;
        protected var m_ImbuementData:ImbuementData;
        private var m_AppearanceTypeID:uint = 0;
        protected var m_UIArrowImageBox:HBox = null;
        protected var m_UIImbueButton:ImbuementButtonWidget;
        private var m_SelectedImbuingSlot:int = -1;
        protected var m_UIPremiumOnly:CustomButton = null;
        protected var m_UIDescriptionLabel:Text = null;
        protected var m_UIProgressBarBox:HBox = null;
        protected var m_UICategorySelection:ComboBox = null;
        protected var m_UILeftTitleLabel:Label = null;
        protected var m_UIRemainingTimeProgress:BitmapProgressBar = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIRightTitleLabel:Label = null;
        protected var m_UITitleLabel:Label = null;
        private var m_UIImbuingItemAppearance:SimpleAppearanceRenderer = null;
        protected var m_UIProtectionCharmButton:ImbuementButtonWidget;
        private var m_CurrentBalance:Number = NaN;
        private var m_UncommittedCurrentCurrency:Boolean = false;
        private var m_UncommittedImbuementData:Boolean = false;
        protected var m_ExistingImbuement:ExistingImbuement = null;
        protected var m_UIAstralSourcesBox:HBox = null;
        private var m_PlayerIsPremium:Boolean = false;
        private var m_TooltipUIElements:Vector.<UIComponent>;
        protected var m_UISuccessRate:Label = null;
        private static const BUNDLE:String = "ImbuingWidget";
        public static const ICON_ARROW:BitmapData = Bitmap(new ICON_ARROW_CLASS()).bitmapData;
        private static const ICON_ARROW_CLASS:Class = ImbuementInformationPane_ICON_ARROW_CLASS;

        public function ImbuementInformationPane()
        {
            this.m_UIAstralSourceAmountWidgets = new Vector.<AstralSourceAmountWidget>;
            this.m_ImbuementData = new ImbuementData(uint.MAX_VALUE, "");
            this.m_TooltipUIElements = new Vector.<UIComponent>;
            return;
        }// end function

        protected function updateEmptySlotImbuingInfos() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = ImbuingManager.getInstance();
            this.m_UITitleLabel.text = resourceManager.getString(BUNDLE, "LBL_IMBUE_EMPTY_SLOT");
            if (this.m_ImbuementData != null)
            {
                _loc_2 = resourceManager.getString(BUNDLE, "LBL_IMBUEMENT_DURATION", [i18nFormatMinutesToCompactDayHourMinutesTimeString(this.m_ImbuementData.durationInSeconds / 60)]);
                this.m_UIDescriptionLabel.text = this.m_ImbuementData.description + "\n" + _loc_2;
                this.m_UIDescriptionLabel.toolTip = this.m_UIDescriptionLabel.text;
                if (this.m_ImbuementData.protectionGoldCost > this.m_CurrentBalance)
                {
                    this.m_UIProtectionCharmButton.button.enabled = false;
                    this.m_UIProtectionCharmButton.currencyView.notEnoughCurrency = true;
                }
                else
                {
                    this.m_UIProtectionCharmButton.button.enabled = true;
                    this.m_UIProtectionCharmButton.currencyView.notEnoughCurrency = false;
                }
                this.m_UIProtectionCharmButton.currencyView.currentCurrency = this.m_ImbuementData.protectionGoldCost;
                _loc_3 = true;
                _loc_4 = 0;
                while (_loc_4 < this.m_UIAstralSourceAmountWidgets.length)
                {
                    
                    if (_loc_4 < this.m_ImbuementData.astralSources.length)
                    {
                        _loc_5 = this.m_ImbuementData.astralSources[_loc_4];
                        _loc_6 = _loc_1.getAvailableAstralSource(_loc_5.apperanceTypeID);
                        _loc_7 = _loc_6 == null ? (0) : (_loc_6.objectCount);
                        if (_loc_7 < _loc_5.objectCount)
                        {
                            _loc_3 = false;
                        }
                        this.m_UIAstralSourceAmountWidgets[_loc_4].refreshData(_loc_5.apperanceTypeID, _loc_7, _loc_5.objectCount);
                    }
                    else
                    {
                        this.m_UIAstralSourceAmountWidgets[_loc_4].clear();
                    }
                    _loc_4 = _loc_4 + 1;
                }
                this.m_UISuccessRate.text = resourceManager.getString(BUNDLE, "SUCCESS_RATE_VALUE", [this.successRatePercent]);
                if (this.successRatePercent == 100)
                {
                    this.m_UISuccessRate.styleName = "successRateHundredPercent";
                }
                else if (this.successRatePercent <= 50)
                {
                    this.m_UISuccessRate.styleName = "successRateBelowTwentyPercent";
                }
                else
                {
                    this.m_UISuccessRate.styleName = "successRate";
                }
                this.m_UIImbueButton.button.enabled = this.m_CurrentBalance >= this.completeGoldCost && _loc_3 && (this.m_ImbuementData.premiumOnly == false || this.m_ImbuementData.premiumOnly == true && this.playerIsPremium);
                this.m_UIImbueButton.currencyView.notEnoughCurrency = this.completeGoldCost > this.m_CurrentBalance;
                this.m_UIImbueButton.currencyView.currentCurrency = this.completeGoldCost;
                this.m_UIPremiumOnly.visible = this.m_ImbuementData.premiumOnly;
                if (this.playerIsPremium)
                {
                    this.m_UIPremiumOnly.styleName = "premiumOnlyPremium";
                    this.m_UIPremiumOnly.selected = true;
                    this.m_UIPremiumOnly.enabled = false;
                }
                else
                {
                    this.m_UIPremiumOnly.styleName = "premiumOnlyNoPremium";
                    this.m_UIPremiumOnly.enabled = true;
                    this.m_UIPremiumOnly.selected = false;
                }
            }
            this.m_UIImbueButton.button.styleName = "applyImbuementButton";
            this.m_UICategorySelection.enabled = true;
            this.m_UIImbuementSelection.enabled = true;
            this.m_UILeftTitleLabel.text = resourceManager.getString(BUNDLE, "REQUIRES_THESE_MATERIALS");
            this.m_UIRightTitleLabel.text = resourceManager.getString(BUNDLE, "SUCCESS_RATE");
            this.m_UISuccessRate.visible = true;
            this.m_UISuccessRate.includeInLayout = true;
            this.m_UIAstralSourcesBox.visible = true;
            this.m_UIAstralSourcesBox.includeInLayout = true;
            this.m_UIArrowImageBox.visible = true;
            this.m_UIProgressBarBox.visible = !this.m_UIAstralSourcesBox.visible;
            this.m_UIProgressBarBox.includeInLayout = !this.m_UIAstralSourcesBox.includeInLayout;
            return;
        }// end function

        public function get imbuementData() : ImbuementData
        {
            return this.m_ImbuementData;
        }// end function

        protected function onImbueClicked(event:MouseEvent) : void
        {
            var _loc_2:* = PopUpBase.getCurrent();
            var _loc_3:* = null;
            if (this.isInRemoveImbuementMode == false)
            {
                this.updateEmptySlotImbuingInfos();
            }
            if (this.m_UIImbueButton.button.enabled == false)
            {
                return;
            }
            _loc_3 = new EmbeddedDialog();
            _loc_3.width = ImbuingWidget.EMBEDDED_DIALOG_WIDTH;
            _loc_3.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            if (this.isInRemoveImbuementMode)
            {
                _loc_3.title = resourceManager.getString(BUNDLE, "MESSAGE_CONFIRM_CLEARING_TITLE");
                _loc_3.text = resourceManager.getString(BUNDLE, "MESSAGE_CONFIRM_CLEARING_TEXT", [this.completeGoldCost, this.m_ExistingImbuement.imbuementData.name]);
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onConfirmClearing, false, EventPriority.DEFAULT, true);
            }
            else
            {
                _loc_3.title = resourceManager.getString(BUNDLE, "MESSAGE_CONFIRM_IMBUING_TITLE");
                _loc_3.text = resourceManager.getString(BUNDLE, "MESSAGE_CONFIRM_IMBUING_TEXT", [this.m_ImbuementData.name, this.successRatePercent, this.completeGoldCost]);
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onConfirmImbuing, false, EventPriority.DEFAULT, true);
            }
            if (_loc_2 != null)
            {
                _loc_2.embeddedDialog = _loc_3;
            }
            this.m_UncommittedImbuementData = true;
            invalidateProperties();
            return;
        }// end function

        public function get selectedImbuingSlot() : int
        {
            return this.m_SelectedImbuingSlot;
        }// end function

        protected function onProtectionCharmClicked(event:MouseEvent) : void
        {
            this.m_UncommittedImbuementData = true;
            invalidateProperties();
            return;
        }// end function

        public function refreshAvailableImbuements() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_ExistingImbuement == null || this.m_ExistingImbuement.empty)
            {
                _loc_1 = ImbuingManager.getInstance();
                _loc_2 = _loc_1.imbuementCategories;
                _loc_3 = [];
                for each (_loc_4 in _loc_2)
                {
                    
                    _loc_3.push({value:_loc_4, label:_loc_4});
                }
                this.m_UICategorySelection.dataProvider = _loc_3;
                if (this.m_ImbuementData != null)
                {
                    this.selectItemInComboBoxes(this.m_ImbuementData);
                }
                else
                {
                    this.updateImbuementsForCategory(_loc_2[0]);
                    this.updateViewWithSelectedImbuement();
                }
            }
            else
            {
                this.m_UICategorySelection.dataProvider = [{value:this.m_ExistingImbuement.imbuementData.category, label:this.m_ExistingImbuement.imbuementData.category}];
                this.m_UIImbuementSelection.dataProvider = [{value:this.m_ExistingImbuement.imbuementData.imbuementID, label:this.m_ExistingImbuement.imbuementData.name}];
            }
            return;
        }// end function

        public function sendTooltipEvent(param1:String) : void
        {
            var _loc_2:* = null;
            if (param1 != null && param1.length > 0)
            {
                _loc_2 = new ExtendedTooltipEvent(ExtendedTooltipEvent.SHOW, true, false, param1);
                dispatchEvent(_loc_2);
            }
            else
            {
                _loc_2 = new ExtendedTooltipEvent(ExtendedTooltipEvent.HIDE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function onConfirmClearing(event:CloseEvent) : void
        {
            if (event.detail == EmbeddedDialog.YES)
            {
                Tibia.s_GetCommunication().sendCAPPLYCLEARINGCHARM(this.m_SelectedImbuingSlot);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            super.createChildren();
            if (!this.m_UIConstructed)
            {
                _loc_1 = new VBox();
                _loc_1.percentWidth = 100;
                _loc_1.percentHeight = 100;
                this.m_UITitleLabel = new Label();
                _loc_1.addChild(this.m_UITitleLabel);
                _loc_2 = new HBox();
                _loc_2.percentWidth = 100;
                _loc_2.height = 30;
                this.m_UICategorySelection = new ComboBox();
                this.m_UICategorySelection.percentWidth = 50;
                this.m_UICategorySelection.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UICategorySelection.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIImbuementSelection = new ComboBox();
                this.m_UIImbuementSelection.percentWidth = 50;
                _loc_2.addChild(this.m_UICategorySelection);
                _loc_2.addChild(this.m_UIImbuementSelection);
                _loc_1.addChild(_loc_2);
                _loc_3 = new HBox();
                _loc_3.percentWidth = 100;
                this.m_UIDescriptionLabel = new Text();
                _loc_3.addChild(this.m_UIDescriptionLabel);
                this.m_UIDescriptionLabel.percentWidth = 100;
                _loc_4 = this.m_UIDescriptionLabel.getLineMetrics(0);
                this.m_UIDescriptionLabel.height = _loc_4.height * 3;
                this.m_UIDescriptionLabel.truncateToFit = true;
                this.m_UIPremiumOnly = new CustomButton();
                this.m_UIPremiumOnly.width = 128;
                this.m_UIPremiumOnly.height = 38;
                this.m_UIPremiumOnly.label = resourceManager.getString(BUNDLE, "PREMIUM_ONLY");
                _loc_3.addChild(this.m_UIPremiumOnly);
                _loc_1.addChild(_loc_3);
                _loc_5 = new HBox();
                _loc_5.percentWidth = 100;
                this.m_UILeftTitleLabel = new Label();
                _loc_5.addChild(this.m_UILeftTitleLabel);
                _loc_6 = new HBox();
                _loc_6.percentWidth = 100;
                this.m_UIRightTitleLabel = new Label();
                _loc_6.addChild(this.m_UIRightTitleLabel);
                this.m_UISuccessRate = new Label();
                this.m_UISuccessRate.width = 40;
                _loc_6.addChild(this.m_UISuccessRate);
                _loc_5.addChild(_loc_6);
                _loc_1.addChild(_loc_5);
                _loc_7 = new HBox();
                _loc_7.percentWidth = 100;
                this.m_UIAstralSourcesBox = new HBox();
                this.m_UIAstralSourcesBox.percentWidth = 100;
                _loc_8 = 0;
                while (_loc_8 < 3)
                {
                    
                    _loc_11 = new AstralSourceAmountWidget();
                    _loc_11.clear();
                    this.m_UIAstralSourceAmountWidgets.push(_loc_11);
                    this.m_UIAstralSourcesBox.addChild(_loc_11);
                    _loc_8 = _loc_8 + 1;
                }
                this.m_UIProtectionCharmButton = new ImbuementButtonWidget();
                this.m_UIProtectionCharmButton.width = 70 + 2;
                this.m_UIProtectionCharmButton.percentHeight = 100;
                this.m_UIProtectionCharmButton.button.toggle = true;
                this.m_UIAstralSourcesBox.addChild(this.m_UIProtectionCharmButton);
                this.m_UIArrowImageBox = new HBox();
                this.m_UIArrowImageBox.percentHeight = 100;
                this.m_UIArrowImageBox.percentWidth = 100;
                _loc_9 = new Image();
                _loc_9.addChild(new Bitmap(ICON_ARROW));
                _loc_9.width = ICON_ARROW.width;
                _loc_9.height = ICON_ARROW.height;
                this.m_UIArrowImageBox.addChild(_loc_9);
                this.m_UIProgressBarBox = new HBox();
                this.m_UIRemainingTimeProgress = new BitmapProgressBar();
                this.m_UIRemainingTimeProgress.percentWidth = 100;
                this.m_UIRemainingTimeProgress.labelEnabled = true;
                this.m_UIProgressBarBox.addChild(this.m_UIRemainingTimeProgress);
                this.m_UIImbueButton = new ImbuementButtonWidget();
                this.m_UIImbueButton.width = this.m_UIPremiumOnly.width;
                this.m_UIImbueButton.percentHeight = 100;
                this.m_UIImbueButton.currencyView.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_GOLD_COIN;
                _loc_7.addChild(this.m_UIAstralSourcesBox);
                _loc_7.addChild(this.m_UIProgressBarBox);
                _loc_7.addChild(this.m_UIArrowImageBox);
                _loc_7.addChild(this.m_UIImbueButton);
                _loc_1.addChild(_loc_7);
                addChild(_loc_1);
                this.m_UIImbuementSelection.addEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UIImbuementSelection.addEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIProtectionCharmButton.addEventListener(MouseEvent.CLICK, this.onProtectionCharmClicked);
                this.m_UIImbueButton.addEventListener(MouseEvent.CLICK, this.onImbueClicked);
                this.m_UIPremiumOnly.addEventListener(MouseEvent.CLICK, this.onPremiumOnlyButtonClicked);
                this.m_TooltipUIElements.push(this.m_UIImbueButton, this.m_UIRemainingTimeProgress, this.m_UIProtectionCharmButton, this.m_UIPremiumOnly);
                this.m_TooltipUIElements = this.m_TooltipUIElements.concat(this.m_UIAstralSourceAmountWidgets);
                for each (_loc_10 in this.m_TooltipUIElements)
                {
                    
                    _loc_10.addEventListener(MouseEvent.MOUSE_OVER, this.onTooltipMouseEvent);
                    _loc_10.addEventListener(MouseEvent.MOUSE_OUT, this.onTooltipMouseEvent);
                }
                _loc_1.styleName = "imbuingItemInformationBox";
                this.m_UITitleLabel.styleName = "headerLabel";
                this.m_UIRemainingTimeProgress.styleName = "imbuingDuration";
                this.m_UIProgressBarBox.styleName = "progressBarBox";
                this.m_UIAstralSourcesBox.styleName = "astralSourcesArrowBox";
                this.m_UIProtectionCharmButton.button.styleName = "protectionCharmButton";
                this.m_UIArrowImageBox.styleName = "astralSourcesArrowBox";
                this.m_UILeftTitleLabel.styleName = "headerLabel";
                this.m_UIRightTitleLabel.styleName = "headerLabel";
                _loc_6.styleName = "successRateBox";
                styleName = "sectionBorder";
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:* = null;
            if (this.m_UIConstructed)
            {
                this.m_UIImbuementSelection.removeEventListener(DropdownEvent.CLOSE, this.onComboBoxChange);
                this.m_UIImbuementSelection.removeEventListener(ListEvent.CHANGE, this.onComboBoxChange);
                this.m_UIProtectionCharmButton.removeEventListener(MouseEvent.CLICK, this.onProtectionCharmClicked);
                for each (_loc_1 in this.m_TooltipUIElements)
                {
                    
                    _loc_1.removeEventListener(MouseEvent.MOUSE_OVER, this.onTooltipMouseEvent);
                    _loc_1.removeEventListener(MouseEvent.MOUSE_OUT, this.onTooltipMouseEvent);
                }
            }
            return;
        }// end function

        public function set selectedImbuingSlot(param1:int) : void
        {
            this.m_SelectedImbuingSlot = param1;
            return;
        }// end function

        protected function onComboBoxChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = -1;
                _loc_3 = null;
                switch(event.currentTarget)
                {
                    case this.m_UICategorySelection:
                    {
                        this.updateImbuementsForCategory(this.m_UICategorySelection.selectedLabel);
                        break;
                    }
                    case this.m_UIImbuementSelection:
                    {
                        this.updateViewWithSelectedImbuement();
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

        protected function get completeGoldCost() : uint
        {
            var _loc_1:* = 0;
            if (this.isInRemoveImbuementMode)
            {
                return this.m_ExistingImbuement.clearingGoldCost;
            }
            _loc_1 = this.m_ImbuementData.goldCost;
            if (this.useProtectionCharm)
            {
                _loc_1 = _loc_1 + this.m_ImbuementData.protectionGoldCost;
            }
            return _loc_1;
        }// end function

        public function selectItemInComboBoxes(param1:ImbuementData) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this.m_UICategorySelection.dataProvider)
            {
                
                if (_loc_2.value == param1.category)
                {
                    this.m_UICategorySelection.selectedItem = _loc_2;
                    for each (_loc_3 in this.m_UIImbuementSelection.dataProvider)
                    {
                        
                        if (_loc_3.value == param1.imbuementID)
                        {
                            this.m_UIImbuementSelection.selectedItem = _loc_3;
                        }
                    }
                }
            }
            return;
        }// end function

        public function get currentBalance() : Number
        {
            return this.m_CurrentBalance;
        }// end function

        protected function updateViewWithSelectedImbuement() : void
        {
            var _loc_1:* = ImbuingManager.getInstance();
            if (this.m_UIImbuementSelection.selectedItem != null)
            {
                this.m_ImbuementData = _loc_1.getAvailableImbuementWithID(uint(this.m_UIImbuementSelection.selectedItem.value));
                this.m_UIProtectionCharmButton.button.selected = false;
                this.m_UncommittedImbuementData = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onPremiumOnlyButtonClicked(event:MouseEvent) : void
        {
            IngameShopManager.getInstance().openShopWindow(true, IngameShopProduct.SERVICE_TYPE_PREMIUM);
            return;
        }// end function

        public function set currentBalance(param1:Number) : void
        {
            if (param1 != this.m_CurrentBalance)
            {
                this.m_CurrentBalance = param1;
                this.m_UncommittedImbuementData = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function onTooltipMouseEvent(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_2:* = ImbuingManager.getInstance();
            if (event.type == MouseEvent.MOUSE_OUT)
            {
                this.sendTooltipEvent(null);
            }
            else if (event.type == MouseEvent.MOUSE_OVER)
            {
                _loc_3 = 0;
                while (_loc_3 < this.m_UIAstralSourceAmountWidgets.length)
                {
                    
                    if (event.currentTarget == this.m_UIAstralSourceAmountWidgets[_loc_3])
                    {
                        if (_loc_3 < this.m_ImbuementData.astralSources.length)
                        {
                            _loc_4 = this.m_ImbuementData.astralSources[_loc_3];
                            _loc_5 = _loc_2.getAvailableAstralSource(_loc_4.apperanceTypeID);
                            _loc_6 = _loc_5 == null ? (0) : (_loc_5.objectCount);
                            if (_loc_6 < _loc_4.objectCount)
                            {
                                this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_IMBUEMENT_RESOURCE_UNAVAILABLE", [_loc_4.name]));
                            }
                            else
                            {
                                this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_IMBUEMENT_RESOURCE_AVAILABLE", [_loc_4.name]));
                            }
                        }
                        else
                        {
                            this.sendTooltipEvent(null);
                        }
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                switch(event.currentTarget)
                {
                    case this.m_UIImbueButton:
                    {
                        if (this.isInRemoveImbuementMode)
                        {
                            this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_REMOVE_IMBUEMENT"));
                        }
                        else
                        {
                            this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_APPLY_IMBUEMENT"));
                        }
                        break;
                    }
                    case this.m_UIRemainingTimeProgress:
                    {
                        this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_REMAINING_TIME"));
                        break;
                    }
                    case this.m_UIProtectionCharmButton:
                    {
                        this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_PROTECTION_CHARM"));
                        break;
                    }
                    case this.m_UIPremiumOnly:
                    {
                        if (this.playerIsPremium)
                        {
                            this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_PREMIUM_AVAILABLE"));
                        }
                        else
                        {
                            this.sendTooltipEvent(resourceManager.getString(BUNDLE, "TOOLTIP_PREMIUM_ONLY"));
                        }
                        break;
                    }
                    default:
                    {
                        this.sendTooltipEvent(null);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function set existingImbuement(param1:ExistingImbuement) : void
        {
            if (param1 != this.m_ExistingImbuement)
            {
                this.m_ExistingImbuement = param1;
                this.m_ImbuementData = this.m_ExistingImbuement.imbuementData;
                this.m_UncommittedImbuementData = true;
                invalidateProperties();
                this.refreshAvailableImbuements();
            }
            return;
        }// end function

        protected function updateImbuementsForCategory(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            _loc_2 = ImbuingManager.getInstance();
            var _loc_3:* = _loc_2.getImbuementsForCategory(param1);
            var _loc_4:* = [];
            for each (_loc_5 in _loc_3)
            {
                
                _loc_6 = _loc_5.name;
                if (_loc_5.premiumOnly)
                {
                    _loc_6 = _loc_6 + resourceManager.getString(BUNDLE, "PREMIUM_IMBUEMENT_POSTFIX");
                }
                _loc_4.push({value:_loc_5.imbuementID, label:_loc_6});
            }
            this.m_UIImbuementSelection.dataProvider = _loc_4;
            this.updateViewWithSelectedImbuement();
            return;
        }// end function

        public function set playerIsPremium(param1:Boolean) : void
        {
            if (param1 != this.m_PlayerIsPremium)
            {
                this.m_PlayerIsPremium = param1;
                this.m_UncommittedImbuementData = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function get successRatePercent() : uint
        {
            if (this.isInRemoveImbuementMode)
            {
                return 100;
            }
            if (this.useProtectionCharm)
            {
                return 100;
            }
            return this.m_ImbuementData.successRatePercent;
        }// end function

        protected function get isInRemoveImbuementMode() : Boolean
        {
            if (this.m_ExistingImbuement == null || this.m_ExistingImbuement.empty)
            {
                return false;
            }
            return true;
        }// end function

        public function get existingImbuement() : ExistingImbuement
        {
            return this.m_ExistingImbuement;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedImbuementData)
            {
                if (this.m_ExistingImbuement == null || this.m_ExistingImbuement.imbuementData == null)
                {
                    this.updateEmptySlotImbuingInfos();
                }
                else
                {
                    this.updateImbuedSlotImbuingInfos();
                }
            }
            if (this.m_UncommittedCurrentCurrency)
            {
                this.m_UncommittedCurrentCurrency = false;
            }
            return;
        }// end function

        private function onConfirmImbuing(event:CloseEvent) : void
        {
            if (event.detail == EmbeddedDialog.YES)
            {
                Tibia.s_GetCommunication().sendCAPPLYIMBUEMENT(this.m_SelectedImbuingSlot, this.m_ImbuementData.imbuementID, this.useProtectionCharm);
            }
            return;
        }// end function

        public function set imbuementData(param1:ImbuementData) : void
        {
            if (param1 != this.m_ImbuementData)
            {
                this.m_ImbuementData = param1;
                this.m_UncommittedImbuementData = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get playerIsPremium() : Boolean
        {
            return this.m_PlayerIsPremium;
        }// end function

        protected function updateImbuedSlotImbuingInfos() : void
        {
            var _loc_1:* = ImbuingManager.getInstance();
            this.m_UITitleLabel.text = resourceManager.getString(BUNDLE, "LBL_CLEAR_IMBUED_SLOT", [this.m_ExistingImbuement.imbuementData.name]);
            var _loc_2:* = resourceManager.getString(BUNDLE, "LBL_IMBUEMENT_DURATION", [i18nFormatMinutesToCompactDayHourMinutesTimeString(this.m_ExistingImbuement.imbuementData.durationInSeconds / 60)]);
            this.m_UIDescriptionLabel.text = this.m_ExistingImbuement.imbuementData.description + "\n" + _loc_2;
            this.m_UIDescriptionLabel.toolTip = this.m_UIDescriptionLabel.text;
            this.m_UIPremiumOnly.visible = false;
            this.m_UICategorySelection.enabled = false;
            this.m_UIImbuementSelection.enabled = false;
            this.m_UIImbueButton.currencyView.currentCurrency = this.m_ExistingImbuement.clearingGoldCost;
            if (this.m_UIImbueButton.currencyView.currentCurrency > this.m_CurrentBalance)
            {
                this.m_UIImbueButton.currencyView.notEnoughCurrency = true;
                this.m_UIImbueButton.button.enabled = false;
            }
            else
            {
                this.m_UIImbueButton.currencyView.notEnoughCurrency = false;
                this.m_UIImbueButton.button.enabled = true;
            }
            this.m_UIImbueButton.button.styleName = "removeImbuementButton";
            this.m_UILeftTitleLabel.text = resourceManager.getString(BUNDLE, "TIME_REMAINING");
            this.m_UIRightTitleLabel.text = resourceManager.getString(BUNDLE, "REMOVE_IMBUEMENT");
            this.m_UISuccessRate.visible = false;
            this.m_UISuccessRate.includeInLayout = false;
            this.m_UIAstralSourcesBox.visible = false;
            this.m_UIAstralSourcesBox.includeInLayout = false;
            this.m_UIArrowImageBox.visible = false;
            this.m_UIProgressBarBox.visible = !this.m_UIAstralSourcesBox.visible;
            this.m_UIProgressBarBox.includeInLayout = !this.m_UIAstralSourcesBox.includeInLayout;
            this.m_UIProgressBarBox.height = this.m_UIAstralSourcesBox.height;
            this.m_UIProgressBarBox.width = this.m_UIAstralSourcesBox.width;
            this.m_UIRemainingTimeProgress.maxValue = this.m_ExistingImbuement.imbuementData.durationInSeconds;
            this.m_UIRemainingTimeProgress.value = this.m_ExistingImbuement.remainingDurationInSeconds;
            this.m_UIRemainingTimeProgress.labelFormat = i18nFormatMinutesToCompactDayHourMinutesTimeString(this.m_ExistingImbuement.remainingDurationInSeconds / 60);
            return;
        }// end function

        protected function get useProtectionCharm() : Boolean
        {
            if (this.m_UIProtectionCharmButton)
            {
                return this.m_UIProtectionCharmButton.button.selected;
            }
            return false;
        }// end function

    }
}
