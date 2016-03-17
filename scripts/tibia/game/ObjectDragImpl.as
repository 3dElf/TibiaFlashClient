package tibia.game
{
   import flash.events.Event;
   import mx.core.IUIComponent;
   import flash.events.MouseEvent;
   import mx.events.DragEvent;
   import flash.geom.Point;
   import flash.display.DisplayObject;
   import tibia.appearances.ObjectInstance;
   import shared.utility.Vector3D;
   import mx.core.DragSource;
   import tibia.input.gameaction.MoveActionImpl;
   import mx.events.SandboxMouseEvent;
   import mx.managers.DragManager;
   import mx.controls.Image;
   import tibia.appearances.AppearanceType;
   import flash.geom.Rectangle;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import tibia.appearances.AppearanceInstance;
   
   public class ObjectDragImpl
   {
      
      protected static const DRAG_OPACITY:Number = 0.75;
      
      protected static const DRAG_TYPE_OBJECT:String = "object";
      
      protected static const DRAG_TYPE_CHANNEL:String = "channel";
      
      protected static const DRAG_TYPE_SPELL:String = "spell";
      
      protected static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
      
      protected static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
      
      protected static const DRAG_TYPE_ACTION:String = "action";
       
      protected var m_DragObject:ObjectInstance = null;
      
      protected var m_DragPosition:int = -1;
      
      protected var m_DragStart:Vector3D = null;
      
      public function ObjectDragImpl()
      {
         super();
      }
      
      protected function onMouseUp(param1:Event) : void
      {
         if(param1 != null)
         {
            this.updateDragInitListeners(param1.currentTarget as IUIComponent,false);
         }
      }
      
      protected function updateDragListeners(param1:IUIComponent, param2:Boolean) : void
      {
         if(param1 != null)
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            param1.addEventListener(DragEvent.DRAG_DROP,this.onDragDrop);
            param1.addEventListener(DragEvent.DRAG_ENTER,this.onDragEnter);
         }
         else
         {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            param1.removeEventListener(DragEvent.DRAG_DROP,this.onDragDrop);
            param1.removeEventListener(DragEvent.DRAG_ENTER,this.onDragEnter);
         }
      }
      
      public function removeDragComponent(param1:IUIComponent) : void
      {
         this.updateDragListeners(param1,false);
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:IUIComponent = null;
         var _loc3_:Point = null;
         var _loc4_:IMoveWidget = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Object = null;
         var _loc7_:ObjectInstance = null;
         var _loc8_:Vector3D = null;
         this.m_DragStart = null;
         this.m_DragPosition = -1;
         this.m_DragObject = null;
         this.updateDragInitListeners(param1.currentTarget as IUIComponent,false);
         if(param1 != null)
         {
            _loc2_ = param1.currentTarget as IUIComponent;
            _loc3_ = null;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.localToGlobal(new Point(param1.localX,param1.localY));
            }
            _loc4_ = null;
            _loc5_ = param1.currentTarget as DisplayObject;
            while(_loc5_ != null && (_loc4_ = _loc5_ as IMoveWidget) == null)
            {
               _loc5_ = _loc5_.parent;
            }
            _loc6_ = null;
            _loc7_ = null;
            _loc8_ = null;
            if(_loc4_ != null && _loc3_ != null && (_loc6_ = _loc4_.getMoveObjectUnderPoint(_loc3_)) != null && (_loc7_ = _loc6_.object as ObjectInstance) != null && (_loc8_ = _loc6_.absolute as Vector3D) != null)
            {
               this.m_DragStart = _loc8_;
               this.m_DragPosition = int(_loc6_.position);
               this.m_DragObject = _loc7_;
               this.updateDragInitListeners(_loc2_,true);
            }
         }
      }
      
      protected function onDragDrop(param1:DragEvent) : void
      {
         var _loc3_:IUIComponent = null;
         var _loc4_:Point = null;
         var _loc5_:IMoveWidget = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Vector3D = null;
         var _loc8_:int = 0;
         var _loc2_:DragSource = null;
         if(param1 != null && (_loc2_ = param1.dragSource) != null && Boolean(_loc2_.hasFormat("dragType")) && _loc2_.dataForFormat("dragType") == DRAG_TYPE_OBJECT && Boolean(_loc2_.hasFormat("dragStart")) && Boolean(_loc2_.hasFormat("dragPosition")) && Boolean(_loc2_.hasFormat("dragObject")))
         {
            _loc3_ = param1.currentTarget as IUIComponent;
            _loc4_ = null;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.localToGlobal(new Point(param1.localX,param1.localY));
            }
            _loc5_ = null;
            _loc6_ = param1.currentTarget as DisplayObject;
            while(_loc6_ != null && (_loc5_ = _loc6_ as IMoveWidget) == null)
            {
               _loc6_ = _loc6_.parent;
            }
            _loc7_ = null;
            if(_loc5_ != null && _loc4_ != null && (_loc7_ = _loc5_.pointToAbsolute(_loc4_)) != null)
            {
               _loc8_ = 0;
               if(param1.shiftKey)
               {
                  _loc8_ = 1;
               }
               else if(param1.ctrlKey)
               {
                  _loc8_ = MoveActionImpl.MOVE_ASK;
               }
               else
               {
                  _loc8_ = MoveActionImpl.MOVE_ALL;
               }
               new MoveActionImpl(_loc2_.dataForFormat("dragStart") as Vector3D,_loc2_.dataForFormat("dragObject") as ObjectInstance,_loc2_.dataForFormat("dragPosition") as Number,_loc7_,_loc8_).perform();
            }
         }
      }
      
      public function addDragComponent(param1:IUIComponent) : void
      {
         this.updateDragListeners(param1,true);
      }
      
      protected function updateDragInitListeners(param1:IUIComponent, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         if(param1 != null)
         {
            _loc3_ = param1.systemManager.getSandboxRoot();
            if(param2)
            {
               param1.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               param1.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               _loc3_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onMouseUp);
            }
            else
            {
               param1.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               param1.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               _loc3_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.onMouseUp);
            }
         }
      }
      
      protected function onDragEnter(param1:DragEvent) : void
      {
         var _loc3_:IUIComponent = null;
         var _loc2_:DragSource = null;
         if(param1 != null && (_loc2_ = param1.dragSource) != null && Boolean(_loc2_.hasFormat("dragType")) && _loc2_.dataForFormat("dragType") == DRAG_TYPE_OBJECT)
         {
            _loc3_ = param1.currentTarget as IUIComponent;
            DragManager.acceptDragDrop(_loc3_);
         }
      }
      
      protected function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:DragSource = null;
         var _loc3_:Image = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:AppearanceType = null;
         var _loc7_:Rectangle = null;
         var _loc8_:BitmapData = null;
         var _loc9_:Bitmap = null;
         if(param1 != null && this.m_DragStart != null && this.m_DragPosition != -1 && this.m_DragObject != null)
         {
            _loc2_ = new DragSource();
            _loc2_.addData(DRAG_TYPE_OBJECT,"dragType");
            _loc2_.addData(this.m_DragStart,"dragStart");
            _loc2_.addData(this.m_DragPosition,"dragPosition");
            _loc2_.addData(this.m_DragObject,"dragObject");
            _loc3_ = new Image();
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = this.m_DragObject.type;
            if(_loc6_ != null && _loc6_.ID != AppearanceInstance.CREATURE && !_loc6_.isBank && !_loc6_.isClip && !_loc6_.isBottom && !_loc6_.isTop)
            {
               _loc7_ = new Rectangle();
               _loc8_ = this.m_DragObject.getSprite(-1,-1,-1,-1,_loc7_);
               _loc9_ = new Bitmap();
               if(_loc7_ != null && _loc8_ != null)
               {
                  _loc9_.bitmapData = new BitmapData(_loc7_.width,_loc7_.height);
                  _loc9_.bitmapData.copyPixels(_loc8_,_loc7_,new Point(0,0));
               }
               _loc3_.source = _loc9_;
               _loc4_ = _loc7_.width - _loc6_.exactSize;
               _loc5_ = _loc7_.height - _loc6_.exactSize;
            }
            this.m_DragStart = null;
            this.m_DragPosition = -1;
            this.m_DragObject = null;
            DragManager.doDrag(param1.currentTarget as IUIComponent,_loc2_,param1,_loc3_,-param1.localX + _loc4_,-param1.localY + _loc5_,DRAG_OPACITY);
            this.updateDragInitListeners(param1.currentTarget as IUIComponent,false);
         }
      }
   }
}
