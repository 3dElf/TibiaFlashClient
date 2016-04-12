package tibia.game
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.options.*;
    import tibia.sessiondump.*;
    import tibia.sessiondump.hints.*;
    import tibia.tutorial.*;

    public class Asset extends AssetBase
    {
        private var m_RawBytes:ByteArray = null;
        protected var m_SaveAsLSO:Boolean = true;

        public function Asset(param1:String, param2:int)
        {
            super(param1, param2);
            return;
        }// end function

        override protected function resetDownloadedData() : void
        {
            this.m_RawBytes = null;
            System.pauseForGCIfCollectionImminent(0.95);
            return;
        }// end function

        public function get rawBytes() : ByteArray
        {
            return this.m_RawBytes;
        }// end function

        override public function load() : void
        {
            var _SharedObjectManager:SharedObjectManager;
            var _SharedObject:SharedObject;
            this.resetDownloadedData();
            if (this.m_SaveAsLSO)
            {
                _SharedObjectManager = SharedObjectManager.s_GetInstance();
                if (SharedObjectManager.s_SharedObjectsAvailable() && _SharedObjectManager != null)
                {
                    try
                    {
                        _SharedObject = _SharedObjectManager.getLocal(name);
                        this.m_RawBytes = _SharedObject.data.RAW_BYTES;
                    }
                    catch (e)
                    {
                    }
                }
                if (this.m_RawBytes != null && (size == 0 || this.m_RawBytes.length == size))
                {
                    setTimeout(dispatchEvent, 0, new Event(Event.COMPLETE, false, false));
                }
                else
                {
                    super.load();
                }
            }
            else
            {
                super.load();
            }
            return;
        }// end function

        override public function get loaded() : Boolean
        {
            return this.m_RawBytes != null || optional == true;
        }// end function

        override protected function processDownloadedData(param1:URLLoader) : Boolean
        {
            var _SharedObject:SharedObject;
            var a_Loader:* = param1;
            this.m_RawBytes = a_Loader.data;
            var _SharedObjectManager:* = SharedObjectManager.s_GetInstance();
            if (this.m_SaveAsLSO && SharedObjectManager.s_SharedObjectsAvailable() && _SharedObjectManager != null)
            {
                try
                {
                    _SharedObject = _SharedObjectManager.getLocal(name);
                    _SharedObject.data.RAW_BYTES = this.m_RawBytes;
                    _SharedObject.flush();
                    _SharedObjectManager.syncListing();
                }
                catch (e)
                {
                }
            }
            return true;
        }// end function

        public static function s_FromXML(param1:XML) : AssetBase
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_2:* = param1 != null ? (param1.localName()) : (null);
            var _loc_3:* = null;
            if (_loc_2 == "appearances" || _loc_2 == "binary" || _loc_2 == "currentOptions" || _loc_2 == "defaultOptions" || _loc_2 == "defaultOptionsTutorial" || _loc_2 == "tutorialProgressService" || _loc_2 == "sprites" || _loc_2 == "tutorialSessiondump" || _loc_2 == "tutorialSessiondumpHints" || _loc_2 == "tutorialProgressService")
            {
                var _loc_13:* = param1.url;
                _loc_3 = param1.url;
                if (_loc_13 == null || _loc_3.length() != 1)
                {
                    return null;
                }
                _loc_4 = _loc_3[0].toString();
                _loc_5 = 0;
                var _loc_13:* = param1.size;
                _loc_3 = param1.size;
                if (_loc_13 != null && _loc_3.length() == 1 && _loc_4.match(/^[1-9[0-9]*$/) != null)
                {
                    _loc_5 = int(_loc_3[0].toString());
                }
                _loc_6 = 0;
                var _loc_13:* = param1.version;
                _loc_3 = param1.version;
                if (_loc_13 != null && _loc_3.length() == 1 && _loc_4.match(/^[1-9[0-9]*$/) != null)
                {
                    _loc_6 = int(_loc_3[0].toString());
                }
                if (_loc_2 != "currentOptions" && _loc_2 != "defaultOptions" && _loc_2 != "defaultOptionsTutorial" && _loc_2 != "tutorialProgressService" && _loc_5 < 1)
                {
                    return null;
                }
                if (_loc_2 == "appearances")
                {
                    return new AppearancesAsset(_loc_4, _loc_5, _loc_6);
                }
                if (_loc_2 == "binary")
                {
                    return new GameBinaryAsset(_loc_4, _loc_5);
                }
                if (_loc_2 == "currentOptions")
                {
                    return new OptionsAsset(_loc_4, _loc_5, "application/json", false, false);
                }
                if (_loc_2 == "defaultOptions")
                {
                    return new OptionsAsset(_loc_4, _loc_5, "text/xml", true, false);
                }
                if (_loc_2 == "defaultOptionsTutorial")
                {
                    return new OptionsAsset(_loc_4, _loc_5, "text/xml", true, true);
                }
                if (_loc_2 == "sprites")
                {
                    _loc_7 = -1;
                    var _loc_13:* = param1.firstSpriteID;
                    _loc_3 = param1.firstSpriteID;
                    if (_loc_13 != null && _loc_3.length() == 1 && _loc_4.match(/^[0-9]+$/) != null)
                    {
                        _loc_7 = int(_loc_3[0].toString());
                    }
                    _loc_8 = -1;
                    var _loc_13:* = param1.lastSpriteID;
                    _loc_3 = param1.lastSpriteID;
                    if (_loc_13 != null && _loc_3.length() == 1 && _loc_4.match(/^[0-9]+$/) != null)
                    {
                        _loc_8 = int(_loc_3[0].toString());
                    }
                    _loc_9 = -1;
                    var _loc_13:* = param1.spriteType;
                    _loc_3 = param1.spriteType;
                    if (_loc_13 != null && _loc_3.length() == 1 && _loc_4.match(/^[0-9]+$/) != null)
                    {
                        _loc_9 = int(_loc_3[0].toString());
                    }
                    _loc_10 = new Vector.<int>;
                    var _loc_13:* = param1.area;
                    _loc_3 = param1.area;
                    if (_loc_13 != null && _loc_3.length() > 0)
                    {
                        _loc_11 = 0;
                        while (_loc_11 < _loc_3.length())
                        {
                            
                            if (_loc_3[_loc_11].toString().match(/^[0-9]+$/) != null)
                            {
                                _loc_12 = int(_loc_3[_loc_11].toString());
                                _loc_10.push(_loc_12);
                            }
                            _loc_11 = _loc_11 + 1;
                        }
                    }
                    return new SpritesAsset(_loc_4, _loc_5, _loc_7, _loc_8, _loc_9, _loc_10);
                }
                else
                {
                    if (_loc_2 == "tutorialSessiondump")
                    {
                        return new SessiondumpAsset(_loc_4, _loc_5);
                    }
                    if (_loc_2 == "tutorialSessiondumpHints")
                    {
                        return new SessiondumpHintsAsset(_loc_4, _loc_5);
                    }
                    if (_loc_2 == "tutorialProgressService")
                    {
                        return new TutorialProgressServiceAsset(_loc_4, _loc_5, "application/json");
                    }
                    return null;
                }
            }
            else
            {
                return null;
            }
        }// end function

    }
}
