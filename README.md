# DB設計
## usersテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| date_of_birth | date | null: false |

### Association
- has_many :items
- has_many :purchases

## itemsテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| name | string | null: false |
| descritption | text | null: false |
| price | integer | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_charge_id | integer | null: false |
| shipping_date_id | integer | null: false |
| prefecture_id | integer | null: false |
| user(FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchases テーブル

| id(PK) | integer | null: false |
| user (FK) | references | null: false, foreign_key: true |
| item (FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## deliveries テーブル

| id(PK) | integer | null: false |
| purchase(FK) | references | null: false, foreign_key: true |
| postal_code | string | null: false |
| prefectures_id | integer | null: false |
| cities_and_towns | string | null: false |
| house_number | string | null: false |
| building_name | string |
| telephone_number | string | null: false |

### Association
- belongs_to :purchase

