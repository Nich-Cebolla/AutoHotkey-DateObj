
#include ..\DateObj.ahk

test()

class test {
    static Call() {
        ; Same-year simple
        TestAssertEq('Same day', DateObj.GetSeconds('20240501120000', '20240501120001'), 1)

        ; Crossing non-leap century
        TestAssertEq('1899-12-31 to 1900-01-01', DateObj.GetSeconds('18991231000000', '19000101000000'), 86400)

        ; Crossing leap century
        TestAssertEq('1999-12-31 to 2000-01-01', DateObj.GetSeconds('19991231000000', '20000101000000'), 86400)

        ; Year 0 behavior
        TestAssertEq('Year 0 Jan 1 to Year 1 Jan 1', DateObj.GetSeconds('00000101000000', '00010101000000'), DATEOBJ_SECONDS_IN_LEAPYEAR)  ; should count full length of year 0

        ; February 29 on leap years only
        TestAssertEq('2000-02-28 -> 2000-03-01', DateObj.GetSeconds('20000228000000', '20000301000000'), 2 * 86400)
        ; Not leap year
        TestAssertEq('1900-02-28 -> 1900-03-01', DateObj.GetSeconds('19000228000000', '19000301000000'), 86400)
    }
}
TestAssertEq(label, got, exp) {
    if (got != exp)
        throw Error('Test failed: ' label ' | got=' got ' exp=' exp)
}
