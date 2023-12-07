
function __fish_using_command
    set cmd (commandline -poc)
    if [ ! (count $cmd) -eq (count $argv) ]
        return 1
    end
    for i in (seq (count $argv))
        if [ $cmd[$i] != $argv[$i] ]
            return 1
        end
    end
    return 0
end

function __fish_prefix_match
    set cmd (commandline -poc)
    if [ ! (count $cmd) -ge (count $argv) ]
        return 1
    end
    for i in (seq (count $argv))
        if [ $cmd[$i] != $argv[$i] ]
            return 1
        end
    end
    return 0
end


function __fish_is_arg_n --argument-names n
    test $n -eq (count (string match -v -- '-*' (commandline -poc)))
end

complete -c atcoder-tools -s h -l help -d 'show help'

# subcommand
complete -x -c atcoder-tools -n '__fish_use_subcommand' -a gen -d "generate workspace [contest]"
complete -x -c atcoder-tools -n '__fish_use_subcommand' -a compile -d "compile codes in your workspace"
complete -x -c atcoder-tools -n '__fish_use_subcommand' -a test -d "test codes in your workspace"
complete -x -c atcoder-tools -n '__fish_use_subcommand' -a submit -d "submit a code to the contest system"
complete -x -c atcoder-tools -n '__fish_use_subcommand' -a version -d "show version"

# gen subcommand
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l without-login -d "download data without login"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l workspace -d "atcoder-tools workspace"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l lang -a "cpp java rust python nim d cs swift go julia" -d "language"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l template -d "template"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l parallel -d "prepare problem directory asynchronously"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l save-no-session-cache -d "save no session cache"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l skip-existing-problems -d "skip"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools gen' -l config -d "config file"

# compile subcommand
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools compile' -l compile-command -d "compile command"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools compile' -l compile-only-when-diff-detected -a "true false" -d "compile only when diff detected"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools compile' -l config -d "config file"

# test subcommand
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s e -l exec -d "execute target"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s n -l num -d "case number to test"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s d -l dir -d "directory to test"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s t -l timeout -d "timeout for each test case(sec)"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s k -l knock-out -d "stop execution after example fail"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s s -l skip-almost-ac-feedback -d "stop execution after example fail"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s j -l judge-type -a "normal absolute relative absolute_or_relative" -d "judge type"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -s v -l error-value -d "error value for decimal number"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -l compile-before-testing -d "compile source before testing"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -l compile-only-when-diff-detected -d "compile only when diff detected"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -l compile-command -d "compile command"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools test' -l config -d "file path to config file"


# submit subcommand
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s e -l exec -d "execute target"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s d -l dir -d "directory to test"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s t -l timeout -d "timeout for each test case(sec)"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s c -l code -d "path to the source code to submit"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s f -l force -d "force submit code"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -l save-no-session-cache -d "save no session cache"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s u -l unlock-safety -d "to submit codes twice or more"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s j -l judge-type -a "normal absolute relative absolute_or_relative" -d "judge type"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -s v -l error-value -d "error value for decimal number"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -l exec-before-submit -d "exec command before submit"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -l exec-after-submit -d "exec command after submit"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit ' -l submit-filename -d "file for submit"
complete -x -c atcoder-tools -n '__fish_prefix_match atcoder-tools submit' -l config -d "file path to config file"

