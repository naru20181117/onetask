# Onetask

## App UI
[![Image from Gyazo](https://i.gyazo.com/b0726715def42c1c9fc59464e8ac42a9.gif)](https://gyazo.com/b0726715def42c1c9fc59464e8ac42a9)

## Router Tree
[![Image from Gyazo](https://i.gyazo.com/b65b3c6e502dc9addb080746525c4830.gif)](https://gyazo.com/b65b3c6e502dc9addb080746525c4830)

---
Things you may want to cover:

* Ruby version
- Ruby 2.7.0
- Rails 6.0.2.1
- PostgreSQL 12.2

### Heroku login
```
$ heroku login
```
### Pull the repository
```
$ git pull origin/master
```
### Precompile assets
```
$ rake assets:precompile RAILS_ENV=production
```
### Deploy your app
```
$ git push heroku master
```
### Set your DB on Heroku
```
$ heroku run rails db:migrate
```
### Set your seed on Heroku
```
$ heroku run rails db:seed
```


## Userモデル
| カラム名 | データ型
| :---: | :---: |
| id | integer |
| admin | boolean |
| email | string |
| password | string |


## Taskモデル
| カラム名 | データ型
| :---: | :---: |
| id | integer |
| user_id | integer |
| name | string |
| memo | integer |
| end_time | date |
| priority | integer |
| status | integer |


## Tasks-Labelsモデル
| カラム名 | データ型
| :---: | :---: |
| id | integer |
| label_id | integer |
| task_id | integer |

## Labelモデル
| カラム名 | データ型
| :---: | :---: |
| id | integer |
| name | string |

## Milestoneモデル
| カラム名 | データ型
| :---: | :---: |
| id | integer |
| task_id | integer |
| description | string |
| status | integer |
| priority | integer |

Figma ー イメージ図


[One-Task.pdf](/uploads/be3cf5c0a7fddb7d2dee6b29cdfb97ab/One-Task.pdf)
