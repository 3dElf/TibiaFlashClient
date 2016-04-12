package shared.controls
{
    import mx.controls.*;
    import mx.core.*;

    public class SimpleTabBar extends TabBar
    {

        public function SimpleTabBar()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            mx_internal::navItemFactory = new ClassFactory(SimpleTab);
            return;
        }// end function

    }
}
