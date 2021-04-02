' 8*8-pixel pattern editor for QBasic

DEFINT A-Z
DIM pixels(63)  ' 0=black, 3=white
DATA Arrows=move cursor,Space=toggle pixel,R=redraw screen,Esc=quit,

SCREEN 1

' print help text
y = 1
DO
    READ l$
    IF l$ = "" THEN EXIT DO
    LOCATE y, 21: PRINT l$: y = y + 1
LOOP

DO
    ' print character editor
    FOR y = 0 TO 7
        l$ = ""
        FOR x = 0 TO 7
            IF pixels(y * 8 + x) THEN l$ = l$ + "X" ELSE l$ = l$ + "."
        NEXT
        LOCATE y + 9, 25: PRINT l$;
    NEXT

    ' print frame around pixel to edit
    x = (24 + px) * 8: y = (8 + py) * 8
    LINE (x, y)-(x + 7, y + 7), 2, B
   
    ' wait for keypress
    DO: k$ = INKEY$: LOOP WHILE k$ = ""
   
    SELECT CASE UCASE$(k$)
        CASE CHR$(0) + "H": py = py - 1  ' up
        CASE CHR$(0) + "P": py = py + 1  ' down
        CASE CHR$(0) + "K": px = px - 1  ' left
        CASE CHR$(0) + "M": px = px + 1  ' right
        CASE " ": i = py * 8 + px: pixels(i) = pixels(i) XOR 3  ' space
        CASE "R"
            ' redraw
            FOR y = 0 TO 127
                FOR x = 0 TO 127
                    PSET (x, y), pixels((y AND 7) * 8 + (x AND 7))
                NEXT
            NEXT
        CASE CHR$(27): END
    END SELECT

    px = px AND 7: py = py AND 7  ' handle underflow/overflow
LOOP

