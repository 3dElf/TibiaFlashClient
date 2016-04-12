package tibia.controls
{
    import mx.core.*;
    import mx.preloaders.*;
    import tibia.cursors.*;

    public class CustomDownloadProgressBar extends DownloadProgressBar
    {

        public function CustomDownloadProgressBar()
        {
            return;
        }// end function

        override public function initialize() : void
        {
            Singleton.registerClass("mx.managers::ICursorManager", CustomCursorManagerImpl);
            super.initialize();
            return;
        }// end function

    }
}
