package shared.skins
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.styles.*;
    import shared.utility.*;

    public class BitmapGrid extends Object implements ISimpleStyleClient, IBorder
    {
        private var m_BitmapStyle:Vector.<Object>;
        private var m_Width:Number = 0;
        private var m_Height:Number = 0;
        private var m_BitmapCell:Vector.<BitmapGridCell>;
        private var m_StyleName:IStyleClient = null;
        private var m_MinBorder:EdgeMetrics;
        private var m_BitmapMask:uint = 0;
        private var m_StylePrefix:String = null;
        private var m_InvalidStyle:Boolean = false;
        private var m_MaxBorder:EdgeMetrics;

        public function BitmapGrid(param1 = null, param2:String = null)
        {
            this.m_BitmapStyle = new Vector.<Object>(EBitmap.NUM_BITMAPS, true);
            this.m_BitmapCell = new Vector.<BitmapGridCell>(EBitmap.NUM_BITMAPS, true);
            this.m_MaxBorder = new EdgeMetrics();
            this.m_MinBorder = new EdgeMetrics();
            this.styleName = param1;
            this.stylePrefix = param2;
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return this.m_StyleName != null ? (this.m_StyleName.getStyle(param1)) : (null);
        }// end function

        public function styleChanged(param1:String) : void
        {
            this.m_InvalidStyle = true;
            return;
        }// end function

        public function get stylePrefix() : String
        {
            return this.m_StylePrefix;
        }// end function

        private function getDefaultReferenceCell(param1:int) : int
        {
            switch(param1)
            {
                case EBitmap.TOP:
                case EBitmap.LEFT:
                case EBitmap.BOTTOM:
                case EBitmap.RIGHT:
                {
                    return EBitmap.RIGHT;
                }
                case EBitmap.TOP_LEFT:
                case EBitmap.BOTTOM_LEFT:
                case EBitmap.BOTTOM_RIGHT:
                case EBitmap.TOP_RIGHT:
                {
                    return EBitmap.TOP_RIGHT;
                }
                default:
                {
                    return EBitmap.NONE;
                    break;
                }
            }
        }// end function

        public function set stylePrefix(param1:String) : void
        {
            if (param1 == null)
            {
                param1 = "";
            }
            if (this.m_StylePrefix != param1)
            {
                this.m_StylePrefix = param1;
                this.m_InvalidStyle = true;
            }
            return;
        }// end function

        private function getMinCellSize(... args) : Point
        {
            args = new Point(Number.POSITIVE_INFINITY, Number.POSITIVE_INFINITY);
            var _loc_3:* = 0;
            var _loc_4:* = args.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3 = args[_loc_4];
                if (this.isCellVisible(_loc_3))
                {
                    args.x = Math.min(args.x, this.m_BitmapCell[_loc_3].realWidth);
                    args.y = Math.min(args.y, this.m_BitmapCell[_loc_3].realHeight);
                }
                _loc_4 = _loc_4 - 1;
            }
            if (!isFinite(args.x))
            {
                args.x = 0;
            }
            if (!isFinite(args.y))
            {
                args.y = 0;
            }
            return args;
        }// end function

        private function getCellMask(param1:String) : uint
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = 0;
            if (param1 != null)
            {
                _loc_3 = param1.split(/ +/);
                _loc_4 = 0;
                _loc_5 = _loc_3.length - 1;
                while (_loc_5 >= 0)
                {
                    
                    _loc_4 = EBitmap.s_ParseString(_loc_3[_loc_5]);
                    if (_loc_4 == EBitmap.ALL)
                    {
                        _loc_2 = _loc_2 | 4294967295;
                    }
                    else if (_loc_4 != EBitmap.NONE)
                    {
                        _loc_2 = _loc_2 | 1 << _loc_4;
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            return _loc_2;
        }// end function

        public function validateStyle() : void
        {
            if (this.m_InvalidStyle)
            {
                this.doValidateStyle();
                this.m_InvalidStyle = false;
            }
            return;
        }// end function

        private function getReferenceTransform(param1:int, param2:int) : Matrix
        {
            switch(param1)
            {
                case EBitmap.TOP:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.LEFT:
                        {
                            return new Matrix(0, -1, 1, 0);
                        }
                        case EBitmap.BOTTOM:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        case EBitmap.RIGHT:
                        {
                            return new Matrix(0, 1, -1, 0);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.TOP_LEFT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP_LEFT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM_LEFT:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        case EBitmap.BOTTOM_RIGHT:
                        {
                            return new Matrix(-1, 0, 0, -1);
                        }
                        case EBitmap.TOP_RIGHT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.LEFT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP:
                        {
                            return new Matrix(0, 1, -1, 0);
                        }
                        case EBitmap.LEFT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM:
                        {
                            return new Matrix(0, -1, 1, 0);
                        }
                        case EBitmap.RIGHT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.BOTTOM_LEFT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP_LEFT:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        case EBitmap.BOTTOM_LEFT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM_RIGHT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        case EBitmap.TOP_RIGHT:
                        {
                            return new Matrix(-1, 0, 0, -1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.BOTTOM:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        case EBitmap.LEFT:
                        {
                            return new Matrix(0, -1, 1, 0);
                        }
                        case EBitmap.BOTTOM:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.RIGHT:
                        {
                            return new Matrix(0, 1, -1, 0);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.BOTTOM_RIGHT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP_LEFT:
                        {
                            return new Matrix(-1, 0, 0, -1);
                        }
                        case EBitmap.BOTTOM_LEFT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM_RIGHT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        case EBitmap.TOP_RIGHT:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.RIGHT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP:
                        {
                            return new Matrix(0, -1, 1, 0);
                        }
                        case EBitmap.LEFT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM:
                        {
                            return new Matrix(0, 1, -1, 0);
                        }
                        case EBitmap.RIGHT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                case EBitmap.TOP_RIGHT:
                {
                    switch(param2)
                    {
                        case EBitmap.TOP_LEFT:
                        {
                            return new Matrix(-1, 0, 0, 1);
                        }
                        case EBitmap.BOTTOM_LEFT:
                        {
                            return new Matrix(-1, 0, 0, -1);
                        }
                        case EBitmap.BOTTOM_RIGHT:
                        {
                            return new Matrix(1, 0, 0, -1);
                        }
                        case EBitmap.TOP_RIGHT:
                        {
                            return new Matrix(1, 0, 0, 1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public function get styleName() : Object
        {
            return this.m_StyleName;
        }// end function

        private function isValidReferenceCell(param1:int, param2:int) : Boolean
        {
            if (param1 == EBitmap.NONE || param1 == EBitmap.CENTER || param2 == EBitmap.NONE || param2 == EBitmap.CENTER || param1 == param2)
            {
                return false;
            }
            var _loc_3:* = param1 == EBitmap.TOP || param1 == EBitmap.LEFT || param1 == EBitmap.BOTTOM || param1 == EBitmap.RIGHT;
            var _loc_4:* = param2 == EBitmap.TOP || param2 == EBitmap.LEFT || param2 == EBitmap.BOTTOM || param2 == EBitmap.RIGHT;
            return (param2 == EBitmap.TOP || param2 == EBitmap.LEFT || param2 == EBitmap.BOTTOM || param2 == EBitmap.RIGHT) && _loc_3 || !_loc_4 && !_loc_3;
        }// end function

        protected function getMaskStyleName() : String
        {
            return this.m_StylePrefix != null ? (this.m_StylePrefix + "Mask") : ("mask");
        }// end function

        protected function getBitmapStyleName(param1:int) : String
        {
            return this.m_StylePrefix != null ? (this.m_StylePrefix + StringHelper.s_Capitalise(EBitmap.s_ToString(param1)) + "Image") : (EBitmap.s_ToString(param1) + "Image");
        }// end function

        public function get measuredHeight() : Number
        {
            this.validateStyle();
            return this.m_Height;
        }// end function

        private function isCellVisible(param1:int) : Boolean
        {
            return (this.m_BitmapMask & 1 << param1) > 0 && this.m_BitmapCell[param1] != null && this.m_BitmapCell[param1].bitmap != null;
        }// end function

        public function get measuredWidth() : Number
        {
            this.validateStyle();
            return this.m_Width;
        }// end function

        protected function getBorderStyleName(param1:String) : String
        {
            return this.m_StylePrefix != null ? (this.m_StylePrefix + StringHelper.s_Capitalise(param1)) : (param1);
        }// end function

        protected function doValidateStyle() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = [];
            _loc_1 = 0;
            while (_loc_1 < EBitmap.NUM_BITMAPS)
            {
                
                _loc_4 = this.getStyle(this.getBitmapStyleName(_loc_1));
                _loc_5 = EBitmap.NONE;
                if (_loc_4 == null || _loc_4 is String || this.m_BitmapStyle[_loc_1] != _loc_4)
                {
                    this.m_BitmapStyle[_loc_1] = _loc_4;
                    this.m_BitmapCell[_loc_1] = null;
                    if (_loc_4 is Class || _loc_4 is Bitmap)
                    {
                        this.m_BitmapCell[_loc_1] = new BitmapGridCell(_loc_1, _loc_4);
                    }
                    else
                    {
                        var _loc_9:* = EBitmap.s_ParseString(String(_loc_4));
                        _loc_5 = EBitmap.s_ParseString(String(_loc_4));
                        if (_loc_4 is String && _loc_9 != EBitmap.NONE && this.isValidReferenceCell(_loc_5, _loc_1))
                        {
                            _loc_3.push({source:_loc_5, target:_loc_1});
                        }
                        else
                        {
                            var _loc_9:* = this.getDefaultReferenceCell(_loc_1);
                            _loc_5 = this.getDefaultReferenceCell(_loc_1);
                            if (_loc_9 != EBitmap.NONE)
                            {
                                _loc_3.push({source:_loc_5, target:_loc_1});
                            }
                        }
                    }
                }
                _loc_1++;
            }
            _loc_1 = 0;
            _loc_2 = _loc_3.length;
            while (_loc_1 < _loc_2)
            {
                
                _loc_6 = _loc_3[_loc_1].source;
                _loc_7 = _loc_3[_loc_1].target;
                _loc_8 = null;
                if (this.m_BitmapCell[_loc_6] != null)
                {
                    _loc_8 = new BitmapGridCell(_loc_7, this.m_BitmapCell[_loc_6].bitmap);
                    _loc_8.matrix = this.getReferenceTransform(_loc_6, _loc_7);
                    this.m_BitmapCell[_loc_7] = _loc_8;
                }
                _loc_1++;
            }
            if (this.getStyle(this.getMaskStyleName()) !== undefined)
            {
                this.m_BitmapMask = this.getCellMask(String(this.getStyle(this.getMaskStyleName())));
            }
            else
            {
                this.m_BitmapMask = 4294967295;
            }
            this.m_MaxBorder.bottom = this.getStyle(this.getBorderStyleName("bottom"));
            if (isNaN(this.m_MaxBorder.bottom))
            {
                this.m_MaxBorder.bottom = this.getMaxCellSize(EBitmap.BOTTOM_LEFT, EBitmap.BOTTOM, EBitmap.BOTTOM_RIGHT).y;
            }
            this.m_MaxBorder.left = this.getStyle(this.getBorderStyleName("left"));
            if (isNaN(this.m_MaxBorder.left))
            {
                this.m_MaxBorder.left = this.getMaxCellSize(EBitmap.TOP_LEFT, EBitmap.LEFT, EBitmap.BOTTOM_LEFT).x;
            }
            this.m_MaxBorder.right = this.getStyle(this.getBorderStyleName("right"));
            if (isNaN(this.m_MaxBorder.right))
            {
                this.m_MaxBorder.right = this.getMaxCellSize(EBitmap.TOP_RIGHT, EBitmap.RIGHT, EBitmap.BOTTOM_RIGHT).x;
            }
            this.m_MaxBorder.top = this.getStyle(this.getBorderStyleName("top"));
            if (isNaN(this.m_MaxBorder.top))
            {
                this.m_MaxBorder.top = this.getMaxCellSize(EBitmap.TOP_LEFT, EBitmap.TOP, EBitmap.TOP_RIGHT).y;
            }
            this.m_MinBorder.bottom = this.getMinCellSize(EBitmap.BOTTOM_LEFT, EBitmap.BOTTOM, EBitmap.BOTTOM_RIGHT).y;
            this.m_MinBorder.left = this.getMinCellSize(EBitmap.TOP_LEFT, EBitmap.LEFT, EBitmap.BOTTOM_LEFT).x;
            this.m_MinBorder.right = this.getMinCellSize(EBitmap.TOP_RIGHT, EBitmap.RIGHT, EBitmap.BOTTOM_RIGHT).x;
            this.m_MinBorder.top = this.getMinCellSize(EBitmap.TOP_LEFT, EBitmap.TOP, EBitmap.TOP_RIGHT).y;
            this.m_Height = this.m_MaxBorder.top + this.m_MaxBorder.bottom;
            this.m_Width = this.m_MaxBorder.left + this.m_MaxBorder.right;
            if (this.isCellVisible(EBitmap.CENTER))
            {
                this.m_Height = this.m_Height + this.getMaxCellSize(EBitmap.CENTER).y;
                this.m_Width = this.m_Width + this.getMaxCellSize(EBitmap.CENTER).x;
            }
            else
            {
                this.m_Height = this.m_Height + this.getMaxCellSize(EBitmap.LEFT, EBitmap.RIGHT).y;
                this.m_Width = this.m_Width + this.getMaxCellSize(EBitmap.TOP, EBitmap.BOTTOM).x;
            }
            return;
        }// end function

        private function getMaxCellSize(... args) : Point
        {
            args = new Point();
            var _loc_3:* = 0;
            var _loc_4:* = args.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_3 = args[_loc_4];
                if (this.isCellVisible(_loc_3))
                {
                    args.x = Math.max(args.x, this.m_BitmapCell[_loc_3].realWidth);
                    args.y = Math.max(args.y, this.m_BitmapCell[_loc_3].realHeight);
                }
                _loc_4 = _loc_4 - 1;
            }
            return args;
        }// end function

        public function invalidateStyle() : void
        {
            this.m_InvalidStyle = true;
            return;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            this.validateStyle();
            return this.m_MaxBorder;
        }// end function

        public function drawGrid(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number) : void
        {
            this.validateStyle();
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (this.isCellVisible(EBitmap.CENTER))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.CENTER].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.CENTER].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.CENTER].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.CENTER].realHeight;
                _loc_7.tx = param2 + this.m_MaxBorder.left;
                _loc_7.ty = param3 + this.m_MaxBorder.top;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, param4 - this.m_MaxBorder.left - this.m_MaxBorder.right, param5 - this.m_MaxBorder.top - this.m_MaxBorder.bottom);
            }
            else if (this.getStyle(this.getBackgroundColorStyleName()) !== undefined)
            {
                param1.beginFill(this.getStyle(this.getBackgroundColorStyleName()), this.getStyle(this.getBackgroundAlphaStyleName()));
                param1.drawRect(param2 + this.m_MaxBorder.left, param3 + this.m_MaxBorder.top, param4 - this.m_MaxBorder.left - this.m_MaxBorder.right, param5 - this.m_MaxBorder.top - this.m_MaxBorder.bottom);
            }
            if (this.isCellVisible(EBitmap.TOP))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.TOP].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.TOP].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.TOP].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.TOP].realHeight;
                _loc_7.tx = param2 + this.m_MinBorder.left;
                _loc_7.ty = param3;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, param4 - this.m_MinBorder.left - this.m_MinBorder.right, _loc_9);
            }
            if (this.isCellVisible(EBitmap.LEFT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.LEFT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.LEFT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.LEFT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.LEFT].realHeight;
                _loc_7.tx = param2;
                _loc_7.ty = param3 + this.m_MinBorder.top;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, param5 - this.m_MinBorder.top - this.m_MinBorder.bottom);
            }
            if (this.isCellVisible(EBitmap.BOTTOM))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.BOTTOM].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.BOTTOM].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.BOTTOM].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.BOTTOM].realHeight;
                _loc_7.tx = param2 + this.m_MinBorder.left;
                _loc_7.ty = param3 + param5 - _loc_9;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, param4 - this.m_MinBorder.left - this.m_MinBorder.right, _loc_9);
            }
            if (this.isCellVisible(EBitmap.RIGHT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.RIGHT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.RIGHT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.RIGHT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.RIGHT].realHeight;
                _loc_7.tx = param2 + param4 - _loc_8;
                _loc_7.ty = param3 + this.m_MinBorder.top;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, param5 - this.m_MinBorder.top - this.m_MinBorder.bottom);
            }
            if (this.isCellVisible(EBitmap.TOP_LEFT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.TOP_LEFT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.TOP_LEFT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.TOP_LEFT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.TOP_LEFT].realHeight;
                _loc_7.tx = param2;
                _loc_7.ty = param3;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, _loc_9);
            }
            if (this.isCellVisible(EBitmap.BOTTOM_LEFT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.BOTTOM_LEFT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.BOTTOM_LEFT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.BOTTOM_LEFT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.BOTTOM_LEFT].realHeight;
                _loc_7.tx = param2;
                _loc_7.ty = param3 + param5 - _loc_9;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, _loc_9);
            }
            if (this.isCellVisible(EBitmap.BOTTOM_RIGHT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.BOTTOM_RIGHT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.BOTTOM_RIGHT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.BOTTOM_RIGHT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.BOTTOM_RIGHT].realHeight;
                _loc_7.tx = param2 + param4 - _loc_8;
                _loc_7.ty = param3 + param5 - _loc_9;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, _loc_9);
            }
            if (this.isCellVisible(EBitmap.TOP_RIGHT))
            {
                _loc_6 = this.m_BitmapCell[EBitmap.TOP_RIGHT].bitmap;
                _loc_7 = this.m_BitmapCell[EBitmap.TOP_RIGHT].matrix;
                _loc_8 = this.m_BitmapCell[EBitmap.TOP_RIGHT].realWidth;
                _loc_9 = this.m_BitmapCell[EBitmap.TOP_RIGHT].realHeight;
                _loc_7.tx = param2 + param4 - _loc_8;
                _loc_7.ty = param3;
                param1.beginBitmapFill(_loc_6.bitmapData, _loc_7, true, false);
                param1.drawRect(_loc_7.tx, _loc_7.ty, _loc_8, _loc_9);
            }
            return;
        }// end function

        protected function getBackgroundAlphaStyleName() : String
        {
            return this.m_StylePrefix != null ? (this.m_StylePrefix + "BackgroundAlpha") : ("backgroundAlpha");
        }// end function

        protected function getBackgroundColorStyleName() : String
        {
            return this.m_StylePrefix != null ? (this.m_StylePrefix + "BackgroundColor") : ("backgroundColor");
        }// end function

        public function set styleName(param1:Object) : void
        {
            if (this.m_StyleName != param1)
            {
                this.m_StyleName = param1 as IStyleClient;
                this.m_InvalidStyle = true;
            }
            return;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.display.*;

import flash.geom.*;

import mx.core.*;

import mx.styles.*;

import shared.utility.*;

class BitmapGridCell extends Object
{
    private var m_Bitmap:Bitmap = null;
    private var m_ID:int;
    private var m_Matrix:Matrix = null;
    private var m_Width:Number = 0;
    private var m_Height:Number = 0;

    function BitmapGridCell(param1:int, param2)
    {
        var _loc_3:* = null;
        this.m_ID = EBitmap.NONE;
        this.m_ID = param1;
        if (param2 is Bitmap)
        {
            this.m_Bitmap = Bitmap(param2);
        }
        else if (param2 is Class)
        {
            _loc_3 = Class(param2);
            this.m_Bitmap = Bitmap(new _loc_3);
        }
        this.matrix = new Matrix();
        return;
    }// end function

    public function get realHeight() : Number
    {
        return this.m_Height;
    }// end function

    public function get bitmap() : Bitmap
    {
        return this.m_Bitmap;
    }// end function

    public function get matrix() : Matrix
    {
        return this.m_Matrix;
    }// end function

    public function set matrix(param1:Matrix) : void
    {
        if (param1 == null)
        {
            param1 = new Matrix();
        }
        this.m_Matrix = param1;
        if (this.m_Bitmap != null)
        {
            this.m_Height = Math.abs(this.m_Matrix.c * this.m_Bitmap.width + this.m_Matrix.d * this.m_Bitmap.height);
            this.m_Width = Math.abs(this.m_Matrix.a * this.m_Bitmap.width + this.m_Matrix.b * this.m_Bitmap.height);
        }
        else
        {
            this.m_Height = 0;
            this.m_Width = 0;
        }
        return;
    }// end function

    public function get realWidth() : Number
    {
        return this.m_Width;
    }// end function

    public function get ID() : int
    {
        return this.m_ID;
    }// end function

}

