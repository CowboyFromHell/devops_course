package main

import (
    "log"
    "fmt"
    "regexp"
    "strconv"
    "github.com/go-telegram-bot-api/telegram-bot-api"
)



var git = [3]string{"https://github.com/CowboyFromHell/devops_course/tree/devops_master/about_myself",
    "https://github.com/CowboyFromHell/devops_course/tree/devops_master/ansible_animals",
    "https://github.com/CowboyFromHell/devops_course/tree/devops_master/bash_script",
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
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, "/git - show main repository\n/tasks - show tasks in repository\n/task# - show task, where '#' is a number of tasks")
            msg.ParseMode = "markdown"
            bot.Send(msg)
        }        

        if update.Message.Text == "/git" {
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, "[My repository](https://github.com/CowboyFromHell/devops_course)")
            msg.ParseMode = "markdown"
            bot.Send(msg)
        }

        if update.Message.Text == "/tasks" {
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, fmt.Sprintf("[about_myself](%s) - about me\n[ansible_animals](%s) - first ansible task\n[bash_script](%s) - first bash task", git[0], git[1], git[2]))
            msg.ParseMode = "markdown"
            bot.Send(msg)
        }

        match, _ := regexp.MatchString("task[1-3]", update.Message.Text)

        if match { 
            cont, _ := strconv.Atoi(string(update.Message.Text[len(update.Message.Text)-1]-1))
            msg := tgbotapi.NewMessage(update.Message.Chat.ID, git[cont])
            bot.Send(msg)
            // if update.Message.Text != "" {
            //     msg := tgbotapi.NewMessage(update.Message.Chat.ID, "kys")
            //     bot.Send(msg)
            // }
            // msg := tgbotapi.NewMessage(update.Message.Chat.ID, "[My repository](https://github.com/CowboyFromHell/devops_course)")
            // msg.ParseMode = "markdown"
            // bot.Send(msg)
        }


        // log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)

        // msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Кулити")
        //msg.ReplyToMessageID = update.Message.MessageID

        //bot.Send(msg)
    }
}