TYPE
  My_Record : STRUCT
    Open: BOOL;       (* +0 *)
    Close: BOOL;      (* +1 *)
    Remote: BOOL;     (* +2 *)
    Alarm: BOOL;      (* +3 *)
    Warning: BOOL;    (* +4 *)
    reserved1: BYTE;  (* +5 align T to x2 boundary *)
    T:INT;            (* +6 *)
    Val:REAL;         (* +8 .. 11 *)
  END_STRUCT;         (* 12 bytes total *)
END_TYPE

PROGRAM valve_st
  VAR_EXTERNAL
    start: BOOL;
    Valve: ARRAY [1..60] OF My_Record;
    myrec: My_Record;
  END_VAR
  VAR
    ton1 : TON;
    ton2 : TON;
  END_VAR

  if start then
  ton1(
       IN := NOT ton2.q,
       PT := T#1000ms);
  ton2(
       IN := ton1.q,
       PT := T#1000ms);
  end_if;

  Valve[1].Open := ton1.q;
  Valve[1].Close := NOT ton1.q;
  Valve[1].T := Valve[1].T + 1;
  myrec.Val := 2.345 + INT_TO_REAL(Valve[1].T);
END_PROGRAM
