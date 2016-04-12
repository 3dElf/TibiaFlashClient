package shared.utility
{
    import __AS3__.vec.*;
    import flash.utils.*;

    public class HeapDictionaryWrapper extends Object
    {
        private var m_Dictionary:Dictionary = null;
        private var m_Keys:Vector.<Object> = null;
        private var m_Heap:Heap = null;

        public function HeapDictionaryWrapper()
        {
            this.clear();
            return;
        }// end function

        public function remove(param1) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (param1 in this.m_Dictionary)
            {
                _loc_2 = this.m_Dictionary[param1] as HeapDictionaryItem;
                _loc_2.data = undefined;
                delete this.m_Dictionary[param1];
                _loc_3 = this.m_Keys.indexOf(param1, 0);
                this.m_Keys.splice(_loc_3, 1);
                this.m_Heap.updateKey(_loc_2, int.MIN_VALUE);
                this.m_Heap.extractMinItem();
                return true;
            }
            return false;
        }// end function

        public function get length() : uint
        {
            return this.m_Keys.length;
        }// end function

        public function peekMinItem() : Object
        {
            return this.m_Heap.peekMinItem() == null ? (null) : (HeapDictionaryItem(this.m_Heap.peekMinItem()).data);
        }// end function

        public function extractMinItem() : Object
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            _loc_1 = this.peekMinItemKey();
            _loc_2 = this.m_Dictionary[_loc_1] as HeapDictionaryItem;
            var _loc_3:* = _loc_2.data;
            this.remove(_loc_1);
            return _loc_3;
        }// end function

        public function put(param1, param2:Object, param3:int = -2.14748e+009) : void
        {
            var _loc_4:* = null;
            if (param1 in this.m_Dictionary)
            {
                _loc_4 = this.m_Dictionary[param1] as HeapDictionaryItem;
                this.m_Heap.updateKey(_loc_4, param3);
                _loc_4.data = param2;
            }
            else
            {
                _loc_4 = new HeapDictionaryItem(param1, param2);
                this.m_Dictionary[param1] = _loc_4;
                this.m_Keys.push(param1);
                this.m_Heap.addItem(_loc_4, param3);
            }
            return;
        }// end function

        public function clear() : void
        {
            this.m_Dictionary = new Dictionary();
            this.m_Keys = new Vector.<Object>;
            this.m_Heap = new Heap();
            return;
        }// end function

        public function peekMinItemKey() : Object
        {
            return this.m_Heap.peekMinItem() == null ? (null) : (HeapDictionaryItem(this.m_Heap.peekMinItem()).key);
        }// end function

        public function get(param1, param2:int = -2.14748e+009)
        {
            var _loc_3:* = null;
            if (param1 in this.m_Dictionary)
            {
                _loc_3 = this.m_Dictionary[param1] as HeapDictionaryItem;
                this.m_Heap.updateKey(_loc_3, param2);
                return _loc_3.data;
            }
            return null;
        }// end function

        public function updateHeapPriority(param1:Object, param2:int) : void
        {
            var _loc_3:* = this.m_Dictionary[param1] as HeapDictionaryItem;
            if (_loc_3 != null)
            {
                this.m_Heap.updateKey(_loc_3, param2);
            }
            return;
        }// end function

        public function get keys() : Vector.<Object>
        {
            return this.m_Keys.concat();
        }// end function

        public function contains(param1) : Boolean
        {
            return param1 in this.m_Dictionary;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.utils.*;

class HeapDictionaryItem extends HeapItem
{
    private var m_Data:Object;
    private var m_Key:Object = null;

    function HeapDictionaryItem(param1, param2)
    {
        this.m_Key = param1;
        this.m_Data = param2;
        return;
    }// end function

    public function get data()
    {
        return this.m_Data;
    }// end function

    public function set data(param1) : void
    {
        this.m_Data = param1;
        return;
    }// end function

    public function get key()
    {
        return this.m_Key;
    }// end function

}

