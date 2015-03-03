# Rails Security Workshop Solutions

Solutions to the Ruby on Rails security workshop run recently at MOJ Digital by Ali (ali@happybearsoftware.com)

Code will not function without the associated rails apps which I have not uploaded, but solutions demonstrate automated exploits of a range of security vulnerabilities ranging from poorly designed authentication mechanisms, to a full compromise of a rails through remote code execution. 

## Overview

* Secret Keeper: non-access protected restful URLs
* Payroll Buddy: more complex variant of secret keeper
* Weight Tracker: broken registration mechanism
* To Do I: broken password reset tokenisation
* To Do I: more sophisticated (yet still predictable) password reset tokenisation
* Uploader I: directory traversal vulnerability
* Uploader II: decrypting rails cookies
* Uploader III: modifying signed rails cookies 
* Uploader IV: code execution through modified cookies