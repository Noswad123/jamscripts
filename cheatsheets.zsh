#!/bin/zsh

# Declare associative array
typeset -A files

# Base directory
darkness="/Users/jdawson/Projects/darkness"

# Populate the array
files[tmux]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/tmux/tmux Commands.md"
files[vim]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/VIM/Vim Documentation/Vim Commands.md"
files[git]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/Git/Git Documentation/Git Cheatsheet.md"

# Initialize variables for jless and json property
jless_flag='false'
json_property=''
choice=''

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -j)
          jless_flag='true'
            shift
            if [[ "$1" && !("$1" =~ ^-) ]]; then
                json_property="$1"
                shift
            fi
            ;;
        *)
            if [[ -z "$choice" ]]; then  # Only set choice if it hasn't been set yet
                choice="$1"
                shift  # Move past the choice
            else
                shift
            fi
            ;;
    esac
done

echo "Arguments parsed: -j $jless_flag, json_property: $json_property, Choice: $choice"

# Main script logic
if [[ -n "${files[$choice]}" ]]; then
    if head -1 "${files[$choice]}" | grep -qx '```json'; then
        content=$(sed '1d;$d' "${files[$choice]}")
    else
        content=$(cat "${files[$choice]}")
    fi

    echo "Content prepared for display or processing..."

    if [[ -n "$json_property" ]]; then
        # Use jless to extract the specified JSON property if provided
        content=$(echo "$content" | jq -r "$json_property")
    fi

    if [[ "$jless_flag" == 'true' ]]; then
        echo "$content" | jless -m line
    else
        echo "$content"
    fi
else
    echo "Invalid selection. Please use one of the following: ${!files[@]}"
fi
