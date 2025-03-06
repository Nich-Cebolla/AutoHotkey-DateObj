#Include DateObj.ahk
#Include ..\Array\Array.ahk
; https://github.com/Nich-Cebolla/AutoHotkey-Array

Result := Test()
sleep 1

Test() {
    Result := []
    DateStr := 'Jan 02, 1992 @ 2 after 5 pm'
    DateFormat := 'MMM dd, yyyy.+?m.+?h tt'
    Result.Push(D := DateObj(DateStr, DateFormat))
    Values := { Year: '1992', Month: '01', Day: '02', Hour: '17', Minute: '02', Second: '', t: 'pm' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr := '2024-01-28 19:00'
    DateFormat := 'yyyy-MM-dd HH:mm'
    Result.Push(D := DateObj(DateStr, DateFormat))
    Values := { Year: '2024', Month: '01', Day: '28', Hour: '19', Minute: '00', Second: '', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr := '2024-01-28 07:00 PM'
    DateFormat := 'yyyy-MM-dd hh:mm tt'
    Result.Push(D := DateObj(DateStr, DateFormat))
    Values := { Year: '2024', Month: '01', Day: '28', Hour: '19', Minute: '00', Second: '', t: 'PM' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr := '12, Dec, around 2 AM'
    DateFormat := 'dd, MMM.+?h tt'
    Result.Push(D := DateObj(DateStr, DateFormat))
    Values := { Year: '', Month: '12', Day: '12', Hour: '02', Minute: '', Second: '', t: 'AM' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr1 := 'In first place at just under 59 seconds'
    DateStr2 := 'In second place at 1 minute 2 seconds'
    DateFormat := 'm? \w+ ?s ``sec'
    Result.Push(D := DateObj(DateStr1, DateFormat))
    Values := { Year: '', Month: '', Day: '', Hour: '', Minute: '', Second: '59', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }
    Result.Push(D := DateObj(DateStr2, DateFormat))
    Values := { Year: '', Month: '', Day: '', Hour: '', Minute: '01', Second: '02', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr1 := 'Appointment time: Fri @ 3:30 PM'
    DateStr2 := 'Appointment time: Fri, March 3, @ 3:30 PM'
    DateFormat := '(?:, MMMM d,)? @ h:mm tt'
    Result.Push(D := DateObj(DateStr1, DateFormat))
    Values := { Year: '', Month: '', Day: '', Hour: '15', Minute: '30', Second: '', t: 'PM' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }
    Result.Push(D := DateObj(DateStr2, DateFormat))
    Values := { Year: '', Month: '03', Day: '03', Hour: '15', Minute: '30', Second: '', t: 'PM' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr := 'Born March 30, 1992 - the year of the monkey'
    DateFormat := 'MMMM d, yyyy.+?(?<animal>``year.+)'
    Result.Push(D := DateObj(DateStr, DateFormat))
    Extra := (D) => (D.Match.animal !== 'year of the monkey' ? 'Match.animal: ' D.Match.animal : '')
    Values := { Year: '1992', Month: '03', Day: '30', Hour: '', Minute: '', Second: '', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    DateStr1 := '2024-11-28 11:05:01'
    DateStr2 := '2024-1-9 8:43:09'
    DateFormat := 'yyyy-M-d H:mm:ss'
    Result.Push(D := DateObj(DateStr1, DateFormat))
    Values := { Year: '2024', Month: '11', Day: '28', Hour: '11', Minute: '05', Second: '01', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }
    Result.Push(D := DateObj(DateStr2, DateFormat))
    Values := { Year: '2024', Month: '01', Day: '09', Hour: '08', Minute: '43', Second: '09', t: '' }
    if e := _Check(D, Values) {
        if _MsgBox(e)
            return
    }

    return Result

    _Check(D, Values, Extra?) {
        Errors := []
        for Prop, Val in Values.OwnProps() {
            if D.%Prop% !== Val
                Errors.Push('Prop: ' Prop ', Correct: ' Val ', Actual: ' D.%Prop%)
        }
        if IsSet(Extra) {
            if R := Extra(D)
                Errors.Push('Extra: ' R)
        }
        return Errors.Length ? Errors : ''
    }
    _MsgBox(e) {
        return MsgBox(e.Join('`n') '`n`nPress OK to continue or Cancel to return.') == 'Cancel'
    }
}
