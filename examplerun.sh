# Display manual
internsctl --help

# Display version
internsctl --version

# Get CPU information
internsctl cpu getinfo

# Get memory information
internsctl memory getinfo

# Create a new user
internsctl user create username

# List all users
internsctl user list

# List users with sudo permissions
internsctl user list --sudo-only

# Get file information
internsctl file getinfo hello.txt

# Get specific file information
internsctl file getinfo --size hello.txt
internsctl file getinfo --permissions hello.txt
internsctl file getinfo --owner hello.txt
internsctl file getinfo --last-modified hello.txt
