package mx.modules
{
    import mx.core.*;

    public class ModuleManager extends Object
    {
        static const VERSION:String = "3.6.0.21751";

        public function ModuleManager()
        {
            return;
        }// end function

        public static function getModule(param1:String) : IModuleInfo
        {
            return getSingleton().getModule(param1);
        }// end function

        private static function getSingleton() : Object
        {
            if (!ModuleManagerGlobals.managerSingleton)
            {
                ModuleManagerGlobals.managerSingleton = new ModuleManagerImpl();
            }
            return ModuleManagerGlobals.managerSingleton;
        }// end function

        public static function getAssociatedFactory(param1:Object) : IFlexModuleFactory
        {
            return getSingleton().getAssociatedFactory(param1);
        }// end function

    }
}

import mx.core.*;

class ModuleManagerImpl extends EventDispatcher
{
    private var moduleList:Object;

    function ModuleManagerImpl()
    {
        moduleList = {};
        return;
    }// end function

    public function getModule(param1:String) : IModuleInfo
    {
        var _loc_2:* = moduleList[param1] as ModuleInfo;
        if (!_loc_2)
        {
            _loc_2 = new ModuleInfo(param1);
            moduleList[param1] = _loc_2;
        }
        return new ModuleInfoProxy(_loc_2);
    }// end function

    public function getAssociatedFactory(param1:Object) : IFlexModuleFactory
    {
        var m:Object;
        var info:ModuleInfo;
        var domain:ApplicationDomain;
        var cls:Class;
        var object:* = param1;
        var className:* = getQualifiedClassName(object);
        var _loc_3:* = 0;
        var _loc_4:* = moduleList;
        do
        {
            
            m = _loc_4[_loc_3];
            info = m as ModuleInfo;
            if (!info.ready)
            {
            }
            else
            {
                domain = info.applicationDomain;
                try
                {
                    cls = Class(domain.getDefinition(className));
                    if (object is cls)
                    {
                        return info.factory;
                    }
                }
                catch (error:Error)
                {
                }
            }
        }while (_loc_4 in _loc_3)
        return null;
    }// end function

}

