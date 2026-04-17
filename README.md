## usersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| nickname         | string              | null: false|
| email            | string              | null: false, unique: true |
| password         | encrypted_password  | null: false|
| last_name        | string              | null: false|
| first_name       | string              | null: false|
| last_name_kana   | string              |null: false |
| first_name_kana  | string              | null: false|
| birth_date       | date                | null: false|


### Association
-has_many :products
-has_many :purchased


## productsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| product_name         | string      | null: false |
| info                 | text        | null: false |
| category_id           | integer    | null: false |
| product_status_id     | integer    | null: false |
| shipping_fee_id       | integer    | null: false |
| prefecture_id         | integer    | null: false |
| delivery_schedule_id  | integer    | null: false |
| price                 | integer    | null: false |
| user                  | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :purchased


## purchasedテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :addresses





## addressesテーブル


| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| zip_code      | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| address       | string     | null: false |
| building      | string     |
| phone_number  | string     | null: false |
| purchased     | references | null: false, foreign_key: true |

### Association
- belongs_to :purchased
