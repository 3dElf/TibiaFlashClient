package shared.controls
{
    import mx.containers.*;
    import mx.core.*;

    public class SimpleTabNavigator extends TabNavigator
    {

        public function SimpleTabNavigator()
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
