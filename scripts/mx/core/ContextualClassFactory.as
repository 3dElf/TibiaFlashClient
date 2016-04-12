package mx.core
{
    import flash.utils.*;

    public class ContextualClassFactory extends ClassFactory
    {
        public var moduleFactory:IFlexModuleFactory;
        static const VERSION:String = "3.6.0.21751";

        public function ContextualClassFactory(param1:Class = null, param2:IFlexModuleFactory = null)
        {
            super(param1);
            this.moduleFactory = param2;
            return;
        }// end function

        override public function newInstance()
        {
            var _loc_2:* = null;
            var _loc_1:* = null;
            if (moduleFactory)
            {
                _loc_1 = moduleFactory.create(getQualifiedClassName(generator));
            }
            if (!_loc_1)
            {
                _loc_1 = super.newInstance();
            }
            if (properties)
            {
                for (_loc_2 in properties)
                {
                    
                    _loc_1[_loc_2] = _loc_4[_loc_2];
                }
            }
            return _loc_1;
        }// end function

    }
}
