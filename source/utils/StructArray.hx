package utils;

@:forward
extern abstract StructArray<T>(Array<T>) from Array<T> to Array<T>
{
    @:arrayAccess
    inline function get(index:Int):T
    {
        return cpp.NativeArray.address(this, index).at(0);
    }

    @:arrayAccess
    inline function set(index:Int, value:T):Void
    {
        cpp.NativeArray.address(this, index).setAt(0, value);
    }
}