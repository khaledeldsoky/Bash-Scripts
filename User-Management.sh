#!/bin/bash

# Main menu
PS3="Please Enter a Number From Main Menu : "
export PS3

echo -e "\n-------- \033[36mMain-Menu\033[0m --------\n"
select Main_Option in User Group Exit; do
    case $Main_Option in
        User)
            # User menu
            PS3="Please Enter Number From User Menu : "
            export PS3

            echo -e "\n-------- \033[36mUser-Menu\033[0m --------\n"
            select User_Option in Add-User Delete-User Modify-User Show-All-User User-Information Back Exit; do
                case $User_Option in
                    Add-User)
                        # Add user
                        echo ""
                        read -p "Enter user name you want to add [Write esc to Cancel]: " User_Name
                        if [[ $User_Name == 'esc' ]]; then
                            echo "Cancel..."
                        else
                            if output=$(useradd "$User_Name" 2>&1); then
                                echo ""
                                echo -e "\033[32mSuccess adding user\033[0m"
                            else
                                echo ""
                                echo -e "\033[31mError adding user:\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                            fi
                        fi
                        ;;
                    Delete-User)
                        # Delete user
                        echo ""
                        read -p "Enter user name you want to delete [Write esc to cancel]: " User_Name
                        if [[ $User_Name == 'esc' ]]; then
                            echo "Cancel..."
                        else
                            if output=$(userdel "$User_Name" 2>&1); then
                                echo ""
                                echo -e "\033[32mSuccess delete user\033[0m"
                            else
                                echo ""
                                echo -e "\033[31mError delete user:\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                            fi
                        fi
                        ;;
                    Modify-User)
                        # Modify user
                        echo -e "\n-------- \033[36mModify-User-Menu\033[0m --------\n"
                        select Modify_Option in Modify-User-ID Modify-Primary-Group Modify-Sup-Group Back Exit; do
                            case $Modify_Option in
                                Modify-User-ID)
                                    # Modify user ID
                                    read -p "Enter user name you want to modify [write esc to cancel]: " User_Name
                                    if [[ $User_Name == 'esc' ]]; then
                                        echo "Cancel..."
                                    else
                                        read -p "Enter user id you want to change : " User_ID
                                        if output=$(usermod -u "$User_ID" "$User_Name" 2>&1); then
                                            echo ""
                                            echo -e "\033[32mChange the ID Success\033[0m"
                                        else
                                            echo ""
                                            echo -e "\033[31mError: Change the ID user:\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                                        fi
                                    fi
                                    ;;
                                Modify-Primary-Group)
                                    # Modify primary group
                                    read -p "Enter the user you want to modify [Write esc to cancel]: " User_Name
                                    if [[ $User_Name == 'esc' ]]; then
                                        echo "Cancel..."
                                    else
                                        read -p "Enter the user you want to change the Modify-Primary-Group : " Primary_Group
                                        if output=$(usermod -aG "$Primary_Group" "$User_Name" 2>&1); then
                                            echo ""
                                            echo -e "\033[32mChange the Primary Group Success\033[0m"
                                        else
                                            echo ""
                                            echo -e "\033[31mError: Change the Primary Group:\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                                        fi
                                    fi
                                    ;;
                                Modify-Sup-Group)
                                    # Modify supplementary group
                                    read -p "Enter the user you want to modify [Write esc to cancel]: " User_Name
                                    if [[ $User_Name == 'esc' ]]; then
                                        echo "Cancel..."
                                    else
                                        read -p "Enter the user you want to change the Modify-Sup-Group : " Sup_Group
                                        if output=$(usermod -aG "$Sup_Group" "$User_Name" 2>&1); then
                                            echo ""
                                            echo -e "\033[32mChange the Sub Group Success\033[0m"
                                        else
                                            echo ""
                                            echo -e "\033[31mError Change the Sub Group :\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                                        fi
                                    fi
                                    ;;
                                Back)
                                    echo "Back..."
                                    break
                                    ;;
                                Exit)
                                    echo "Exit..."
                                    break 4
                                    ;;
                                *)
                                    echo -e "\n\033[31mInvalid option. Please choose again\033[0m"
                                    ;;
                            esac
                        done
                        ;;
                    Show-All-User)
                        # Show all users
                        echo ""
                        awk -F: '$3 > 1000 {print $1}' /etc/passwd
                        ;;
                    User-Information)
                        # User information
                        echo ""
                        read -p "Enter User Name [Write esc to cancel]: " User_Name
                        if [[ $User_Name == 'esc' ]]; then
                            echo "Cancel..."
                        else
                            if output=$(id "$User_Name" 2>&1); then
                                echo ""
                                id "$User_Name"
                            else
                                echo ""
                                echo -e "\033[31mError adding user:\033[0m $User_Name \n\033[31mError Details:\033[0m $output"
                            fi
                        fi
                        ;;
                    Back)
                        echo "Back..."
                        break
                        ;;
                    Exit)
                        echo "Exit..."
                        break 3
                        ;;
                    *)
                        echo -e "\n\033[31mInvalid option. Please choose again\033[0m"
                        ;;
                esac
            done
            ;;
        Group)
            # Group menu
            PS3="Select Number For Group Option : "
            export PS3
            echo -e "\n-------- \033[36mGroup-Menu\033[0m --------\n"
            select Group_Option in Add-Group Delete-Group Modify-Group Back Exit; do
                case $Group_Option in
                    Add-Group)
                        # Add group
                        read -p "Enter the group you want to add [Write esc to cancel]: " Group_Name
                        if [[ $Group_Name == 'esc' ]]; then
                            echo "Cancel..."
                        else
                            if output=$(groupadd "$Group_Name" 2>&1); then
                                echo ""
                                echo -e "\033[32mSuccess Add New Group\033[0m"
                            else
                                echo ""
                                echo -e "\033[31mError Add New Group:\033[0m $Group_Name \n\033[31mError Details:\033[0m $output"
                            fi
                        fi
                        ;;
                    Delete-Group)
                        # Delete group
                        read -p "Enter the group you want to delete [Write esc to cancel] : " Group_Name
                        if [[ $Group_Name == 'esc' ]]; then
                            echo "Cancel..."
                        else
                            if output=$(groupdel "$Group_Name" 2>&1); then
                                echo ""
                                echo -e "\033[32mSuccess delete Group\033[0m"
                            else
                                echo ""
                                echo -e "\033[31mError delete Group:\033[0m $Group_Name \n\033[31mError Details:\033[0m $output"
                            fi
                        fi
                        ;;
                    Modify-Group)
                        # Modify group
                        echo -e "\n-------- \033[36mModify-Group-Option\033[0m --------\n"
                        select Modify_Group in New-Name New-ID Back Exit; do
                            case $Modify_Group in
                                New-Name)
                                    # Modify group name
                                    read -p "Enter the Old Group Name [Write esc to cancel] : " Old_name
                                    if [[ $Old_name == 'esc' ]]; then
                                        echo "Cancel..."
                                    else
                                        read -p "Enter the New Group Name : " New_name
                                        if output=$(groupmod -n "$New_name" "$Old_name" 2>&1); then
                                            echo ""
                                            echo -e "\033[32mChange Name group\033[0m"
                                        else
                                            echo ""
                                            echo -e "\033[31mError Change Name group:\033[0m $Old_name \n\033[31mError Details:\033[0m $output"
                                        fi
                                    fi
                                    ;;
                                New-ID)
                                    # Modify group ID
                                    read -p "Enter the Group Name [Write esc to cancel] : " Group_name
                                    if [[ $Group_name == 'esc' ]]; then
                                        echo "Cancel..."
                                    else
                                        if output=$(groupmod -g "$New_ID" "$Group_name" 2>&1); then
                                            echo ""
                                            echo -e "\033[32mChange Group ID\033[0m"
                                        else
                                            echo ""
                                            echo -e "\033[31mError adding user:\033[0m $Group_name \n\033[31mError Details:\033[0m $output"
                                        fi
                                    fi
                                    ;;
                                Back)
                                    echo "Back..."
                                    break
                                    ;;
                                Exit)
                                    echo "Exit..."
                                    break 4
                                    ;;
                                *)
                                    echo -e "\n\033[31mInvalid option. Please choose again\033[0m"
                                    ;;
                            esac
                        done
                        ;;
                    Back)
                        echo "Back..."
                        break
                        ;;
                    Exit)
                        echo "Exit..."
                        break 3
                        ;;
                    *)
                        echo -e "\n\033[31mInvalid option. Please choose again\033[0m"
                        ;;
                esac
            done
            ;;
        Exit)
            echo "Exit..."
            break
            ;;
        *)
            echo -e "\n\033[31mInvalid option. Please choose again\033[0m"
            ;;
    esac
done

