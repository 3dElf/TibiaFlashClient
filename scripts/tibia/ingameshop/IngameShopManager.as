package tibia.ingameshop
{
    import __AS3__.vec.*;
    import flash.events.*;
    import tibia.network.*;

    final public class IngameShopManager extends EventDispatcher
    {
        private var m_ImageManager:DynamicImageManager;
        private var m_CreditsAreFinal:Boolean = false;
        private var m_CurrentlyFeaturedServiceType:int = 0;
        private var m_Categories:Vector.<IngameShopCategory>;
        private var m_CanRequestNextTransactionHistoryPage:Boolean = false;
        private var m_History:Vector.<IngameShopHistoryEntry>;
        private var m_CreditBalance:Number = NaN;
        private var m_CurrentTransactionHistoryPage:int = 0;
        private var m_ConfirmedCreditBalance:Number = NaN;
        private var m_CreditPackageSize:Number = 25;
        private static var s_Instance:IngameShopManager = null;
        public static const STORE_EVENT_SELECT_OFFER:int = 0;
        public static const TIBIA_COINS_APPEARANCE_TYPE_ID:int = 22118;

        public function IngameShopManager()
        {
            this.m_Categories = new Vector.<IngameShopCategory>;
            this.m_History = new Vector.<IngameShopHistoryEntry>;
            return;
        }// end function

        public function canRequestNextHistoryPage() : Boolean
        {
            return this.m_CanRequestNextTransactionHistoryPage;
        }// end function

        public function purchaseRegularOffer(param1:int) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCBUYPREMIUMOFFER(param1, IngameShopProduct.SERVICE_TYPE_UNKNOWN);
            }
            return;
        }// end function

        private function recursiveSearchOffer(param1:int, param2:Vector.<IngameShopCategory>) : IngameShopOffer
        {
            var OfferList:Vector.<IngameShopOffer>;
            var a_OfferID:* = param1;
            var a_Categories:* = param2;
            OfferList = new Vector.<IngameShopOffer>;
            this.recursiveVisitCategory(a_Categories, function (param1:IngameShopCategory) : void
            {
                var _loc_2:* = 0;
                while (_loc_2 < param1.offers.length)
                {
                    
                    if (param1.offers[_loc_2].offerID == a_OfferID)
                    {
                        OfferList.push(param1.offers[_loc_2]);
                    }
                    _loc_2++;
                }
                return;
            }// end function
            );
            return OfferList.length > 0 ? (OfferList[0]) : (null);
        }// end function

        public function creditsAreFinal() : Boolean
        {
            return this.m_CreditsAreFinal;
        }// end function

        public function pageTransactionHistory(param1:int, param2:int) : void
        {
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCGETTRANSACTIONHISTORY(param1, param2);
            }
            return;
        }// end function

        public function setCreditBalanceUpdating(param1:Boolean) : void
        {
            if (this.m_CreditsAreFinal != param1)
            {
                this.m_CreditsAreFinal = param1;
                dispatchEvent(new IngameShopEvent(IngameShopEvent.CREDIT_BALANCE_CHANGED));
            }
            return;
        }// end function

        public function setupWithServerSettings(param1:String, param2:Number) : void
        {
            var _loc_3:* = param1.length > 0 && param1.charAt((param1.length - 1)) != "/" ? (param1 + "/") : (param1);
            this.m_ImageManager = new DynamicImageManager(_loc_3, "igs-", 60 * 60);
            this.m_CreditPackageSize = param2;
            return;
        }// end function

        public function set currentlyFeaturedServiceType(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 != this.m_CurrentlyFeaturedServiceType)
            {
                this.m_CurrentlyFeaturedServiceType = param1;
                _loc_2 = new IngameShopEvent(IngameShopEvent.CURRENTLY_FEATURED_SERVICE_TYPE_CHANGED);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function refreshTransactionHistory(param1:int) : void
        {
            if (this.getHistory().length > 0)
            {
                this.setHistory(0, false, new Vector.<IngameShopHistoryEntry>);
            }
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCOPENTRANSACTIONHISTORY(param1);
            }
            return;
        }// end function

        private function recursiveVisitCategory(param1:Vector.<IngameShopCategory>, param2:Function) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in param1)
            {
                
                this.param2(_loc_3);
                if (_loc_3.subCategories.length > 0)
                {
                    this.recursiveVisitCategory(_loc_3.subCategories, param2);
                }
            }
            return;
        }// end function

        public function get imageManager() : DynamicImageManager
        {
            return this.m_ImageManager;
        }// end function

        public function getRootCategories() : Vector.<IngameShopCategory>
        {
            return this.m_Categories;
        }// end function

        public function getHistory() : Vector.<IngameShopHistoryEntry>
        {
            return this.m_History;
        }// end function

        public function propagateError(param1:String, param2:int) : void
        {
            var _loc_3:* = new IngameShopEvent(IngameShopEvent.ERROR_RECEIVED);
            _loc_3.errorType = param2;
            _loc_3.message = param1;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function setHistory(param1:int, param2:Boolean, param3:Vector.<IngameShopHistoryEntry>) : void
        {
            this.m_History = param3;
            this.m_CurrentTransactionHistoryPage = param1;
            this.m_CanRequestNextTransactionHistoryPage = param2;
            var _loc_4:* = new IngameShopEvent(IngameShopEvent.HISTORY_CHANGED);
            dispatchEvent(_loc_4);
            return;
        }// end function

        public function purchaseCharacterNameChange(param1:int, param2:String) : void
        {
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCBUYPREMIUMOFFER(param1, IngameShopProduct.SERVICE_TYPE_CHARACTER_NAME_CHANGE, param2);
            }
            return;
        }// end function

        public function getHistoryPage() : int
        {
            return this.m_CurrentTransactionHistoryPage;
        }// end function

        private function recursiveSearchCategory(param1:String, param2:Vector.<IngameShopCategory>) : IngameShopCategory
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_3 in param2)
            {
                
                if (_loc_3.name == param1)
                {
                    return _loc_3;
                }
                if (_loc_3.subCategories.length > 0)
                {
                    _loc_4 = this.recursiveSearchCategory(param1, _loc_3.subCategories);
                    if (_loc_4 != null)
                    {
                        return _loc_4;
                    }
                }
            }
            return null;
        }// end function

        public function setCreditBalance(param1:Number, param2:Number) : void
        {
            if (this.m_CreditBalance != param1)
            {
                this.m_CreditBalance = param1;
                this.m_ConfirmedCreditBalance = param2;
                dispatchEvent(new IngameShopEvent(IngameShopEvent.CREDIT_BALANCE_CHANGED));
            }
            return;
        }// end function

        public function requestNameForNameChange(param1:int) : void
        {
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.NAME_CHANGE_REQUESTED);
            _loc_2.data = param1;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function getCreditBalance() : Number
        {
            return this.m_CreditBalance;
        }// end function

        public function transferCredits(param1:String, param2:Number) : void
        {
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCTRANSFERCURRENCY(param1, param2);
            }
            return;
        }// end function

        public function openShopWindow(param1:Boolean, param2:int, param3:Boolean = false) : void
        {
            var _loc_4:* = Tibia.s_GetCommunication();
            if (param1 && _loc_4 != null && (_loc_4.isGameRunning || param3))
            {
                this.m_Categories.length = 0;
                _loc_4.sendCOPENPREMIUMSHOP(param2, "");
                this.currentlyFeaturedServiceType = IngameShopProduct.SERVICE_TYPE_UNKNOWN;
            }
            else if (!param1)
            {
                if (IngameShopWidget.s_GetCurrentInstance() == null)
                {
                    new IngameShopWidget().show();
                }
            }
            return;
        }// end function

        public function completePurchase(param1:String) : void
        {
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.PURCHASE_COMPLETED);
            _loc_2.message = param1;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function getCategory(param1:String) : IngameShopCategory
        {
            return this.recursiveSearchCategory(param1, this.m_Categories);
        }// end function

        public function getConfirmedCreditBalance() : Number
        {
            return this.m_ConfirmedCreditBalance;
        }// end function

        public function get currentlyFeaturedServiceType() : int
        {
            return this.m_CurrentlyFeaturedServiceType;
        }// end function

        public function getCreditPackageSize() : Number
        {
            return this.m_CreditPackageSize;
        }// end function

        public function addCategory(param1:IngameShopCategory, param2:String) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = this.recursiveSearchCategory(param1.name, this.m_Categories);
            if (_loc_3 != null)
            {
                _loc_3.offers = param1.offers;
            }
            else if (param2 != null && param2.length > 0)
            {
                _loc_4 = this.recursiveSearchCategory(param2, this.m_Categories);
                if (_loc_4 != null)
                {
                    _loc_4.subCategories.push(param1);
                }
                else
                {
                    throw ArgumentError("IngameShopManager.addCategory: Invalid parent category " + param2);
                }
            }
            else
            {
                this.m_Categories.push(param1);
            }
            return;
        }// end function

        public static function getInstance() : IngameShopManager
        {
            if (s_Instance == null)
            {
                s_Instance = new IngameShopManager;
            }
            return s_Instance;
        }// end function

    }
}
