package build
{
    import tibia.game.*;

    public class ObjectDragImplFactory extends Object
    {

        public function ObjectDragImplFactory()
        {
            throw new Error("ObjectDragImplFactory must not be instantiated");
        }// end function

        public static function s_CreateObjectDragImpl() : ObjectDragImpl
        {
            var _loc_1:* = null;
            _loc_1 = new ObjectDragImpl();
            return _loc_1;
        }// end function

    }
}
