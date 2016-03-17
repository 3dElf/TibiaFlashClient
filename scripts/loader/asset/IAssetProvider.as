package loader.asset
{
   import flash.events.IEventDispatcher;
   import tibia.game.GameBinaryAsset;
   import tibia.game.AppearancesAsset;
   import tibia.game.AssetBase;
   import tibia.game.OptionsAsset;
   import tibia.game.SpritesAsset;
   
   public interface IAssetProvider extends IEventDispatcher
   {
       
      function get bytesTotalMandatory() : uint;
      
      function getGameBinary() : GameBinaryAsset;
      
      function get loadQueueDelay() : uint;
      
      function getAppearances() : AppearancesAsset;
      
      function get bytesLoadedMandatory() : uint;
      
      function removeAsset(param1:AssetBase) : void;
      
      function get loadingFinished() : Boolean;
      
      function get bytesLoaded() : uint;
      
      function set concurrentLoaders(param1:uint) : void;
      
      function getDefaultOptions() : OptionsAsset;
      
      function set loadQueueDelay(param1:uint) : void;
      
      function get concurrentLoaders() : uint;
      
      function get bytesTotal() : uint;
      
      function getAsset(param1:Object) : AssetBase;
      
      function getCurrentOptions() : OptionsAsset;
      
      function getSpriteAssets() : Vector.<SpritesAsset>;
      
      function pushAssetForwardInLoadingQueueByKey(param1:String) : void;
   }
}
