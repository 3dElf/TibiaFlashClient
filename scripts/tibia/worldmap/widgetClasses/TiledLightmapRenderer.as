package tibia.worldmap.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.events.*;
    import shared.stage3D.*;
    import shared.stage3D.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.options.*;
    import tibia.worldmap.*;

    public class TiledLightmapRenderer extends Object
    {
        protected var m_LightmapBitmap:BitmapData = null;
        protected var m_UpdateColorBuffer:Boolean;
        private const COORDINATES_PER_VERTEX:uint = 2;
        private var m_OptionsLevelSeparator:Number = NaN;
        private const COLOR_VALUES_COUNT:uint = 1140;
        protected var m_ColorBuffer:VertexBuffer3D;
        protected var m_AmbientColour:Colour;
        private var m_Rect:Rectangle = null;
        protected var m_AmbientBrightness:int = 0;
        protected var m_UpdateLightmap:Boolean;
        protected var m_UpdateShaderProgram:Boolean;
        protected var m_CoordinatesBuffer:VertexBuffer3D;
        protected var m_IndexData:Vector.<uint>;
        protected const VERTEX_SHADER_HEX_CODE:String = "a0 01 00 00 00 a1 00 18 00 00 00 00 00 0f 03 00 00 00 e4 00 00 00 00 00 00 00 e4 01 00 00 00 00 00 00 00 00 00 0f 04 01 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00";
        protected var m_Options:OptionsStorage = null;
        private const INDICES_COUNT:uint = 190;
        private var m_OptionsAmbientBrightness:Number = NaN;
        protected var m_WorldMapStorage:WorldMapStorage = null;
        protected var m_IndexBuffer:IndexBuffer3D;
        private const VERTICES_COUNT:uint = 285;
        protected var m_CoordinatesData:Vector.<Number>;
        protected const FRAGMENT_SHADER_HEX_CODE:String = "a0 01 00 00 00 a1 01 00 00 00 00 00 00 0f 03 00 00 00 e4 04 00 00 00 00 00 00 00 00 00 00 00";
        protected var m_CurrentColorData:ByteArray;
        private const COLOR_VALUES_PER_VERTEX:uint = 4;
        private const m_CachedLayerBrightnessInfo:Vector.<Vector.<Boolean>>;
        protected var m_ShaderProgram:Program3D;
        protected var m_Context3D:Context3D = null;
        protected var m_UpdateCoordinatesBuffer:Boolean;
        protected var m_OldColorData:ByteArray;
        protected var m_LightmapCamera:Camera2D = null;
        protected var m_HelperCoordinate:Vector3D;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        public static const COLOUR_BELOW_GROUND:Colour = new Colour(255, 255, 255);
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        public static const COLOUR_ABOVE_GROUND:Colour = new Colour(200, 200, 255);
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        public static const LIGHTMAP_SHRINK_FACTOR:uint = 8;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;

        public function TiledLightmapRenderer()
        {
            this.m_AmbientColour = new Colour(0, 0, 0);
            this.m_HelperCoordinate = new Vector3D();
            this.m_CachedLayerBrightnessInfo = new Vector.<Vector.<Boolean>>(MAPSIZE_Z, false);
            if (Tibia3D.isReady)
            {
                this.m_Context3D = Tibia3D.instance.context3D;
            }
            this.m_Rect = new Rectangle(0, 0, MAPSIZE_X * FIELD_SIZE / LIGHTMAP_SHRINK_FACTOR, MAPSIZE_Y * FIELD_SIZE / LIGHTMAP_SHRINK_FACTOR);
            this.m_CoordinatesData = new Vector.<Number>;
            this.m_CurrentColorData = new ByteArray();
            this.m_CurrentColorData.length = this.COLOR_VALUES_COUNT;
            this.m_CurrentColorData.position = 0;
            this.m_OldColorData = new ByteArray();
            this.m_OldColorData.length = this.COLOR_VALUES_COUNT;
            this.m_OldColorData.position = 0;
            this.m_IndexData = new Vector.<uint>;
            this.m_LightmapCamera = new Camera2D(MAPSIZE_X, MAPSIZE_Y);
            this.m_LightmapCamera.offsetX = 0;
            this.m_LightmapCamera.offsetY = 0;
            this.m_UpdateCoordinatesBuffer = true;
            this.m_UpdateColorBuffer = true;
            this.m_UpdateShaderProgram = true;
            this.createBufferData();
            Tibia3D.instance.addEventListener(Tibia3DEvent.CONTEXT3D_CREATED, this.onContextCreated);
            return;
        }// end function

        protected function setupShaders() : void
        {
            if (this.m_ShaderProgram != null)
            {
                this.m_ShaderProgram.dispose();
            }
            this.m_ShaderProgram = this.m_Context3D.createProgram();
            var _loc_1:* = this.hexStringToByteArray(this.VERTEX_SHADER_HEX_CODE);
            var _loc_2:* = this.hexStringToByteArray(this.FRAGMENT_SHADER_HEX_CODE);
            this.m_ShaderProgram.upload(_loc_1, _loc_2);
            return;
        }// end function

        public function setLightSource(param1:Number, param2:Number, param3:uint, param4:uint, param5:Colour) : void
        {
            var _loc_25:* = 0;
            if (param1 < 0 || param1 > MAPSIZE_X || param2 < 0 || param2 > MAPSIZE_Y || param4 <= 0)
            {
                return;
            }
            var _loc_6:* = 0;
            var _loc_7:* = param1;
            var _loc_8:* = param2;
            var _loc_9:* = _loc_7 - param4;
            var _loc_10:* = _loc_7 + param4;
            var _loc_11:* = _loc_8 - param4;
            var _loc_12:* = _loc_8 + param4;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = param4;
            var _loc_16:* = 0;
            var _loc_17:* = 1;
            var _loc_18:* = 1;
            var _loc_19:* = 1;
            var _loc_20:* = null;
            var _loc_21:* = this.getLayerInformation(param3);
            var _loc_22:* = param5.red;
            var _loc_23:* = param5.green;
            var _loc_24:* = param5.blue;
            if (_loc_9 < 0)
            {
                _loc_9 = 0;
            }
            if (_loc_10 > MAPSIZE_X)
            {
                _loc_10 = MAPSIZE_X;
            }
            if (_loc_11 < 0)
            {
                _loc_11 = 0;
            }
            if (_loc_12 > MAPSIZE_Y)
            {
                _loc_12 = MAPSIZE_Y;
            }
            _loc_8 = _loc_11;
            while (_loc_8 < _loc_12)
            {
                
                _loc_14 = (_loc_8 + 1) - param2;
                _loc_14 = ((_loc_8 + 1) - param2) * _loc_14;
                _loc_7 = _loc_9;
                while (_loc_7 < _loc_10)
                {
                    
                    _loc_13 = (_loc_7 + 1) - param1;
                    _loc_13 = ((_loc_7 + 1) - param1) * _loc_13;
                    _loc_16 = (_loc_15 - Math.sqrt(_loc_13 + _loc_14)) / 5;
                    if (_loc_16 < 0)
                    {
                    }
                    else
                    {
                        if (_loc_16 > 1)
                        {
                            _loc_16 = 1;
                        }
                        _loc_17 = _loc_22 * _loc_16;
                        _loc_18 = _loc_23 * _loc_16;
                        _loc_19 = _loc_24 * _loc_16;
                        _loc_25 = _loc_8 * MAPSIZE_X + _loc_7;
                        if (_loc_21[_loc_25] == true)
                        {
                            _loc_17 = _loc_17 * this.m_OptionsLevelSeparator;
                            _loc_18 = _loc_18 * this.m_OptionsLevelSeparator;
                            _loc_19 = _loc_19 * this.m_OptionsLevelSeparator;
                        }
                        _loc_6 = this.toColorIndexRed(_loc_7, _loc_8);
                        if (_loc_17 > this.m_CurrentColorData[_loc_6])
                        {
                            this.m_CurrentColorData[_loc_6] = _loc_17;
                        }
                        if (_loc_18 > this.m_CurrentColorData[++_loc_6])
                        {
                            this.m_CurrentColorData[++_loc_6] = _loc_18;
                        }
                        if (_loc_19 > this.m_CurrentColorData[++_loc_6])
                        {
                            this.m_CurrentColorData[++_loc_6] = _loc_19;
                        }
                    }
                    _loc_7 = _loc_7 + 1;
                }
                _loc_8 = _loc_8 + 1;
            }
            this.m_UpdateColorBuffer = true;
            return;
        }// end function

        protected function getLayerInformation(param1:uint) : Vector.<Boolean>
        {
            if (this.m_CachedLayerBrightnessInfo[param1] == null)
            {
                this.m_CachedLayerBrightnessInfo[param1] = this.m_WorldMapStorage.getLightBlockingTilesForZLayer(param1);
            }
            return this.m_CachedLayerBrightnessInfo[param1];
        }// end function

        public function calculateCreatureHudBrightnessFactor(param1:Creature, param2:Boolean) : Number
        {
            this.m_WorldMapStorage.toMapClosest(param1.position, this.m_HelperCoordinate);
            var _loc_3:* = this.getFieldBrightness(this.m_HelperCoordinate.x, this.m_HelperCoordinate.y);
            if (param2)
            {
                _loc_3 = Math.max(_loc_3, Math.max(2, Math.min(param1.brightness, 5)) * 51);
            }
            return _loc_3 / 255;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function dispose() : void
        {
            Tibia3D.instance.removeEventListener(Tibia3DEvent.CONTEXT3D_CREATED, this.onContextCreated);
            this.m_UpdateCoordinatesBuffer = true;
            this.m_UpdateColorBuffer = true;
            this.m_UpdateShaderProgram = true;
            this.m_UpdateLightmap = true;
            this.m_ColorBuffer = null;
            this.m_CoordinatesBuffer = null;
            this.m_IndexBuffer = null;
            this.m_LightmapBitmap = null;
            return;
        }// end function

        protected function onContextCreated(event:Tibia3DEvent) : void
        {
            if (Tibia3D.isReady)
            {
                this.m_Context3D = Tibia3D.instance.context3D;
            }
            else
            {
                this.m_Context3D = null;
            }
            this.m_UpdateCoordinatesBuffer = true;
            this.m_UpdateColorBuffer = true;
            this.m_UpdateShaderProgram = true;
            this.m_UpdateLightmap = true;
            this.m_ColorBuffer = null;
            this.m_CoordinatesBuffer = null;
            this.m_IndexBuffer = null;
            this.m_LightmapBitmap = null;
            return;
        }// end function

        public function toColorIndexRed(param1:uint, param2:uint) : uint
        {
            return ((param2 + 1) * (MAPSIZE_X + 1) + (param1 + 1)) * this.COLOR_VALUES_PER_VERTEX;
        }// end function

        protected function createBufferData() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_2 = 0;
            while (_loc_2 < (MAPSIZE_Y + 1))
            {
                
                _loc_1 = 0;
                while (_loc_1 < (MAPSIZE_X + 1))
                {
                    
                    this.m_CoordinatesData.push(_loc_1, _loc_2);
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < MAPSIZE_Y)
            {
                
                _loc_5 = _loc_2 * (MAPSIZE_X + 1);
                _loc_1 = 0;
                while (_loc_1 < MAPSIZE_X)
                {
                    
                    _loc_6 = _loc_1 + _loc_5;
                    _loc_7 = _loc_6 + 1;
                    _loc_8 = _loc_1 + _loc_5 + MAPSIZE_X + 1;
                    _loc_9 = _loc_8 + 1;
                    this.m_IndexData.push(_loc_6, _loc_7, _loc_9, _loc_6, _loc_9, _loc_8);
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < this.COLOR_VALUES_COUNT)
            {
                
                this.m_CurrentColorData[_loc_3] = 255;
                this.m_OldColorData[_loc_3] = 255;
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function createLightmap() : void
        {
            var x:uint;
            var y:uint;
            var DestIndex:uint;
            var SourceIndex:uint;
            var Same:Boolean;
            var i:uint;
            try
            {
                if (Tibia3D.isReady)
                {
                    if (Tibia3D.instance.viewPort.equals(this.m_Rect) == false)
                    {
                        Tibia3D.instance.viewPort = this.m_Rect;
                    }
                    if (this.lightmapBitmap == null)
                    {
                        this.createLightmapBitmap();
                        this.m_UpdateLightmap = true;
                    }
                    x;
                    y;
                    DestIndex;
                    SourceIndex;
                    x;
                    while (x < (MAPSIZE_X + 1))
                    {
                        
                        DestIndex = x * this.COLOR_VALUES_PER_VERTEX;
                        SourceIndex = (x + MAPSIZE_X + 1) * this.COLOR_VALUES_PER_VERTEX;
                        this.m_CurrentColorData[DestIndex] = this.m_CurrentColorData[SourceIndex];
                        this.m_CurrentColorData[(DestIndex + 1)] = this.m_CurrentColorData[(SourceIndex + 1)];
                        this.m_CurrentColorData[DestIndex + 2] = this.m_CurrentColorData[SourceIndex + 2];
                        x = (x + 1);
                    }
                    y;
                    while (y < (MAPSIZE_Y + 1))
                    {
                        
                        DestIndex = y * (MAPSIZE_X + 1) * this.COLOR_VALUES_PER_VERTEX;
                        SourceIndex = DestIndex + this.COLOR_VALUES_PER_VERTEX;
                        this.m_CurrentColorData[DestIndex] = this.m_CurrentColorData[SourceIndex];
                        this.m_CurrentColorData[(DestIndex + 1)] = this.m_CurrentColorData[(SourceIndex + 1)];
                        this.m_CurrentColorData[DestIndex + 2] = this.m_CurrentColorData[SourceIndex + 2];
                        y = (y + 1);
                    }
                    Same;
                    i;
                    while (i < this.COLOR_VALUES_COUNT)
                    {
                        
                        Same = Same && this.m_OldColorData[i] == this.m_CurrentColorData[i];
                        this.m_OldColorData[i] = this.m_CurrentColorData[i];
                        i = (i + 1);
                    }
                    this.m_UpdateLightmap = this.m_UpdateLightmap || Same == false;
                    if (this.m_UpdateLightmap)
                    {
                        this.m_Context3D.clear(1, 1, 1, 1);
                        this.draw();
                        this.m_Context3D.drawToBitmapData(this.m_LightmapBitmap);
                        this.m_UpdateLightmap = false;
                    }
                }
            }
            catch (_Error:Error)
            {
                if (_Error.errorID == 3694)
                {
                }
                else
                {
                    throw _Error;
                }
            }
            z;
            while (z < MAPSIZE_Z)
            {
                
                this.m_CachedLayerBrightnessInfo[z] = null;
                z = (z + 1);
            }
            return;
        }// end function

        public function getFieldBrightness(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = 0;
            if (param1 < MAPSIZE_X && param2 < MAPSIZE_Y)
            {
                _loc_3 = this.toColorIndexRed(param1, param2);
                return (this.m_CurrentColorData[_loc_3] + this.m_CurrentColorData[(_loc_3 + 1)] + this.m_CurrentColorData[_loc_3 + 2]) / 3;
            }
            return uint.MAX_VALUE;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.updateOptions();
            }
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:* = 0;
            if (Tibia3D.isReady == false)
            {
                return;
            }
            if (this.m_UpdateCoordinatesBuffer)
            {
                if (this.m_CoordinatesBuffer == null)
                {
                    this.m_CoordinatesBuffer = this.m_Context3D.createVertexBuffer(this.VERTICES_COUNT, this.COORDINATES_PER_VERTEX);
                }
                this.m_CoordinatesBuffer.uploadFromVector(this.m_CoordinatesData, 0, this.VERTICES_COUNT);
                if (this.m_IndexBuffer == null)
                {
                    this.m_IndexBuffer = this.m_Context3D.createIndexBuffer(this.m_IndexData.length);
                }
                this.m_IndexBuffer.uploadFromVector(this.m_IndexData, 0, this.m_IndexData.length);
                this.m_UpdateCoordinatesBuffer = false;
            }
            if (this.m_UpdateColorBuffer)
            {
                if (this.m_ColorBuffer == null)
                {
                    this.m_ColorBuffer = this.m_Context3D.createVertexBuffer(this.VERTICES_COUNT, 1);
                }
                this.m_ColorBuffer.uploadFromByteArray(this.m_CurrentColorData, 0, 0, this.VERTICES_COUNT);
                this.m_UpdateColorBuffer = false;
            }
            if (this.m_UpdateShaderProgram)
            {
                this.setupShaders();
                this.m_UpdateShaderProgram = false;
            }
            this.m_Context3D.setProgram(this.m_ShaderProgram);
            this.m_Context3D.setBlendFactors(Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO);
            var _loc_2:* = this.m_LightmapCamera.getViewProjectionMatrix();
            this.m_Context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _loc_2, true);
            this.m_Context3D.setVertexBufferAt(0, this.m_CoordinatesBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
            this.m_Context3D.setVertexBufferAt(1, this.m_ColorBuffer, 0, Context3DVertexBufferFormat.BYTES_4);
            this.m_Context3D.drawTriangles(this.m_IndexBuffer);
            this.m_Context3D.setVertexBufferAt(0, null);
            this.m_Context3D.setVertexBufferAt(1, null);
            this.m_Context3D.setProgram(null);
            return;
        }// end function

        public function get worldMapStorage() : WorldMapStorage
        {
            return this.m_WorldMapStorage;
        }// end function

        protected function hexStringToByteArray(param1:String) : ByteArray
        {
            var _loc_5:* = null;
            var _loc_2:* = new ByteArray();
            _loc_2.endian = Endian.LITTLE_ENDIAN;
            var _loc_3:* = param1.split(" ");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                _loc_2.writeByte(parseInt(_loc_5, 16));
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.position = 0;
            return _loc_2;
        }// end function

        public function setFieldBrightness(param1:uint, param2:uint, param3:uint, param4:Boolean) : void
        {
            if (param1 < 0 || param1 >= MAPSIZE_X || param2 < 0 || param2 >= MAPSIZE_Y)
            {
                return;
            }
            var _loc_5:* = 255;
            var _loc_6:* = 255;
            var _loc_7:* = 255;
            var _loc_8:* = 0;
            var _loc_9:* = this.m_WorldMapStorage.getAmbientColour();
            var _loc_10:* = param3 / 255;
            if (param3 / 255 < 0)
            {
                _loc_10 = 0;
            }
            if (_loc_10 > 1)
            {
                _loc_10 = 1;
            }
            _loc_6 = _loc_9.green * _loc_10;
            _loc_7 = _loc_9.blue * _loc_10;
            _loc_5 = _loc_9.red * _loc_10;
            var _loc_11:* = null;
            if (param4)
            {
                _loc_11 = COLOUR_ABOVE_GROUND;
            }
            else
            {
                _loc_11 = COLOUR_BELOW_GROUND;
            }
            var _loc_12:* = this.m_OptionsAmbientBrightness * (255 - _loc_5) / 255;
            _loc_5 = _loc_5 + _loc_11.red * _loc_12;
            _loc_6 = _loc_6 + _loc_11.green * _loc_12;
            _loc_7 = _loc_7 + _loc_11.blue * _loc_12;
            if (_loc_5 > 255)
            {
                _loc_5 = 255;
            }
            if (_loc_6 > 255)
            {
                _loc_6 = 255;
            }
            if (_loc_7 > 255)
            {
                _loc_7 = 255;
            }
            _loc_8 = this.toColorIndexRed(param1, param2);
            this.m_CurrentColorData[_loc_8] = _loc_5;
            this.m_CurrentColorData[++_loc_8] = _loc_6;
            _loc_8 = ++_loc_8 + 1;
            var _loc_14:* = ++_loc_8 + 1;
            this.m_CurrentColorData[++_loc_8 + 1] = _loc_7;
            return;
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "rendererAmbientBrightness":
                    case "rendererLevelSeparator":
                    case "*":
                    {
                        this.updateOptions();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get lightmapBitmap() : BitmapData
        {
            return this.m_LightmapBitmap;
        }// end function

        private function updateOptions() : void
        {
            if (this.m_Options != null)
            {
                this.m_OptionsAmbientBrightness = this.m_Options.rendererAmbientBrightness;
                this.m_OptionsLevelSeparator = this.m_Options.rendererLevelSeparator;
            }
            else
            {
                this.m_OptionsAmbientBrightness = NaN;
                this.m_OptionsLevelSeparator = 4 / 5;
            }
            return;
        }// end function

        public function set worldMapStorage(param1:WorldMapStorage) : void
        {
            if (this.m_WorldMapStorage != param1)
            {
                this.m_WorldMapStorage = param1;
            }
            return;
        }// end function

        public function get rect() : Rectangle
        {
            return this.m_Rect;
        }// end function

        public function get rawColorData() : ByteArray
        {
            return this.m_CurrentColorData;
        }// end function

        protected function createLightmapBitmap() : void
        {
            this.m_LightmapBitmap = new BitmapData(Tibia3D.instance.viewPort.width, Tibia3D.instance.viewPort.height);
            return;
        }// end function

        public function resetTiles() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.m_CurrentColorData.length)
            {
                
                this.m_CurrentColorData[_loc_1] = 255;
                _loc_1 = _loc_1 + 1;
            }
            this.m_UpdateColorBuffer = true;
            return;
        }// end function

    }
}
