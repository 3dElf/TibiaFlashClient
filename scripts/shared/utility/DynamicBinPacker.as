package shared.utility
{
    import __AS3__.vec.*;
    import flash.geom.*;

    public class DynamicBinPacker extends Object
    {
        private var m_PackedRectangles:uint = 0;
        private var m_AvailableSpace:uint = 0;
        private var m_RootNode:DynamicBinPackerNode = null;
        private var m_UsedSpace:uint = 0;
        private var m_Rectangle:Rectangle = null;

        public function DynamicBinPacker(param1:Rectangle)
        {
            if (param1 == null || param1.width == 0 || param1.height == 0)
            {
                throw new ArgumentError("DynamicBinPacker.DynamicBinPacker: Invalid rectangle");
            }
            this.m_Rectangle = param1.clone();
            this.m_RootNode = new DynamicBinPackerNode(this.m_Rectangle);
            this.m_AvailableSpace = this.m_Rectangle.width * this.m_Rectangle.height;
            return;
        }// end function

        public function get packedRectangles() : uint
        {
            return this.m_PackedRectangles;
        }// end function

        public function get availableSpace() : uint
        {
            return this.m_AvailableSpace;
        }// end function

        public function get splitRectangles() : Vector.<Rectangle>
        {
            var _loc_1:* = new Vector.<Rectangle>;
            this.m_RootNode.getRectangles(_loc_1);
            return _loc_1;
        }// end function

        public function get usedSpace() : uint
        {
            return this.m_UsedSpace;
        }// end function

        public function clear() : void
        {
            this.m_RootNode.m_Childs[0] = null;
            this.m_RootNode.m_Childs[1] = null;
            this.m_RootNode.m_Filled = false;
            this.m_UsedSpace = 0;
            this.m_PackedRectangles = 0;
            return;
        }// end function

        public function get fillFactor() : Number
        {
            return this.m_UsedSpace / this.m_AvailableSpace;
        }// end function

        public function insert(param1:Rectangle) : Rectangle
        {
            var _loc_2:* = this.m_RootNode.insert(param1);
            if (_loc_2 != null)
            {
                this.m_UsedSpace = this.m_UsedSpace + _loc_2.m_Rectangle.width * _loc_2.m_Rectangle.height;
                var _loc_3:* = this;
                var _loc_4:* = this.m_PackedRectangles + 1;
                _loc_3.m_PackedRectangles = _loc_4;
                return _loc_2.m_Rectangle;
            }
            return null;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.geom.*;

class DynamicBinPackerNode extends Object
{
    public var m_Filled:Boolean = false;
    public var m_Childs:Vector.<DynamicBinPackerNode>;
    public var m_Rectangle:Rectangle = null;

    function DynamicBinPackerNode(param1:Rectangle)
    {
        this.m_Childs = new Vector.<DynamicBinPackerNode>(2, true);
        this.m_Rectangle = param1;
        return;
    }// end function

    public function insert(param1:Rectangle) : DynamicBinPackerNode
    {
        var _loc_3:* = null;
        var _loc_4:* = 0;
        var _loc_5:* = 0;
        var _loc_6:* = null;
        var _loc_2:* = null;
        if (this.m_Childs[0] != null && this.m_Childs[1] != null)
        {
            for each (_loc_3 in this.m_Childs)
            {
                
                if (_loc_3.m_Filled == false && _loc_3.m_Rectangle.width >= param1.width && _loc_3.m_Rectangle.height >= param1.height)
                {
                    _loc_2 = _loc_3.insert(param1);
                    if (_loc_2 != null)
                    {
                        break;
                    }
                }
            }
            if (_loc_8[0].m_Filled && _loc_8[1].m_Filled)
            {
                this.m_Filled = true;
            }
            return _loc_2;
        }
        else
        {
            if (this.m_Filled)
            {
                return null;
            }
            if (param1.width > this.m_Rectangle.width || param1.height > this.m_Rectangle.height)
            {
                return null;
            }
            if (this.m_Rectangle.width == param1.width && this.m_Rectangle.height == param1.height)
            {
                this.m_Filled = true;
                return this;
            }
            _loc_4 = this.m_Rectangle.width - param1.width;
            _loc_5 = this.m_Rectangle.height - param1.height;
            _loc_6 = new Rectangle();
            if (_loc_4 > _loc_5)
            {
                _loc_8[0] = new DynamicBinPackerNode(new Rectangle(this.m_Rectangle.left, this.m_Rectangle.top, param1.width, this.m_Rectangle.height));
                _loc_8[1] = new DynamicBinPackerNode(new Rectangle(this.m_Rectangle.left + param1.width, this.m_Rectangle.top, this.m_Rectangle.width - param1.width, this.m_Rectangle.height));
            }
        }
        _loc_8[0] = new DynamicBinPackerNode(new Rectangle(this.m_Rectangle.left, this.m_Rectangle.top, this.m_Rectangle.width, param1.height));
        _loc_8[1] = new DynamicBinPackerNode(new Rectangle(this.m_Rectangle.left, this.m_Rectangle.top + param1.height, this.m_Rectangle.width, this.m_Rectangle.height - param1.height));
        return _loc_8[0].insert(param1);
    }// end function

    public function getRectangles(param1:Vector.<Rectangle>) : void
    {
        if (this.m_Childs[0] != null)
        {
            param1.push(this.m_Childs[0].m_Rectangle);
            this.m_Childs[0].getRectangles(param1);
        }
        if (this.m_Childs[1] != null)
        {
            param1.push(this.m_Childs[1].m_Rectangle);
            this.m_Childs[1].getRectangles(param1);
        }
        return;
    }// end function

}

