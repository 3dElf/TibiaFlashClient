package shared.utility
{
    import __AS3__.vec.*;

    public class Heap extends Object
    {
        private var m_Length:int = 0;
        private var m_Heap:Vector.<HeapItem> = null;

        public function Heap(param1:int = 0)
        {
            this.m_Heap = new Vector.<HeapItem>(param1);
            return;
        }// end function

        public function addItem(param1:HeapItem, param2:int) : HeapItem
        {
            var _loc_3:* = 0;
            if (param1 != null)
            {
                _loc_3 = this.m_Length;
                param1.m_HeapKey = param2;
                param1.m_HeapParent = this;
                param1.m_HeapPosition = _loc_3;
                this.m_Heap[_loc_3] = param1;
                var _loc_4:* = this;
                var _loc_5:* = this.m_Length + 1;
                _loc_4.m_Length = _loc_5;
                this.minHeapify(_loc_3);
            }
            return param1;
        }// end function

        public function updateKey(param1:HeapItem, param2:int) : HeapItem
        {
            if (param1 != null && param1.m_HeapParent == this && param1.m_HeapPosition < this.m_Length && param1.m_HeapKey != param2)
            {
                param1.m_HeapKey = param2;
                this.minHeapify(param1.m_HeapPosition);
            }
            return param1;
        }// end function

        public function get length() : int
        {
            return this.m_Length;
        }// end function

        private function minHeapify(param1:int, param2:Boolean = true) : void
        {
            var _loc_3:* = param1;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            while (param2 && _loc_3 > 0)
            {
                
                _loc_4 = ((_loc_3 + 1) >>> 1) - 1;
                if (this.m_Heap[_loc_3].m_HeapKey < this.m_Heap[_loc_4].m_HeapKey)
                {
                    _loc_8 = this.m_Heap[_loc_4];
                    this.m_Heap[_loc_4] = this.m_Heap[_loc_3];
                    _loc_8.m_HeapPosition = _loc_4;
                    this.m_Heap[_loc_3] = _loc_8;
                    this.m_Heap[_loc_3].m_HeapPosition = _loc_3;
                    _loc_3 = _loc_4;
                    continue;
                }
                _loc_3 = 0;
            }
            while (true)
            {
                
                _loc_5 = ((_loc_3 + 1) << 1) - 1;
                _loc_6 = _loc_5 + 1;
                _loc_7 = _loc_3;
                if (_loc_5 < this.m_Length && this.m_Heap[_loc_5].m_HeapKey < this.m_Heap[_loc_7].m_HeapKey)
                {
                    _loc_7 = _loc_5;
                }
                if (_loc_6 < this.m_Length && this.m_Heap[_loc_6].m_HeapKey < this.m_Heap[_loc_7].m_HeapKey)
                {
                    _loc_7 = _loc_6;
                }
                if (_loc_7 > _loc_3)
                {
                    _loc_8 = this.m_Heap[_loc_3];
                    this.m_Heap[_loc_3] = this.m_Heap[_loc_7];
                    _loc_8.m_HeapPosition = _loc_3;
                    this.m_Heap[_loc_7] = _loc_8;
                    this.m_Heap[_loc_7].m_HeapPosition = _loc_7;
                    _loc_3 = _loc_7;
                    continue;
                }
                break;
            }
            return;
        }// end function

        public function peekMinItem() : HeapItem
        {
            return this.m_Length > 0 ? (this.m_Heap[0]) : (null);
        }// end function

        public function extractMinItem() : HeapItem
        {
            if (this.m_Length <= 0)
            {
                return null;
            }
            var _loc_1:* = this.m_Heap[0];
            _loc_1.m_HeapParent = null;
            _loc_1.m_HeapPosition = -1;
            var _loc_2:* = this;
            var _loc_3:* = this.m_Length - 1;
            _loc_2.m_Length = _loc_3;
            this.m_Heap[0] = this.m_Heap[this.m_Length];
            this.m_Heap[this.m_Length] = null;
            this.minHeapify(0);
            return _loc_1;
        }// end function

        public function clear(param1:Boolean = true) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this.m_Length)
            {
                
                if (_loc_2 != null)
                {
                    _loc_2.m_HeapPosition = -1;
                    _loc_2.m_HeapParent = null;
                }
                _loc_3++;
            }
            this.m_Length = 0;
            if (param1)
            {
                this.m_Heap.length = 0;
            }
            return;
        }// end function

    }
}
