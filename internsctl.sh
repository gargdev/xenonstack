#!/bin/bash

# Function to display the manual page
display_manual() {
    # You can use a tool like pandoc to convert Markdown to man page format
    pandoc -s -f markdown -t man <<'EOF'
% INTERNSCTL(1) Interns Control Manual
% Your Name
% Date

# NAME
internsctl - Custom Linux command for various operations

# SYNOPSIS
internsctl [OPTIONS] COMMAND [ARGS]...

# DESCRIPTION
This manual page documents the internsctl command.

# OPTIONS
--help          Show this message
--version       Show version information

# COMMANDS
cpu             Get CPU information
memory          Get memory information
user            Manage users
file            Get information about a file

EOF
}

# Function to display version information
display_version() {
    echo "internsctl version v0.1.0"
}

# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free
}

# Function to create a new user
create_user() {
    username=$1
    sudo useradd $username
    sudo passwd $username
}

# Function to list users
list_users() {
    if [ "$1" == "--sudo-only" ]; then
        getent passwd | grep -E '\s*/home' | cut -d: -f1,3 | awk -F: '$2 >= 1000 { print $1 }'
    else
        getent passwd | grep -E '\s*/home' | cut -d: -f1
    fi
}

# Function to get file information
get_file_info() {
    filename=$2
    case $1 in
        --size|-s)
            stat -c %s "$filename"
            ;;
        --permissions|-p)
            stat -c %A "$filename"
            ;;
        --owner|-o)
            stat -c %U "$filename"
            ;;
        --last-modified|-m)
            stat -c %y "$filename"
            ;;
        *)
            echo "Invalid option"
            exit 1
            ;;
    esac
}

# Main script
case $1 in
    cpu)
        shift
        get_cpu_info "$@"
        ;;
    memory)
        shift
        get_memory_info "$@"
        ;;
    user)
        shift
        case $1 in
            create)
                shift
                create_user "$@"
                ;;
            list)
                shift
                list_users "$@"
                ;;
            *)
                echo "Invalid user command"
                exit 1
                ;;
        esac
        ;;
    file)
        shift
        get_file_info "$@"
        ;;
    --help)
        display_manual
        ;;
    --version)
        display_version
        ;;
    *)
        echo "Invalid command"
        exit 1
        ;;
esac
