package 
{
    import flash.display.*;
    import mx.binding.*;
    import mx.core.*;

    public class _TibiaWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _TibiaWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Tibia.watcherSetupUtil = new _TibiaWatcherSetupUtil;
            return;
        }// end function

    }
}
