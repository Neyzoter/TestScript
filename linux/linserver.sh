#!/usr/bin/expect

# log in your remote server
spawn ssh user_name@ip_address
expect {
    "yes/no" { send "yes\n";exp_continue }      # download pub key
    "password" { send "your_password\n" }         # input password
}
interact
expect eof 
