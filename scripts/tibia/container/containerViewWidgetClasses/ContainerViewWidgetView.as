package tibia.container.containerViewWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.game.IUseWidget;
   import tibia.game.IMoveWidget;
   import tibia.container.ContainerView;
   import shared.utility.Vector3D;
   import flash.geom.Point;
   import shared.utility.getClassInstanceUnderPoint;
   import flash.events.MouseEvent;
   import tibia.network.Communication;
   import tibia.game.ObjectDragImpl;
   import tibia.appearances.widgetClasses.SimpleAppearanceRenderer;
   import shared.utility.StringHelper;
   import mx.core.EdgeMetrics;
   import mx.controls.Button;
   import mx.containers.HBox;
   import mx.events.PropertyChangeEvent;
   import tibia.appearances.ObjectInstance;
   import flash.display.DisplayObject;
   import mx.controls.Label;
   import tibia.input.MouseRepeatEvent;
   import shared.controls.CustomButton;
   import shared.controls.CustomLabel;
   import mx.core.ScrollPolicy;
   import mx.styles.StyleProxy;
   import mx.events.DragEvent;
   import mx.core.EventPriority;
   import shared.skins.VectorBorderSkin;
   import mx.core.UIComponent;
   import mx.containers.BoxDirection;
   
   public class ContainerViewWidgetView extends WidgetView implements IUseWidget, IMoveWidget
   {
      
      protected static const DRAG_OPACITY:Number = 0.75;
      
      protected static const DEFAULT_WIDGET_WIDTH:Number = 184;
      
      protected static const DEFAULT_WIDGET_HEIGHT:Number = 200;
      
      protected static const DRAG_TYPE_OBJECT:String = "object";
      
      protected static const DRAG_TYPE_CHANNEL:String = "channel";
      
      protected static const DRAG_TYPE_SPELL:String = "spell";
      
      protected static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
      
      private static const BUNDLE:String = "ContainerViewWidget";
      
      protected static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
      
      protected static const DRAG_TYPE_ACTION:String = "action";
      
      private static const SLOT_HOLDER_STYLE_FILTER:Object = {
         "slotHorizontalAlign":"horizontalAlign",
         "slotVerticalAlign":"verticalAlign",
         "slotHorizontalGap":"horizontalGap",
         "slotVerticalGap":"verticalGap",
         "slotPaddingBottom":"paddingBottom",
         "slotPaddingLeft":"paddingLeft",
         "slotPaddingRight":"paddingRight",
         "slotPaddingTop":"paddingTop"
      };
       
      private const m_DragHandler:ObjectDragImpl = new ObjectDragImpl();
      
      private var m_UIPageLeftButton:Button = null;
      
      private var m_Container:ContainerView = null;
      
      private var m_UIPageFooter:HBox = null;
      
      private var m_UISlotHolder:tibia.container.containerViewWidgetClasses.ContainerSlotHolder = null;
      
      private var m_UIPageRightButton:Button = null;
      
      private var m_UIPageLabel:Label = null;
      
      private var m_UncommittedContainer:Boolean = false;
      
      private var m_UIUpButton:Button = null;
      
      public function ContainerViewWidgetView()
      {
         super();
         direction = BoxDirection.VERTICAL;
         titleIcon = null;
         titleText = resourceManager.getString(BUNDLE,"TITLE");
      }
      
      function get container() : ContainerView
      {
         return this.m_Container;
      }
      
      public function pointToAbsolute(param1:Point) : Vector3D
      {
         var _loc2_:ContainerSlot = null;
         if(this.container != null && (_loc2_ = getClassInstanceUnderPoint(stage,param1,ContainerSlot)) != null)
         {
            return new Vector3D(65535,64 + this.container.ID,_loc2_.position);
         }
         return null;
      }
      
      private function onUpButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:Communication = Tibia.s_GetCommunication();
         if(_loc2_ != null && Boolean(_loc2_.isGameRunning) && this.container != null)
         {
            _loc2_.sendCUPCONTAINER(this.container.ID);
         }
         if(this.m_UIUpButton != null)
         {
            this.m_UIUpButton.enabled = false;
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:SimpleAppearanceRenderer = null;
         if(this.m_UncommittedContainer)
         {
            this.updateFooter();
            this.updateSlots();
            if(this.container != null)
            {
               _loc1_ = new SimpleAppearanceRenderer();
               _loc1_.appearance = this.container.icon;
               _loc1_.size = 19;
               titleIcon = _loc1_;
               titleText = StringHelper.s_Capitalise(this.container.name);
               this.m_UIUpButton.enabled = this.m_UIUpButton.visible = this.container.isSubContainer;
            }
            else
            {
               titleIcon = null;
               titleText = resourceManager.getString(BUNDLE,"TITLE");
               this.m_UIUpButton.enabled = this.m_UIUpButton.visible = false;
            }
            this.m_UISlotHolder.verticalScrollPosition = 0;
            this.m_UncommittedContainer = false;
         }
         super.commitProperties();
      }
      
      override protected function measure() : void
      {
         var _loc1_:EdgeMetrics = viewMetricsAndPadding;
         var _loc2_:Number = getStyle("verticalGap");
         measuredMaxWidth = DEFAULT_WIDGET_WIDTH;
         measuredMinWidth = DEFAULT_WIDGET_WIDTH;
         measuredWidth = DEFAULT_WIDGET_WIDTH;
         if(isNaN(measuredMaxHeight))
         {
            measuredHeight = _loc1_.top + _loc1_.bottom + this.m_UISlotHolder.getExplicitOrMeasuredHeight();
            if(contains(this.m_UIPageFooter))
            {
               measuredHeight = measuredHeight + (_loc2_ + this.m_UIPageFooter.getExplicitOrMeasuredHeight());
            }
         }
         measuredMaxHeight = _loc1_.top + _loc1_.bottom;
         measuredMinHeight = _loc1_.top + _loc1_.bottom;
         if(!isNaN(this.m_UISlotHolder.explicitMaxHeight))
         {
            measuredMaxHeight = measuredMaxHeight + this.m_UISlotHolder.explicitMaxHeight;
         }
         else
         {
            measuredMaxHeight = measuredMaxHeight + this.m_UISlotHolder.measuredMaxHeight;
         }
         if(!isNaN(this.m_UISlotHolder.explicitMinHeight))
         {
            measuredMinHeight = measuredMinHeight + this.m_UISlotHolder.explicitMinHeight;
         }
         else
         {
            measuredMinHeight = measuredMinHeight + this.m_UISlotHolder.measuredMinHeight;
         }
         if(contains(this.m_UIPageFooter))
         {
            measuredMaxHeight = measuredMaxHeight + _loc2_;
            measuredMinHeight = measuredMinHeight + _loc2_;
            if(!isNaN(this.m_UIPageFooter.explicitMaxHeight))
            {
               measuredMaxHeight = measuredMaxHeight + this.m_UIPageFooter.explicitMaxHeight;
            }
            else
            {
               measuredMaxHeight = measuredMaxHeight + this.m_UIPageFooter.getExplicitOrMeasuredHeight();
            }
            if(!isNaN(this.m_UIPageFooter.explicitMinHeight))
            {
               measuredMinHeight = measuredMinHeight + this.m_UIPageFooter.explicitMinHeight;
            }
            else
            {
               measuredMinHeight = measuredMinHeight + this.m_UIPageFooter.measuredMinHeight;
            }
         }
         if(measuredHeight < measuredMinHeight)
         {
            measuredHeight = measuredMinHeight;
         }
         if(explicitHeight < measuredMinHeight)
         {
            explicitHeight = measuredMinHeight;
         }
      }
      
      function set container(param1:ContainerView) : void
      {
         if(param1 != this.m_Container)
         {
            if(this.m_Container != null)
            {
               this.m_Container.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onContainerChanged);
            }
            this.m_Container = param1;
            if(this.m_Container != null)
            {
               this.m_Container.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onContainerChanged);
            }
            this.m_UncommittedContainer = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      private function onSlotClick(param1:MouseEvent) : void
      {
         var _loc2_:ContainerSlot = null;
         if(this.container != null && (_loc2_ = param1.target as ContainerSlot) != null)
         {
            containerSlotMouseEventHandler(param1,this,new Vector3D(65535,64 + this.container.ID,_loc2_.position),_loc2_.appearance);
         }
      }
      
      private function updateFooter() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.container != null)
         {
            if(this.container.isPaginationEnabled)
            {
               _loc1_ = this.container.indexOfFirstObject / this.container.numberOfSlotsPerPage;
               _loc2_ = (this.container.numberOfTotalObjects + this.container.numberOfSlotsPerPage - 1) / this.container.numberOfSlotsPerPage;
               this.m_UIPageLabel.text = resourceManager.getString(BUNDLE,"PAGE_LABEL",[_loc1_ + 1,Math.max(_loc2_,1)]);
               this.m_UIPageLeftButton.enabled = this.m_UIPageLeftButton.visible = _loc1_ > 0;
               this.m_UIPageRightButton.enabled = this.m_UIPageRightButton.visible = _loc1_ < _loc2_ - 1;
            }
            if(!contains(this.m_UIPageFooter) && Boolean(this.container.isPaginationEnabled))
            {
               addChild(this.m_UIPageFooter);
            }
            else if(Boolean(contains(this.m_UIPageFooter)) && !this.container.isPaginationEnabled)
            {
               removeChild(this.m_UIPageFooter);
            }
         }
         else if(contains(this.m_UIPageFooter))
         {
            removeChild(this.m_UIPageFooter);
         }
      }
      
      private function destroySlot(param1:int) : void
      {
         var _loc2_:ContainerSlot = ContainerSlot(this.m_UISlotHolder.removeChildAt(param1));
         _loc2_.appearance = null;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onSlotClick);
         _loc2_.removeEventListener(MouseEvent.RIGHT_CLICK,this.onSlotClick);
      }
      
      private function createSlot(param1:ObjectInstance = null, param2:int = -1) : ContainerSlot
      {
         var _loc3_:ContainerSlot = new ContainerSlot();
         _loc3_.appearance = param1;
         _loc3_.position = param2;
         _loc3_.styleName = getStyle("slotStyleName");
         _loc3_.addEventListener(MouseEvent.CLICK,this.onSlotClick);
         _loc3_.addEventListener(MouseEvent.RIGHT_CLICK,this.onSlotClick);
         this.m_UISlotHolder.addChild(DisplayObject(_loc3_));
         return _loc3_;
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      public function getMoveObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      public function getUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:ContainerSlot = null;
         if(this.container != null && (_loc2_ = getClassInstanceUnderPoint(stage,param1,ContainerSlot)) != null)
         {
            return {
               "object":_loc2_.appearance,
               "absolute":new Vector3D(65535,64 + this.container.ID,_loc2_.position),
               "position":_loc2_.position
            };
         }
         return null;
      }
      
      private function onPageButtonDown(param1:MouseEvent) : void
      {
         if(param1 is MouseRepeatEvent)
         {
            MouseRepeatEvent(param1).repeatEnabled = true;
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.m_UIPageFooter = new HBox();
         this.m_UIPageFooter.percentWidth = 100;
         this.m_UIPageFooter.styleName = getStyle("pageFooterStyle");
         this.m_UIPageLeftButton = new CustomButton();
         this.m_UIPageLeftButton.styleName = getStyle("pageLeftButtonStyle");
         this.m_UIPageLeftButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onPageButtonDown);
         this.m_UIPageLeftButton.addEventListener(MouseEvent.CLICK,this.onPageButtonClick);
         this.m_UIPageLeftButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN,this.onPageButtonClick);
         this.m_UIPageLeftButton.setStyle("repeatDelay",500);
         this.m_UIPageFooter.addChild(this.m_UIPageLeftButton);
         this.m_UIPageLabel = new CustomLabel();
         this.m_UIPageLabel.percentWidth = 100;
         this.m_UIPageLabel.setStyle("textAlign","center");
         this.m_UIPageFooter.addChild(this.m_UIPageLabel);
         this.m_UIPageRightButton = new CustomButton();
         this.m_UIPageRightButton.styleName = getStyle("pageRightButtonStyle");
         this.m_UIPageRightButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onPageButtonDown);
         this.m_UIPageRightButton.addEventListener(MouseEvent.CLICK,this.onPageButtonClick);
         this.m_UIPageRightButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN,this.onPageButtonClick);
         this.m_UIPageRightButton.setStyle("repeatDelay",500);
         this.m_UIPageFooter.addChild(this.m_UIPageRightButton);
         this.m_UISlotHolder = new tibia.container.containerViewWidgetClasses.ContainerSlotHolder();
         this.m_UISlotHolder.height = NaN;
         this.m_UISlotHolder.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.m_UISlotHolder.percentWidth = NaN;
         this.m_UISlotHolder.percentHeight = 100;
         this.m_UISlotHolder.styleName = new StyleProxy(this,SLOT_HOLDER_STYLE_FILTER);
         this.m_UISlotHolder.verticalScrollPolicy = ScrollPolicy.ON;
         this.m_UISlotHolder.width = unscaledInnerWidth;
         this.m_UISlotHolder.addEventListener(DragEvent.DRAG_ENTER,this.onSlotHolderDragEnter,false,EventPriority.DEFAULT + 1);
         this.m_UISlotHolder.setStyle("backgroundAlpha",0);
         this.m_UISlotHolder.setStyle("backgroundColor",65280);
         this.m_UISlotHolder.setStyle("borderAlpha",0);
         this.m_UISlotHolder.setStyle("borderColor",65280);
         this.m_UISlotHolder.setStyle("borderSkin",VectorBorderSkin);
         this.m_UISlotHolder.setStyle("borderThickness",0);
         this.m_DragHandler.addDragComponent(this.m_UISlotHolder);
         addChild(this.m_UISlotHolder);
         this.m_UIUpButton = new CustomButton();
         this.m_UIUpButton.styleName = getStyle("upButtonStyle");
         this.m_UIUpButton.visible = this.container != null && Boolean(this.container.isSubContainer);
         this.m_UIUpButton.addEventListener(MouseEvent.CLICK,this.onUpButtonClick);
         header.addChildAt(this.m_UIUpButton,header.numChildren - 2);
      }
      
      private function updateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ContainerSlot = null;
         var _loc5_:int = 0;
         if(this.container != null)
         {
            _loc1_ = this.m_UISlotHolder.numChildren - 1;
            while(_loc1_ >= this.container.numberOfSlotsPerPage)
            {
               this.destroySlot(_loc1_);
               _loc1_--;
            }
            _loc2_ = this.m_UISlotHolder.numChildren;
            while(_loc2_ < this.container.numberOfSlotsPerPage)
            {
               this.createSlot(null,_loc2_);
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.container.numberOfSlotsPerPage)
            {
               _loc4_ = ContainerSlot(this.m_UISlotHolder.getChildAt(_loc3_));
               if(_loc3_ < this.container.numberOfObjects)
               {
                  _loc4_.appearance = this.container.getObject(this.container.indexOfFirstObject + _loc3_);
               }
               else
               {
                  _loc4_.appearance = null;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < this.m_UISlotHolder.numChildren)
            {
               this.destroySlot(_loc5_);
               _loc5_++;
            }
         }
      }
      
      public function pointToMap(param1:Point) : Vector3D
      {
         return null;
      }
      
      private function onPageButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:Communication = Tibia.s_GetCommunication();
         if(_loc2_ != null && Boolean(_loc2_.isGameRunning) && this.container != null)
         {
            if(param1.currentTarget == this.m_UIPageLeftButton && this.container.indexOfFirstObject >= this.container.numberOfSlotsPerPage)
            {
               _loc2_.sendCSEEKINCONTAINER(this.container.ID,this.container.indexOfFirstObject - this.container.numberOfSlotsPerPage);
            }
            else if(param1.currentTarget == this.m_UIPageRightButton && this.container.indexOfFirstObject + this.container.numberOfSlotsPerPage < this.container.numberOfTotalObjects)
            {
               _loc2_.sendCSEEKINCONTAINER(this.container.ID,this.container.indexOfFirstObject + this.container.numberOfSlotsPerPage);
            }
         }
      }
      
      override public function setStyle(param1:String, param2:*) : void
      {
         if(SLOT_HOLDER_STYLE_FILTER[param1] != null)
         {
            this.m_UISlotHolder.setStyle(SLOT_HOLDER_STYLE_FILTER[param1],param2);
         }
         else
         {
            super.setStyle(param1,param2);
         }
      }
      
      private function onContainerChanged(param1:PropertyChangeEvent) : void
      {
         if(param1.property == "objects")
         {
            this.updateFooter();
            this.updateSlots();
         }
      }
      
      private function onSlotHolderDragEnter(param1:DragEvent) : void
      {
         if(param1.dragSource == null || !param1.dragSource.hasFormat("dragType") || param1.dragSource.dataForFormat("dragType") != DRAG_TYPE_OBJECT || this.container == null || !this.container.isDragAndDropEnabled)
         {
            param1.preventDefault();
         }
      }
      
      override function releaseInstance() : void
      {
         super.releaseInstance();
         this.m_DragHandler.removeDragComponent(this.m_UISlotHolder as UIComponent);
         this.m_UISlotHolder.removeEventListener(DragEvent.DRAG_ENTER,this.onSlotHolderDragEnter);
         var _loc1_:int = this.m_UISlotHolder.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.destroySlot(_loc1_);
            _loc1_--;
         }
         this.m_UIUpButton.removeEventListener(MouseEvent.CLICK,this.onUpButtonClick);
      }
   }
}
