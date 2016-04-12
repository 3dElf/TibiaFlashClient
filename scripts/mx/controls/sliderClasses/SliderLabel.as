package mx.controls.sliderClasses
{
    import mx.controls.*;

    public class SliderLabel extends Label
    {
        static const VERSION:String = "3.6.0.21751";

        public function SliderLabel()
        {
            return;
        }// end function

        public function getMinimumText(param1:String) : String
        {
            if (!param1 || param1.length < 1)
            {
                param1 = "W";
            }
            return param1;
        }// end function

    }
}
