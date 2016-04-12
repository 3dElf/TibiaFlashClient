package shared.utility
{

    public class ExtentCache extends Object
    {
        protected var m_Width:Number = 0;
        protected var m_Length:int = 0;
        protected var m_Chunks:Array = null;
        protected var m_Gap:Number = 0;
        protected var m_DefaultSize:Number = NaN;
        static const CHUNK_SIZE:int = 1 << CHUNK_BITS;
        static const CHUNK_BITS:int = 8;
        static const CHUNK_MASK:int = (1 << CHUNK_BITS) - 1;

        public function ExtentCache(param1:Number = 0)
        {
            if (isNaN(param1))
            {
                throw new ArgumentError("ExtentCache.ExtentCache: Invalid default size.");
            }
            this.m_Chunks = new Array();
            this.m_DefaultSize = param1;
            return;
        }// end function

        public function topToIndex(param1:Number, param2:Boolean = true) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (param1 <= 0)
            {
                return 0;
            }
            var _loc_8:* = param2 ? (this.m_Gap) : (0);
            var _loc_9:* = param2 ? (this.m_Gap * CHUNK_SIZE) : (0);
            while (_loc_5 <= param1 && _loc_3 < this.m_Chunks.length)
            {
                
                _loc_7 = this.m_Chunks[_loc_3];
                if (_loc_7 != null)
                {
                    _loc_6 = _loc_9 + _loc_7.m_Sum + _loc_7.m_NaN * this.m_DefaultSize;
                }
                else
                {
                    _loc_6 = _loc_9 + CHUNK_SIZE * this.m_DefaultSize;
                }
                if (_loc_5 + _loc_6 <= param1)
                {
                    _loc_5 = _loc_5 + _loc_6;
                    _loc_3++;
                    continue;
                }
                break;
            }
            _loc_7 = this.m_Chunks[_loc_3];
            if (_loc_7 != null)
            {
                while (_loc_5 <= param1 && _loc_4 < CHUNK_SIZE)
                {
                    
                    if (!isNaN(_loc_7.m_Items[_loc_4]))
                    {
                        _loc_6 = _loc_8 + _loc_7.m_Items[_loc_4];
                    }
                    else
                    {
                        _loc_6 = _loc_8 + this.m_DefaultSize;
                    }
                    if (_loc_5 + _loc_6 <= param1)
                    {
                        _loc_5 = _loc_5 + _loc_6;
                        _loc_4++;
                        continue;
                    }
                    break;
                }
            }
            else
            {
                _loc_6 = this.m_DefaultSize + (param2 ? (_loc_8) : (0));
                _loc_4 = Math.floor((param1 - _loc_5) / _loc_6);
            }
            return (_loc_3 << CHUNK_BITS) + _loc_4;
        }// end function

        public function set defaultSize(param1:Number) : void
        {
            this.m_DefaultSize = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return this.m_Width;
        }// end function

        public function removeItemAt(param1:int) : Number
        {
            var _loc_7:* = null;
            if (param1 < 0)
            {
                throw new RangeError("ExtentCache.removeItemAt: Index is out of range.");
            }
            var _loc_2:* = this.getItemAt(param1);
            var _loc_3:* = param1 >> CHUNK_BITS;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = this.m_Chunks.length - 1;
            while (_loc_6 >= _loc_3)
            {
                
                if (this.m_Chunks[_loc_6] == null)
                {
                    _loc_5 = NaN;
                }
                else
                {
                    _loc_4 = _loc_6 == _loc_3 ? (param1 & CHUNK_MASK) : (0);
                    _loc_5 = this.m_Chunks[_loc_6].shiftLeft(_loc_5, _loc_4);
                }
                _loc_6 = _loc_6 - 1;
            }
            while (this.m_Chunks.length > 0)
            {
                
                _loc_7 = this.m_Chunks[(this.m_Chunks.length - 1)];
                if (_loc_7 == null || _loc_7.m_NaN == CHUNK_SIZE)
                {
                    this.m_Chunks.pop();
                    continue;
                }
                break;
            }
            var _loc_8:* = this;
            var _loc_9:* = this.m_Length - 1;
            _loc_8.m_Length = _loc_9;
            return _loc_2;
        }// end function

        public function set width(param1:Number) : void
        {
            this.m_Width = param1;
            return;
        }// end function

        public function reset() : void
        {
            this.m_Chunks.length = 0;
            this.m_Length = 0;
            this.m_Width = 0;
            return;
        }// end function

        public function top(param1:int, param2:Boolean = true) : Number
        {
            if (param1 < 0)
            {
                throw new RangeError("ExtentCache.top: Index is out of range.");
            }
            var _loc_3:* = 0;
            var _loc_4:* = param1 >> CHUNK_BITS;
            var _loc_5:* = param1 & CHUNK_MASK;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = param2 ? (this.m_Gap) : (0);
            var _loc_9:* = param2 ? (this.m_Gap * CHUNK_SIZE) : (0);
            _loc_7 = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_3 = _loc_3 + _loc_9;
                _loc_6 = this.m_Chunks[_loc_7];
                if (_loc_6 != null)
                {
                    _loc_3 = _loc_3 + (_loc_6.m_Sum + _loc_6.m_NaN * this.m_DefaultSize);
                }
                else
                {
                    _loc_3 = _loc_3 + CHUNK_SIZE * this.m_DefaultSize;
                }
                _loc_7++;
            }
            _loc_6 = this.m_Chunks[_loc_4];
            if (_loc_6 != null)
            {
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    _loc_3 = _loc_3 + _loc_8;
                    _loc_3 = _loc_3 + (!isNaN(_loc_6.m_Items[_loc_7]) ? (_loc_6.m_Items[_loc_7]) : (this.m_DefaultSize));
                    _loc_7++;
                }
            }
            else
            {
                _loc_3 = _loc_3 + _loc_5 * (_loc_8 + this.m_DefaultSize);
            }
            return _loc_3;
        }// end function

        public function updateItemAt(param1:Number, param2:int) : Number
        {
            var _loc_5:* = null;
            if (param2 < 0)
            {
                throw new RangeError("ExtentCache.updateItemAt: Index is out of range.");
            }
            var _loc_3:* = param2 >> CHUNK_BITS;
            var _loc_4:* = param2 & CHUNK_MASK;
            this.m_Length = Math.max(this.m_Length, (param2 + 1));
            if (this.m_Chunks[_loc_3] == null)
            {
                _loc_5 = new Chunk();
                _loc_5.update(param1, _loc_4);
                this.m_Chunks[_loc_3] = _loc_5;
                return NaN;
            }
            return this.m_Chunks[_loc_3].update(param1, _loc_4);
        }// end function

        public function getItemAt(param1:int) : Number
        {
            var _loc_4:* = NaN;
            if (param1 < 0)
            {
                throw new RangeError("ExtentCache.getItemAt: Index is out of range.");
            }
            var _loc_2:* = param1 >> CHUNK_BITS;
            var _loc_3:* = param1 & CHUNK_MASK;
            if (this.m_Chunks[_loc_2] == null)
            {
                return this.m_DefaultSize;
            }
            _loc_4 = this.m_Chunks[_loc_2].m_Items[_loc_3];
            return isNaN(_loc_4) ? (this.m_DefaultSize) : (_loc_4);
        }// end function

        public function get gap() : Number
        {
            return this.m_Gap;
        }// end function

        public function get defaultSize() : Number
        {
            return this.m_DefaultSize;
        }// end function

        public function get length() : int
        {
            return this.m_Length;
        }// end function

        public function addItemAt(param1:Number, param2:int) : void
        {
            var _loc_7:* = null;
            if (param2 < 0)
            {
                throw new RangeError("ExtentCache.addItemAt: Index is out of range.");
            }
            var _loc_3:* = param2 >> CHUNK_BITS;
            var _loc_4:* = param2 & CHUNK_MASK;
            while (_loc_3 >= this.m_Chunks.length)
            {
                
                this.m_Chunks.push(new Chunk());
            }
            var _loc_5:* = param1;
            var _loc_6:* = _loc_3;
            while (_loc_6 < this.m_Chunks.length)
            {
                
                _loc_5 = this.m_Chunks[_loc_6].shiftRight(_loc_5, _loc_4);
                _loc_4 = 0;
                _loc_6++;
            }
            if (!isNaN(_loc_5))
            {
                _loc_7 = new Chunk();
                _loc_7.shiftRight(_loc_5, 0);
                this.m_Chunks.push(_loc_7);
            }
            this.m_Length = Math.max(this.m_Length, param2) + 1;
            return;
        }// end function

        public function bottom(param1:int, param2:Boolean = true) : Number
        {
            if (param1 < 0)
            {
                throw new RangeError("ExtentCache.bottom: Index is out of range.");
            }
            return this.top(param1, param2) + this.getItemAt(param1);
        }// end function

        public function set gap(param1:Number) : void
        {
            this.m_Gap = param1;
            return;
        }// end function

    }
}

class Chunk extends Object
{
    var m_Sum:Number = NaN;
    var m_NaN:int = 0;
    var m_Items:Vector.<Number> = null;
    static const CHUNK_SIZE:int = ExtentCache.CHUNK_SIZE;

    function Chunk()
    {
        this.m_Sum = 0;
        this.m_NaN = CHUNK_SIZE;
        this.m_Items = new Vector.<Number>(CHUNK_SIZE, true);
        var _loc_1:* = 0;
        while (_loc_1 < CHUNK_SIZE)
        {
            
            this.m_Items[_loc_1] = NaN;
            _loc_1++;
        }
        return;
    }// end function

    public function shiftLeft(param1:Number, param2:int = 0) : Number
    {
        if (param2 < 0 || param2 >= CHUNK_SIZE)
        {
            throw new RangeError("Chunk.shiftLeft: Index is out of range.");
        }
        var _loc_3:* = this.m_Items[param2];
        if (!isNaN(_loc_3))
        {
            this.m_Sum = this.m_Sum - _loc_3;
            var _loc_6:* = this;
            var _loc_7:* = this.m_NaN + 1;
            _loc_6.m_NaN = _loc_7;
        }
        if (!isNaN(param1))
        {
            this.m_Sum = this.m_Sum + param1;
            var _loc_6:* = this;
            var _loc_7:* = this.m_NaN - 1;
            _loc_6.m_NaN = _loc_7;
        }
        var _loc_4:* = CHUNK_SIZE - 1;
        var _loc_5:* = param2;
        while (_loc_5 < _loc_4)
        {
            
            this.m_Items[_loc_5] = this.m_Items[(_loc_5 + 1)];
            _loc_5++;
        }
        this.m_Items[_loc_4] = param1;
        return _loc_3;
    }// end function

    public function shiftRight(param1:Number, param2:int = 0) : Number
    {
        if (param2 < 0 || param2 >= CHUNK_SIZE)
        {
            throw new RangeError("Chunk.shiftRight: Index is out of range.");
        }
        var _loc_3:* = this.m_Items[(CHUNK_SIZE - 1)];
        if (!isNaN(_loc_3))
        {
            this.m_Sum = this.m_Sum - _loc_3;
            var _loc_5:* = this;
            var _loc_6:* = this.m_NaN + 1;
            _loc_5.m_NaN = _loc_6;
        }
        if (!isNaN(param1))
        {
            this.m_Sum = this.m_Sum + param1;
            var _loc_5:* = this;
            var _loc_6:* = this.m_NaN - 1;
            _loc_5.m_NaN = _loc_6;
        }
        var _loc_4:* = CHUNK_SIZE - 1;
        while (_loc_4 > param2)
        {
            
            this.m_Items[_loc_4] = this.m_Items[(_loc_4 - 1)];
            _loc_4 = _loc_4 - 1;
        }
        this.m_Items[param2] = param1;
        return _loc_3;
    }// end function

    public function update(param1:Number, param2:int) : Number
    {
        if (param2 < 0 || param2 >= CHUNK_SIZE)
        {
            throw new RangeError("Chunk.update: Index is out of range.");
        }
        var _loc_3:* = this.m_Items[param2];
        if (param1 == _loc_3)
        {
            return _loc_3;
        }
        if (!isNaN(_loc_3))
        {
            this.m_Sum = this.m_Sum - _loc_3;
            var _loc_4:* = this;
            var _loc_5:* = this.m_NaN + 1;
            _loc_4.m_NaN = _loc_5;
        }
        if (!isNaN(param1))
        {
            this.m_Sum = this.m_Sum + param1;
            var _loc_4:* = this;
            var _loc_5:* = this.m_NaN - 1;
            _loc_4.m_NaN = _loc_5;
        }
        this.m_Items[param2] = param1;
        return _loc_3;
    }// end function

}

