# Rainfall

**Summary:** This project is an introduction to the exploitation of (elf-like) binary.

**Version:** 4.2

## Table of Contents

- [Preamble](#preamble)
- [Introduction](#introduction)
- [Objectives](#objectives)
- [General Instructions](#general-instructions)
- [Mandatory Part](#mandatory-part)
- [Bonus Part](#bonus-part)
- [Submission and Peer-Evaluation](#submission-and-peer-evaluation)

---

## Preamble

There is something wrong...

---

## Introduction

As a developer, you might have to work on softwares that will be used by hundreds of people.

You have learned to develop more or less complex programs without taking security into account.

With this project, you will realize that your programs are full of breaches that can be easily exploitable by some malicious users. But here's good news: you can avoid them very easily!

Once you're through with this project, not only will you have avoided these pitfalls, but you will have a clearer understanding of the RAM. And this will really help you design a bugless program!

---

## Objectives

This project aims to further your knowledge in the world of elf-like binary exploitation in i386 system.

The more or less complex methods you will use will give you a new perspective on IT in general but mostly raise your awareness on issues coming from common programming malpractice.

You will be challenged during this project. You have to overcome these challenges by yourself. The way you'll be dealing with these challenges must be yours and YOURS ONLY. The point is to help you develop some logic and acquire reflexes that will help you all along your career. Before asking for help, ask yourself if you have factored in all the possibilities.

---

## General Instructions

### Project Environment

- This project will only be evaluated by humans.
- You may have to prove your results during the evaluation. Be ready!
- To make this project, you will have to use a VM (64 bits). Once you have started your machine with the ISO provided with this subject, if your configuration is right, you will get a simple prompt with an IP.

### SSH Access

You really should use the SSH connection available on port 4242:

```bash
ssh level0@192.168.1.13 -p 4242
```

Initial credentials: `level0:level0`

> If the IP address is not visible, you will get it with the command `ifconfig` once you're logged-in.

### How the Project Works

- Once logged-in, you will have to find a way to read the `.pass` file with the `levelX` user account of the next level (X = number of the next level).
- This `.pass` file is located at the home directory of each (level0 excluded) user.
- Of course, once you've reached level9 you will have to go towards the bonus0 user.

### Sample Session

```bash
level0@RainFall:~$ ./level0 $(exploit)
$ cat /home/user/level1/.pass
?????????????????????
$ exit
level0@RainFall:~$ su level1
Password:
level1@RainFall:~$ _
```

### Important Notes

- Nothing is left to chance. If there is a problem, start wondering if your code is not the cause.
- **Using an automation tool is cheating. Cheating gets you a -42.**
- Of course, in case of a true bug, run to the educational team!

---

## Mandatory Part

### Repository Structure

Your repo must include anything that helped you solve each validated test.

Your repository will have this form:

```
[..]
drwxr-xr-x 2 root root 4096 Dec 3 XX:XX level0
drwxr-xr-x 2 root root 4096 Dec 3 XX:XX level1
drwxr-xr-x 2 root root 4096 Dec 3 XX:XX level2
drwxr-xr-x 2 root root 4096 Dec 3 XX:XX level3
[..]
```

For each level directory:

```
level0:
total 16
drwxr-xr-x 3 root root 4096 Dec 3 15:22 .
drwxr-xr-x 6 root root 4096 Dec 3 15:20 ..
-rw-r--r-- 1 root root 5 Dec 3 15:22 flag
-rw-r--r-- 1 root root 50 Dec 3 15:22 source
-rw-r--r-- 1 root root 50 Dec 3 15:22 walkthrough
drwxr-xr-x 2 root root 4096 Dec 3 15:22 Resources

level0/Resources:
total 8
drwxr-xr-x 2 root root 4096 Dec 3 15:22 .
drwxr-xr-x 3 root root 4096 Dec 3 15:22 ..
-rw-r--r-- 1 root root 0 Dec 3 15:22 whatever.whatever
```

### File Requirements

- **flag**: The password/flag for the level. May be empty, but you may have to explain why.
- **source**: Must only include the exploited binary in a form any developer could understand. You're free to choose the used language.
- **walkthrough**: Will include the different steps of the test solution.
- **Resources**: Keep everything you need to prove your results during the evaluation.

### Important Warnings

> ⚠️ **WARNING:** You must be able to clearly and precisely explain anything that is included in the folder. The folder mustn't include ANY binary.

- If you need to use a specific file that's included on the project's ISO, you must download it during the evaluation. You must NOT put it in your repo under any circumstances.
- If you plan to use a specific external software, you must set up a specific environment (VM, docker, Vagrant).
- You're invited to create scripts that will make you stall, but you will have to explain them during the evaluation.

### Mandatory Levels

You must complete the following levels:

- level0
- level1
- level2
- level3
- level4
- level5
- level6
- level7
- level8
- level9

### Evaluation Requirements

During the evaluation, each member of the group must be able to justify each challenge solved.

> ⚠️ **Hey, smarty (or not so smarty) pants!** You cannot bruteforce the ssh flags. This would be useless anyway, since you will have to justify your solution during the evaluation.

---

## Bonus Part

For the bonus part, you can complete the following levels:

- bonus0
- bonus1
- bonus2
- bonus3

The last user is "end".

> ⚠️ **WARNING:** Becoming root is considered cheating, here.

### Bonus Evaluation Criteria

The bonus part will only be assessed if the mandatory part is **PERFECT**. Perfect means the mandatory part has been integrally done and works without malfunctioning. If you have not passed ALL the mandatory requirements, your bonus part will not be evaluated at all.

---

## Submission and Peer-Evaluation

Turn in your assignment in your Git repository as usual. Only the work inside your repository will be evaluated during the defense. Don't hesitate to double check the names of your folders and files to ensure they are correct.
