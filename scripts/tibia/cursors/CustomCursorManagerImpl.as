package tibia.cursors
{
    import __AS3__.vec.*;
    import flash.ui.*;
    import mx.managers.*;

    public class CustomCursorManagerImpl extends Object implements ICursorManager
    {
        private var m_CursorList:Vector.<CursorQueueItem>;
        protected var m_CursorPriority:int = -1;
        protected var m_CursorID:int = 0;
        private var m_NextCursorID:int = 1;
        private static var s_Instance:ICursorManager = null;

        public function CustomCursorManagerImpl()
        {
            this.m_CursorList = new Vector.<CursorQueueItem>;
            return;
        }// end function

        public function set currentCursorYOffset(param1:Number) : void
        {
            return;
        }// end function

        public function get currentCursorXOffset() : Number
        {
            return 0;
        }// end function

        public function get currentCursorYOffset() : Number
        {
            return 0;
        }// end function

        private function cursorClassToCursorName(param1:Class) : String
        {
            var _loc_2:* = DefaultCursor.CURSOR_NAME;
            switch(param1)
            {
                case DefaultRejectCursor:
                {
                    _loc_2 = DefaultRejectCursor.CURSOR_NAME;
                    break;
                }
                case CrosshairCursor:
                {
                    _loc_2 = CrosshairCursor.CURSOR_NAME;
                    break;
                }
                case DragCopyCursor:
                {
                    _loc_2 = DragCopyCursor.CURSOR_NAME;
                    break;
                }
                case DragLinkCursor:
                {
                    _loc_2 = DragLinkCursor.CURSOR_NAME;
                    break;
                }
                case DragMoveCursor:
                {
                    _loc_2 = DragMoveCursor.CURSOR_NAME;
                    break;
                }
                case DragNoneCursor:
                {
                    _loc_2 = DragNoneCursor.CURSOR_NAME;
                    break;
                }
                case ResizeHorizontalCursor:
                {
                    _loc_2 = ResizeHorizontalCursor.CURSOR_NAME;
                    break;
                }
                case ResizeVerticalCursor:
                {
                    _loc_2 = ResizeVerticalCursor.CURSOR_NAME;
                    break;
                }
                case AttackCursor:
                {
                    _loc_2 = AttackCursor.CURSOR_NAME;
                    break;
                }
                case WalkCursor:
                {
                    _loc_2 = WalkCursor.CURSOR_NAME;
                    break;
                }
                case UseCursor:
                {
                    _loc_2 = UseCursor.CURSOR_NAME;
                    break;
                }
                case TalkCursor:
                {
                    _loc_2 = TalkCursor.CURSOR_NAME;
                    break;
                }
                case OpenCursor:
                {
                    _loc_2 = OpenCursor.CURSOR_NAME;
                    break;
                }
                case LookCursor:
                {
                    _loc_2 = LookCursor.CURSOR_NAME;
                    break;
                }
                default:
                {
                    _loc_2 = DefaultCursor.CURSOR_NAME;
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function hideCursor() : void
        {
            return;
        }// end function

        public function removeCursor(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_CursorList.length)
            {
                
                _loc_3 = this.m_CursorList[_loc_2];
                if (_loc_3.m_CursorID == param1)
                {
                    this.m_CursorList.splice(_loc_2, 1);
                    this.showCurrentCursor();
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function set currentCursorXOffset(param1:Number) : void
        {
            return;
        }// end function

        public function get currentCursorID() : int
        {
            return this.m_CursorID;
        }// end function

        public function removeBusyCursor() : void
        {
            return;
        }// end function

        public function set currentCursorID(param1:int) : void
        {
            return;
        }// end function

        public function setCursor(param1:Class, param2:int = 2, param3:Number = 0, param4:Number = 0) : int
        {
            var _loc_7:* = this;
            this.m_NextCursorID = (this.m_NextCursorID + 1);
            _loc_7.m_NextCursorID = this.m_NextCursorID + 1;
            var _loc_5:* = this.m_NextCursorID + 1;
            var _loc_6:* = new CursorQueueItem();
            _loc_6.m_CursorID = _loc_5;
            _loc_6.m_CursorName = this.cursorClassToCursorName(param1);
            if (_loc_6.m_CursorName.substr(0, 4) == "drag")
            {
                _loc_6.m_Priority = CursorManagerPriority.HIGH;
            }
            else
            {
                _loc_6.m_Priority = param2;
            }
            this.m_CursorList.push(_loc_6);
            this.m_CursorList.sort(this.priorityCompare);
            this.showCurrentCursor();
            return _loc_5;
        }// end function

        public function removeAllCursors() : void
        {
            this.m_CursorList.length = 0;
            this.showCurrentCursor();
            return;
        }// end function

        private function priorityCompare(param1:CursorQueueItem, param2:CursorQueueItem) : int
        {
            if (param1.m_Priority < param2.m_Priority)
            {
                return -1;
            }
            if (param1.m_Priority == param2.m_Priority)
            {
                if (param1.m_CursorID > param2.m_CursorID)
                {
                    return -1;
                }
                if (param1.m_CursorID == param2.m_CursorID)
                {
                    return 0;
                }
                return 1;
            }
            return 1;
        }// end function

        public function registerToUseBusyCursor(param1:Object) : void
        {
            return;
        }// end function

        public function unRegisterToUseBusyCursor(param1:Object) : void
        {
            return;
        }// end function

        public function setBusyCursor() : void
        {
            return;
        }// end function

        private function showCurrentCursor() : void
        {
            var _loc_1:* = null;
            if (this.m_CursorList.length > 0)
            {
                _loc_1 = this.m_CursorList[0];
                Mouse.cursor = _loc_1.m_CursorName;
                this.m_CursorID = _loc_1.m_CursorID;
            }
            else
            {
                Mouse.cursor = DefaultCursor.CURSOR_NAME;
            }
            return;
        }// end function

        public function showCursor() : void
        {
            return;
        }// end function

        public static function getInstance() : ICursorManager
        {
            if (s_Instance == null)
            {
                s_Instance = new CustomCursorManagerImpl;
            }
            return s_Instance;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.ui.*;

import mx.managers.*;

class CursorQueueItem extends Object
{
    public var m_CursorName:String = null;
    public var m_CursorID:int = 0;
    public var m_Priority:int = 2;

    function CursorQueueItem()
    {
        return;
    }// end function

}

