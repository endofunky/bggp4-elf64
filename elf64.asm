;; 112-byte ELF64 for BGGP4
;;
;; endofunky <ebbg (ng) shmmrq.bet> 0x510F3BD00000DEAD
;; @endofunky / @aa55@mastodon.social
;;
;; % nasm -f bin -o elf64 elf64.asm
;;
;; % chmod +x ./elf64
;;
;; % ./elf64
;;
;; % echo $?
;; 4
;;
;; % sha256sum 4 elf64
;; 1f56c2e9f9dfa28aa458d8e6a14507544f0d71bce3956e7a6cdb21f3f2482a5b  4
;; 1f56c2e9f9dfa28aa458d8e6a14507544f0d71bce3956e7a6cdb21f3f2482a5b  elf64
;;
bits 64
org 0x1000

ehdr:                     ; Elf64_Ehdr                           Code
        db 0x7F, "ELF"    ;   ├─┬─ e_ident                         │
_start:                   ;   │ │                                  │
        mov al, 0x8       ;   │ ├─ Bits/Endian                     │
        mov bx, filename  ;   │ └─ ELF Ver/OS ABI/ABI Ver/Padding  │
        inc ch            ;   │                                    │
        int 0x80          ;   │                         SYS_creat ─┤
        jmp short _write  ;   │                                    │
        dw 2              ;   ├─ e_type                            │
        dw 62             ;   ├─ e_machine                         │
        dd 1              ;   ├─ e_version                         │
        dq _start         ;   ├─ e_entry                           │
        dq phdr-$$        ;   ├─ e_phoff                           │
_write:                   ;   │                                    │
        xchg ebx, eax     ;   ├─ e_shoff                           │
        and eax, 0x04     ;   │                                    │
        mov ch, 0x10      ;   │                                    │
        mov dl, FSIZE     ;   │                                    │
        int 0x80          ;   ├─ e_flags                SYS_write ─┤
        jmp short _exit   ;   │                                    │
filename:                 ;   │                                    │
        dw  0x34          ;   ├─ e_ehsize                          │
        dw  0x38          ;   └────────────┬─ e_phentsize          │
phdr:                     ; Elf64_Phdr     │                       │
        dd 1              ;   ├─ p_type    ├─ e_phnum              │
        dd 5              ;   ├─ p_flags   │                       │
        dq 0              ;   ├─ p_offset  ├─ e_shendsize/e_shnum  │
        dq $$             ;   ├─ p_vaddr   └─ e_shstrndx           │
        dq $$             ;   ├─ p_paddr                           │
        dq FSIZE          ;   ├─ p_filesz                          │
        dq FSIZE          ;   ├─ p_memsz                           │
_exit:                    ;   │                                    │
        mov ax, 1         ;   └─ p_align                           │
        mov bl, 4         ;                                        │
        int 0x80          ;                              SYS_exit ─┘
FSIZE: equ $-$$           ;
