package tibia.ingameshop.shopWidgetClasses
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.controls.dataGridClasses.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;

    public class TransactionHistory extends CustomDataGrid implements IIngameShopWidgetComponent
    {
        private var m_UncommittedHistory:Boolean = false;
        private var m_UINextButton:Button;
        private var m_UIPreviousButton:Button;
        private var m_DisplayMode:int = 0;
        private var m_HistoryData:ArrayCollection;
        private var m_ShopWindow:IngameShopWidget;
        private var m_UncommittedDisplayMode:Boolean = true;
        private var m_UncommittedButtons:Boolean = false;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const DISPLAY_MODE_ERROR:int = 1;
        private static const HISTORY_ENTRIES_PER_PAGE:int = 13;
        private static const DISPLAY_MODE_REGULAR:int = 0;

        public function TransactionHistory()
        {
            showDataTips = true;
            variableRowHeight = false;
            this.m_HistoryData = new ArrayCollection();
            var _loc_1:* = new DataGridColumn(resourceManager.getString(BUNDLE, "COL_DATE"));
            _loc_1.dataField = "timestamp";
            _loc_1.itemRenderer = new ClassFactory(DateRenderer);
            _loc_1.width = 50;
            var _loc_2:* = new DataGridColumn(resourceManager.getString(BUNDLE, "COL_BALANCE"));
            _loc_2.dataField = "creditChange";
            _loc_2.itemRenderer = new ClassFactory(CreditsRenderer);
            _loc_2.width = 42;
            var _loc_3:* = new DataGridColumn(resourceManager.getString(BUNDLE, "COL_PRODUCT"));
            _loc_3.dataField = "transactionName";
            _loc_3.dataTipField = "transactionName";
            var _loc_4:* = new DataGridColumn(resourceManager.getString(BUNDLE, "COL_ERROR"));
            _loc_4.dataField = "transactionName";
            _loc_3.dataTipField = "transactionName";
            _loc_4.visible = false;
            _loc_4.wordWrap = true;
            columns = [_loc_1, _loc_2, _loc_3, _loc_4];
            dataProvider = this.m_HistoryData;
            resizableColumns = false;
            draggableColumns = false;
            sortableColumns = false;
            editable = false;
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.HISTORY_CHANGED, this.onHistoryChanged);
            return;
        }// end function

        protected function get displayMode() : int
        {
            return this.m_DisplayMode;
        }// end function

        protected function set displayMode(param1:int) : void
        {
            if (param1 != this.m_DisplayMode)
            {
                this.m_DisplayMode = param1;
                this.m_UncommittedDisplayMode = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set shopWidget(param1:IngameShopWidget) : void
        {
            if (this.m_ShopWindow != null)
            {
                throw new IllegalOperationError("IngameShopOfferList.shopWidget: Attempted to set reference twice");
            }
            this.m_ShopWindow = param1;
            return;
        }// end function

        protected function onHistoryChanged(event:IngameShopEvent) : void
        {
            this.displayMode = DISPLAY_MODE_REGULAR;
            this.m_UncommittedHistory = true;
            this.m_UncommittedButtons = true;
            invalidateProperties();
            return;
        }// end function

        public function refreshTransactionHistory() : void
        {
            IngameShopManager.getInstance().refreshTransactionHistory(TransactionHistory.HISTORY_ENTRIES_PER_PAGE);
            return;
        }// end function

        protected function onNextClicked(event:MouseEvent) : void
        {
            var _loc_2:* = IngameShopManager.getInstance().getHistoryPage() + 1;
            IngameShopManager.getInstance().pageTransactionHistory(_loc_2, TransactionHistory.HISTORY_ENTRIES_PER_PAGE);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = false;
            super.commitProperties();
            if (this.m_UncommittedHistory)
            {
                _loc_1 = IngameShopManager.getInstance().getHistory();
                _loc_2 = new Array();
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_2.push(_loc_1[_loc_3]);
                    _loc_3++;
                }
                this.m_HistoryData.source = _loc_2;
                this.m_HistoryData.refresh();
                this.m_UncommittedHistory = false;
            }
            if (this.m_UncommittedButtons)
            {
                _loc_4 = IngameShopManager.getInstance().getHistoryPage() > 0;
                _loc_5 = IngameShopManager.getInstance().canRequestNextHistoryPage();
                if (this.m_UINextButton != null)
                {
                    this.m_UINextButton.enabled = _loc_5;
                }
                if (this.m_UIPreviousButton != null)
                {
                    this.m_UIPreviousButton.enabled = _loc_4;
                }
                this.m_UncommittedButtons = false;
            }
            if (this.m_UncommittedDisplayMode)
            {
                variableRowHeight = this.displayMode == DISPLAY_MODE_ERROR;
                _loc_3 = 0;
                while (_loc_3 < columns.length)
                {
                    
                    _loc_6 = _loc_3 == (columns.length - 1);
                    columns[_loc_3].visible = this.displayMode == DISPLAY_MODE_ERROR ? (_loc_6) : (!_loc_6);
                    _loc_3++;
                }
                this.m_UncommittedDisplayMode = false;
            }
            return;
        }// end function

        public function setControlledButton(param1:Button, param2:Button) : void
        {
            if (this.m_UIPreviousButton != null)
            {
                this.m_UIPreviousButton.removeEventListener(MouseEvent.CLICK, this.onPreviousClicked);
            }
            if (this.m_UINextButton != null)
            {
                this.m_UINextButton.removeEventListener(MouseEvent.CLICK, this.onNextClicked);
            }
            this.m_UIPreviousButton = param1;
            this.m_UINextButton = param2;
            if (this.m_UIPreviousButton != null)
            {
                this.m_UIPreviousButton.addEventListener(MouseEvent.CLICK, this.onPreviousClicked);
            }
            if (this.m_UINextButton != null)
            {
                this.m_UINextButton.addEventListener(MouseEvent.CLICK, this.onNextClicked);
            }
            this.m_UncommittedButtons = true;
            invalidateProperties();
            return;
        }// end function

        protected function onPreviousClicked(event:MouseEvent) : void
        {
            var _loc_2:* = Math.max(0, (IngameShopManager.getInstance().getHistoryPage() - 1));
            IngameShopManager.getInstance().pageTransactionHistory(_loc_2, TransactionHistory.HISTORY_ENTRIES_PER_PAGE);
            return;
        }// end function

        public function dispose() : void
        {
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.HISTORY_CHANGED, this.onHistoryChanged);
            this.m_ShopWindow = null;
            return;
        }// end function

        public function displayTransactionHistoryError(param1:String) : void
        {
            this.displayMode = DISPLAY_MODE_ERROR;
            var _loc_2:* = new Array();
            _loc_2.push(new IngameShopHistoryEntry(0, 0, 0, param1));
            this.m_HistoryData.source = _loc_2;
            this.m_HistoryData.refresh();
            return;
        }// end function

    }
}
