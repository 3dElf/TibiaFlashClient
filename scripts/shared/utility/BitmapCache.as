package shared.utility
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class BitmapCache extends BitmapData
    {
        private var m_SlotRows:int = 0;
        private var m_SlotColumns:int = 0;
        private var m_ItemSequenceNumber:int = -2.14748e+009;
        private var m_ItemQueue:Heap = null;
        private var m_SlotList:Vector.<int> = null;
        private var m_SlotWidth:Number = 0;
        private var m_SlotHeight:Number = 0;
        private var m_ItemDictionary:Dictionary = null;

        public function BitmapCache(param1:Number, param2:Number, param3:uint)
        {
            param3 = Math.max(1, param3);
            this.m_SlotWidth = Math.ceil(param1);
            this.m_SlotHeight = Math.ceil(param2);
            this.m_SlotColumns = Math.ceil(Math.sqrt(param3));
            this.m_SlotRows = Math.ceil(param3 / this.m_SlotColumns);
            super(this.m_SlotColumns * this.m_SlotWidth, this.m_SlotRows * this.m_SlotHeight, true, 0);
            this.m_ItemDictionary = new Dictionary(true);
            this.m_ItemQueue = new Heap();
            this.m_SlotList = new Vector.<int>(this.m_SlotColumns * this.m_SlotRows);
            var _loc_4:* = 0;
            var _loc_5:* = this.m_SlotList.length;
            while (_loc_4 < _loc_5)
            {
                
                this.m_SlotList[_loc_4] = (_loc_5 - 1) - _loc_4;
                _loc_4++;
            }
            return;
        }// end function

        public function get size() : int
        {
            return this.m_SlotColumns * this.m_SlotRows;
        }// end function

        public function get slotHeight() : int
        {
            return this.m_SlotHeight;
        }// end function

        public function get length() : int
        {
            return this.m_SlotColumns * this.m_SlotRows - this.m_SlotList.length;
        }// end function

        public function get slotWidth() : int
        {
            return this.m_SlotWidth;
        }// end function

        public function getItem(param1, ... args) : Rectangle
        {
            args = BitmapCacheItem(this.m_ItemDictionary[param1]);
            if (args == null)
            {
                if (this.m_SlotList.length < 1)
                {
                    args = BitmapCacheItem(this.m_ItemQueue.peekMinItem());
                    delete this.m_ItemDictionary[args.key];
                    args.key = param1;
                    this.m_ItemDictionary[param1] = args;
                    this.m_ItemQueue.updateKey(args, this.m_ItemSequenceNumber);
                }
                else
                {
                    args = new BitmapCacheItem();
                    args.key = param1;
                    args.slot = this.m_SlotList.pop();
                    this.m_ItemDictionary[param1] = args;
                    this.m_ItemQueue.addItem(args, this.m_ItemSequenceNumber);
                }
                var _loc_4:* = this;
                var _loc_5:* = this.m_ItemSequenceNumber + 1;
                _loc_4.m_ItemSequenceNumber = _loc_5;
                args.rectangle.x = args.slot % this.m_SlotColumns * this.m_SlotWidth;
                args.rectangle.y = int(args.slot / this.m_SlotColumns) * this.m_SlotHeight;
                args.rectangle.width = this.m_SlotWidth;
                args.rectangle.height = this.m_SlotHeight;
                fillRect(args.rectangle, 0);
                this.addItem(args.rectangle, args);
            }
            return args.rectangle;
        }// end function

        protected function addItem(param1:Rectangle, param2:Array) : void
        {
            return;
        }// end function

        public function removeItem(param1) : void
        {
            var _loc_2:* = BitmapCacheItem(this.m_ItemDictionary[param1]);
            if (_loc_2 != null)
            {
                this.m_SlotList.push(_loc_2.slot);
                delete this.m_ItemDictionary[_loc_2.key];
                _loc_2.key = undefined;
                this.m_ItemQueue.updateKey(_loc_2, int.MIN_VALUE);
                this.m_ItemQueue.extractMinItem();
            }
            return;
        }// end function

    }
}
