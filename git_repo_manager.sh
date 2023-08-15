#!/bin/bash

# Function to create a new Git repository
create_repository() {
    local repo_name="$1"
    mkdir "$repo_name"
    cd "$repo_name" || exit
    git init
    echo "Created and initialized repository: $repo_name"
    cd ..
}

# Function to clone a Git repository
clone_repository() {
    local repo_url="$1"
    git clone "$repo_url"
}

# Function to list all repositories
list_repositories() {
    ls -d */
}

# Main menu
while true; do
    clear
    echo "Git Repository Manager"
    echo "1. Create a new repository"
    echo "2. Clone a repository"
    echo "3. List repositories"
    echo "4. Exit"
    read -rp "Enter your choice: " choice

    case $choice in
        1)
            read -rp "Enter the name of the new repository: " repo_name
            create_repository "$repo_name"
            ;;
        2)
            read -rp "Enter the URL of the repository to clone: " repo_url
            clone_repository "$repo_url"
            ;;
        3)
            list_repositories
            read -rp "Press Enter to continue..."
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            read -rp "Press Enter to continue..."
            ;;
    esac
done
