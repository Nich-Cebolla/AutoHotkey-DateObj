#Include ..\DateObj.ahk

test_DateObj()

class test_DateObj {
    static tests := [
        { str: '2024-10-9 23:19:10', fmt: 'yyyy-MM-d HH:mm:ss', Year: '2024', Month: '10', Day: '09', Hour: '23', Minute: '19', Second: '10' },
        { str: 'january 2, 2024', fmt: 'MMMM d, yyyy', Year: '2024', Month: '01', Day: '02', Hour: '00', Minute: '00', Second: '00' },
        { str: '1:22:44 am. the time was 9:12 am', fmt: 'the time was \t{h:m:?s? tt}', Year: SubStr(A_Now, 1, 4), Month: '01', Day: '01', Hour: '09', Minute: '12', Second: '00' },
        { str: '2024-01-28 19:15', fmt: 'yyyy-MM-dd HH:mm', Year: '2024', Month: '01', Day: '28', Hour: '19', Minute: '15', Second: '00' },
        { str: 'Voicemail From <1-555-555-5555> at 2024-01-28 07:15:20', fmt: 'at \t{yyyy-MM-dd HH:mm:ss}', Year: '2024', Month: '01', Day: '28', Hour: '07', Minute: '15', Second: '20' },
        { str: 'Voicemail From <1-555-555-5555> Received January 28, 2024 at 12:15 AM', fmt: 'Received \t{MMMM dd, yyyy} at \t{hh:mm:?ss? tt}', Year: '2024', Month: '01', Day: '28', Hour: '00', Minute: '15', Second: '00' },
        { str: 'Voicemail From <1-555-555-5555> Received January 28, 2024 at 12:15:12 AM', fmt: 'Received \t{MMMM dd, yyyy} at \t{hh:mm:?ss? tt}', Year: '2024', Month: '01', Day: '28', Hour: '00', Minute: '15', Second: '12' },
        { str: 'The child was born May 2, 1990, the year of the horse', fmt: '\t{MMMM d, yyyy}, the year of the (?<animal>\w+)', Year: '1990', Month: '05', Day: '02', Hour: '00', Minute: '00', Second: '00', Extra: 'Animal' }
    ]
    static Call() {
        i := 0
        for t in this.tests {
            if A_Index == 5 {
                sleep 1
            }
            i++
            d := DateObj(t.str, t.fmt, 'i)')
            for unit in ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second'] {
                if d.%unit% !== t.%unit% {
                    throw Error('Unit value mismatch.', , 'Index: ' i '; Test: ' t '; Date: ' d.Timestamp '; nice-date: ' d.Get() '; unit: ' unit)
                }
            }
            if t.HasOwnProp('Extra') {
                if this.%t.Extra%(d.Match) {
                    throw Error('Extra value mismatch.', , 'Index: ' i '; Test: ' t '; Date: ' d.Timestamp '; nice-date: ' d.Get() '; extra: ' d.Match['animal'])
                }
            }
        }
    }

    static Animal(Match) {
        if Match['animal'] !== 'horse' {
            return 1
        }
    }
}
