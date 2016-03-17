package tibia.container.containerWidgetClasses
{
   import tibia.sidebar.sideBarWidgetClasses.WidgetView;
   import tibia.game.IUseWidget;
   import tibia.game.IMoveWidget;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import flash.events.MouseEvent;
   import tibia.options.OptionsStorage;
   import shared.utility.Vector3D;
   import tibia.input.gameaction.UseActionImpl;
   import tibia.input.gameaction.LookActionImpl;
   import tibia.game.ObjectContextMenu;
   import tibia.container.Container;
   import flash.geom.Point;
   import tibia.game.ObjectDragImpl;
   import flash.display.DisplayObjectContainer;
   import tibia.container.ContainerStorage;
   import mx.events.PropertyChangeEvent;
   import mx.core.ClassFactory;
   import tibia.appearances.AppearanceInstance;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   
   public class ContainerWidgetViewBase extends WidgetView implements IUseWidget, IMoveWidget
   {
      
      protected static const ACTION_UNSET:int = -1;
      
      protected static const ACTION_NONE:int = 0;
      
      protected static const ACTION_CONTEXT_MENU:int = 1;
      
      protected static const ACTION_LOOK:int = 2;
      
      protected static const ACTION_USE:int = 3;
      
      {
         s_InitializeStyle();
      }
      
      protected var m_DragHandler:ObjectDragImpl;
      
      protected var m_Container:Container = null;
      
      private var m_UncommittedSlotFactory:Boolean = false;
      
      private var m_UncommittedContainer:Boolean = false;
      
      protected var m_SlotFactory:ClassFactory = null;
      
      public function ContainerWidgetViewBase()
      {
         super();
         this.m_DragHandler = new ObjectDragImpl();
      }
      
      private static function s_InitializeStyle() : void
      {
         var Selector:String = "ContainerWidgetViewBase";
         var Style:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Style == null)
         {
            Style = new CSSStyleDeclaration(Selector);
         }
         Style.defaultFactory = function():void
         {
            ContainerWidgetViewBase.horizontalGap = 2;
            ContainerWidgetViewBase.verticalGap = 2;
            ContainerWidgetViewBase.slotBackgroundImage = undefined;
            ContainerWidgetViewBase.slotBackgroundColor = 0;
            ContainerWidgetViewBase.slotBackgroundAlpha = 1;
         };
         StyleManager.setStyleDeclaration(Selector,Style,true);
      }
      
      protected function onSlotMouseClick(param1:MouseEvent) : void
      {
         var _loc3_:OptionsStorage = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Vector3D = null;
         var _loc7_:int = 0;
         var _loc2_:IContainerSlot = null;
         if(param1 != null && (_loc2_ = param1.target as IContainerSlot) != null && this.m_Container != null)
         {
            _loc3_ = Tibia.s_GetOptions();
            _loc4_ = {
               "position":_loc2_.position,
               "object":_loc2_.appearance
            };
            _loc5_ = {
               "position":_loc2_.position,
               "object":_loc2_.appearance
            };
            _loc6_ = this.getSlotCoordinate(_loc2_);
            _loc7_ = ACTION_UNSET;
            if(param1.type == MouseEvent.CLICK && !param1.shiftKey && !param1.ctrlKey && !param1.altKey)
            {
               _loc7_ = ACTION_NONE;
            }
            else if(_loc3_ != null && Boolean(_loc3_.generalInputClassicControls))
            {
               if(param1.altKey)
               {
                  _loc7_ = ACTION_USE;
               }
               else if(param1.ctrlKey)
               {
                  _loc7_ = ACTION_CONTEXT_MENU;
               }
               else if(param1.shiftKey)
               {
                  _loc7_ = ACTION_LOOK;
               }
               else
               {
                  _loc7_ = ACTION_USE;
               }
            }
            else if(param1.altKey)
            {
               _loc7_ = ACTION_CONTEXT_MENU;
            }
            else if(param1.ctrlKey)
            {
               _loc7_ = ACTION_USE;
            }
            else if(param1.shiftKey)
            {
               _loc7_ = ACTION_LOOK;
            }
            else
            {
               _loc7_ = ACTION_CONTEXT_MENU;
            }
            switch(_loc7_)
            {
               case ACTION_NONE:
                  break;
               case ACTION_USE:
                  if(_loc5_.object != null)
                  {
                     new UseActionImpl(_loc6_,_loc5_.object,_loc6_.z,UseActionImpl.TARGET_AUTO).perform();
                  }
                  break;
               case ACTION_LOOK:
                  if(_loc4_.object != null)
                  {
                     new LookActionImpl(_loc6_,_loc4_.object,_loc4_.position).perform();
                  }
                  break;
               case ACTION_CONTEXT_MENU:
                  if(_loc4_.object != null || _loc5_.object != null)
                  {
                     new ObjectContextMenu(_loc6_,_loc4_,_loc5_,null).display(this,param1.stageX,param1.stageY);
                  }
                  break;
               case ACTION_UNSET:
               default:
                  log("ContainerWidgetViewBase.onSlotMouseClick: Unhandled event: " + param1 + ", action: " + _loc7_);
            }
         }
      }
      
      function get container() : Container
      {
         return this.m_Container;
      }
      
      public function pointToAbsolute(param1:Point) : Vector3D
      {
         var _loc2_:IContainerSlot = this.getSlotUnderPoint(param1);
         if(_loc2_ != null)
         {
            return this.getSlotCoordinate(_loc2_);
         }
         return null;
      }
      
      protected function get slotHolder() : DisplayObjectContainer
      {
         return this;
      }
      
      protected function getSlotCoordinate(param1:IContainerSlot) : Vector3D
      {
         var _loc2_:Vector3D = new Vector3D(65535,0,0);
         if(this.m_Container.window < 0)
         {
            _loc2_.y = ContainerStorage.BODY_HEAD + param1.position;
            _loc2_.z = 0;
         }
         else
         {
            _loc2_.y = 64 + this.m_Container.window;
            _loc2_.z = param1.position;
         }
         return _loc2_;
      }
      
      protected function updateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = this.slotHolder.numChildren - 1;
         _loc2_ = this.container != null && !this.m_UncommittedSlotFactory?int(this.container.capacity):0;
         while(_loc1_ >= _loc2_)
         {
            this.destroySlot(_loc1_);
            _loc1_--;
         }
         _loc1_ = this.slotHolder.numChildren;
         _loc2_ = this.container != null?int(this.container.capacity):0;
         while(_loc1_ < _loc2_)
         {
            this.createSlot(null,_loc1_);
            _loc1_++;
         }
         var _loc3_:IContainerSlot = null;
         _loc1_ = 0;
         _loc2_ = this.container != null?int(Math.min(this.container.capacity,this.container.length)):0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = IContainerSlot(this.slotHolder.getChildAt(_loc1_));
            _loc3_.appearance = this.container.getItemAt(_loc1_);
            _loc1_++;
         }
         _loc2_ = this.container != null?int(this.container.capacity):0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = IContainerSlot(this.slotHolder.getChildAt(_loc1_));
            _loc3_.appearance = null;
            _loc1_++;
         }
      }
      
      function set container(param1:Container) : void
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
      
      protected function set slotFactory(param1:ClassFactory) : void
      {
         if(this.m_SlotFactory != param1)
         {
            this.m_SlotFactory = param1;
            this.m_UncommittedSlotFactory = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedContainer)
         {
            this.updateSlots();
            this.m_UncommittedContainer = false;
         }
         if(this.m_UncommittedSlotFactory)
         {
            this.updateSlots();
            this.m_UncommittedSlotFactory = false;
         }
      }
      
      protected function createSlot(param1:AppearanceInstance = null, param2:int = -1) : IContainerSlot
      {
         var _loc3_:IContainerSlot = this.slotFactory.newInstance();
         _loc3_.appearance = param1;
         _loc3_.position = param2;
         _loc3_.styleName = getStyle("slotStyleName");
         _loc3_.addEventListener(MouseEvent.CLICK,this.onSlotMouseClick);
         _loc3_.addEventListener(MouseEvent.RIGHT_CLICK,this.onSlotMouseClick);
         this.slotHolder.addChild(DisplayObject(_loc3_));
         this.m_DragHandler.addDragComponent(_loc3_);
         return _loc3_;
      }
      
      public function getMoveObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      protected function destroySlot(param1:int) : void
      {
         var _loc2_:IContainerSlot = IContainerSlot(this.slotHolder.removeChildAt(param1));
         _loc2_.appearance = null;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onSlotMouseClick);
         _loc2_.removeEventListener(MouseEvent.RIGHT_CLICK,this.onSlotMouseClick);
         this.m_DragHandler.removeDragComponent(_loc2_);
      }
      
      public function getMultiUseObjectUnderPoint(param1:Point) : Object
      {
         return this.getUseObjectUnderPoint(param1);
      }
      
      protected function getSlotUnderPoint(param1:Point) : IContainerSlot
      {
         var _loc2_:Array = stage.getObjectsUnderPoint(param1);
         var _loc3_:DisplayObject = null;
         var _loc4_:int = _loc2_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = DisplayObject(_loc2_[_loc4_]);
            while(_loc3_ != null && !(_loc3_ is Stage))
            {
               if(_loc3_ is IContainerSlot)
               {
                  return IContainerSlot(_loc3_);
               }
               _loc3_ = _loc3_.parent;
            }
            _loc4_--;
         }
         return null;
      }
      
      public function getUseObjectUnderPoint(param1:Point) : Object
      {
         var _loc2_:IContainerSlot = this.getSlotUnderPoint(param1);
         if(this.m_Container != null && _loc2_ != null)
         {
            return {
               "object":_loc2_.appearance,
               "absolute":this.getSlotCoordinate(_loc2_),
               "position":(this.m_Container.window < 0?0:_loc2_.position)
            };
         }
         return null;
      }
      
      public function pointToMap(param1:Point) : Vector3D
      {
         return null;
      }
      
      protected function onContainerChanged(param1:PropertyChangeEvent) : void
      {
         if(param1 != null)
         {
            switch(param1.property)
            {
               case "item":
                  this.updateSlots();
                  break;
               default:
                  log("ContainerWidgetViewBase.onContainerChanged: Unknown porperty " + param1.property + ".");
            }
         }
      }
      
      protected function get slotFactory() : ClassFactory
      {
         return this.m_SlotFactory;
      }
   }
}
