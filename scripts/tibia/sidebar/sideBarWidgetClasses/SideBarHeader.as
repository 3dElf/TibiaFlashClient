package tibia.sidebar.sideBarWidgetClasses
{
   import mx.containers.Canvas;
   import tibia.sidebar.Widget;
   import mx.controls.Button;
   import flash.events.MouseEvent;
   import mx.core.EventPriority;
   import mx.events.PropertyChangeEvent;
   import mx.core.EdgeMetrics;
   import tibia.sidebar.SideBarSet;
   import mx.core.mx_internal;
   import mx.core.IBorder;
   import mx.core.ScrollPolicy;
   
   public class SideBarHeader extends Canvas
   {
      
      private static const COMPONENT_WIDTH:Number = 159;
      
      private static const COMPONENT_HEIGHT:Number = 41;
      
      protected static const DEFAULT_WIDGET_HEIGHT:Number = 200;
      
      protected static const DEFAULT_WIDGET_WIDTH:Number = 184;
      
      private static const BUNDLE:String = "SideBarHeader";
      
      private static const COMPONENT_DEFINITIONS:Array = [{
         "toolTip":"TIP_GENERAL",
         "type":Widget.TYPE_GENERALBUTTONS,
         "style":"buttonGeneralStyle",
         "left":8,
         "top":19
      },{
         "toolTip":"TIP_COMBAT",
         "type":Widget.TYPE_COMBATCONTROL,
         "style":"buttonCombatStyle",
         "left":20,
         "top":4
      },{
         "toolTip":"TIP_MINIMAP",
         "type":Widget.TYPE_MINIMAP,
         "style":"buttonMinimapStyle",
         "left":44,
         "top":19
      },{
         "toolTip":"TIP_CONTAINER",
         "type":Widget.TYPE_CONTAINER,
         "style":"buttonContainerStyle",
         "left":128,
         "top":4
      },{
         "toolTip":"TIP_BODY",
         "type":Widget.TYPE_BODY,
         "style":"buttonBodyStyle",
         "left":56,
         "top":4
      },{
         "toolTip":"TIP_BATTLELIST",
         "type":Widget.TYPE_BATTLELIST,
         "style":"buttonBattlelistStyle",
         "left":92,
         "top":4
      },{
         "toolTip":"TIP_BUDDYLIST",
         "type":Widget.TYPE_BUDDYLIST,
         "style":"buttonBuddylistStyle",
         "left":80,
         "top":19
      },{
         "toolTip":"TIP_TRADE",
         "type":Widget.TYPE_NPCTRADE,
         "style":"buttonTradeStyle",
         "left":116,
         "top":19
      }];
       
      protected var m_Location:int = -1;
      
      private var m_UncommittedLocation:Boolean = false;
      
      private var m_UncommittedSideBarSet:Boolean = false;
      
      protected var m_SideBarSet:SideBarSet = null;
      
      private var m_UIConstructed:Boolean = false;
      
      public function SideBarHeader()
      {
         super();
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Button = null;
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            _loc1_ = 0;
            while(_loc1_ < COMPONENT_DEFINITIONS.length)
            {
               _loc2_ = new Button();
               _loc2_.data = COMPONENT_DEFINITIONS[_loc1_].type;
               _loc2_.selected = false;
               _loc2_.styleName = getStyle(COMPONENT_DEFINITIONS[_loc1_].style);
               _loc2_.toggle = true;
               _loc2_.toolTip = resourceManager.getString(BUNDLE,COMPONENT_DEFINITIONS[_loc1_].toolTip);
               _loc2_.x = COMPONENT_DEFINITIONS[_loc1_].left;
               _loc2_.y = COMPONENT_DEFINITIONS[_loc1_].top;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onButtonClick,false,EventPriority.DEFAULT + 1,false);
               addChild(_loc2_);
               _loc1_++;
            }
            this.m_UIConstructed = true;
         }
      }
      
      protected function onSideBarSetChange(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "defaultLocation":
               case "sideBarInstanceOptions":
                  this.updateButtons();
            }
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:EdgeMetrics = this.borderMetrics;
         measuredMinHeight = measuredHeight = _loc1_.top + COMPONENT_HEIGHT + _loc1_.bottom;
         measuredMinWidth = measuredWidth = _loc1_.left + COMPONENT_WIDTH + _loc1_.right;
      }
      
      public function get sideBarSet() : SideBarSet
      {
         return this.m_SideBarSet;
      }
      
      public function set location(param1:int) : void
      {
         if(this.m_Location != param1)
         {
            this.m_Location = param1;
            this.m_UncommittedLocation = true;
            invalidateProperties();
         }
      }
      
      protected function onButtonClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Button = null;
         if(param1 != null && (_loc2_ = param1.currentTarget as Button) != null && this.m_SideBarSet != null)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            _loc3_ = int(_loc2_.data);
            if(!Widget.s_GetUnique(_loc3_))
            {
               this.m_SideBarSet.setDefaultLocation(_loc3_,this.m_Location);
            }
            else if(this.m_SideBarSet.countWidgetType(_loc3_,this.m_Location) > 0)
            {
               this.m_SideBarSet.hideWidgetType(_loc3_,this.m_Location);
            }
            else
            {
               this.m_SideBarSet.showWidgetType(_loc3_,this.m_Location,-1);
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedSideBarSet)
         {
            this.updateButtons();
            this.m_UncommittedSideBarSet = false;
         }
         if(this.m_UncommittedLocation)
         {
            this.updateButtons();
            this.m_UncommittedLocation = false;
         }
      }
      
      protected function updateButtons() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Button = null;
         var _loc2_:int = numChildren - 1;
         while(_loc2_ >= 0)
         {
            if((_loc1_ = getChildAt(_loc2_) as Button) != null)
            {
               _loc3_ = int(_loc1_.data);
               if(this.m_SideBarSet == null)
               {
                  _loc1_.selected = false;
               }
               else if(!Widget.s_GetUnique(_loc3_))
               {
                  _loc1_.selected = this.m_SideBarSet.getDefaultLocation(_loc3_) == this.m_Location;
               }
               else
               {
                  _loc1_.selected = this.m_SideBarSet.countWidgetType(_loc3_,this.m_Location) > 0;
               }
            }
            _loc2_--;
         }
      }
      
      public function set sideBarSet(param1:SideBarSet) : void
      {
         if(this.m_SideBarSet != param1)
         {
            if(this.m_SideBarSet != null)
            {
               this.m_SideBarSet.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onSideBarSetChange);
            }
            this.m_SideBarSet = param1;
            if(this.m_SideBarSet != null)
            {
               this.m_SideBarSet.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onSideBarSetChange);
            }
            this.m_UncommittedSideBarSet = true;
            invalidateProperties();
         }
      }
      
      public function get location() : int
      {
         return this.m_Location;
      }
      
      override public function get borderMetrics() : EdgeMetrics
      {
         if(mx_internal::border is IBorder)
         {
            return IBorder(mx_internal::border).borderMetrics;
         }
         return super.borderMetrics;
      }
   }
}
