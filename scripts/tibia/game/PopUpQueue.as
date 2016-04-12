package tibia.game
{
    import __AS3__.vec.*;
    import mx.events.*;
    import mx.managers.*;
    import tibia.input.*;

    public class PopUpQueue extends Object
    {
        private var m_Queue:Vector.<PopUpBase>;
        private static var s_Instance:PopUpQueue = null;

        public function PopUpQueue()
        {
            this.m_Queue = new Vector.<PopUpBase>;
            return;
        }// end function

        public function hide(param1:PopUpBase) : void
        {
            var _loc_2:* = -1;
            _loc_2 = this.m_Queue.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Queue[_loc_2] == param1)
                {
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            if (_loc_2 == 0)
            {
                this.hideInternal(this.m_Queue[0]);
            }
            if (_loc_2 == 0 && this.m_Queue.length > 1)
            {
                this.showInternal(this.m_Queue[1]);
            }
            if (_loc_2 > -1)
            {
                this.m_Queue[_loc_2].removeEventListener(CloseEvent.CLOSE, this.onClose);
                this.m_Queue.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            if (this.m_Queue.length > 0)
            {
                this.hideInternal(this.m_Queue[0]);
                _loc_1 = this.m_Queue.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this.m_Queue[_loc_1].removeEventListener(CloseEvent.CLOSE, this.onClose);
                    _loc_1 = _loc_1 - 1;
                }
                this.m_Queue.length = 0;
            }
            return;
        }// end function

        private function hideInternal(param1:PopUpBase) : void
        {
            PopUpManager.removePopUp(param1);
            var _loc_2:* = Tibia.s_GetInputHandler();
            if (_loc_2 != null)
            {
                _loc_2.captureKeyboard = true;
            }
            return;
        }// end function

        private function onClose(event:CloseEvent) : void
        {
            if (!event.cancelable || !event.isDefaultPrevented())
            {
                this.hide(event.currentTarget as PopUpBase);
            }
            return;
        }// end function

        private function showInternal(param1:PopUpBase) : void
        {
            if (ContextMenuBase.getCurrent() != null)
            {
                ContextMenuBase.getCurrent().hide();
            }
            var _loc_2:* = Tibia.s_GetInputHandler();
            if (_loc_2 != null)
            {
                _loc_2.captureKeyboard = false;
            }
            PopUpManager.addPopUp(param1, Tibia.s_GetInstance(), true);
            PopUpManager.centerPopUp(param1);
            return;
        }// end function

        public function show(param1:PopUpBase) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("PopUpQueue.show: Invalid pop-up.");
            }
            this.hideByPriority(param1.priority);
            this.m_Queue.push(param1);
            if (this.m_Queue.length == 1)
            {
                this.showInternal(this.m_Queue[0]);
            }
            param1.addEventListener(CloseEvent.CLOSE, this.onClose);
            return;
        }// end function

        public function hideByPriority(param1:int) : void
        {
            var _loc_2:* = this.m_Queue.length - 1;
            while (_loc_2 >= 0 && this.m_Queue[_loc_2].priority <= param1)
            {
                
                this.m_Queue[_loc_2].removeEventListener(CloseEvent.CLOSE, this.onClose);
                if (_loc_2 == 0)
                {
                    this.m_Queue[_loc_2].hide();
                }
                _loc_2 = _loc_2 - 1;
            }
            this.m_Queue.length = _loc_2 + 1;
            return;
        }// end function

        public function contains(param1:PopUpBase) : Boolean
        {
            var _loc_2:* = this.m_Queue.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Queue[_loc_2] == param1)
                {
                    return true;
                }
                _loc_2 = _loc_2 - 1;
            }
            return false;
        }// end function

        public static function getInstance() : PopUpQueue
        {
            if (s_Instance == null)
            {
                s_Instance = new PopUpQueue;
            }
            return s_Instance;
        }// end function

    }
}
