INCLUDE C:\Irvine\Irvine32.inc
INCLUDELIB C:\Irvine\Irvine32.lib

.data
input DWORD ?
str1 byte "Enter total marks obtained:",0
str2 byte "The integer grade is :",0
str3 byte "The GPA is:",0
str4 byte "--------------------------MUBARAK HO!!!!!!!!!!!!!------------",0
str5 byte "--------------------------BACH GAYE-------------------------",0
str6 byte "--------------------------KUCH PAR LYTY BYTA-----------------",0
str7 byte "--------------------------Tauseef & SONS GPA CALCULATOR SERVICE----------------------",0
str8 byte "Enter password: ",0
str9 byte "Wrong password ",0

subject_count DWORD 5
total_gpa DWORD ?
cgpa DWORD ?

; Set a secure password
password DWORD 1234

.code
Main PROC
    mov edx, OFFSET str8       ; Asking user to enter the password
    call WriteString
    call ReadInt
    cmp eax, password           ; Compare entered password with the correct password
    je @PasswordCorrect

    mov edx, OFFSET str9
    call WriteString
    call Crlf
    jmp @Exit

@PasswordCorrect:
    call Clrscr

    mov eax, 0                  ; Clearing registers
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    mov edx, OFFSET str7
    call WriteString
    call Crlf
    call Crlf
    call Crlf
    call Crlf

    mov ecx, 5                  ; Setting condition for the loop

    @Loop:
        mov edx, OFFSET str1
        call WriteString
        call ReadInt
        mov input, eax
        call ShowGrade          ; Calling function
        call Crlf
        loop @Loop

    call TotalGPA               ; Calling function
    call WaitMsg
    jmp @Exit

@Exit:
    call Crlf
    ret

Main ENDP

ShowGrade PROC                  ; Defining function
    mov eax, input

    cmp eax, 85
    jle @GradeA

    mov al, 'A'
    add ebx, 4
    mov total_gpa, ebx
    jmp short @Done

@GradeA:
    cmp eax, 75
    jle @GradeB

    mov al, 'B'
    add ebx, 3
    mov total_gpa, ebx
    jmp short @Done

@GradeB:
    cmp eax, 60
    jle @GradeC

    mov al, 'C'
    add ebx, 2
    mov total_gpa, ebx
    jmp short @Done

@GradeC:
    cmp eax, 50
    jle @GradeD

    mov al, 'D'
    add ebx, 1
    mov total_gpa, ebx
    jmp short @Done

@GradeD:
    mov al, 'F'

@Done:
    mov edx, OFFSET str2
    call WriteString
    call WriteChar
    call Crlf
    ret

ShowGrade ENDP                    ; Ending ShowGrade function

TotalGPA PROC                     ; Defining function
    mov eax, total_gpa
    mov ebx, subject_count
    xor edx, edx
    div ebx
    mov cgpa, eax

    ; Display CGPA
    mov edx, OFFSET str3
    call WriteString
    call Crlf
    mov eax, cgpa
    call WriteDec
    call Crlf
    call Crlf

    cmp eax, 3
    je @GradeHigh

    cmp eax, 2
    je @GradeAvg

    mov edx, OFFSET str6
    call WriteString
    jmp short @Done

@GradeHigh:
    mov edx, OFFSET str4
    call WriteString
    jmp @Done

@GradeAvg:
    mov edx, OFFSET str5
    call WriteString

@Done:
    call Crlf
    ret

TotalGPA ENDP

call ExitProcess
END Main