package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.controls.*;
    import mx.resources.*;
    import shared.utility.*;
    import shared.utility.i18n.*;
    import tibia.appearances.*;
    import tibia.market.*;

    class Utility extends Object
    {
        private static const MARKET_BUNDLE:String = "MarketWidget";
        private static const GLOBAL_BUNDLE:String = "Global";

        function Utility()
        {
            return;
        }// end function

        public static function formatOfferPiecePrice(param1:Offer, ... args) : String
        {
            return i18nFormatNumber(param1.piecePrice);
        }// end function

        public static function formatOfferTerminationReason(param1:Offer, ... args) : String
        {
            args = ResourceManager.getInstance();
            switch(param1.terminationReason)
            {
                case Offer.ACTIVE:
                {
                    return args.getString(MARKET_BUNDLE, "REASON_ACTIVE");
                }
                case Offer.CANCELLED:
                {
                    return args.getString(MARKET_BUNDLE, "REASON_CANCELLED");
                }
                case Offer.EXPIRED:
                {
                    return args.getString(MARKET_BUNDLE, "REASON_EXPIRED");
                }
                case Offer.ACCEPTED:
                {
                    return args.getString(MARKET_BUNDLE, param1.kind == Offer.BUY_OFFER ? ("REASON_ACCEPTED_BUY_OFFER") : ("REASON_ACCEPTED_SELL_OFFER"));
                }
                default:
                {
                    return args.getString(MARKET_BUNDLE, "REASON_UNKNOWN");
                    break;
                }
            }
        }// end function

        public static function formatOfferTotalPrice(param1:Offer, ... args) : String
        {
            return i18nFormatNumber(param1.totalPrice);
        }// end function

        public static function compareOfferByItemName(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_4:* = param1 as Offer;
            var _loc_5:* = param2 as Offer;
            if (_loc_4 == null || _loc_5 == null)
            {
                return 0;
            }
            var _loc_6:* = Tibia.s_GetAppearanceStorage();
            if (Tibia.s_GetAppearanceStorage() == null)
            {
                return 0;
            }
            var _loc_7:* = _loc_6.getMarketObjectType(_loc_4.typeID);
            var _loc_8:* = _loc_6.getMarketObjectType(_loc_5.typeID);
            if (_loc_7 == null || !_loc_7.isMarket || _loc_8 == null || !_loc_8.isMarket)
            {
                return 0;
            }
            if (_loc_7.marketNameLowerCase < _loc_8.marketNameLowerCase)
            {
                return -1;
            }
            if (_loc_7.marketNameLowerCase > _loc_8.marketNameLowerCase)
            {
                return 1;
            }
            if (_loc_4.typeID < _loc_5.typeID)
            {
                return -1;
            }
            if (_loc_4.typeID > _loc_5.typeID)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function preventNonNumericInput(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (event != null)
            {
                _loc_2 = event.currentTarget as TextInput;
                if (_loc_2 == null)
                {
                    return;
                }
                _loc_3 = null;
                if (event is KeyboardEvent && KeyboardEvent(event).charCode != 0)
                {
                    _loc_3 = String.fromCharCode(KeyboardEvent(event).charCode);
                }
                else if (event is TextEvent)
                {
                    _loc_3 = TextEvent(event).text;
                }
                else
                {
                    return;
                }
                _loc_4 = /[0-9]/;
                if (!_loc_4.test(_loc_3) || _loc_3 == "0" && _loc_2.selectionBeginIndex == 0)
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                }
            }
            return;
        }// end function

        public static function createFilter(param1:Object) : Function
        {
            var a_Filter:* = param1;
            return closure({filter:a_Filter}, function (param1) : Boolean
            {
                var _loc_2:* = undefined;
                if (param1 == null)
                {
                    return false;
                }
                for (_loc_2 in this["filter"])
                {
                    
                    if (!param1.hasOwnProperty(_loc_2) || param1[_loc_2] !== _loc_4[_loc_2])
                    {
                        return false;
                    }
                }
                return true;
            }// end function
            );
        }// end function

        public static function formatOfferTerminationTimestamp(param1:Offer, ... args) : String
        {
            return i18nFormatDate(new Date(param1.terminationTimestamp * 1000));
        }// end function

        public static function formatOfferTypeID(param1:Offer, ... args) : String
        {
            args = null;
            var _loc_4:* = null;
            var _loc_6:* = Tibia.s_GetAppearanceStorage();
            args = Tibia.s_GetAppearanceStorage();
            var _loc_6:* = args.getMarketObjectType(param1.typeID);
            _loc_4 = args.getMarketObjectType(param1.typeID);
            if (param1 != null && _loc_6 != null && _loc_6 != null)
            {
                return _loc_4.marketName;
            }
            var _loc_5:* = ResourceManager.getInstance();
            return _loc_5.getString(MARKET_BUNDLE, "TYPE_UNKNOWN");
        }// end function

        public static function compareAppearanceType(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_4:* = param1 as AppearanceType;
            var _loc_5:* = param2 as AppearanceType;
            if (_loc_4 != null && _loc_4.isMarket && _loc_5 != null && _loc_5.isMarket)
            {
                if (_loc_4.marketNameLowerCase < _loc_5.marketNameLowerCase)
                {
                    return -1;
                }
                if (_loc_4.marketNameLowerCase > _loc_5.marketNameLowerCase)
                {
                    return 1;
                }
                if (_loc_4.ID < _loc_5.ID)
                {
                    return -1;
                }
                if (_loc_4.ID > _loc_5.ID)
                {
                    return 1;
                }
            }
            return 0;
        }// end function

    }
}
