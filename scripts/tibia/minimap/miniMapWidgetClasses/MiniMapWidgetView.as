package tibia.minimap.miniMapWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import mx.controls.Button;
   import flash.events.MouseEvent;
   import tibia.minimap.MiniMapWidget;
   import tibia.§sidebar:ns_sidebar_internal§.widgetInstance;
   import shared.controls.CustomButton;
   import tibia.minimap.MiniMapStorage;
   import shared.utility.Vector3D;
   import tibia.creatures.Player;
   import tibia.network.Communication;
   import tibia.chat.MessageMode;
   import mx.core.EdgeMetrics;
   import mx.core.UIComponent;
   import mx.core.ScrollPolicy;
   
   public class MiniMapWidgetView extends WidgetView
   {
      
      public static const BUNDLE:String = "MiniMapWidget";
      
      private static const WIDGET_VIEW_HEIGHT:Number = 108;
      
      private static const WIDGET_VIEW_WIDTH:Number = 176;
      
      private static const WIDGET_COMPONENT_POSITIONS:Array = [{
         "left":1,
         "top":1,
         "width":NaN,
         "height":NaN
      },{
         "left":158,
         "top":23,
         "width":NaN,
         "height":NaN
      },{
         "left":133,
         "top":8,
         "width":NaN,
         "height":NaN
      },{
         "left":118,
         "top":23,
         "width":NaN,
         "height":NaN
      },{
         "left":133,
         "top":48,
         "width":NaN,
         "height":NaN
      },{
         "left":122,
         "top":71,
         "width":NaN,
         "height":NaN
      },{
         "left":122,
         "top":91,
         "width":NaN,
         "height":NaN
      },{
         "left":150,
         "top":72,
         "width":NaN,
         "height":NaN
      },{
         "left":151,
         "top":95,
         "width":NaN,
         "height":NaN
      },{
         "left":134,
         "top":24,
         "width":NaN,
         "height":NaN
      }];
       
      private var m_UncommittedZoom:Boolean = false;
      
      protected var m_Zoom:int = 0;
      
      protected var m_UIButtonEast:Button = null;
      
      private var m_UncommittedMiniMapStorage:Boolean = false;
      
      private var m_UIConstructed:Boolean = false;
      
      protected var m_UIButtonSouth:Button = null;
      
      private var m_UncommittedHighlightEnd:Boolean = false;
      
      protected var m_HighlightEnd:Number = 0;
      
      protected var m_UIButtonDown:Button = null;
      
      protected var m_UIButtonUp:Button = null;
      
      protected var m_UIButtonWest:Button = null;
      
      private var m_UncommittedPosition:Boolean = false;
      
      protected var m_PositionX:int = -1;
      
      protected var m_PositionY:int = -1;
      
      protected var m_PositionZ:int = -1;
      
      protected var m_UIButtonZoomOut:Button = null;
      
      protected var m_MiniMapStorage:MiniMapStorage = null;
      
      protected var m_UIView:tibia.minimap.miniMapWidgetClasses.MiniMapRenderer = null;
      
      protected var m_UIButtonCenter:Button = null;
      
      protected var m_UIButtonNorth:Button = null;
      
      protected var m_UIButtonZoomIn:Button = null;
      
      public function MiniMapWidgetView()
      {
         super();
         titleText = resourceManager.getString(BUNDLE,"TITLE");
         horizontalScrollPolicy = ScrollPolicy.OFF;
         verticalScrollPolicy = ScrollPolicy.OFF;
      }
      
      function get highlightEnd() : Number
      {
         return this.m_HighlightEnd;
      }
      
      protected function onButtonClick(param1:MouseEvent) : void
      {
         var _loc2_:MiniMapWidget = null;
         var _loc3_:int = 0;
         if(param1 != null && widgetInstance is MiniMapWidget)
         {
            _loc2_ = MiniMapWidget(widgetInstance);
            _loc3_ = 1;
            if(param1.shiftKey)
            {
               _loc3_ = 10;
            }
            switch(param1.currentTarget)
            {
               case this.m_UIButtonEast:
                  _loc2_.translatePosition(_loc3_,0,0);
                  break;
               case this.m_UIButtonNorth:
                  _loc2_.translatePosition(0,-_loc3_,0);
                  break;
               case this.m_UIButtonWest:
                  _loc2_.translatePosition(-_loc3_,0,0);
                  break;
               case this.m_UIButtonSouth:
                  _loc2_.translatePosition(0,_loc3_,0);
                  break;
               case this.m_UIButtonUp:
                  _loc2_.translatePosition(0,0,-1);
                  break;
               case this.m_UIButtonDown:
                  _loc2_.translatePosition(0,0,1);
                  break;
               case this.m_UIButtonZoomIn:
                  _loc2_.zoom = _loc2_.zoom + 1;
                  break;
               case this.m_UIButtonZoomOut:
                  _loc2_.zoom = _loc2_.zoom - 1;
                  break;
               case this.m_UIButtonCenter:
                  _loc2_.centerPosition();
            }
         }
      }
      
      override protected function createChildren() : void
      {
         if(!this.m_UIConstructed)
         {
            super.createChildren();
            this.m_UIView = new tibia.minimap.miniMapWidgetClasses.MiniMapRenderer();
            this.m_UIView.addEventListener(MouseEvent.CLICK,this.onViewClick);
            this.m_UIView.addEventListener(MouseEvent.RIGHT_CLICK,this.onViewClick);
            this.m_UIView.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            addChild(this.m_UIView);
            this.m_UIButtonEast = new CustomButton();
            this.m_UIButtonEast.styleName = getStyle("buttonEastStyle");
            this.m_UIButtonEast.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_EAST");
            this.m_UIButtonEast.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonEast);
            this.m_UIButtonNorth = new CustomButton();
            this.m_UIButtonNorth.styleName = getStyle("buttonNorthStyle");
            this.m_UIButtonNorth.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_NORTH");
            this.m_UIButtonNorth.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonNorth);
            this.m_UIButtonWest = new CustomButton();
            this.m_UIButtonWest.styleName = getStyle("buttonWestStyle");
            this.m_UIButtonWest.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_WEST");
            this.m_UIButtonWest.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonWest);
            this.m_UIButtonSouth = new CustomButton();
            this.m_UIButtonSouth.styleName = getStyle("buttonSouthStyle");
            this.m_UIButtonSouth.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_SOUTH");
            this.m_UIButtonSouth.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonSouth);
            this.m_UIButtonUp = new CustomButton();
            this.m_UIButtonUp.styleName = getStyle("buttonUpStyle");
            this.m_UIButtonUp.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_UP");
            this.m_UIButtonUp.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonUp);
            this.m_UIButtonDown = new CustomButton();
            this.m_UIButtonDown.styleName = getStyle("buttonDownStyle");
            this.m_UIButtonDown.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_DOWN");
            this.m_UIButtonDown.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonDown);
            this.m_UIButtonZoomIn = new CustomButton();
            this.m_UIButtonZoomIn.styleName = getStyle("buttonZoomInStyle");
            this.m_UIButtonZoomIn.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_ZOOMIN");
            this.m_UIButtonZoomIn.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonZoomIn);
            this.m_UIButtonZoomOut = new CustomButton();
            this.m_UIButtonZoomOut.styleName = getStyle("buttonZoomOutStyle");
            this.m_UIButtonZoomOut.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_ZOOMOUT");
            this.m_UIButtonZoomOut.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonZoomOut);
            this.m_UIButtonCenter = new CustomButton();
            this.m_UIButtonCenter.styleName = getStyle("buttonCenterStyle");
            this.m_UIButtonCenter.toolTip = resourceManager.getString(BUNDLE,"BTN_TOOLTIP_CENTER");
            this.m_UIButtonCenter.addEventListener(MouseEvent.CLICK,this.onButtonClick);
            addChild(this.m_UIButtonCenter);
            this.m_UIConstructed = true;
         }
      }
      
      function set highlightEnd(param1:Number) : void
      {
         if(this.m_HighlightEnd != param1)
         {
            this.m_HighlightEnd = param1;
            this.m_UncommittedHighlightEnd = true;
            invalidateProperties();
         }
      }
      
      function set zoom(param1:int) : void
      {
         if(this.m_Zoom != param1)
         {
            this.m_Zoom = param1;
            this.m_UncommittedZoom = true;
            invalidateProperties();
         }
      }
      
      function setPosition(param1:int, param2:int, param3:int) : void
      {
         if(this.m_PositionX != param1 || this.m_PositionY != param2 || this.m_PositionZ != param3)
         {
            this.m_PositionX = param1;
            this.m_PositionY = param2;
            this.m_PositionZ = param3;
            this.m_UncommittedPosition = true;
            invalidateProperties();
         }
      }
      
      function get miniMapStorage() : MiniMapStorage
      {
         return this.m_MiniMapStorage;
      }
      
      override function releaseInstance() : void
      {
         super.releaseInstance();
         this.m_UIButtonCenter.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonDown.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonEast.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonNorth.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonSouth.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonUp.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonWest.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonZoomIn.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIButtonZoomOut.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         this.m_UIView.removeEventListener(MouseEvent.CLICK,this.onViewClick);
         this.m_UIView.removeEventListener(MouseEvent.RIGHT_CLICK,this.onViewClick);
         this.m_UIView.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
      }
      
      protected function onViewClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Vector3D = null;
         var _loc4_:Player = null;
         var _loc5_:MiniMapStorage = null;
         var _loc6_:Communication = null;
         if(param1 != null && widgetInstance is MiniMapWidget)
         {
            _loc2_ = this.m_UIView.pointToMark(param1.localX,param1.localY);
            _loc3_ = null;
            if(_loc2_ != null)
            {
               _loc3_ = new Vector3D(_loc2_.x,_loc2_.y,_loc2_.z);
            }
            else
            {
               _loc3_ = this.m_UIView.pointToAbsolute(param1.localX,param1.localY);
            }
            if(_loc3_ != null)
            {
               switch(param1.type)
               {
                  case MouseEvent.CLICK:
                     _loc4_ = Tibia.s_GetPlayer();
                     if(_loc4_ != null)
                     {
                        if(false && Boolean(param1.ctrlKey) && Boolean(param1.shiftKey))
                        {
                           _loc6_ = Tibia.s_GetCommunication();
                           _loc6_.sendCTALK(MessageMode.MESSAGE_SAY,"alani " + _loc3_.x + "," + _loc3_.y + "," + _loc3_.z);
                        }
                        else
                        {
                           _loc4_.startAutowalk(_loc3_.x,_loc3_.y,_loc3_.z,false,false);
                        }
                     }
                     break;
                  case MouseEvent.RIGHT_CLICK:
                     _loc5_ = MiniMapWidget(widgetInstance).miniMapStorage;
                     if(_loc5_ != null)
                     {
                        new MiniMapWidgetContextMenu(_loc5_,_loc3_.x,_loc3_.y,_loc3_.z).display(this,param1.stageX,param1.stageY);
                     }
               }
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedMiniMapStorage)
         {
            this.m_UIView.miniMapStorage = this.miniMapStorage;
            this.m_UncommittedMiniMapStorage = false;
         }
         if(this.m_UncommittedPosition)
         {
            this.m_UIView.setPosition(this.positionX,this.positionY,this.positionZ);
            this.m_UncommittedPosition = false;
         }
         if(this.m_UncommittedZoom)
         {
            this.m_UIView.zoom = this.zoom;
            this.m_UncommittedZoom = false;
         }
         if(this.m_UncommittedHighlightEnd)
         {
            this.m_UIView.highlightEnd = this.highlightEnd;
            this.m_UncommittedHighlightEnd = false;
         }
      }
      
      function get positionX() : int
      {
         return this.m_PositionX;
      }
      
      function get positionZ() : int
      {
         return this.m_PositionZ;
      }
      
      function get zoom() : int
      {
         return this.m_Zoom;
      }
      
      function get positionY() : int
      {
         return this.m_PositionY;
      }
      
      override protected function measure() : void
      {
         var _loc1_:EdgeMetrics = null;
         super.measure();
         _loc1_ = viewMetricsAndPadding;
         measuredMinWidth = measuredWidth = _loc1_.left + WIDGET_VIEW_WIDTH + _loc1_.right;
         measuredMinHeight = measuredHeight = _loc1_.top + WIDGET_VIEW_HEIGHT + _loc1_.bottom;
      }
      
      function set miniMapStorage(param1:MiniMapStorage) : void
      {
         if(this.m_MiniMapStorage != param1)
         {
            this.m_MiniMapStorage = param1;
            this.m_UncommittedMiniMapStorage = true;
            invalidateProperties();
         }
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:MiniMapWidget = null;
         if(param1 != null && widgetInstance is MiniMapWidget)
         {
            _loc2_ = MiniMapWidget(widgetInstance);
            if(param1.delta > 0)
            {
               _loc2_.zoom = _loc2_.zoom + 1;
            }
            else if(param1.delta < 0)
            {
               _loc2_.zoom = _loc2_.zoom - 1;
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc4_:UIComponent = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         super.updateDisplayList(param1,param2);
         var _loc3_:int = 0;
         while(_loc3_ < WIDGET_COMPONENT_POSITIONS.length)
         {
            _loc4_ = UIComponent(getChildAt(_loc3_));
            _loc4_.move(WIDGET_COMPONENT_POSITIONS[_loc3_].left,WIDGET_COMPONENT_POSITIONS[_loc3_].top);
            _loc5_ = WIDGET_COMPONENT_POSITIONS[_loc3_].width;
            _loc6_ = WIDGET_COMPONENT_POSITIONS[_loc3_].height;
            if(isNaN(_loc5_))
            {
               _loc5_ = _loc4_.getExplicitOrMeasuredHeight();
            }
            if(isNaN(_loc6_))
            {
               _loc6_ = _loc4_.getExplicitOrMeasuredWidth();
            }
            _loc4_.setActualSize(_loc6_,_loc5_);
            _loc3_++;
         }
      }
   }
}
