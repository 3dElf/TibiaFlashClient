package tibia.appearances
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;

    public class Marks extends EventDispatcher
    {
        private var m_CurrentMarks:Dictionary = null;
        public static const MARK_AIM_FOLLOW:uint = 219;
        public static const MARK_ATTACK:uint = 220;
        public static const MARK_FOLLOW:uint = 221;
        public static const MARK_TYPE_CLIENT_MAPWINDOW:uint = 1;
        public static const MARK_AIM:uint = 217;
        public static const MARK_AIM_ATTACK:uint = 218;
        public static const MARK_TYPE_CLIENT_BATTLELIST:uint = 2;
        public static const MARK_NUM_TOTAL:uint = 222;
        public static const MARK_TYPE_ONE_SECOND_TEMP:uint = 3;
        public static const MARK_TYPE_PERMANENT:uint = 4;
        public static const MARK_NUM_COLOURS:uint = 216;
        public static const MARK_UNMARKED:uint = 255;

        public function Marks()
        {
            return;
        }// end function

        public function getMarkColor(param1:uint) : uint
        {
            if (this.m_CurrentMarks == null)
            {
                return MARK_UNMARKED;
            }
            if (this.m_CurrentMarks[param1] as MarkBase != null)
            {
                return (this.m_CurrentMarks[param1] as MarkBase).m_MarkColor;
            }
            return MARK_UNMARKED;
        }// end function

        public function areAnyMarksSet(param1:Vector.<uint>) : Boolean
        {
            var _loc_3:* = 0;
            if (this.m_CurrentMarks == null)
            {
                return false;
            }
            var _loc_2:* = false;
            for each (_loc_3 in param1)
            {
                
                _loc_2 = this.isMarkSet(_loc_3) || _loc_2;
            }
            return _loc_2;
        }// end function

        public function areAllMarksSet(param1:Vector.<uint>) : Boolean
        {
            var _loc_3:* = 0;
            if (this.m_CurrentMarks == null)
            {
                return false;
            }
            var _loc_2:* = true;
            for each (_loc_3 in param1)
            {
                
                _loc_2 = this.isMarkSet(_loc_3) && _loc_2;
            }
            return _loc_2;
        }// end function

        public function isMarkSet(param1:uint) : Boolean
        {
            if (this.m_CurrentMarks == null)
            {
                return false;
            }
            if (this.m_CurrentMarks[param1] as MarkBase != null)
            {
                return (this.m_CurrentMarks[param1] as MarkBase).isSet;
            }
            return false;
        }// end function

        public function clear() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_CurrentMarks == null)
            {
                return;
            }
            var _loc_1:* = false;
            for each (_loc_2 in this.m_CurrentMarks)
            {
                
                delete _loc_5[_loc_2];
                _loc_1 = true;
            }
            if (_loc_1)
            {
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.kind = PropertyChangeEventKind.DELETE;
                _loc_3.property = "marks";
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function setMark(param1:uint, param2:uint) : void
        {
            var _loc_4:* = null;
            if (this.m_CurrentMarks == null)
            {
                if (param2 != MARK_UNMARKED)
                {
                    this.m_CurrentMarks = new Dictionary();
                }
                else
                {
                    return;
                }
            }
            if (this.m_CurrentMarks.hasOwnProperty(param1) == false)
            {
                switch(param1)
                {
                    case MARK_TYPE_ONE_SECOND_TEMP:
                    {
                        this.m_CurrentMarks[MARK_TYPE_ONE_SECOND_TEMP] = new MarkTimeout(1000);
                        break;
                    }
                    default:
                    {
                        this.m_CurrentMarks[param1] = new MarkBase();
                        break;
                        break;
                    }
                }
            }
            var _loc_3:* = this.getMarkColor(param1);
            if (this.isMarkSet(param1) == false || this.getMarkColor(param1) != param2)
            {
                (this.m_CurrentMarks[param1] as MarkBase).set(param2);
                _loc_4 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_4.kind = PropertyChangeEventKind.UPDATE;
                _loc_4.property = "marks";
                _loc_4.oldValue = _loc_3;
                _loc_4.newValue = param2;
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.events.*;

import flash.utils.*;

import mx.events.*;

class MarkBase extends Object
{
    public var m_MarkColor:uint = 255;

    function MarkBase()
    {
        return;
    }// end function

    public function set(param1:uint) : void
    {
        this.m_MarkColor = param1;
        return;
    }// end function

    public function get isSet() : Boolean
    {
        return this.m_MarkColor != Marks.MARK_UNMARKED;
    }// end function

}


import __AS3__.vec.*;

import flash.events.*;

import flash.utils.*;

import mx.events.*;

class MarkTimeout extends MarkBase
{
    private var m_TimeoutMilliseconds:uint = 1000;
    private var m_SetTimestamp:Number = 0;

    function MarkTimeout(param1:uint)
    {
        this.m_TimeoutMilliseconds = param1;
        return;
    }// end function

    override public function get isSet() : Boolean
    {
        return super.isSet && this.m_SetTimestamp + this.m_TimeoutMilliseconds > getTimer();
    }// end function

    override public function set(param1:uint) : void
    {
        super.set(param1);
        this.m_SetTimestamp = getTimer();
        return;
    }// end function

}

