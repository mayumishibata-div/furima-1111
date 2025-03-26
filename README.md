◉テストコード実行結果

　■ユーザー管理機能
 
 <img width="652" alt="スクリーンショット 2025-03-26 16 38 16" src="https://github.com/user-attachments/assets/9688bc89-0455-4991-9ad5-cb4bd3f6ec69" />

 ■商品出品機能

<img width="559" alt="スクリーンショット 2025-03-26 16 41 45" src="https://github.com/user-attachments/assets/efd6c24f-e66e-49a7-8229-8a4960a9910b" />

 ■購入機能の実装

<img width="546" alt="スクリーンショット 2025-03-26 16 43 00" src="https://github.com/user-attachments/assets/ac413d56-e31a-473f-b2b1-29e06672291e" />

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
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column            | Type       | Options                         |
| ----------------- | ---------- | ------------------------------- |
| item_name         | string     | null: false                     |
| item_category_id  | integer    | null: false                     |
| item_condition_id | integer    | null: false                     |
| shipping_cost_id  | integer    | null: false                     |
| shipping_area_id  | integer    | null: false                     |
| delivery_time_id  | integer    | null: false                     |
| price             | integer    | null: false                     |
| user              | references | null: false, foreign_key: true  |

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

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| shipping_area_id | integer    | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| building_name    | string     |                                |
| tel_number       | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to :order
- belongs_to :shipping_area
