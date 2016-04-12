package mx.controls.treeClasses
{
    import mx.controls.listClasses.*;

    public class TreeListData extends BaseListData
    {
        public var hasChildren:Boolean;
        public var depth:int;
        public var disclosureIcon:Class;
        public var open:Boolean;
        public var indent:int;
        public var item:Object;
        public var icon:Class;
        static const VERSION:String = "3.6.0.21751";

        public function TreeListData(param1:String, param2:String, param3:ListBase, param4:int = 0, param5:int = 0)
        {
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

    }
}
