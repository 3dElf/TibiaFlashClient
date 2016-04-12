package shared.utility
{
    import flash.events.*;
    import flash.net.*;

    public class SharedObjectManager extends Object
    {
        protected var m_Secure:Boolean = false;
        protected var m_SharedObject:SharedObject = null;
        protected var m_LocalPath:String = null;
        static var s_Instance:SharedObjectManager = null;
        static const LISTING_NAME:String = "listing";
        static var s_SharedObject:SharedObject = null;
        static var s_AllocatedSize:int = -2.14748e+009;
        public static const STORAGE_UNLIMITED:int = 1.04858e+007;

        public function SharedObjectManager(param1:String = "/", param2:Boolean = false)
        {
            var a_LocalPath:* = param1;
            var a_Secure:* = param2;
            this.m_LocalPath = a_LocalPath;
            this.m_Secure = a_Secure;
            this.m_SharedObject = null;
            try
            {
                this.m_SharedObject = SharedObject.getLocal(LISTING_NAME, this.m_LocalPath, this.m_Secure);
            }
            catch (_Error)
            {
            }
            return;
        }// end function

        public function exists(param1:String) : Boolean
        {
            return param1 != null && param1.length > 0 && this.m_SharedObject != null && this.m_SharedObject.data.hasOwnProperty(param1);
        }// end function

        public function clear(param1:String, param2:Boolean = false) : void
        {
            var o:SharedObject;
            var a_Name:* = param1;
            var a_IncludeProtected:* = param2;
            if (a_Name == null || a_Name.length < 1)
            {
                throw new ArgumentError("SharedObjectManager.clear: Invalid name: " + a_Name);
            }
            if (this.m_SharedObject != null)
            {
                if (!this.exists(a_Name) || !a_IncludeProtected && this.m_SharedObject.data[a_Name].isProtected)
                {
                    return;
                }
            }
            try
            {
                o = SharedObject.getLocal(a_Name, this.m_LocalPath, this.m_Secure);
                if (o != null)
                {
                    o.clear();
                }
                if (this.m_SharedObject != null)
                {
                    delete this.m_SharedObject.data[a_Name];
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function getListing(param1:Boolean = false) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            if (this.m_SharedObject != null)
            {
                for (_loc_3 in this.m_SharedObject.data)
                {
                    
                    if (!_loc_5[_loc_3].isProtected || param1)
                    {
                        _loc_2.push(_loc_3);
                    }
                }
            }
            return _loc_2;
        }// end function

        public function get localPath() : String
        {
            return this.m_LocalPath;
        }// end function

        public function getLocal(param1:String, param2:Boolean = true, param3:Boolean = false) : SharedObject
        {
            if (param1 == null || param1.length < 1)
            {
                throw new ArgumentError("SharedObjectManager.getLocal: Invalid name: " + param1);
            }
            if (this.m_SharedObject != null)
            {
                if (!param2 && !this.exists(param1))
                {
                    return null;
                }
                this.m_SharedObject.data[param1] = {name:param1, lastAccess:new Date().time, isProtected:param3};
            }
            return SharedObject.getLocal(param1, this.m_LocalPath, this.m_Secure);
        }// end function

        public function get secure() : Boolean
        {
            return this.m_Secure;
        }// end function

        public function syncListing() : void
        {
            try
            {
                if (this.m_SharedObject != null)
                {
                    this.m_SharedObject.flush();
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function s_AllocateSpace(param1:int = 1.04858e+007, param2:Function = null, param3:Boolean = false) : void
        {
            var a_RequestedSize:* = param1;
            var a_Callback:* = param2;
            var a_Rerequest:* = param3;
            var SafeCallback:* = a_Callback != null ? (a_Callback) : (function (param1:Boolean) : void
            {
                return;
            }// end function
            );
            if (s_SharedObject != null)
            {
                SharedObjectManager.SafeCallback(false);
                return;
            }
            var SafeSize:* = Math.abs(a_RequestedSize);
            if (s_AllocatedSize != int.MIN_VALUE && !a_Rerequest || SafeSize <= s_AllocatedSize)
            {
                SharedObjectManager.SafeCallback(SafeSize <= s_AllocatedSize);
                return;
            }
            s_AllocateSpaceInternal(SafeSize, SafeCallback, true);
            return;
        }// end function

        public static function s_SharedObjectsAvailable() : Boolean
        {
            return s_AllocatedSize > -1;
        }// end function

        static function s_AllocateSpaceInternal(param1:int, param2:Function, param3:Boolean = true) : void
        {
            var Name:String;
            var Listener:Function;
            var a_RequestedSize:* = param1;
            var a_Callback:* = param2;
            var a_FirstPass:* = param3;
            var FlushStatus:String;
            try
            {
                Name = new Date().time.toString(16);
                s_SharedObject = SharedObject.getLocal(Name, "/");
                FlushStatus = s_SharedObject.flush(a_RequestedSize);
            }
            catch (e:Error)
            {
                FlushStatus;
            }
            if (FlushStatus == SharedObjectFlushStatus.FLUSHED)
            {
                s_SharedObject.clear();
                s_SharedObject = null;
                s_AllocatedSize = Math.max(s_AllocatedSize, a_RequestedSize);
                SharedObjectManager.a_Callback(true);
            }
            else if (FlushStatus == SharedObjectFlushStatus.PENDING)
            {
                Listener = function (event:NetStatusEvent) : void
            {
                var _loc_2:* = false;
                if (s_SharedObject != null)
                {
                    s_SharedObject.removeEventListener(NetStatusEvent.NET_STATUS, Listener);
                    s_SharedObject.clear();
                    s_SharedObject = null;
                }
                if (a_FirstPass && a_RequestedSize >= STORAGE_UNLIMITED && !checkPlayerVersion(10, 1, 0, 0))
                {
                    s_AllocateSpaceInternal(a_RequestedSize, a_Callback, false);
                }
                else
                {
                    _loc_2 = event.info.code == "SharedObject.Flush.Success";
                    s_AllocatedSize = _loc_2 ? (Math.max(s_AllocatedSize, a_RequestedSize)) : (-1);
                    a_Callback(_loc_2);
                }
                return;
            }// end function
            ;
                s_SharedObject.addEventListener(NetStatusEvent.NET_STATUS, Listener);
            }
            else
            {
                if (s_SharedObject != null)
                {
                    s_SharedObject.clear();
                    s_SharedObject = null;
                }
                s_AllocatedSize = -1;
                SharedObjectManager.a_Callback(false);
            }
            return;
        }// end function

        public static function s_GetInstance() : SharedObjectManager
        {
            if (s_Instance == null)
            {
                s_Instance = new SharedObjectManager;
            }
            return s_Instance;
        }// end function

    }
}
