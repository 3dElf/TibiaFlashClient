package shared.controls
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.controls.*;

    public class CustomButton extends Button
    {
        private var m_EventQueue:Vector.<DeferredEvent>;

        public function CustomButton()
        {
            this.m_EventQueue = new Vector.<>;
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        override protected function mouseUpHandler(event:MouseEvent) : void
        {
            this.m_EventQueue.length = 0;
            super.mouseUpHandler(event);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            this.processEventQueue();
            return;
        }// end function

        private function processEventQueue(param1:int = 0) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = getTimer() - param1;
            var _loc_3:* = this.m_EventQueue.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3 && this.m_EventQueue[_loc_4].timestamp <= _loc_2)
            {
                
                _loc_5 = this.m_EventQueue[_loc_4].event;
                if (_loc_5.type == MouseEvent.ROLL_OUT)
                {
                    super.rollOutHandler(_loc_5);
                }
                else
                {
                    super.rollOverHandler(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_4 < _loc_3)
            {
                this.m_EventQueue = this.m_EventQueue.slice(_loc_4);
            }
            else
            {
                this.m_EventQueue.length = 0;
            }
            return;
        }// end function

        override protected function keyUpHandler(event:KeyboardEvent) : void
        {
            this.m_EventQueue.length = 0;
            super.keyUpHandler(event);
            return;
        }// end function

        override protected function rollOutHandler(event:MouseEvent) : void
        {
            this.m_EventQueue.push(new DeferredEvent(event));
            this.processEventQueue(50);
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            this.m_EventQueue.length = 0;
            super.keyDownHandler(event);
            return;
        }// end function

        override protected function mouseDownHandler(event:MouseEvent) : void
        {
            this.m_EventQueue.length = 0;
            super.mouseDownHandler(event);
            return;
        }// end function

        override protected function rollOverHandler(event:MouseEvent) : void
        {
            this.m_EventQueue.push(new DeferredEvent(event));
            this.processEventQueue(50);
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.events.*;

import flash.utils.*;

import mx.controls.*;

class DeferredEvent extends Object
{
    public var event:MouseEvent = null;
    public var timestamp:int = 0;

    function DeferredEvent(event:MouseEvent, param2:int = -1)
    {
        this.event = event;
        if (param2 < 0)
        {
            this.timestamp = getTimer();
        }
        else
        {
            this.timestamp = param2;
        }
        return;
    }// end function

}

