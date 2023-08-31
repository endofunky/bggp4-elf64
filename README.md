# 112-byte self-replicating ELF64 for BGGP4

endofunky <ebbg (ng) shmmrq.bet> 0x510F3BD00000DEAD
@endofunky / @aa55@mastodon.social

## How to use

Assembly binary:

    % nasm -f bin -o elf64 elf64.asm

Make executable:

    % chmod +x ./elf64

Run it:

    % ./elf64

Check exit status (should be `4`):

    % echo $?
    4

Compare SHA256 checksum:

    % sha256sum 4 elf64
    1f56c2e9f9dfa28aa458d8e6a14507544f0d71bce3956e7a6cdb21f3f2482a5b  4
    1f56c2e9f9dfa28aa458d8e6a14507544f0d71bce3956e7a6cdb21f3f2482a5b  elf64

