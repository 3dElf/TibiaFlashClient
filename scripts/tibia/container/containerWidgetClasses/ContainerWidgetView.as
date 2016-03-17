package tibia.container.containerWidgetClasses
{
   import tibia.container.Container;
   import flash.display.DisplayObjectContainer;
   import tibia.appearances.widgetClasses.SimpleAppearanceRenderer;
   import tibia.§sidebar:ns_sidebar_internal§.container;
   import shared.utility.StringHelper;
   import mx.controls.Button;
   import flash.events.MouseEvent;
   import mx.core.ScrollPolicy;
   import mx.styles.StyleProxy;
   import shared.skins.VectorBorderSkin;
   import tibia.container.ContainerStorage;
   import mx.core.EdgeMetrics;
   import mx.containers.BoxDirection;
   import mx.core.ClassFactory;
   
   public class ContainerWidgetView extends ContainerWidgetViewBase
   {
      
      protected static const DEFAULT_WIDGET_HEIGHT:Number = 200;
      
      protected static const DEFAULT_WIDGET_WIDTH:Number = 184;
      
      private static const BUNDLE:String = "ContainerWidget";
      
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
       
      private var m_UncommittedContainer:Boolean = false;
      
      protected var m_UIUpButton:Button = null;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UISlotHolder:ContainerSlotHolder = null;
      
      public function ContainerWidgetView()
      {
         super();
         direction = BoxDirection.VERTICAL;
         titleIcon = null;
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         slotFactory = new ClassFactory(ContainerSlot);
      }
      
      override function set container(param1:Container) : void
      {
         if(param1 != m_Container)
         {
            super.container = param1;
            this.m_UncommittedContainer = true;
            invalidateProperties();
         }
      }
      
      override protected function get slotHolder() : DisplayObjectContainer
      {
         return this.m_UISlotHolder;
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:SimpleAppearanceRenderer = null;
         if(this.m_UncommittedContainer)
         {
            if(m_Container != null)
            {
               _loc1_ = new SimpleAppearanceRenderer();
               _loc1_.appearance = container.object;
               _loc1_.size = 19;
               titleIcon = _loc1_;
               titleText = StringHelper.s_Capitalise(container.name);
               this.m_UIUpButton.visible = container.isSubContainer;
            }
            else
            {
               titleIcon = null;
               titleText = resourceManager.getString(BUNDLE,"TITLE");
               this.m_UIUpButton.visible = false;
            }
            this.m_UISlotHolder.verticalScrollPosition = 0;
            this.m_UncommittedContainer = false;
         }
         super.commitProperties();
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
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIUpButton = new Button();
            this.m_UIUpButton.styleName = getStyle("upButtonStyle");
            this.m_UIUpButton.visible = m_Container != null && Boolean(m_Container.isSubContainer);
            this.m_UIUpButton.addEventListener(MouseEvent.CLICK,this.onUpButtonClick);
            header.addChildAt(this.m_UIUpButton,header.numChildren - 2);
            this.m_UISlotHolder = new ContainerSlotHolder();
            this.m_UISlotHolder.height = NaN;
            this.m_UISlotHolder.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.m_UISlotHolder.percentWidth = NaN;
            this.m_UISlotHolder.percentHeight = 100;
            this.m_UISlotHolder.styleName = new StyleProxy(this,SLOT_HOLDER_STYLE_FILTER);
            this.m_UISlotHolder.verticalScrollPolicy = ScrollPolicy.ON;
            this.m_UISlotHolder.width = unscaledInnerWidth;
            this.m_UISlotHolder.setStyle("backgroundAlpha",0);
            this.m_UISlotHolder.setStyle("backgroundColor",65280);
            this.m_UISlotHolder.setStyle("borderAlpha",0);
            this.m_UISlotHolder.setStyle("borderColor",65280);
            this.m_UISlotHolder.setStyle("borderSkin",VectorBorderSkin);
            this.m_UISlotHolder.setStyle("borderThickness",0);
            addChild(this.m_UISlotHolder);
            this.m_UIConstructed = true;
         }
      }
      
      protected function onUpButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:ContainerStorage = null;
         if(param1 != null)
         {
            _loc2_ = Tibia.s_GetContainerStorage();
            if(_loc2_ != null && container != null && Boolean(container.isSubContainer))
            {
               _loc2_.sendUpContainer(container);
            }
         }
      }
      
      override protected function measure() : void
      {
         var _loc1_:EdgeMetrics = null;
         _loc1_ = viewMetricsAndPadding;
         measuredMinWidth = DEFAULT_WIDGET_WIDTH;
         measuredWidth = DEFAULT_WIDGET_WIDTH;
         measuredMinHeight = _loc1_.top + _loc1_.bottom + (!isNaN(this.m_UISlotHolder.explicitMinHeight)?this.m_UISlotHolder.explicitMinHeight:this.m_UISlotHolder.measuredMinHeight);
         if(isNaN(measuredMaxHeight))
         {
            measuredHeight = _loc1_.top + _loc1_.bottom + this.m_UISlotHolder.getExplicitOrMeasuredHeight();
         }
         measuredMaxHeight = _loc1_.top + _loc1_.bottom + (!isNaN(this.m_UISlotHolder.explicitMaxHeight)?this.m_UISlotHolder.explicitMaxHeight:this.m_UISlotHolder.measuredMaxHeight);
      }
   }
}

import mx.containers.Tile;
import tibia.container.containerWidgetClasses.IContainerSlot;
import mx.core.mx_internal;
import mx.core.EdgeMetrics;
import mx.containers.TileDirection;

class ContainerSlotHolder extends Tile
{
    
   private var m_MeasuredMaxHeight:Number = NaN;
   
   function ContainerSlotHolder()
   {
      super();
      direction = TileDirection.HORIZONTAL;
   }
   
   override protected function measure() : void
   {
      var _loc1_:Number = NaN;
      var _loc2_:Number = NaN;
      var _loc12_:IContainerSlot = null;
      mx_internal::findCellSize();
      _loc1_ = getStyle("horizontalGap");
      _loc2_ = getStyle("verticalGap");
      var _loc3_:EdgeMetrics = viewMetricsAndPadding;
      var _loc4_:int = numChildren;
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      while(_loc6_ < _loc4_)
      {
         _loc12_ = getChildAt(_loc6_) as IContainerSlot;
         if(_loc12_ != null && _loc12_.appearance != null)
         {
            _loc5_++;
         }
         _loc6_++;
      }
      var _loc7_:int = -1;
      var _loc8_:int = -1;
      var _loc9_:int = -1;
      if(!isNaN(explicitWidth))
      {
         _loc7_ = Math.floor((explicitWidth + _loc1_ - _loc3_.left - _loc3_.right) / (mx_internal::cellWidth + _loc1_));
      }
      if(_loc7_ < 0)
      {
         _loc7_ = Math.floor(Math.sqrt(_loc4_));
      }
      if(_loc7_ < 1)
      {
         _loc7_ = 1;
      }
      _loc8_ = Math.ceil(_loc4_ / _loc7_);
      if(_loc8_ < 1)
      {
         _loc8_ = 1;
      }
      _loc9_ = Math.ceil(_loc5_ / _loc7_);
      if(_loc9_ < 1)
      {
         _loc9_ = 1;
      }
      var _loc10_:Number = _loc3_.left + _loc3_.right;
      var _loc11_:Number = _loc3_.top + _loc3_.bottom;
      measuredMinWidth = _loc10_ + mx_internal::cellWidth;
      measuredWidth = _loc10_ + (_loc7_ - 1) * _loc1_ + _loc7_ * mx_internal::cellWidth;
      measuredMinHeight = _loc11_ + mx_internal::cellHeight;
      measuredHeight = _loc11_ + (_loc9_ - 1) * _loc2_ + _loc9_ * mx_internal::cellHeight;
      this.measuredMaxHeight = _loc11_ + (_loc8_ - 1) * _loc2_ + _loc8_ * mx_internal::cellHeight;
   }
   
   public function set measuredMaxHeight(param1:Number) : void
   {
      this.m_MeasuredMaxHeight = param1;
   }
   
   public function get measuredMaxHeight() : Number
   {
      return this.m_MeasuredMaxHeight;
   }
}
