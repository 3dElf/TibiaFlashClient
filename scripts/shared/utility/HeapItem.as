package shared.utility
{

    public class HeapItem extends Object
    {
        var m_HeapKey:int = 0;
        var m_HeapPosition:int = 0;
        var m_HeapParent:Heap = null;

        public function HeapItem()
        {
            return;
        }// end function

        public function reset() : void
        {
            this.m_HeapKey = 0;
            this.m_HeapPosition = 0;
            this.m_HeapParent = null;
            return;
        }// end function

    }
}
