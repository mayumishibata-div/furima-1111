# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | data   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| item_name         | string  | null: false |
| item_category_id  | integer | null: false |
| item_condition_id | integer | null: false |
| shipping_cost_id  | integer | null: false |
| shipping_area_id  | integer | null: false |
| delivery_time_id  | integer | null: false |
| price             | integer | null: false |

### Association

- belongs_to :user
- has_one :order
- belongs_to :item_category
- belongs_to :item_condition
- belongs_to :shipping_cost
- belongs_to :shipping_area
- belongs_to :delivery_time


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column          | Type    | Options     |
| --------------- | ------- | ----------- |
| item_name_id    | string  | null: false |
| price           | string  | null: false |
| post_code       | integer | null: false |
| prefecture_id   | string  | null: false |
| city            | string  | null: false |
| address         | string  | null: false |
| building_name   | string  |             |
| tel_number      | integer | null: false |

### Association

- belongs_to :order
- belongs_to :item_name
- belongs_to :prefecture
