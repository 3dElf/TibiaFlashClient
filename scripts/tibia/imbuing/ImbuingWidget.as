package tibia.imbuing
{
    import __AS3__.vec.*;
    import flash.text.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import shared.utility.i18n.*;
    import tibia.controls.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.imbuing.imbuingWidgetClasses.*;

    public class ImbuingWidget extends PopUpBase
    {
        private var m_UncommittedPlayer:Boolean = false;
        private var m_Player:Player = null;
        private var m_UIGoldBalance:TibiaCurrencyView = null;
        private var m_UIItemInformationPane:ItemInformationPane = null;
        private var m_UncommittedPlayerData:Boolean = false;
        private var m_UIHintLabel:Text = null;
        private var m_UncomittedImbuementData:Boolean = false;
        private var m_UIImbuementInformationPane:ImbuementInformationPane = null;
        private var m_UIConstructed:Boolean = false;
        private static var s_CurrentInstance:ImbuingWidget = null;
        private static const BUNDLE:String = "ImbuingWidget";
        public static const EMBEDDED_DIALOG_WIDTH:int = 380;

        public function ImbuingWidget()
        {
            height = 518;
            width = 600;
            title = resourceManager.getString(BUNDLE, "TITLE");
            buttonFlags = PopUpBase.BUTTON_CLOSE;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            stretchEmbeddedDialog = false;
            this.player = Tibia.s_GetPlayer();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            ImbuingManager.getInstance().removeEventListener(ImbuingEvent.IMBUEMENT_DATA_CHANGED, this.onImbuementDataChanged);
            if (this.m_UIConstructed)
            {
                this.m_UIItemInformationPane.removeEventListener(ImbuingEvent.IMBUEMENT_SLOT_SELECTED, this.onImbuementSlotSelected);
                this.m_UIItemInformationPane.removeEventListener(ExtendedTooltipEvent.SHOW, this.onExtendedTooltipEvent);
                this.m_UIItemInformationPane.removeEventListener(ExtendedTooltipEvent.HIDE, this.onExtendedTooltipEvent);
                this.m_UIImbuementInformationPane.removeEventListener(ExtendedTooltipEvent.SHOW, this.onExtendedTooltipEvent);
                this.m_UIImbuementInformationPane.removeEventListener(ExtendedTooltipEvent.HIDE, this.onExtendedTooltipEvent);
                this.m_UIItemInformationPane.dispose();
                this.m_UIImbuementInformationPane.dispose();
            }
            Tibia.s_GetCommunication().sendCCLOSEDIMBUINGDIALOG();
            s_CurrentInstance = null;
            return;
        }// end function

        public function set player(param1:Player) : void
        {
            if (this.m_Player != param1)
            {
                if (this.m_Player != null)
                {
                    this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
                this.m_Player = param1;
                this.m_UncommittedPlayerData = true;
                invalidateProperties();
                if (this.m_Player != null)
                {
                    this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerChange);
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.commitProperties();
            if (this.m_UncomittedImbuementData)
            {
                this.m_UIItemInformationPane.apperanceTypeID = ImbuingManager.getInstance().apperanceTypeID;
                this.m_UIItemInformationPane.selectedImbuingSlot = 0;
                this.onImbuementSlotSelected(null);
                this.m_UncomittedImbuementData = false;
            }
            if (this.m_UncommittedPlayerData)
            {
                _loc_1 = NaN;
                _loc_2 = false;
                if (this.m_Player != null)
                {
                    _loc_1 = this.m_Player.bankGoldBalance + this.m_Player.inventoryGoldBalance;
                    _loc_2 = this.m_Player.premium;
                    if (this.m_UIGoldBalance)
                    {
                        this.m_UIGoldBalance.baseCurrency = NaN;
                        this.m_UIGoldBalance.currentCurrency = _loc_1;
                        _loc_3 = i18nFormatNumber(this.m_Player.inventoryGoldBalance);
                        _loc_4 = i18nFormatNumber(this.m_Player.bankGoldBalance);
                        this.m_UIGoldBalance.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_GOLD_BALANCE", [_loc_3, _loc_4]);
                    }
                }
                this.m_UIImbuementInformationPane.currentBalance = _loc_1;
                this.m_UIImbuementInformationPane.playerIsPremium = _loc_2;
                this.m_UncommittedPlayerData = false;
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
                this.m_UIItemInformationPane = new ItemInformationPane();
                this.m_UIItemInformationPane.percentWidth = 100;
                addChild(this.m_UIItemInformationPane);
                this.m_UIItemInformationPane.selectedImbuingSlot = 0;
                this.m_UIImbuementInformationPane = new ImbuementInformationPane();
                this.m_UIImbuementInformationPane.percentWidth = 100;
                this.m_UIImbuementInformationPane.percentHeight = 100;
                addChild(this.m_UIImbuementInformationPane);
                _loc_1 = new HBox();
                _loc_1.percentWidth = 100;
                this.m_UIHintLabel = new Text();
                this.m_UIHintLabel.percentWidth = 100;
                _loc_1.addChild(this.m_UIHintLabel);
                addChild(_loc_1);
                this.m_UIGoldBalance = new TibiaCurrencyView();
                this.m_UIGoldBalance.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_GOLD_COIN;
                this.m_UIGoldBalance.width = 200;
                addChild(this.m_UIGoldBalance);
                _loc_1.styleName = "hintBox";
                _loc_2 = this.m_UIHintLabel.getLineMetrics(0);
                this.m_UIHintLabel.height = _loc_2.height * 3;
                ImbuingManager.getInstance().addEventListener(ImbuingEvent.IMBUEMENT_DATA_CHANGED, this.onImbuementDataChanged);
                this.m_UIItemInformationPane.addEventListener(ImbuingEvent.IMBUEMENT_SLOT_SELECTED, this.onImbuementSlotSelected);
                this.m_UIItemInformationPane.addEventListener(ExtendedTooltipEvent.SHOW, this.onExtendedTooltipEvent);
                this.m_UIItemInformationPane.addEventListener(ExtendedTooltipEvent.HIDE, this.onExtendedTooltipEvent);
                this.m_UIImbuementInformationPane.addEventListener(ExtendedTooltipEvent.SHOW, this.onExtendedTooltipEvent);
                this.m_UIImbuementInformationPane.addEventListener(ExtendedTooltipEvent.HIDE, this.onExtendedTooltipEvent);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onImbuementDataChanged(event:ImbuingEvent) : void
        {
            var _loc_2:* = null;
            var _loc_5:* = null;
            _loc_2 = ImbuingManager.getInstance();
            this.m_UIItemInformationPane.apperanceTypeID = _loc_2.apperanceTypeID;
            var _loc_3:* = _loc_2.existingImbuements;
            var _loc_4:* = new Vector.<int>;
            for each (_loc_5 in _loc_2.existingImbuements)
            {
                
                if (_loc_5.empty)
                {
                    _loc_4.push(ImbuementSlotWidget.IMBUING_IMAGE_EMPTY);
                    continue;
                }
                _loc_4.push(_loc_5.imbuementData.iconID);
            }
            this.m_UIItemInformationPane.imbuingSlotImages = _loc_4;
            this.onImbuementSlotSelected(null);
            return;
        }// end function

        public function get player() : Player
        {
            return this.m_Player;
        }// end function

        protected function onImbuementSlotSelected(event:ImbuingEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = ImbuingManager.getInstance();
            var _loc_3:* = this.m_UIItemInformationPane.selectedImbuingSlot;
            if (_loc_3 > -1)
            {
                _loc_4 = _loc_2.existingImbuements;
                if (_loc_3 < _loc_4.length)
                {
                    this.m_UIImbuementInformationPane.existingImbuement = _loc_4[_loc_3];
                }
                else
                {
                    this.m_UIImbuementInformationPane.existingImbuement = null;
                }
            }
            this.m_UIImbuementInformationPane.selectedImbuingSlot = _loc_3;
            return;
        }// end function

        protected function onExtendedTooltipEvent(event:ExtendedTooltipEvent) : void
        {
            if (event.type == ExtendedTooltipEvent.SHOW)
            {
                this.m_UIHintLabel.text = event.tooltip;
            }
            else if (event.type == ExtendedTooltipEvent.HIDE)
            {
                this.m_UIHintLabel.text = "";
            }
            return;
        }// end function

        public function showImbuingResultDialog(param1:String) : void
        {
            var _loc_2:* = new EmbeddedDialog();
            _loc_2.name = "ImbuingDialogResult";
            _loc_2.buttonFlags = PopUpBase.BUTTON_OKAY;
            _loc_2.text = param1;
            _loc_2.title = resourceManager.getString(BUNDLE, "RESULTDIALOG_TITLE");
            _loc_2.width = EMBEDDED_DIALOG_WIDTH;
            embeddedDialog = _loc_2;
            return;
        }// end function

        private function onPlayerChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "bankGoldBalance" || event.property == "inventoryGoldBalance" || event.property == "premium")
            {
                this.m_UncommittedPlayerData = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            s_CurrentInstance = this;
            return;
        }// end function

        public static function s_GetCurrentInstance() : ImbuingWidget
        {
            return s_CurrentInstance;
        }// end function

    }
}
