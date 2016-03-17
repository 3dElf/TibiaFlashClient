package tibia.premium.premiumWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import shared.controls.CustomButton;
   import tibia.premium.PremiumMessage;
   import mx.containers.GridRow;
   import mx.containers.GridItem;
   import mx.controls.Text;
   import flash.display.Bitmap;
   import mx.controls.Image;
   import tibia.premium.PremiumWidget;
   import flash.events.MouseEvent;
   import tibia.premium.PremiumEvent;
   import mx.containers.Grid;
   import mx.controls.Label;
   import tibia.premium.PremiumManager;
   import mx.containers.HBox;
   import flash.events.TimerEvent;
   import mx.core.ScrollPolicy;
   
   public class PremiumWidgetView extends WidgetView
   {
      
      private static const BUNDLE:String = "PremiumWidget";
      
      private static const CONFIRMATION_TIMEOUT:int = 1000 * 30;
       
      private var m_UICancel:CustomButton = null;
      
      private var m_TriggerExpiryTime:int = 0;
      
      protected var m_PseudoCollapsed:Boolean = true;
      
      private var m_UICollapsedStyleName:Object;
      
      private var m_ConfirmationOpenedTimestamp:uint = 0;
      
      private var m_UIPremium:CustomButton = null;
      
      private var m_UIGrid:Grid = null;
      
      private var m_TriggerHighlight:Boolean = false;
      
      private var m_UIConfirmText:Label = null;
      
      private var m_UIButtonContainer:HBox = null;
      
      private var m_UIConstructed:Boolean = false;
      
      private var m_UIConfirm:CustomButton = null;
      
      private var m_LastTriggerTime:Number = 0;
      
      public function PremiumWidgetView()
      {
         super();
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         Tibia.s_GetPremiumManager().addEventListener(PremiumEvent.TRIGGER,this.onPremiumTrigger);
         Tibia.s_GetPremiumManager().addEventListener(PremiumEvent.HIGHLIGHT,this.onPremiumHighlightToggle);
         Tibia.s_GetSecondaryTimer().addEventListener(TimerEvent.TIMER,this.onSecondaryTimer);
      }
      
      private function updatePremiumBenefits(param1:Vector.<PremiumMessage>) : void
      {
         var _loc2_:PremiumMessage = null;
         var _loc3_:GridRow = null;
         var _loc4_:GridItem = null;
         var _loc5_:Text = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Image = null;
         this.m_UIGrid.removeAllChildren();
         for each(_loc2_ in param1)
         {
            _loc3_ = new GridRow();
            _loc4_ = new GridItem();
            _loc4_.styleName = "premiumWidgetGridItem";
            if(_loc2_.icon != null)
            {
               _loc6_ = new Bitmap(_loc2_.icon);
               _loc7_ = new Image();
               _loc7_.source = _loc6_;
               _loc4_.addChild(_loc7_);
            }
            _loc3_.addChild(_loc4_);
            _loc4_ = new GridItem();
            _loc4_.styleName = "premiumWidgetGridItem";
            _loc5_ = new Text();
            _loc5_.htmlText = resourceManager.getString(BUNDLE,_loc2_.resourceText,[(m_WidgetInstance as PremiumWidget).premiumManager.premiumExpiryDays]);
            _loc4_.addChild(_loc5_);
            _loc3_.addChild(_loc4_);
            this.m_UIGrid.addChild(_loc3_);
         }
      }
      
      private function replaceButtonWithConfirmation() : void
      {
         this.m_UIPremium.removeEventListener(MouseEvent.CLICK,this.onPremiumButtonClick);
         this.m_UIConfirm.addEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         this.m_UICancel.addEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         this.m_UIButtonContainer.removeAllChildren();
         this.m_UIButtonContainer.addChild(this.m_UIConfirmText);
         this.m_UIButtonContainer.addChild(this.m_UIConfirm);
         this.m_UIButtonContainer.addChild(this.m_UICancel);
         this.m_ConfirmationOpenedTimestamp = Tibia.s_GetTibiaTimer();
         this.stopTriggerHighlight();
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         m_UICollapseButton.selected = this.m_PseudoCollapsed;
         if(Boolean(this.m_PseudoCollapsed) && Boolean(contains(this.m_UIGrid)))
         {
            removeChild(this.m_UIGrid);
         }
         else if(!this.m_PseudoCollapsed && !contains(this.m_UIGrid))
         {
            addChild(this.m_UIGrid);
         }
         m_UICloseButton.enabled = m_WidgetClosable;
      }
      
      protected function onPremiumHighlightToggle(param1:PremiumEvent) : void
      {
         if(this.m_TriggerHighlight)
         {
            this.stopTriggerHighlight();
         }
         else
         {
            this.startTriggerHighlight(param1.highlightExpiry);
         }
      }
      
      private function replaceConfirmationWithButton() : void
      {
         this.m_UIConfirm.removeEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         this.m_UICancel.removeEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         this.m_UIPremium.addEventListener(MouseEvent.CLICK,this.onPremiumButtonClick);
         this.m_UIButtonContainer.removeAllChildren();
         this.m_UIButtonContainer.addChild(this.m_UIPremium);
      }
      
      protected function onHeaderDoubleClick(param1:MouseEvent) : void
      {
         this.pseudoCollapsed = !this.pseudoCollapsed;
         this.stopTriggerHighlight();
         invalidateProperties();
      }
      
      public function startTriggerHighlight(param1:int) : void
      {
         this.m_LastTriggerTime = Tibia.s_GetTibiaTimer();
         this.m_TriggerExpiryTime = param1;
         if(Boolean(this.m_PseudoCollapsed) && !this.m_TriggerHighlight)
         {
            this.m_UIPremium.styleName = "premiumWidgetTriggered";
            this.m_UICollapsedStyleName = m_UICollapseButton.styleName;
            m_UICollapseButton.styleName = "expandButtonPremiumTriggered";
         }
         this.m_TriggerHighlight = true;
      }
      
      protected function onConfirmButtonClick(param1:MouseEvent) : void
      {
         if(param1 != null && param1.target != null)
         {
            if(param1.target == this.m_UIConfirm)
            {
               Tibia.s_GetPremiumManager().goToPaymentWebsite(PremiumManager.PREMIUM_BUTTON_WIDGET);
            }
         }
         this.replaceConfirmationWithButton();
      }
      
      protected function onPremiumButtonClick(param1:MouseEvent) : void
      {
         this.stopTriggerHighlight();
         if(Tibia.s_GetPlayer().isFighting)
         {
            this.replaceButtonWithConfirmation();
         }
         else
         {
            Tibia.s_GetPremiumManager().goToPaymentWebsite(PremiumManager.PREMIUM_BUTTON_WIDGET);
         }
      }
      
      protected function onPremiumTrigger(param1:PremiumEvent) : void
      {
         this.updatePremiumBenefits(param1.messages);
         if(param1.highlight)
         {
            this.startTriggerHighlight(param1.highlightExpiry);
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            m_UICollapseButton.addEventListener(MouseEvent.CLICK,this.onCollapseButtonClick);
            this.m_UICollapsedStyleName = m_UICollapseButton.styleName;
            this.m_UIButtonContainer = new HBox();
            this.m_UIButtonContainer.percentWidth = 100;
            this.m_UIButtonContainer.styleName = "premiumWidgetButtonBox";
            addChild(this.m_UIButtonContainer);
            this.m_UIPremium = new CustomButton();
            this.m_UIPremium.percentWidth = 100;
            this.m_UIPremium.label = resourceManager.getString(BUNDLE,"BTN_GET_PREMIUM");
            this.m_UIPremium.addEventListener(MouseEvent.CLICK,this.onPremiumButtonClick);
            this.m_UIButtonContainer.addChild(this.m_UIPremium);
            this.m_UIGrid = new Grid();
            this.m_UIGrid.percentWidth = 100;
            this.m_UIConfirmText = new Label();
            this.m_UIConfirmText.text = resourceManager.getString(BUNDLE,"LBL_OPEN_WEBSITE");
            this.m_UIConfirm = new CustomButton();
            this.m_UIConfirm.label = resourceManager.getString(BUNDLE,"BTN_CONFIRM");
            this.m_UICancel = new CustomButton();
            this.m_UICancel.label = resourceManager.getString(BUNDLE,"BTN_CANCEL");
            this.updatePremiumBenefits(Tibia.s_GetPremiumManager().premiumMessages);
            m_UIHeader.addEventListener(MouseEvent.DOUBLE_CLICK,this.onHeaderDoubleClick);
            this.m_UIConstructed = true;
         }
      }
      
      protected function onCollapseButtonClick(param1:MouseEvent) : void
      {
         this.pseudoCollapsed = !this.pseudoCollapsed;
         this.stopTriggerHighlight();
         invalidateProperties();
      }
      
      public function set pseudoCollapsed(param1:Boolean) : void
      {
         this.m_PseudoCollapsed = param1;
      }
      
      protected function onSecondaryTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = Tibia.s_GetTibiaTimer();
         if(Boolean(this.m_UIButtonContainer.contains(this.m_UIConfirm)) && this.m_ConfirmationOpenedTimestamp + CONFIRMATION_TIMEOUT < _loc2_)
         {
            this.replaceConfirmationWithButton();
         }
         if(Boolean(this.m_TriggerHighlight) && this.m_LastTriggerTime + this.m_TriggerExpiryTime < _loc2_)
         {
            this.stopTriggerHighlight();
         }
      }
      
      public function get pseudoCollapsed() : Boolean
      {
         return this.m_PseudoCollapsed;
      }
      
      override function releaseInstance() : void
      {
         super.releaseInstance();
         this.m_UIPremium.removeEventListener(MouseEvent.CLICK,this.onPremiumButtonClick);
         this.m_UIConfirm.removeEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         this.m_UICancel.removeEventListener(MouseEvent.CLICK,this.onConfirmButtonClick);
         m_UICollapseButton.removeEventListener(MouseEvent.CLICK,this.onCollapseButtonClick);
         m_UIHeader.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onHeaderDoubleClick);
         Tibia.s_GetSecondaryTimer().removeEventListener(TimerEvent.TIMER,this.onSecondaryTimer);
         Tibia.s_GetPremiumManager().removeEventListener(PremiumEvent.TRIGGER,this.onPremiumTrigger);
         Tibia.s_GetPremiumManager().removeEventListener(PremiumEvent.HIGHLIGHT,this.onPremiumHighlightToggle);
      }
      
      public function stopTriggerHighlight() : void
      {
         this.m_TriggerHighlight = false;
         this.m_UIPremium.styleName = null;
         m_UICollapseButton.styleName = this.m_UICollapsedStyleName;
      }
   }
}
