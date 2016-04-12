package loader.asset
{
    import __AS3__.vec.*;
    import flash.events.*;
    import tibia.appearances.*;
    import tibia.game.*;
    import tibia.options.*;
    import tibia.sessiondump.*;

    public interface IAssetProvider extends IEventDispatcher
    {

        public function IAssetProvider();

        function get bytesTotalMandatory() : uint;

        function getGameBinary() : GameBinaryAsset;

        function getAppearances() : AppearancesAsset;

        function get loadQueueDelay() : uint;

        function getAssetsByClass(param1:Class) : Vector.<AssetBase>;

        function get bytesLoadedMandatory() : uint;

        function removeAsset(param1:AssetBase) : void;

        function getAssetByKey(param1:Object) : AssetBase;

        function get bytesLoaded() : uint;

        function getDefaultOptionsTutorial() : OptionsAsset;

        function set concurrentLoaders(param1:uint) : void;

        function getDefaultOptions() : OptionsAsset;

        function get loadingFinished() : Boolean;

        function set loadQueueDelay(param1:uint) : void;

        function get concurrentLoaders() : uint;

        function get bytesTotal() : uint;

        function getCurrentOptions() : OptionsAsset;

        function getSessiondumpAsset() : SessiondumpAsset;

        function getSpriteAssets() : Vector.<SpritesAsset>;

        function pushAssetForwardInLoadingQueueByKey(param1:String) : void;

    }
}
