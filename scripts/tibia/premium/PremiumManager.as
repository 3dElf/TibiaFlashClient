package tibia.premium
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.net.*;
    import mx.events.*;
    import tibia.creatures.*;
    import tibia.options.*;
    import tibia.sidebar.*;

    public class PremiumManager extends EventDispatcher
    {
        protected var m_PremiumMessages:Vector.<PremiumMessage> = null;
        protected var m_Player:Player = null;
        public static const PREMIUM_BUTTON_GENERAL_CONTROLS:int = 0;
        static const PREMIUM_TRIGGER_ALL_OUTFITS:uint = 5;
        static const PREMIUM_TRIGGER_RENEW_PREMIUM:uint = 14;
        static const PREMIUM_EXPIRY_THRESHOLD:uint = 3;
        static const PREMIUM_TRIGGER_RIDE_MOUNTS:uint = 4;
        static const PREMIUM_TRIGGER_XP_BOOST:uint = 6;
        static const PREMIUM_TRIGGER_DEPOT_SPACE:uint = 11;
        static const PREMIUM_TRIGGER_DEATH_PENALTY:uint = 7;
        static const PREMIUM_TRIGGER_ACCESS_ARENAS:uint = 15;
        public static const HIGHLIGHT_TIMEOUT:int = 600000;
        static const PREMIUM_TRIGGER_ALL_SPELLS:uint = 2;
        static const PREMIUM_TRIGGER_MARKET:uint = 8;
        public static const PREMIUM_BUTTON_SHOP:int = 2;
        static const PREMIUM_TRIGGER_TRAVEL_FASTER:uint = 3;
        static const PREMIUM_TRIGGER_INVITE_PRIVCHAT:uint = 12;
        public static const PREMIUM_BUTTON_WIDGET:int = 1;
        static const PREMIUM_TRIGGER_RENT_HOUSES:uint = 9;
        static const PREMIUM_TRIGGER_VIP_LIST:uint = 10;
        static const PREMIUM_URL:String = "/account/index.php?subtopic=redirectlogin&clienttarget=payment&clientselection=FC";
        static const PREMIUM_TRIGGER_ALL_AREAS:uint = 0;
        static const PREMIUM_TRIGGER_CLASS_PROMOTION:uint = 13;
        static const PREMIUM_TRIGGER_TRAIN_OFFLINE:uint = 1;

        public function PremiumManager(param1:Player)
        {
            if (param1 == null)
            {
                throw new ArgumentError("PremiumManager: Player instance is null");
            }
            this.m_PremiumMessages = new Vector.<PremiumMessage>;
            this.m_Player = param1;
            this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerPropertyChange);
            return;
        }// end function

        public function get premiumExpiryDays() : int
        {
            var _loc_1:* = Math.max(0, this.m_Player.premiumUntil - new Date().time / 1000);
            return _loc_1 / (60 * 60 * 24) + 1;
        }// end function

        public function get premiumMessages() : Vector.<PremiumMessage>
        {
            return this.m_PremiumMessages;
        }// end function

        public function isWidgetVisible() : Boolean
        {
            var _loc_3:* = null;
            var _loc_1:* = null;
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 != null)
            {
                _loc_3 = _loc_2.getSideBarSet(SideBarSet.DEFAULT_SET);
                if (_loc_3 != null)
                {
                    _loc_1 = _loc_3.getWidgetByType(Widget.TYPE_PREMIUM);
                }
            }
            return _loc_1 != null && !_loc_1.closed;
        }// end function

        protected function onPlayerPropertyChange(event:PropertyChangeEvent) : void
        {
            if (event != null && event.kind == PropertyChangeEventKind.UPDATE && event.property == "premium")
            {
                this.showOrHideWidgetBasedOnPremiumStatus();
            }
            return;
        }// end function

        public function get freePlayerLimitations() : Boolean
        {
            return !(this.m_Player.premium || this.m_Player.premiumUntil > 0);
        }// end function

        public function showOrHideWidget(param1:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetOptions();
            if (_loc_3 != null)
            {
                _loc_4 = _loc_3.getSideBarSet(SideBarSet.DEFAULT_SET);
                if (_loc_4 != null)
                {
                    _loc_2 = _loc_4.getWidgetByType(Widget.TYPE_PREMIUM);
                    if (_loc_2 == null && param1)
                    {
                        _loc_5 = this.findVisibleSidebarLocation(_loc_4);
                        _loc_2 = _loc_4.showWidgetType(Widget.TYPE_PREMIUM, _loc_5, 0);
                        _loc_2.collapsed = true;
                    }
                    else if (_loc_2 != null && param1 == false)
                    {
                        _loc_2.close();
                        _loc_2 = null;
                    }
                }
            }
            return;
        }// end function

        private function translateMessageId(param1:uint) : PremiumMessage
        {
            switch(param1)
            {
                case PREMIUM_TRIGGER_ALL_AREAS:
                {
                    return PremiumMessage.ALL_AREAS;
                }
                case PREMIUM_TRIGGER_TRAIN_OFFLINE:
                {
                    return PremiumMessage.TRAIN_OFFLINE;
                }
                case PREMIUM_TRIGGER_ALL_SPELLS:
                {
                    return PremiumMessage.ALL_SPELLS;
                }
                case PREMIUM_TRIGGER_TRAVEL_FASTER:
                {
                    return PremiumMessage.TRAVEL_FASTER;
                }
                case PREMIUM_TRIGGER_RIDE_MOUNTS:
                {
                    return PremiumMessage.RIDE_MOUNTS;
                }
                case PREMIUM_TRIGGER_ALL_OUTFITS:
                {
                    return PremiumMessage.ALL_OUTFITS;
                }
                case PREMIUM_TRIGGER_XP_BOOST:
                {
                    return PremiumMessage.XP_BOOST;
                }
                case PREMIUM_TRIGGER_DEATH_PENALTY:
                {
                    return PremiumMessage.DEATH_PENALTY;
                }
                case PREMIUM_TRIGGER_MARKET:
                {
                    return PremiumMessage.MARKET;
                }
                case PREMIUM_TRIGGER_RENT_HOUSES:
                {
                    return PremiumMessage.RENT_HOUSES;
                }
                case PREMIUM_TRIGGER_VIP_LIST:
                {
                    return PremiumMessage.VIP_LIST;
                }
                case PREMIUM_TRIGGER_DEPOT_SPACE:
                {
                    return PremiumMessage.DEPOT_SPACE;
                }
                case PREMIUM_TRIGGER_INVITE_PRIVCHAT:
                {
                    return PremiumMessage.INVITE_PRIVCHAT;
                }
                case PREMIUM_TRIGGER_CLASS_PROMOTION:
                {
                    return PremiumMessage.CLASS_PROMOTION;
                }
                case PREMIUM_TRIGGER_RENEW_PREMIUM:
                {
                    return PremiumMessage.RENEW_PREMIUM;
                }
                case PREMIUM_TRIGGER_ACCESS_ARENAS:
                {
                    return PremiumMessage.ACCESS_ARENAS;
                }
                default:
                {
                    throw new ArgumentError("Invalid premium trigger ID: " + param1);
                    break;
                }
            }
        }// end function

        public function goToPaymentWebsite(param1:int) : void
        {
            var _loc_2:* = new URLRequest(PREMIUM_URL + param1);
            navigateToURL(_loc_2, "_blank");
            return;
        }// end function

        public function updatePremiumMessages(param1:Vector.<uint>, param2:int) : void
        {
            var a_MessageIds:* = param1;
            var a_FeaturedServiceType:* = param2;
            this.m_PremiumMessages.length = 0;
            a_MessageIds.forEach(function (param1:uint, param2:int, param3:Vector.<uint>) : void
            {
                m_PremiumMessages.push(translateMessageId(param1));
                return;
            }// end function
            );
            var Event:* = new PremiumEvent(PremiumEvent.TRIGGER);
            Event.messages = this.m_PremiumMessages;
            Event.featuredStoreServiceType = a_FeaturedServiceType;
            Event.highlightExpiry = HIGHLIGHT_TIMEOUT;
            dispatchEvent(Event);
            return;
        }// end function

        public function showOrHideWidgetBasedOnPremiumStatus() : void
        {
            var _loc_1:* = this.isWidgetVisible();
            var _loc_2:* = this.freePlayerLimitations || this.m_Player.premium && this.premiumExpiryDays <= PREMIUM_EXPIRY_THRESHOLD;
            if (_loc_1 && !_loc_2)
            {
                this.showOrHideWidget(false);
            }
            else if (!_loc_1 && _loc_2)
            {
                this.showOrHideWidget(true);
            }
            return;
        }// end function

        private function findVisibleSidebarLocation(param1:SideBarSet) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = [SideBarSet.LOCATION_C, SideBarSet.LOCATION_B, SideBarSet.LOCATION_D, SideBarSet.LOCATION_A];
            for each (_loc_3 in _loc_2)
            {
                
                if (param1.getSideBar(_loc_3).visible)
                {
                    return _loc_3;
                }
            }
            return SideBarSet.LOCATION_B;
        }// end function

    }
}
