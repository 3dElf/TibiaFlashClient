package tibia.sessiondump.hints
{
    import tibia.game.*;

    public class SessiondumpHintsAsset extends Asset
    {
        private var m_CachedSessiondumpHintsObject:Object = null;

        public function SessiondumpHintsAsset(param1:String, param2:int)
        {
            super(param1, param2);
            this.m_NoCacheEnabled = true;
            return;
        }// end function

        public function get sessiondumpHintsObject() : Object
        {
            var _loc_1:* = null;
            if (this.m_CachedSessiondumpHintsObject == null && this.loaded)
            {
                _loc_1 = rawBytes.readUTFBytes(rawBytes.bytesAvailable);
                this.m_CachedSessiondumpHintsObject = JSON.parse(_loc_1);
            }
            return this.m_CachedSessiondumpHintsObject;
        }// end function

    }
}
