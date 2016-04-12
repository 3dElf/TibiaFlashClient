package mx.graphics
{
    import flash.display.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.graphics.codec.*;
    import mx.utils.*;

    dynamic public class ImageSnapshot extends Object
    {
        private var _data:ByteArray;
        private var _height:int;
        private var _contentType:String;
        private var _width:int;
        private var _properties:Object;
        public static var defaultEncoder:Class = PNGEncoder;
        public static const MAX_BITMAP_DIMENSION:int = 2880;
        static const VERSION:String = "3.6.0.21751";

        public function ImageSnapshot(param1:int = 0, param2:int = 0, param3:ByteArray = null, param4:String = null)
        {
            _properties = {};
            this.contentType = param4;
            this.width = param1;
            this.height = param2;
            this.data = param3;
            return;
        }// end function

        public function get properties() : Object
        {
            return _properties;
        }// end function

        public function set width(param1:int) : void
        {
            _width = param1;
            return;
        }// end function

        public function set contentType(param1:String) : void
        {
            _contentType = param1;
            return;
        }// end function

        public function get height() : int
        {
            return _height;
        }// end function

        public function get data() : ByteArray
        {
            return _data;
        }// end function

        public function set height(param1:int) : void
        {
            _height = param1;
            return;
        }// end function

        public function get contentType() : String
        {
            return _contentType;
        }// end function

        public function set properties(param1:Object) : void
        {
            _properties = param1;
            return;
        }// end function

        public function set data(param1:ByteArray) : void
        {
            _data = param1;
            return;
        }// end function

        public function get width() : int
        {
            return _width;
        }// end function

        private static function finishPrintObject(param1:IUIComponent, param2:Array) : void
        {
            var _loc_3:* = param1 is DisplayObject ? (DisplayObject(param1)) : (null);
            var _loc_4:* = 0;
            while (_loc_3 != null)
            {
                
                if (_loc_3 is UIComponent)
                {
                    UIComponent(_loc_3).finishPrint(param2[_loc_4++], UIComponent(param1));
                }
                else if (_loc_3 is DisplayObject && !(_loc_3 is Stage))
                {
                    DisplayObject(_loc_3).mask = param2[_loc_4++];
                }
                _loc_3 = _loc_3.parent is DisplayObject ? (DisplayObject(_loc_3.parent)) : (null);
            }
            return;
        }// end function

        public static function encodeImageAsBase64(param1:ImageSnapshot) : String
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = new Base64Encoder();
            _loc_3.encodeBytes(_loc_2);
            var _loc_4:* = _loc_3.drain();
            return _loc_3.drain();
        }// end function

        private static function mergePixelRows(param1:ByteArray, param2:int, param3:ByteArray, param4:int, param5:int) : ByteArray
        {
            var _loc_6:* = new ByteArray();
            var _loc_7:* = param2 * 4;
            var _loc_8:* = param4 * 4;
            var _loc_9:* = 0;
            while (_loc_9 < param5)
            {
                
                _loc_6.writeBytes(param1, _loc_9 * _loc_7, _loc_7);
                _loc_6.writeBytes(param3, _loc_9 * _loc_8, _loc_8);
                _loc_9++;
            }
            _loc_6.position = 0;
            return _loc_6;
        }// end function

        public static function captureImage(param1:IBitmapDrawable, param2:Number = 0, param3:IImageEncoder = null, param4:Boolean = true) : ImageSnapshot
        {
            var snapshot:ImageSnapshot;
            var width:int;
            var height:int;
            var normalState:Array;
            var bytes:ByteArray;
            var data:BitmapData;
            var bitmap:Bitmap;
            var bounds:Rectangle;
            var source:* = param1;
            var dpi:* = param2;
            var encoder:* = param3;
            var scaleLimited:* = param4;
            var screenDPI:* = Capabilities.screenDPI;
            if (dpi <= 0)
            {
                dpi = screenDPI;
            }
            var scale:* = dpi / screenDPI;
            var matrix:* = new Matrix(scale, 0, 0, scale);
            if (source is IUIComponent)
            {
                normalState = prepareToPrintObject(IUIComponent(source));
            }
            try
            {
                if (source != null)
                {
                    if (source is DisplayObject)
                    {
                        width = DisplayObject(source).width;
                        height = DisplayObject(source).height;
                    }
                    else if (source is BitmapData)
                    {
                        width = BitmapData(source).width;
                        height = BitmapData(source).height;
                    }
                    else if (source is IFlexDisplayObject)
                    {
                        width = IFlexDisplayObject(source).mx.core:IFlexDisplayObject::width;
                        height = IFlexDisplayObject(source).mx.core:IFlexDisplayObject::height;
                    }
                }
                if (!encoder)
                {
                    encoder = new defaultEncoder();
                }
                width = width * matrix.a;
                height = height * matrix.d;
                if (scaleLimited || width <= MAX_BITMAP_DIMENSION && height <= MAX_BITMAP_DIMENSION)
                {
                    data = captureBitmapData(source, matrix);
                    bitmap = new Bitmap(data);
                    width = bitmap.width;
                    height = bitmap.height;
                    bytes = encoder.encode(data);
                }
                else
                {
                    bounds = new Rectangle(0, 0, width, height);
                    bytes = captureAll(source, bounds, matrix);
                    bytes = encoder.encodeByteArray(bytes, width, height);
                }
                snapshot = new ImageSnapshot(width, height, bytes, encoder.contentType);
            }
            catch (e:Error)
            {
                throw null;
            }
            finally
            {
                if (source is IUIComponent)
                {
                    finishPrintObject(IUIComponent(source), normalState);
                }
            }
            return snapshot;
        }// end function

        private static function prepareToPrintObject(param1:IUIComponent) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = param1 is DisplayObject ? (DisplayObject(param1)) : (null);
            var _loc_4:* = 0;
            while (_loc_3 != null)
            {
                
                if (_loc_3 is UIComponent)
                {
                    _loc_2[++_loc_4] = UIComponent(_loc_3).prepareToPrint(UIComponent(param1));
                }
                else if (_loc_3 is DisplayObject && !(_loc_3 is Stage))
                {
                    _loc_2[++_loc_4] = DisplayObject(_loc_3).mask;
                    DisplayObject(_loc_3).mask = null;
                }
                _loc_3 = _loc_3.parent is DisplayObject ? (DisplayObject(_loc_3.parent)) : (null);
            }
            return _loc_2;
        }// end function

        private static function captureAll(param1:IBitmapDrawable, param2:Rectangle, param3:Matrix, param4:ColorTransform = null, param5:String = null, param6:Rectangle = null, param7:Boolean = false) : ByteArray
        {
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_8:* = param3.clone();
            var _loc_9:* = param2.clone();
            if (param2.width > MAX_BITMAP_DIMENSION)
            {
                _loc_9.width = MAX_BITMAP_DIMENSION;
                _loc_10 = new Rectangle();
                _loc_10.x = _loc_9.width;
                _loc_10.y = param2.y;
                _loc_10.width = param2.width - _loc_9.width;
                _loc_10.height = param2.height;
            }
            if (param2.height > MAX_BITMAP_DIMENSION)
            {
                _loc_9.height = MAX_BITMAP_DIMENSION;
                if (_loc_10 != null)
                {
                    _loc_10.height = _loc_9.height;
                }
                _loc_11 = new Rectangle();
                _loc_11.x = param2.x;
                _loc_11.y = _loc_9.height;
                _loc_11.width = _loc_9.width;
                _loc_11.height = param2.height - _loc_9.height;
                if (param2.width > MAX_BITMAP_DIMENSION)
                {
                    _loc_12 = new Rectangle();
                    _loc_12.x = _loc_9.width;
                    _loc_12.y = _loc_9.height;
                    _loc_12.width = param2.width - _loc_9.width;
                    _loc_12.height = param2.height - _loc_9.height;
                }
            }
            _loc_8.translate(-_loc_9.x, -_loc_9.y);
            _loc_9.x = 0;
            _loc_9.y = 0;
            var _loc_13:* = new BitmapData(_loc_9.width, _loc_9.height, true, 0);
            _loc_13.draw(param1, _loc_8, param4, param5, param6, param7);
            var _loc_14:* = _loc_13.getPixels(_loc_9);
            _loc_14.position = 0;
            if (_loc_10 != null)
            {
                _loc_8 = param3.clone();
                _loc_8.translate(-_loc_10.x, -_loc_10.y);
                _loc_10.x = 0;
                _loc_10.y = 0;
                _loc_15 = captureAll(param1, _loc_10, _loc_8);
                _loc_14 = mergePixelRows(_loc_14, _loc_9.width, _loc_15, _loc_10.width, _loc_10.height);
            }
            if (_loc_11 != null)
            {
                _loc_8 = param3.clone();
                _loc_8.translate(-_loc_11.x, -_loc_11.y);
                _loc_11.x = 0;
                _loc_11.y = 0;
                _loc_16 = captureAll(param1, _loc_11, _loc_8);
                if (_loc_12 != null)
                {
                    _loc_8 = param3.clone();
                    _loc_8.translate(-_loc_12.x, -_loc_12.y);
                    _loc_12.x = 0;
                    _loc_12.y = 0;
                    _loc_17 = captureAll(param1, _loc_12, _loc_8);
                    _loc_16 = mergePixelRows(_loc_16, _loc_11.width, _loc_17, _loc_12.width, _loc_12.height);
                }
                _loc_14.position = _loc_14.length;
                _loc_14.writeBytes(_loc_16);
            }
            _loc_14.position = 0;
            return _loc_14;
        }// end function

        public static function captureBitmapData(param1:IBitmapDrawable, param2:Matrix = null, param3:ColorTransform = null, param4:String = null, param5:Rectangle = null, param6:Boolean = false) : BitmapData
        {
            var data:BitmapData;
            var width:int;
            var height:int;
            var normalState:Array;
            var scaledWidth:Number;
            var scaledHeight:Number;
            var reductionScale:Number;
            var source:* = param1;
            var matrix:* = param2;
            var colorTransform:* = param3;
            var blendMode:* = param4;
            var clipRect:* = param5;
            var smoothing:* = param6;
            if (source is IUIComponent)
            {
                normalState = prepareToPrintObject(IUIComponent(source));
            }
            try
            {
                if (source != null)
                {
                    if (source is DisplayObject)
                    {
                        width = DisplayObject(source).width;
                        height = DisplayObject(source).height;
                    }
                    else if (source is BitmapData)
                    {
                        width = BitmapData(source).width;
                        height = BitmapData(source).height;
                    }
                    else if (source is IFlexDisplayObject)
                    {
                        width = IFlexDisplayObject(source).mx.core:IFlexDisplayObject::width;
                        height = IFlexDisplayObject(source).mx.core:IFlexDisplayObject::height;
                    }
                }
                if (!matrix)
                {
                    matrix = new Matrix(1, 0, 0, 1);
                }
                scaledWidth = width * matrix.a;
                scaledHeight = height * matrix.d;
                reductionScale;
                if (scaledWidth > MAX_BITMAP_DIMENSION)
                {
                    reductionScale = scaledWidth / MAX_BITMAP_DIMENSION;
                    scaledWidth = MAX_BITMAP_DIMENSION;
                    scaledHeight = scaledHeight / reductionScale;
                    matrix.a = scaledWidth / width;
                    matrix.d = scaledHeight / height;
                }
                if (scaledHeight > MAX_BITMAP_DIMENSION)
                {
                    reductionScale = scaledHeight / MAX_BITMAP_DIMENSION;
                    scaledHeight = MAX_BITMAP_DIMENSION;
                    scaledWidth = scaledWidth / reductionScale;
                    matrix.a = scaledWidth / width;
                    matrix.d = scaledHeight / height;
                }
                data = new BitmapData(scaledWidth, scaledHeight, true, 0);
                data.draw(source, matrix, colorTransform, blendMode, clipRect, smoothing);
            }
            catch (e:Error)
            {
                throw null;
            }
            finally
            {
                if (source is IUIComponent)
                {
                    finishPrintObject(IUIComponent(source), normalState);
                }
            }
            return data;
        }// end function

    }
}
