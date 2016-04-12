package shared.utility
{
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class RingBuffer extends EventDispatcher implements IList
    {
        protected var m_Offset:int = 0;
        protected var m_Length:int = 0;
        protected var m_Data:Array = null;
        protected var m_Size:int = 0;

        public function RingBuffer(param1:int = 1)
        {
            if (param1 < 1)
            {
                throw new ArgumentError("RingBuffer.RingBuffer: Size has to be >= 1.");
            }
            this.m_Size = param1;
            this.m_Data = new Array(this.m_Size);
            this.m_Offset = 0;
            this.m_Length = 0;
            return;
        }// end function

        public function get size() : int
        {
            return this.m_Size;
        }// end function

        public function removeAll() : void
        {
            this.m_Data = new Array(this.m_Size);
            this.m_Offset = 0;
            this.m_Length = 0;
            var _loc_1:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_1.kind = CollectionEventKind.RESET;
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.m_Length)
            {
                
                if (this.m_Data[(this.m_Offset + _loc_2) % this.m_Size] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function removeItemAt(param1:int) : Object
        {
            if (param1 < 0 || param1 >= this.m_Length)
            {
                throw new RangeError("RingBuffer.removeItemAt: Index " + param1 + " is out of range.");
            }
            var _loc_2:* = this.m_Data[(this.m_Offset + param1) % this.m_Size];
            var _loc_3:* = param1;
            while (_loc_3 < (this.m_Length - 1))
            {
                
                this.m_Data[(this.m_Offset + _loc_3) % this.m_Size] = this.m_Data[(this.m_Offset + _loc_3 + 1) % this.m_Size];
                _loc_3++;
            }
            var _loc_5:* = this;
            var _loc_6:* = this.m_Length - 1;
            _loc_5.m_Length = _loc_6;
            var _loc_4:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_4.kind = CollectionEventKind.REMOVE;
            _loc_4.items = [_loc_2];
            _loc_4.location = param1;
            dispatchEvent(_loc_4);
            return _loc_2;
        }// end function

        public function addItem(param1:Object) : void
        {
            this.addItemInternal(param1);
            return;
        }// end function

        public function getItemAt(param1:int, param2:int = 0) : Object
        {
            if (param1 < 0 || param1 >= this.m_Length)
            {
                throw new RangeError("RingBuffer.getItemAt: Index " + param1 + " is out of range.");
            }
            return this.m_Data[(this.m_Offset + param1) % this.m_Size];
        }// end function

        public function toArray() : Array
        {
            var _loc_1:* = new Array(this.m_Length);
            var _loc_2:* = 0;
            while (_loc_2 < this.m_Length)
            {
                
                _loc_1[_loc_2] = this.m_Data[(this.m_Offset + _loc_2) % this.m_Size];
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function addItemAt(param1:Object, param2:int) : void
        {
            var _loc_5:* = null;
            if (param2 < 0 || param2 > this.m_Length)
            {
                throw new RangeError("RingBuffer.addItemAt: Index " + param2 + " is out of range.");
            }
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (this.m_Length < this.m_Size)
            {
                _loc_4 = this.m_Length;
                while (_loc_4 > param2)
                {
                    
                    this.m_Data[_loc_4] = this.m_Data[(_loc_4 - 1)];
                    _loc_4 = _loc_4 - 1;
                }
                this.m_Data[param2] = param1;
                var _loc_6:* = this;
                var _loc_7:* = this.m_Length + 1;
                _loc_6.m_Length = _loc_7;
            }
            else
            {
                _loc_5 = this.m_Data[this.m_Offset];
                param2 = Math.min(param2, (this.m_Size - 1));
                _loc_4 = 0;
                while (_loc_4 < param2)
                {
                    
                    this.m_Data[(this.m_Offset + _loc_4) % this.m_Size] = this.m_Data[(this.m_Offset + _loc_4 + 1) % this.m_Size];
                    _loc_4++;
                }
                this.m_Data[(this.m_Offset + param2) % this.m_Size] = param1;
                _loc_3 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_3.kind = CollectionEventKind.REMOVE;
                _loc_3.items = [_loc_5];
                _loc_3.location = 0;
                dispatchEvent(_loc_3);
            }
            _loc_3 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_3.kind = CollectionEventKind.ADD;
            _loc_3.items = [param1];
            _loc_3.location = param2;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
        {
            throw new Error("RingBuffer.itemUpdated: Not implemented.");
        }// end function

        public function get length() : int
        {
            return this.m_Length;
        }// end function

        private function addItemInternal(param1:Object) : Object
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.m_Length < this.m_Size)
            {
                this.m_Data[(this.m_Offset + this.m_Length) % this.m_Size] = param1;
                var _loc_4:* = this;
                var _loc_5:* = this.m_Length + 1;
                _loc_4.m_Length = _loc_5;
            }
            else
            {
                _loc_3 = this.m_Data[this.m_Offset];
                this.m_Data[this.m_Offset] = param1;
                this.m_Offset = (this.m_Offset + 1) % this.m_Size;
                _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_2.kind = CollectionEventKind.REMOVE;
                _loc_2.items = [_loc_3];
                _loc_2.location = 0;
                dispatchEvent(_loc_2);
            }
            _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_2.kind = CollectionEventKind.ADD;
            _loc_2.items = [param1];
            _loc_2.location = this.m_Length - 1;
            dispatchEvent(_loc_2);
            return _loc_3;
        }// end function

        public function setItemAt(param1:Object, param2:int) : Object
        {
            if (param2 < 0 || param2 >= this.m_Length)
            {
                throw new RangeError("RingBuffer.setItemAt: Index " + param2 + " is out of range.");
            }
            var _loc_3:* = (this.m_Offset + param2) % this.m_Size;
            var _loc_4:* = this.m_Data[_loc_3];
            this.m_Data[_loc_3] = param1;
            var _loc_5:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, false, CollectionEventKind.REMOVE, param2);
            dispatchEvent(_loc_5);
            return _loc_4;
        }// end function

    }
}
