/**
   To avoid cyclic dependencies with module constructors
 */
module xlld.static_;

version(unittest):

///
shared static this() {
    import xlld.sdk.xlcall: XLOPER12;
    import xlld.test_util: gAsyncReturns, AA;
    gAsyncReturns = AA!(XLOPER12, XLOPER12).create;
}

///
shared static this() {
    import xlld.conv.from: gToEnumMutex;
    import xlld.conv.to: gFromEnumMutex;
    import core.sync.mutex: Mutex;
    gToEnumMutex = new shared Mutex;
    gFromEnumMutex = new shared Mutex;
}

///
static this() {
    import xlld.test_util: excel12UnitTest;
    import xlld.sdk.xlcallcpp: SetExcel12EntryPt;
    // this effectively "implements" the Excel12v function
    // so that the code can be unit tested without needing to link
    // with the Excel SDK
    SetExcel12EntryPt(&excel12UnitTest);
}

///
static ~this() {
    import xlld.test_util: gAllocated, gFreed, gNumXlAllocated, gNumXlFree;
    import unit_threaded.should: shouldBeSameSetAs;
    gAllocated[0 .. gNumXlAllocated].shouldBeSameSetAs(gFreed[0 .. gNumXlFree]);
}
