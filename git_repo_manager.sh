#!/bin/bash

GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

print_error() {
    echo -e "${RED}Error: $1${RESET}"
}

# Function to create a new Git repository
create_repository() {
    local repo_name="$1"
    if [ -d "$repo_name" ]; then
        print_error "Repository '$repo_name' already exists."
    else
        mkdir "$repo_name" && cd "$repo_name" || exit
        git init
        echo -e "${GREEN}Created and initialized repository: $repo_name${RESET}"
        cd ..
    fi
}

# Function to clone a Git repository
clone_repository() {
    local repo_url="$1"
    git clone "$repo_url"
}

# Function to list all repositories
list_repositories() {
    local repositories=($(ls -d */))
    if [ ${#repositories[@]} -eq 0 ]; then
        echo -e "${YELLOW}No repositories found.${RESET}"
    else
        echo -e "${CYAN}List of repositories:${RESET}"
        for repo in "${repositories[@]}"; do
            echo "- $repo"
        done
    fi
}

# Function to delete a repository
delete_repository() {
    local repo_name="$1"
    if [ -d "$repo_name" ]; then
        read -p "Are you sure you want to delete '$repo_name'? (y/n): " confirm
        if [[ $confirm == "y" ]]; then
            rm -rf "$repo_name"
            echo -e "${GREEN}Deleted repository: $repo_name${RESET}"
        else
            echo "Deletion canceled."
        fi
    else
        print_error "Repository '$repo_name' not found."
    fi
}

# Function to display repository information
repository_info() {
    local repo_name="$1"
    if [ -d "$repo_name" ]; then
        cd "$repo_name" || exit
        echo -e "${CYAN}Repository Information: $repo_name${RESET}"
        echo "========================="
        git remote -v
        git branch -a
        cd ..
    else
        print_error "Repository '$repo_name' not found."
    fi
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
            read -rp "Press Enter to continue..."
            ;;
        2)
            read -rp "Enter the URL of the repository to clone: " repo_url
            clone_repository "$repo_url"
            read -rp "Press Enter to continue..."
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
            print_error "Invalid choice. Please select a valid option."
            read -rp "Press Enter to continue..."
            ;;
    esac
done
