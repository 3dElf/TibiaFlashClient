package build
{
    import tibia.appearances.*;

    public class ApperanceStorageFactory extends Object
    {

        public function ApperanceStorageFactory()
        {
            throw new Error("ApperanceStorageFactory must not be instantiated");
        }// end function

        public static function s_CreateAppearanceStorage() : AppearanceStorage
        {
            var _loc_1:* = null;
            _loc_1 = new AppearanceStorage();
            return _loc_1;
        }// end function

    }
}
