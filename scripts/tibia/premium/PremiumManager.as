package tibia.premium
{
   import flash.events.EventDispatcher;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   import tibia.sidebar.SideBarSet;
   import tibia.options.OptionsStorage;
   import tibia.sidebar.Widget;
   import tibia.creatures.Player;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class PremiumManager extends EventDispatcher
   {
      
      protected static const PREMIUM_TRIGGER_RIDE_MOUNTS:uint = 4;
      
      protected static const PREMIUM_TRIGGER_ALL_OUTFITS:uint = 5;
      
      protected static const PREMIUM_EXPIRY_THRESHOLD:uint = 3;
      
      public static const PREMIUM_BUTTON_GENERAL_CONTROLS:int = 0;
      
      protected static const PREMIUM_TRIGGER_XP_BOOST:uint = 6;
      
      protected static const PREMIUM_TRIGGER_DEPOT_SPACE:uint = 11;
      
      protected static const PREMIUM_TRIGGER_DEATH_PENALTY:uint = 7;
      
      public static const HIGHLIGHT_MINIBUTTON_TIMEOUT:int = 1000 * 5;
      
      protected static const PREMIUM_TRIGGER_ALL_SPELLS:uint = 2;
      
      protected static const PREMIUM_TRIGGER_MARKET:uint = 8;
      
      public static const HIGHLIGHT_TIMEOUT:int = 1000 * 60 * 10;
      
      protected static const PREMIUM_TRIGGER_TRAVEL_FASTER:uint = 3;
      
      protected static const PREMIUM_TRIGGER_INVITE_PRIVCHAT:uint = 12;
      
      public static const PREMIUM_BUTTON_WIDGET:int = 1;
      
      protected static const PREMIUM_TRIGGER_RENT_HOUSES:uint = 9;
      
      protected static const PREMIUM_TRIGGER_VIP_LIST:uint = 10;
      
      protected static const PREMIUM_URL:String = "/account/index.php?subtopic=redirectlogin&clienttarget=payment&clientselection=FC";
      
      protected static const PREMIUM_TRIGGER_RENEW_PREMIUM:uint = 14;
      
      protected static const PREMIUM_TRIGGER_ALL_AREAS:uint = 0;
      
      protected static const PREMIUM_TRIGGER_CLASS_PROMOTION:uint = 13;
      
      protected static const PREMIUM_TRIGGER_TRAIN_OFFLINE:uint = 1;
       
      protected var m_PremiumMessages:Vector.<tibia.premium.PremiumMessage> = null;
      
      protected var m_Player:Player = null;
      
      public function PremiumManager(param1:Player)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("PremiumManager: Player instance is null");
         }
         this.m_PremiumMessages = new Vector.<tibia.premium.PremiumMessage>();
         this.m_Player = param1;
         this.m_Player.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerPropertyChange);
      }
      
      public function toggleHighlight(param1:int) : void
      {
         var _loc2_:PremiumEvent = new PremiumEvent(PremiumEvent.HIGHLIGHT);
         _loc2_.highlightExpiry = param1;
         dispatchEvent(_loc2_);
      }
      
      public function get premiumExpiryDays() : int
      {
         var _loc1_:Number = Math.max(0,this.m_Player.premiumUntil - new Date().time / 1000);
         return _loc1_ / (60 * 60 * 24) + 1;
      }
      
      public function get premiumMessages() : Vector.<tibia.premium.PremiumMessage>
      {
         return this.m_PremiumMessages;
      }
      
      protected function onPlayerPropertyChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null && param1.kind == PropertyChangeEventKind.UPDATE && param1.property == "premium")
         {
            this.showWidget();
            this.m_Player.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onPlayerPropertyChange);
         }
      }
      
      private function findVisibleSidebarLocation(param1:SideBarSet) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [SideBarSet.LOCATION_C,SideBarSet.LOCATION_B,SideBarSet.LOCATION_D,SideBarSet.LOCATION_A];
         for each(_loc3_ in _loc2_)
         {
            if(param1.getSideBar(_loc3_).visible)
            {
               return _loc3_;
            }
         }
         return SideBarSet.LOCATION_B;
      }
      
      public function showWidget(param1:Boolean = false) : void
      {
         var _loc3_:SideBarSet = null;
         var _loc4_:PremiumWidget = null;
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getSideBarSet(SideBarSet.DEFAULT_SET);
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.getWidgetByType(Widget.TYPE_PREMIUM) as PremiumWidget;
               if(_loc4_ == null && (Boolean(param1) || Boolean(this.freePlayerLimitations) || Boolean(this.m_Player.premium) && this.premiumExpiryDays <= PREMIUM_EXPIRY_THRESHOLD))
               {
                  this.toggleWidget();
               }
            }
         }
      }
      
      public function get freePlayerLimitations() : Boolean
      {
         return !(Boolean(this.m_Player.premium) || this.m_Player.premiumUntil > 0);
      }
      
      private function translateMessageId(param1:uint) : tibia.premium.PremiumMessage
      {
         switch(param1)
         {
            case PREMIUM_TRIGGER_ALL_AREAS:
               return tibia.premium.PremiumMessage.ALL_AREAS;
            case PREMIUM_TRIGGER_TRAIN_OFFLINE:
               return tibia.premium.PremiumMessage.TRAIN_OFFLINE;
            case PREMIUM_TRIGGER_ALL_SPELLS:
               return tibia.premium.PremiumMessage.ALL_SPELLS;
            case PREMIUM_TRIGGER_TRAVEL_FASTER:
               return tibia.premium.PremiumMessage.TRAVEL_FASTER;
            case PREMIUM_TRIGGER_RIDE_MOUNTS:
               return tibia.premium.PremiumMessage.RIDE_MOUNTS;
            case PREMIUM_TRIGGER_ALL_OUTFITS:
               return tibia.premium.PremiumMessage.ALL_OUTFITS;
            case PREMIUM_TRIGGER_XP_BOOST:
               return tibia.premium.PremiumMessage.XP_BOOST;
            case PREMIUM_TRIGGER_DEATH_PENALTY:
               return tibia.premium.PremiumMessage.DEATH_PENALTY;
            case PREMIUM_TRIGGER_MARKET:
               return tibia.premium.PremiumMessage.MARKET;
            case PREMIUM_TRIGGER_RENT_HOUSES:
               return tibia.premium.PremiumMessage.RENT_HOUSES;
            case PREMIUM_TRIGGER_VIP_LIST:
               return tibia.premium.PremiumMessage.VIP_LIST;
            case PREMIUM_TRIGGER_DEPOT_SPACE:
               return tibia.premium.PremiumMessage.DEPOT_SPACE;
            case PREMIUM_TRIGGER_INVITE_PRIVCHAT:
               return tibia.premium.PremiumMessage.INVITE_PRIVCHAT;
            case PREMIUM_TRIGGER_CLASS_PROMOTION:
               return tibia.premium.PremiumMessage.CLASS_PROMOTION;
            case PREMIUM_TRIGGER_RENEW_PREMIUM:
               return tibia.premium.PremiumMessage.RENEW_PREMIUM;
            default:
               throw new ArgumentError("Invalid premium trigger ID: " + param1);
         }
      }
      
      public function toggleWidget() : void
      {
         var _loc3_:SideBarSet = null;
         var _loc4_:int = 0;
         var _loc1_:Widget = null;
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getSideBarSet(SideBarSet.DEFAULT_SET);
            if(_loc3_ != null)
            {
               _loc1_ = _loc3_.getWidgetByType(Widget.TYPE_PREMIUM);
               if(_loc1_ == null)
               {
                  _loc4_ = this.findVisibleSidebarLocation(_loc3_);
                  _loc1_ = _loc3_.showWidgetType(Widget.TYPE_PREMIUM,_loc4_,0);
               }
               else
               {
                  _loc1_.close();
                  _loc1_ = null;
               }
            }
         }
      }
      
      public function updatePremiumMessages(param1:Vector.<uint>, param2:Boolean) : void
      {
         var a_MessageIds:Vector.<uint> = param1;
         var a_TriggerNotification:Boolean = param2;
         this.m_PremiumMessages.length = 0;
         a_MessageIds.forEach(function(param1:uint, param2:int, param3:Vector.<uint>):void
         {
            m_PremiumMessages.push(translateMessageId(param1));
         });
         var Event:PremiumEvent = new PremiumEvent(PremiumEvent.TRIGGER);
         Event.messages = this.m_PremiumMessages;
         Event.highlight = a_TriggerNotification;
         Event.highlightExpiry = HIGHLIGHT_TIMEOUT;
         dispatchEvent(Event);
      }
      
      public function goToPaymentWebsite(param1:int) : void
      {
         var _loc2_:URLRequest = new URLRequest(PREMIUM_URL + param1);
         navigateToURL(_loc2_,"_blank");
      }
   }
}
