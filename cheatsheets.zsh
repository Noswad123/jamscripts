#!/bin/zsh

typeset -A files

darkness="/Users/jdawson/Projects/darkness"

files[tmux]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/tmux/tmux Commands.md"
files[vim]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/VIM/Vim Documentation/Vim Commands.md"
files[git]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Computer Tools/Git/Git Documentation/Git Cheatsheet.md"
files[jq]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Programming Language Theory/Programming Languages/Bash/Bash Commands/JQ Cheatsheet.md"
files[sed]="$darkness/Lifelong Learner/Curriculum/Computer Science/Software Development/Programming Language Theory/Programming Languages/Bash/Bash Commands/Sed Cheatsheet.md"

jless_flag='false'
verbose_flag='false'
edit_flag='false'
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
        -e)
            edit_flag='true'
            shift
            ;;
        -v)
            verbose_flag='true'
            shift
            ;;
        *)
            if [[ -z "$choice" ]]; then
                choice="$1"
                shift
            else
                shift
            fi
            ;;
    esac
done

if [[ "$verbose_flag" == 'true' ]]; then
  echo "Arguments parsed: -j $jless_flag, -e $edit_flag, json_property: $json_property, Choice: $choice"
fi

if [[ -z $choice ]]; then
  choice=$(for k in "${(@k)files}"; do echo $k; done | fzf --prompt="Select a cheatsheet:")
fi

if [[ $edit_flag == 'true' ]]; then
  nvim "${files[$choice]}"
  exit
fi

if [[ -n "${files[$choice]}" ]]; then
  content=$(awk '
    BEGIN { print_block = 1 }
      /^---$/ { 
        print_block = 1 - print_block;  # Toggle print_block
        next;  # Skip the line containing ---
      }
    print_block { print }
    ' "${files[$choice]}")

    if [[ "$verbose_flag" == 'true' ]]; then
      echo "after awk..."
      echo $content
    fi

    if  echo $content | grep -qx '```json'; then
        content=$(echo "$content" | sed '1d;$d')
    fi

    if [[ "$verbose_flag" == 'true' ]]; then
      echo "Content prepared for display or processing..."
      echo $content
    fi

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
