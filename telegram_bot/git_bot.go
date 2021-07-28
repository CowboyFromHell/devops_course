package main

import (
    "strings"
    "log"
    "fmt"
    "regexp"
    "strconv"
    "github.com/go-telegram-bot-api/telegram-bot-api"
)



var git = [11]string{"[about_myself](https://github.com/CowboyFromHell/devops_course/tree/devops_master/about_myself) - About me",
"[ansible_animals](https://github.com/CowboyFromHell/devops_course/tree/devops_master/ansible_animals) - Ansible task",
"[bash_script](https://github.com/CowboyFromHell/devops_course/tree/devops_master/bash_script) - Bash task",
"[docker_task](https://github.com/CowboyFromHell/devops_course/tree/devops_master/docker_task) - Python app on flask in a docker image",
"[git_task](https://github.com/CowboyFromHell/devops_course/tree/devops_master/git_task)  - Python script to parse pull requests on GitHub",
"[rights_chmod](https://github.com/CowboyFromHell/devops_course/tree/devops_master/rights_chmod) - Bonus chmod task",
"[telegram_bot](https://github.com/CowboyFromHell/devops_course/tree/devops_master/telegram_bot) - Telegram bot on golang",
"[terraform_task](https://github.com/CowboyFromHell/devops_course/tree/devops_master/terraform_task) - Terraform task",
"[aws_cli_task](https://github.com/CowboyFromHell/devops_course/tree/devops_master/aws_cli_task) - AWS cli task",
"[cd_cd](https://github.com/CowboyFromHell/devops_course/tree/devops_master/cd_cd) - About CD/CD difference",
"[exam_task](https://github.com/CowboyFromHell/devops_course/tree/devops_master/exam_task) - Exam task",
}


func main() {
    bot, err := tgbotapi.NewBotAPI("TOKEN")
    if err != nil {
        log.Panic(err)
    }

    bot.Debug = true

    log.Printf("Authorized on account %s", bot.Self.UserName)

    u := tgbotapi.NewUpdate(0)
    u.Timeout = 60

    updates, err := bot.GetUpdatesChan(u)

    for update := range updates {
        if update.Message == nil { // ignore any non-Message Updates
            continue
        }

        if update.Message.Text == "/help" {
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, "/git - show main repository\n/tasks - show tasks in repository\n/task# - show task, where '#' is a number from 1 till 8")
            msg.ParseMode = "markdown"
            bot.Send(msg)
            continue
        }        

        if update.Message.Text == "/git" {
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, "[My repository](https://github.com/CowboyFromHell/devops_course)")
            msg.ParseMode = "markdown"
            bot.Send(msg)
            continue
        }

        if update.Message.Text == "/tasks" {
            var mess_res strings.Builder
            for _, value := range git {
                mess_res.WriteString(value + "\n")
                // fmt.Println(key)
                // fmt.Println(value)
            }
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, fmt.Sprintf("%s", mess_res.String()))
            msg.ParseMode = "markdown"
            bot.Send(msg)
            continue
            
        }

        if update.Message.Text == "/task" {
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Please send /task# where '#' is a number from 1 till 8")
            msg.ParseMode = "markdown"
            bot.Send(msg)
            continue
        } 

        match, _ := regexp.MatchString("^/task[1-9][0-1]?$", update.Message.Text)

        if match {
            re := regexp.MustCompile("/task")
            s := re.ReplaceAllString(update.Message.Text, "")
            cont, _ := strconv.Atoi(s)
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, git[cont-1])
            msg.ParseMode = "markdown"
            bot.Send(msg)
            continue
            // if update.Message.Text != "" {
            //     msg := tgbotapi.NewMessage(update.Message.Chat.ID, "kys")
            //     bot.Send(msg)
            // }
            // msg := tgbotapi.NewMessage(update.Message.Chat.ID, "[My repository](https://github.com/CowboyFromHell/devops_course)")
            // msg.ParseMode = "markdown"
            // bot.Send(msg)
        }
        msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Please send /help for help")
        msg.ParseMode = "markdown"
        bot.Send(msg)

        // log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

        // msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Кулити")
        //msg.ReplyToMessageID = update.Message.MessageID

        //bot.Send(msg)
    }
}