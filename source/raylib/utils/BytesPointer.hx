package raylib.utils;

import haxe.io.Bytes;
import haxe.io.BytesData;

@:nullSafety
extern abstract BytesPointer(cpp.RawPointer<cpp.UInt8>) from cpp.RawPointer<cpp.UInt8> to cpp.RawPointer<cpp.UInt8>
{
    inline function new(ptr:cpp.RawPointer<cpp.UInt8>):Void
    {
        this = ptr;
    }

    @:from
    static inline function fromBytes(value:Bytes):BytesPointer
    {
        return fromBytesData(value.getData());
    }

    @:from
    static inline function fromBytesData(value:BytesData):BytesPointer
    {
        return new BytesPointer(cpp.Pointer.ofArray(value).raw);
    }
}
