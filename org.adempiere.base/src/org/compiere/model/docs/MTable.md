# MTable

## システム概要
- 論理名：テーブル管理クラス
- 物理名：MTable
- 用途：iDempiereシステムにおけるデータベーステーブルのメタデータと操作を管理する永続化クラス

## 機能一覧
- テーブルメタデータのキャッシュ管理と取得（get, getCopy）
- テーブルカラム情報の取得と管理（getColumns, getColumn）
- テーブルのキー列の管理（getKeyColumns, isSingleKey）
- テーブル識別子カラムの管理（getIdentifierColumns）
- POインスタンスの生成と管理（getPO各メソッド）
- テーブルパーティション管理（getPartitionKeyColumns, createTablePartition）
- ビューコンポーネントの管理（getViewComponent）
- UUIDベースのレコード管理（getPOByUU, getUUIDFromZeroID）

## クラス/コンポーネントの詳細説明
### キャッシュ管理機能
- ImmutableIntPOCacheによるテーブル情報の永続的キャッシング
- モデルファクトリーキャッシュを使用したPOインスタンスの効率的生成
- キャッシュの自動更新とスレッドセーフな管理

### カラム管理機能
- テーブルのカラム情報の動的ロードと更新
- カラム名とインデックスの双方向マッピング
- カラムの存在確認と型検証
- 仮想カラムのサポート

### キー管理機能
- 単一キー/複合キーの自動判定
- UUIDベースのキー管理とインデックス作成
- キーカラムの動的特定と検証
- ゼロIDレコードの特別処理

### POインスタンス管理機能
- レコードIDベースのPOインスタンス生成
- ResultSetからの効率的なPO生成
- UUIDベースのレコード検索と生成
- 条件指定による柔軟なPO検索
- 部分的なPOロードのサポート

## 技術実装の特徴
- スレッドセーフな実装（synchronized methodsの使用）
- イミュータブルなキャッシング戦略（ImmutableIntPOCache）
- 効率的なカラムインデックス管理（ConcurrentMap）
- プラグイン可能なモデルファクトリーアーキテクチャ
- データベース非依存の実装（AdempiereDatabase抽象化）
- パーティショニングのサポート（テーブル分割機能）
- ビューテーブルの特別処理（ビューコンポーネント管理）
- 高度なキャッシュ制御（markImmutable機能）
- 拡張可能なPO生成メカニズム（IModelFactory統合）
