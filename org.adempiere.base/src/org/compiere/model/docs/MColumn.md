# MColumn

## システム概要
- 論理名：カラム管理クラス
- 物理名：MColumn
- 用途：iDempiereシステムにおけるデータベースカラムのメタデータと操作を管理する永続化クラス

## 機能一覧
- カラムメタデータのキャッシュ管理（get, getCopy）
- カラム属性の管理（データ型、長さ、必須性など）
- 仮想カラムの管理（isVirtualColumn, isVirtualDBColumn）
- 暗号化カラムの管理（isEncrypted）
- 標準カラムの識別（isStandardColumn）
- SQLコード生成（getSQLAdd, getSQLModify, getSQLDDL）
- 外部キー制約の管理（getForeignKeyConstraint）
- カラムの検証と整合性チェック（beforeSave）

## クラス/コンポーネントの詳細説明
### キャッシュ管理機能
- ImmutableIntPOCacheによるカラム情報の永続的キャッシング
- カラム情報の効率的な取得と更新
- スレッドセーフなキャッシュ操作

### データ型管理機能
- 各種データ型のサポート（DisplayType）
- フィールド長の自動設定と検証
- データ型に応じた制約の自動設定
- UUID型の特別処理

### 制約管理機能
- 主キー制約の生成と管理
- 外部キー制約の生成と管理
- 一意性制約の管理
- NULL制約の管理

### 検証機能
- カラム名の有効性検証
- データ型と長さの整合性チェック
- 制約名の有効性検証
- 識別子カラムの重複チェック

## 技術実装の特徴
- スレッドセーフな実装（synchronized methodsの使用）
- イミュータブルなキャッシング戦略（ImmutableIntPOCache）
- データベース非依存の実装（AdempiereDatabase抽象化）
- 高度な検証メカニズム（beforeSave）
- 柔軟なSQL生成機能（getSQLAdd, getSQLModify）
- 多言語対応（翻訳テーブル対応）
- パーティショニングのサポート
- 仮想カラムと物理カラムの区別管理
- セキュリティ機能（暗号化、ログ制御）
