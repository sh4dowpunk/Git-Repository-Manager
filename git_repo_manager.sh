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

# Function to delete a repository
delete_repository() {
    local repo_name="$1"
    read -p "Are you sure you want to delete $repo_name? (y/n): " confirm
    if [[ $confirm == "y" ]]; then
        rm -rf "$repo_name"
        echo "Deleted repository: $repo_name"
    else
        echo "Deletion canceled."
    fi
}

# Function to display repository information
repository_info() {
    local repo_name="$1"
    cd "$repo_name" || exit
    echo "Repository Information: $repo_name"
    echo "========================="
    git remote -v
    git branch -a
    cd ..
}

# Main menu
while true; do
    clear
    echo "Git Repository Manager"
    echo "1. Create a new repository"
    echo "2. Clone a repository"
    echo "3. List repositories"
    echo "4. Delete a repository"
    echo "5. Repository information"
    echo "6. Exit"
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
            read -rp "Enter the name of the repository to delete: " repo_to_delete
            delete_repository "$repo_to_delete"
            read -rp "Press Enter to continue..."
            ;;
        5)
            read -rp "Enter the name of the repository: " repo_to_show
            repository_info "$repo_to_show"
            read -rp "Press Enter to continue..."
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            read -rp "Press Enter to continue..."
            ;;
    esac
done
