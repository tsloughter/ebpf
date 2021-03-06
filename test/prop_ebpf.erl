-module(prop_ebpf).

-include_lib("proper/include/proper.hrl").
-include("ebpf_kern.hrl").
-include("ebpf_user.hrl").

%%%%%%%%%%%%%%%%%%
%%% Properties %%%
%%%%%%%%%%%%%%%%%%

prop_disassemble_assemble_symmetry() ->
    ?FORALL(
        Instructions,
        bpf_sequence(),
        begin
            Instructions = ebpf_asm:disassemble(ebpf_asm:assemble(Instructions)),
            true
        end
    ).

prop_assemble_produces_sane_binaries() ->
    ?FORALL(
        Instructions,
        bpf_sequence(),
        begin
            byte_size(ebpf_asm:assemble(Instructions)) rem 8 == 0
        end
    ).

%%%%%%%%%%%%%%%
%%% Helpers %%%
%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
%%% Generators %%%
%%%%%%%%%%%%%%%%%%
