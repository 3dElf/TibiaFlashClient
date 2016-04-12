package loader.asset
{
    import flash.events.*;
    import tibia.game.*;

    public class AssetProviderEvent extends Event
    {
        private var m_AssetKey:Object = null;
        private var m_Asset:AssetBase = null;
        public static const ALL_ASSETS_LOADED:String = "allassetsloaded";
        public static const ASSET_LOADED:String = "assetloaded";
        public static const MANDATORY_ASSETS_LOADED:String = "mandatoryassetsloaded";

        public function AssetProviderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        public function get asset() : AssetBase
        {
            return this.m_Asset;
        }// end function

        public function set assetKey(param1:Object) : void
        {
            this.m_AssetKey = param1;
            return;
        }// end function

        public function set asset(param1:AssetBase) : void
        {
            this.m_Asset = param1;
            return;
        }// end function

        public function get assetKey() : Object
        {
            return this.m_AssetKey;
        }// end function

    }
}
