package shared.stage3D
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.*;
    import shared.stage3D.events.*;

    public class Tibia3D extends EventDispatcher
    {
        private var m_AntiAliasing:int = 0;
        private var m_RenderMode:String = "auto";
        private var m_Camera:Camera2D;
        private var m_Context3D:Context3D = null;
        private var m_Stage3D:Stage3D = null;
        private var m_ViewPort:Rectangle;
        private static var s_Instance:Tibia3D = null;

        public function Tibia3D(param1:Stage3D, param2:Rectangle = null, param3:String = null)
        {
            this.m_ViewPort = new Rectangle(0, 0);
            this.m_Camera = new Camera2D(1, 1);
            if (s_Instance == null)
            {
                if (param1 == null)
                {
                    throw new ArgumentError("Stage3D must not be null");
                }
                if (param2 == null)
                {
                    param2 = new Rectangle(0, 0, 0, 0);
                }
                if (param3 == null)
                {
                    param3 = Context3DRenderMode.AUTO;
                }
                this.m_Stage3D = param1;
                this.m_ViewPort = param2;
                this.m_RenderMode = param3;
                this.m_Stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated, false, 1, true);
                this.m_Stage3D.addEventListener(ErrorEvent.ERROR, this.onStage3DError, false, 1, true);
                this.requestContext3D();
                s_Instance = this;
            }
            return;
        }// end function

        protected function showFatalError(param1:String) : void
        {
            throw new Error(param1);
        }// end function

        public function set camera(param1:Camera2D) : void
        {
            this.m_Camera = param1;
            return;
        }// end function

        public function get viewPort() : Rectangle
        {
            return this.m_ViewPort.clone();
        }// end function

        public function get modelViewMatrix() : Matrix3D
        {
            return this.m_Camera.getViewProjectionMatrix();
        }// end function

        protected function requestContext3D() : void
        {
            try
            {
                this.m_Stage3D.requestContext3D(this.m_RenderMode);
            }
            catch (e:Error)
            {
                showFatalError("Context3D error: " + e.message);
            }
            return;
        }// end function

        public function set viewPort(param1:Rectangle) : void
        {
            if (this.m_ViewPort.equals(param1) == false)
            {
                this.m_ViewPort = param1.clone();
                this.updateViewPort();
            }
            return;
        }// end function

        public function get antiAliasing() : int
        {
            return this.m_AntiAliasing;
        }// end function

        protected function onStage3DError(event:ErrorEvent) : void
        {
            this.showFatalError("This application is not correctly embedded (wrong wmode value?)");
            return;
        }// end function

        public function get renderMode() : String
        {
            return this.m_RenderMode;
        }// end function

        protected function initializeGraphicsAPI() : void
        {
            this.updateViewPort();
            return;
        }// end function

        public function get context3D() : Context3D
        {
            return this.m_Context3D;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this.m_Stage3D.visible = param1;
            return;
        }// end function

        public function get camera() : Camera2D
        {
            return this.m_Camera;
        }// end function

        public function dispose() : void
        {
            this.m_Stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated, false);
            this.m_Stage3D.removeEventListener(ErrorEvent.ERROR, this.onStage3DError, false);
            if (this.m_Stage3D.context3D != null)
            {
                this.m_Stage3D.context3D.dispose();
            }
            return;
        }// end function

        public function set antiAliasing(param1:int) : void
        {
            this.m_AntiAliasing = param1;
            this.updateViewPort();
            return;
        }// end function

        protected function updateViewPort() : void
        {
            if (this.m_Context3D)
            {
                this.m_Context3D.configureBackBuffer(this.m_ViewPort.width, this.m_ViewPort.height, this.m_AntiAliasing, false);
            }
            this.m_Stage3D.x = this.m_ViewPort.x;
            this.m_Stage3D.y = this.m_ViewPort.y;
            return;
        }// end function

        public function set renderMode(param1:String) : void
        {
            this.m_RenderMode = param1;
            this.requestContext3D();
            return;
        }// end function

        protected function onContextCreated(event:Event) : void
        {
            this.m_Context3D = this.m_Stage3D.context3D;
            this.initializeGraphicsAPI();
            dispatchEvent(new Tibia3DEvent(Tibia3DEvent.CONTEXT3D_CREATED));
            return;
        }// end function

        public function get visible() : Boolean
        {
            return this.m_Stage3D.visible;
        }// end function

        public static function get context3D() : Context3D
        {
            return isReady ? (s_Instance.context3D) : (null);
        }// end function

        public static function get instance() : Tibia3D
        {
            return s_Instance;
        }// end function

        public static function get isReady() : Boolean
        {
            return s_Instance != null && s_Instance.context3D != null && s_Instance.context3D.driverInfo != "Disposed";
        }// end function

    }
}
