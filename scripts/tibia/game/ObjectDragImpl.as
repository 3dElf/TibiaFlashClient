package tibia.game
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.input.gameaction.*;

    public class ObjectDragImpl extends Object
    {
        private var m_DragObject:ObjectInstance = null;
        private var m_DragPosition:int = -1;
        private var m_DragStart:Vector3D = null;
        static const DRAG_OPACITY:Number = 0.75;
        static const DRAG_TYPE_OBJECT:String = "object";
        static const DRAG_TYPE_CHANNEL:String = "channel";
        static const DRAG_TYPE_SPELL:String = "spell";
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        static const DRAG_TYPE_ACTION:String = "action";

        public function ObjectDragImpl()
        {
            return;
        }// end function

        private function onMouseUp(event:Event) : void
        {
            this.removeDragInitListeners(InteractiveObject(event.currentTarget));
            return;
        }// end function

        protected function onDragDrop(event:DragEvent) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = null;
            var _loc_6:* = event.dragSource;
            _loc_2 = event.dragSource;
            if (_loc_6 != null && _loc_2.hasFormat("dragType") && _loc_2.dataForFormat("dragType") == DRAG_TYPE_OBJECT && _loc_2.hasFormat("dragStart") && _loc_2.hasFormat("dragPosition") && _loc_2.hasFormat("dragObject"))
            {
                _loc_3 = event.target;
                while (_loc_3 != null && !(_loc_3 is IMoveWidget) && !(_loc_3 is Stage))
                {
                    
                    _loc_3 = _loc_3.parent;
                }
                _loc_4 = null;
                var _loc_6:* = _loc_3.pointToAbsolute(new Point(event.stageX, event.stageY));
                _loc_4 = _loc_3.pointToAbsolute(new Point(event.stageX, event.stageY));
                if (_loc_3 != null && _loc_6 != null)
                {
                    _loc_5 = 0;
                    if (event.shiftKey)
                    {
                        _loc_5 = 1;
                    }
                    else if (event.ctrlKey)
                    {
                        _loc_5 = MoveActionImpl.MOVE_ASK;
                    }
                    else
                    {
                        _loc_5 = MoveActionImpl.MOVE_ALL;
                    }
                    Tibia.s_GameActionFactory.createMoveAction(_loc_2.dataForFormat("dragStart") as Vector3D, _loc_2.dataForFormat("dragObject") as ObjectInstance, _loc_2.dataForFormat("dragPosition") as Number, _loc_4, _loc_5).perform();
                }
            }
            return;
        }// end function

        public function removeDragComponent(param1:InteractiveObject) : void
        {
            if (param1 != null)
            {
                param1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                param1.removeEventListener(DragEvent.DRAG_DROP, this.onDragDrop);
                param1.removeEventListener(DragEvent.DRAG_ENTER, this.onDragEnter);
            }
            return;
        }// end function

        private function onMouseDown(event:MouseEvent) : void
        {
            this.m_DragStart = null;
            this.m_DragPosition = -1;
            this.m_DragObject = null;
            this.removeDragInitListeners(InteractiveObject(event.currentTarget));
            var _loc_2:* = event.currentTarget;
            while (_loc_2 != null && !(_loc_2 is IMoveWidget) && !(_loc_2 is Stage))
            {
                
                _loc_2 = _loc_2.parent;
            }
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = _loc_2.getMoveObjectUnderPoint(new Point(event.stageX, event.stageY));
            _loc_3 = _loc_2.getMoveObjectUnderPoint(new Point(event.stageX, event.stageY));
            var _loc_6:* = _loc_3.object as ObjectInstance;
            _loc_4 = _loc_3.object as ObjectInstance;
            var _loc_6:* = _loc_3.absolute as Vector3D;
            _loc_5 = _loc_3.absolute as Vector3D;
            if (_loc_2 != null && _loc_6 != null && _loc_6 != null && _loc_6 != null)
            {
                this.m_DragStart = _loc_5;
                this.m_DragPosition = int(_loc_3.position);
                this.m_DragObject = _loc_4;
                this.addDragInitListeners(InteractiveObject(event.currentTarget));
            }
            return;
        }// end function

        public function addDragComponent(param1:InteractiveObject) : void
        {
            if (param1 != null)
            {
                param1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                param1.addEventListener(DragEvent.DRAG_DROP, this.onDragDrop);
                param1.addEventListener(DragEvent.DRAG_ENTER, this.onDragEnter);
            }
            return;
        }// end function

        private function onDragEnter(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.dragSource;
            _loc_2 = event.dragSource;
            if (_loc_3 != null && _loc_2.hasFormat("dragType") && _loc_2.dataForFormat("dragType") == DRAG_TYPE_OBJECT && event.target is UIComponent && !(event.cancelable && event.isDefaultPrevented()))
            {
                DragManager.acceptDragDrop(UIComponent(event.currentTarget));
            }
            return;
        }// end function

        private function removeDragInitListeners(param1:InteractiveObject) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                param1.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
                param1.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            }
            if (param1 is UIComponent)
            {
                _loc_2 = UIComponent(param1).systemManager.getSandboxRoot();
                _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onMouseUp);
            }
            return;
        }// end function

        private function addDragInitListeners(param1:InteractiveObject) : void
        {
            var _loc_2:* = null;
            if (param1 != null)
            {
                param1.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
                param1.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            }
            if (param1 is UIComponent)
            {
                _loc_2 = UIComponent(param1).systemManager.getSandboxRoot();
                _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onMouseUp);
            }
            return;
        }// end function

        private function onMouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this.m_DragStart != null && this.m_DragPosition != -1 && this.m_DragObject != null && event.currentTarget is UIComponent)
            {
                _loc_2 = new DragSource();
                _loc_2.addData(DRAG_TYPE_OBJECT, "dragType");
                _loc_2.addData(this.m_DragStart, "dragStart");
                _loc_2.addData(this.m_DragPosition, "dragPosition");
                _loc_2.addData(this.m_DragObject, "dragObject");
                _loc_3 = new Image();
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = this.m_DragObject.type;
                if (_loc_6 != null && _loc_6.ID != AppearanceInstance.CREATURE && !_loc_6.isBank && !_loc_6.isClip && !_loc_6.isBottom && !_loc_6.isTop)
                {
                    _loc_7 = new Rectangle();
                    _loc_8 = this.m_DragObject.getSprite(-1, -1, -1, -1);
                    _loc_9 = _loc_8.bitmapData;
                    _loc_7.copyFrom(_loc_8.rectangle);
                    _loc_10 = new Bitmap();
                    if (_loc_7 != null && _loc_9 != null)
                    {
                        _loc_10.bitmapData = new BitmapData(_loc_7.width, _loc_7.height);
                        _loc_10.bitmapData.copyPixels(_loc_9, _loc_7, new Point(0, 0));
                    }
                    _loc_3.source = _loc_10;
                    _loc_4 = _loc_7.width - _loc_6.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                    _loc_5 = _loc_7.height - _loc_6.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].exactSize;
                }
                this.m_DragStart = null;
                this.m_DragPosition = -1;
                this.m_DragObject = null;
                DragManager.doDrag(UIComponent(event.currentTarget), _loc_2, event, _loc_3, -UIComponent(event.currentTarget).mouseX + _loc_4, -UIComponent(event.currentTarget).mouseY + _loc_5, DRAG_OPACITY);
                this.removeDragInitListeners(InteractiveObject(event.currentTarget));
            }
            return;
        }// end function

    }
}
